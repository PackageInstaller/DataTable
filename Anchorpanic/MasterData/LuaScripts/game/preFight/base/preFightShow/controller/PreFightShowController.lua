-- 展示控制器
module('preFight.ShowController', Class.impl(Controller))

--构造函数
function ctor(self)
	self.m_showManager = preFight.ShowManager
	self.m_manager = nil
	super.ctor(self)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
	self.m_showManager:addEventListener(self.m_showManager.START_INIT, self.__onStartInitHandler, self)
	self.m_showManager:addEventListener(self.m_showManager.START_RECOVERY, self.__onStartRecoveryHandler, self)
	self.m_showManager:addEventListener(self.m_showManager.ADD_SHOW_ITEM, self.__onAddShowItemHandler, self)
	self.m_showManager:addEventListener(self.m_showManager.REMOVE_SHOW_ITEM, self.__onRemoveShowItemHandler, self)
	self.m_showManager:addEventListener(self.m_showManager.REMOVE_ATT_SHOW_ITEMS, self.__onRemoveAttShowItemsHandler, self)
	self.m_showManager:addEventListener(self.m_showManager.REMOVE_DEF_SHOW_ITEMS, self.__onRemoveDefShowItemsHandler, self)
	local instance = preFight.ShowManager
	local instance = preFight.ShowManager
end

--注册server发来的数据
function registerMsgHandler(self)
	return {}
end

-- 通知初始化
function __onStartInitHandler(self, args)
	self.m_manager = args.manager
	self.m_showManager:init()
	self:__startDragListen()
end

-- 通知回收
function __onStartRecoveryHandler(self)
	self:__onRemoveAttShowItemsHandler()
	self:__onRemoveDefShowItemsHandler()
	self.m_showManager:reset()
	self:__endDragListen()
end

-- 添加展示项
function __onAddShowItemHandler(self, args)
	local showVo = args.showVo
	local heroVo = args.heroVo
	local item = self.m_showManager:getItem(showVo.isAttacker, showVo.index)
	if(item) then
		return
	end
	item = LuaPoolMgr:poolGet(preFight.ShowItem)
	item:setData(showVo, heroVo)
	self.m_showManager:addItem(item, showVo.isAttacker, showVo.index)
end

-- 移除展示项
function __onRemoveShowItemHandler(self, args)
	local showVo = args.showVo
	local heroVo = args.heroVo
	local item = self.m_showManager:getItem(showVo.isAttacker, showVo.index)
	if(not item) then
		return
	end
	self.m_showManager:removeItem(showVo.isAttacker, showVo.index)
	item:dispose()
	LuaPoolMgr:poolRecover(item)
end

-- 移除攻方展示项
function __onRemoveAttShowItemsHandler(self)
	local itemDic = self.m_showManager:getItemDic(true)
	for index, item in pairs(itemDic) do
		local showVo, heroVo = item:getData()
		self.m_showManager:removeItem(showVo.isAttacker, showVo.index)
		item:dispose()
		LuaPoolMgr:poolRecover(item)
	end
end

-- 移除守方展示项
function __onRemoveDefShowItemsHandler(self)
	local itemDic = self.m_showManager:getItemDic(false)
	for index, item in pairs(itemDic) do
		local showVo, heroVo = item:getData()
		self.m_showManager:removeItem(showVo.isAttacker, showVo.index)
		item:dispose()
		LuaPoolMgr:poolRecover(item)
	end
end

----------------------------------------------------------拖拽相关，还差需要暂时禁止多指触屏----------------------------------------------------------
-- 鼠标是否点击了(在此是因为，鼠标点击时，多帧内都为true，需要保证只在点击的那一帧内为true)
m_isClick = nil
-- BoxCollider大小
m_boxSize = nil
-- 是否点中物体
m_isClickGo = nil
-- 拖拽的item transform
m_itemTrans = nil
-- 开始拖拽时item的屏幕坐标
m_ItemScreenPos = nil

-- 拖拽的showVo
m_dragShwVo = nil
-- 当前点击世界坐标和点击item的世界坐标的偏移值
m_offsetPos = nil
-- 当前的矩形碰撞区域（屏幕坐标规则）
m_collisionArea = {index = - 1, startX = - 1, startY = - 1, endX = - 1, endY = - 1}

-- 开始触屏监听
function __startDragListen(self)
	LoopManager:addFrame(1, 0, self, self.__frameUpdate)
end

-- 结束触屏监听
function __endDragListen(self)
	LoopManager:removeFrame(self, self.__frameUpdate)
end

function __frameUpdate(self)
	if(not self.m_isClick and gs.Input:GetMouseButtonDown(0)) then
		self.m_isClick = true
		if(self:__checkIsClick()) then
			self.m_offsetPos = self.m_itemTrans.position - gs.CameraMgr:ScreenToWorldByUICamera(gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y, self.m_ItemScreenPos.z))
		end
	end

	-- 当前鼠标所在的屏幕坐标
	local curScreenPos = gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y,  self.m_ItemScreenPos and self.m_ItemScreenPos.z or gs.Input.mousePosition.z)
	if(self.m_isClickGo) then
		-- 把当前鼠标的屏幕坐标转换成世界坐标
		local curWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(curScreenPos)
		local position = curWorldPos + self.m_offsetPos
		gs.TransQuick:Pos(self.m_itemTrans, position.x, position.y, position.z)
		
		local itemScreenPos = self:__getCenterScreenPos(self.m_itemTrans.position)
		-- 是否已存在矩形碰撞区域，存在则监听是否离开当前区域，不存在则监听是否进入其他区域
		if(self:__isExistArea()) then
			self:__checkLeaveCollision(itemScreenPos)
		else
			self:__checkEnterCollision(itemScreenPos)
		end
		
		-- print("鼠标坐标：(" .. curScreenPos.x .. "，" .. curScreenPos.y .. "，" .. curScreenPos.z .. ")")
		if(self:__isOutScreen(curScreenPos) or gs.Input:GetMouseButtonUp(0)) then
			self.m_isClickGo = false
		end
		
		if(not self.m_isClickGo) then
			self:__checkResult(itemScreenPos)
		end
	end

	if(self:__isOutScreen(curScreenPos) or gs.Input:GetMouseButtonUp(0)) then
		self.m_isClick = false
	end
end

-- 检测结果
function __checkResult(self, itemScreenPos)
	if(self.m_ItemScreenPos == itemScreenPos) then	-- 点击位置（即取消）
		local delHeroVo = self.m_dragShwVo.heroVo
		self.m_dragShwVo.heroVo = nil
		-- 发送事件，和点击取消下阵一样的
		self.m_manager:dispatchEvent(self.m_manager.PREP_FIGHT_SELECT_TEMP_CHANGE, {isSelect = false, tempShowVo = self.m_dragShwVo, changeHeroVo = delHeroVo})
	else
		if(self:__isExistArea()) then
			local exchangeShowVo = self.m_manager:getTempShowVo(self.m_dragShwVo.isAttacker, self.m_collisionArea.index)
			-- if(exchangeShowVo.heroVo) then		--互交换位置
			-- else									--移动到空位置
			-- end
			self.m_showManager:exchangeItem(self.m_dragShwVo.isAttacker, self.m_dragShwVo.index, exchangeShowVo.index)
			self.m_dragShwVo.index, exchangeShowVo.index = exchangeShowVo.index, self.m_dragShwVo.index
			self.m_dragShwVo.pos, exchangeShowVo.pos = exchangeShowVo.pos, self.m_dragShwVo.pos
			
			self.m_showManager:dispatchEvent(self.m_showManager.FINISH_COLLISION_LISTEN, {updateShwVo = self.m_dragShwVo})
			
		else										-- 恢复到原位置
			self.m_showManager:dispatchEvent(self.m_showManager.FINISH_COLLISION_LISTEN, {updateShwVo = self.m_dragShwVo})
		end
	end
	self:__resetCollisionArea()
end

function __checkIsClick(self)
	self.m_isClickGo = false
    local sceneCamera = gs.CameraMgr:GetSceneCamera()
	local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, self.m_showManager.m_raycastLayer, 100)
	if(hitInfo and hitInfo.collider) then
		local item = hitInfo.collider.gameObject
		self.m_dragShwVo = self.m_showManager:getDataByItemHash(item:GetHashCode())
		
		if(self.m_dragShwVo.isAttacker == self.m_manager:getIsAttackerSetting()) then
			self.m_isClickGo = true
			
			self.m_boxSize = item:GetComponent(ty.BoxCollider).size
			self.m_itemTrans = item.transform	--射线碰撞到的物体
			self.m_ItemScreenPos = self:__getCenterScreenPos(self.m_itemTrans.position)
			--print("BoxCollider大小：(" .. self.m_boxSize.x .. "，" .. self.m_boxSize.y .. "，" .. self.m_boxSize.z .. ")")
			--print("目标坐标：(" .. self.m_ItemScreenPos.x .. "，" .. self.m_ItemScreenPos.y .. "，" .. self.m_ItemScreenPos.z .. ")")
		else
			gs.Message.Show("切换攻守方设置，在进行拖动")
		end
	end
	return self.m_isClickGo
end

-- 检测进入矩形碰撞区域
function __checkEnterCollision(self, cusScreenPos)
	local posDic = self.m_manager:getPosDic(self.m_dragShwVo.isAttacker)
	-- 检测矩形大小
	local checkW, checkH = 90, 100
	for index, pos in pairs(posDic) do
		if(index ~= self.m_dragShwVo.index) then
			local screenPos = gs.Vector2(pos.x + gs.Screen.width / 2, pos.y + gs.Screen.height / 2)
			self.m_collisionArea.index = index
			self.m_collisionArea.startX = screenPos.x - checkW / 2
			self.m_collisionArea.startY = screenPos.y - checkH / 2 + self.m_boxSize.y / 2		--调制模型中心
			self.m_collisionArea.endX = screenPos.x + checkW / 2
			self.m_collisionArea.endY = screenPos.y + checkH / 2 + self.m_boxSize.y / 2			--调制模型中心
			if(self:__checkIsInCollision(cusScreenPos)) then
				break
			else
				self:__resetCollisionArea()
			end
		end
	end
	if(self.m_collisionArea.index ~= - 1) then
		print("进入了index：" .. self.m_collisionArea.index)
		print("区域范围：(" .. self.m_collisionArea.startX..","..self.m_collisionArea.startY..","..(self.m_collisionArea.endX-self.m_collisionArea.startX)..","..(self.m_collisionArea.endY-self.m_collisionArea.startY)..")")
		self.m_showManager:dispatchEvent(self.m_showManager.ENTER_OTHER_COLLISION_AREA, {dragShwVo = self.m_dragShwVo, collisionIndex = self.m_collisionArea.index})
	else
		self:__resetCollisionArea()
	end
end

-- 检测离开矩形碰撞区域
function __checkLeaveCollision(self, cusScreenPos)
	if(self.m_collisionArea.index ~= - 1
	and self.m_collisionArea.startX ~= - 1
	and self.m_collisionArea.startY ~= - 1
	and self.m_collisionArea.endX ~= - 1
	and self.m_collisionArea.endY ~= - 1) then
		local isLeave = not self:__checkIsInCollision(cusScreenPos)
		if(isLeave) then
			print("离开了index：" .. self.m_collisionArea.index)
			self.m_showManager:dispatchEvent(self.m_showManager.LEAVE_OTHER_COLLISION_AREA, {dragShwVo = self.m_dragShwVo, collisionIndex = self.m_collisionArea.index})
			self:__resetCollisionArea()
		end
	end
end

-- 重置矩形碰撞区域
function __resetCollisionArea(self)
	self.m_collisionArea.index = - 1
	self.m_collisionArea.startX = - 1
	self.m_collisionArea.startY = - 1
	self.m_collisionArea.endX = - 1
	self.m_collisionArea.endY = - 1
end

-- 检测是否在碰撞区域内
function __checkIsInCollision(self, screenPos)
	if(screenPos.x >= self.m_collisionArea.startX
	and screenPos.x <= self.m_collisionArea.endX
	and screenPos.y >= self.m_collisionArea.startY
	and screenPos.y <= self.m_collisionArea.endY) then
		return true
	end
	return false
end

-- 获取是否存在矩形碰撞区域
function __isExistArea(self)
	if(self.m_collisionArea.index ~= - 1
	and self.m_collisionArea.startX ~= - 1
	and self.m_collisionArea.startY ~= - 1
	and self.m_collisionArea.endX ~= - 1
	and self.m_collisionArea.endY ~= - 1) then
		return true
	else
		return false
	end
end

-- 获取item的中心点的(屏幕坐标)
function __getCenterScreenPos(self, cusItemPos)
	local centerPos = gs.CameraMgr:WorldToScreenByUICamera(cusItemPos)
	centerPos.y = centerPos.y + self.m_boxSize.y / 2
	-- print("拖拽物中心坐标：(" .. centerPos.x .. "，" .. centerPos.y .. "，" .. centerPos.z .. ")");
	return centerPos;
end

function __isOutScreen(self, mouseScreenPos)
	local offset = 1
	if(mouseScreenPos.x <= offset or mouseScreenPos.y <= offset or mouseScreenPos.x >= gs.Screen.width - offset or mouseScreenPos.y >= gs.Screen.height - offset) then
		return true
	end
	return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
