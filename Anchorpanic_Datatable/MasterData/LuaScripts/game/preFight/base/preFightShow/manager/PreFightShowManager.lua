module("preFight.ShowManager", Class.impl("game.preFight.base.preFightShow.manager.PreFightShowEventDispatcher"))


-------------------展示模型操作事件-----------------------------
-- 通知初始化
START_INIT = "START_INIT"
-- 通知回收
START_RECOVERY = "START_RECOVERY"

-- 添加展示项
ADD_SHOW_ITEM = "ADD_SHOW_ITEM"
-- 移除展示项
REMOVE_SHOW_ITEM = "REMOVE_SHOW_ITEM"

-- 移除攻方展示项
REMOVE_ATT_SHOW_ITEMS = "REMOVE_ATT_SHOW_ITEMS"
-- 移除守方展示项
REMOVE_DEF_SHOW_ITEMS = "REMOVE_DEF_SHOW_ITEMS"

-- 拖拽物体进入其他碰撞区域
ENTER_OTHER_COLLISION_AREA = "ENTER_OTHER_COLLISION_AREA"
-- 拖拽物体离开其他碰撞区域
LEAVE_OTHER_COLLISION_AREA = "LEAVE_OTHER_COLLISION_AREA"
-- 拖拽结束
FINISH_COLLISION_LISTEN = "FINISH_COLLISION_LISTEN"

------------------------------------------------------------

--构造函数
function ctor(self)
	super.ctor(self)
	self:__initData()
end

function __initData(self)
	-------------------一些界面设置-----------------------------
	-- 旧的平面距离
	self.m_oldPlaneDistance = nil
	-- 需要调整层次的节点
	self.m_oldModifyPos = {}
	
	-- 一个临时的父节点
	self.m_emptyLayer = nil
	self.m_layerPrefabName = "EmptyLayer.prefab"

	-------------------一些数据-----------------------------
	-- 展示item字典
	self.m_attItemGoDic = {}
	self.m_defItemGoDic = {}
	self.m_raycastLayer = "UI_ANIMATION"
end

-- 初始化
function init(self)
	if(self.m_emptyLayer) then
		return
	end
	local planeDistance = 50
	local uiRootCanvas = GameView.stage:GetComponent(ty.Canvas)
	self.m_oldPlaneDistance = uiRootCanvas.planeDistance

	self.m_emptyLayer = gs.GOPoolMgr:Get(self.m_layerPrefabName)
	local rect = self.m_emptyLayer:GetComponent(ty.RectTransform)
	gs.TransQuick:Pos(rect, 0, 0, -gs.CameraMgr:GetWorldDis()/2)
    gs.TransQuick:Anchor(rect, 0, 0, 1, 1)
    gs.TransQuick:Offset(rect, 0, 0, 0, 0)
	self.m_emptyLayer.transform:SetParent(GameView.pop, false)
	
	local modifyList = {GameView.subPop, GameView.guide, GameView.loading, GameView.alert, GameView.msg}
	for _, trans in pairs(modifyList) do
		local rect = trans:GetComponent(ty.RectTransform)
		self.m_oldModifyPos[trans] = gs.Vector3(rect.anchoredPosition3D.x, rect.anchoredPosition3D.y, rect.anchoredPosition3D.z)
		rect.anchoredPosition3D = gs.Vector3(rect.anchoredPosition3D.x, rect.anchoredPosition3D.y, -gs.CameraMgr:GetWorldDis())
	end
end

function getLayerGo(self)
	return self.m_emptyLayer
end

function getItemDic(self, cusIsAttacker)
	local dic
	if(cusIsAttacker) then
		dic = self.m_attItemGoDic
	else
		dic = self.m_defItemGoDic
	end
	return dic
end

function exchangeItem(self, cusIsAttacker, cusIndex_1, cusIndex_2)
	local dic = self:getItemDic(cusIsAttacker)
	dic[cusIndex_1], dic[cusIndex_2] = dic[cusIndex_2], dic[cusIndex_1]
end

function getItem(self, cusIsAttacker, cusIndex)
	local dic = self:getItemDic(cusIsAttacker)
	return dic[cusIndex]
end

function getDataByItemHash(self, cusHashCode)
	for index, item in pairs(self.m_attItemGoDic) do
		if(item:compareHash(cusHashCode)) then
			return item:getData()
		end
	end
	for index, item in pairs(self.m_defItemGoDic) do
		if(item:compareHash(cusHashCode)) then
			return item:getData()
		end
	end
end

function addItem(self, cusItem, cusIsAttacker, cusIndex)
	local dic = self:getItemDic(cusIsAttacker)
	dic[cusIndex] = cusItem
end

function removeItem(self, cusIsAttacker, cusIndex)
	local dic = self:getItemDic(cusIsAttacker)
	dic[cusIndex] = nil
end

-- 重置界面的设置
function reset(self)
	gs.GOPoolMgr:Recover(self.m_emptyLayer, self.m_layerPrefabName)
	self.m_emptyLayer = nil
	
	local uiRootCanvas = GameView.stage:GetComponent(ty.Canvas)
	uiRootCanvas.planeDistance = self.m_oldPlaneDistance
	self.m_oldPlaneDistance = 0
	
	for trans, oldPos in pairs(self.m_oldModifyPos) do
		local rect = trans:GetComponent(ty.RectTransform)
		rect.anchoredPosition3D = oldPos
	end
	self.m_oldModifyPos = {}
end

--析构函数
function dtor(self)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
