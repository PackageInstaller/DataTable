module('preFight.ShowItem', Class.impl())

m_modelShowVo = nil
m_heroVo = nil
m_itemPrefabName = "ModelShowItem.prefab"

m_itemGo = nil
m_modelGo = nil
m_childDic = {}

function setData(self, showVo, heroVo)
	self.m_modelShowVo = showVo
	self.m_heroVo = heroVo
	
	self:__addEvent()
	self:parseGo()
end

function getData(self)
	return self.m_modelShowVo, self.m_heroVo
end

function parseGo(self)
	self.m_modelGo = gs.GOPoolMgr:Get(self.m_heroVo.prefabName)
	local modelTrans = self.m_modelGo.transform
	gs.TransQuick:SetRotation(modelTrans, 0, self.m_modelShowVo.isAttacker and 100 or - 100, 0)
    gs.TransQuick:Scale(modelTrans, 70, 70, 70)
	gs.TransQuick:Pos(modelTrans, 0, 0, 50)
	self.m_itemGo = gs.GOPoolMgr:Get(self.m_itemPrefabName)
	self:parseChild(self.m_itemGo)
	local showItemTrans = self.m_itemGo.transform
	gs.TransQuick:LPos(showItemTrans, self.m_modelShowVo.pos.x, self.m_modelShowVo.pos.y, self.m_modelShowVo.pos.z)
	local emptyLayer = preFight.ShowManager:getLayerGo()
	showItemTrans:SetParent(emptyLayer.transform, false)
	
	modelTrans:SetParent(self.m_itemGo.transform, false)
	gs.GoUtil.ChangeLayer(self.m_itemGo, preFight.ShowManager.m_raycastLayer)
	
	self:updateView()
end

function parseChild(self, cusGo)
	local childGoDic, childTranDic = GoUtil.GetChildHash(cusGo)
	self.m_childDic[self.m_itemPrefabName] = {childGoDic = childGoDic, childTranDic = childTranDic}
end

function __addEvent(self)
	preFight.ShowManager:addEventListener(preFight.ShowManager.ENTER_OTHER_COLLISION_AREA, self.__onEnterHandler, self)
	preFight.ShowManager:addEventListener(preFight.ShowManager.LEAVE_OTHER_COLLISION_AREA, self.__onLeaveHandler, self)
	preFight.ShowManager:addEventListener(preFight.ShowManager.FINISH_COLLISION_LISTEN, self.__onFinishHandler, self)
end

function __removeEvent(self)
	preFight.ShowManager:removeEventListener(preFight.ShowManager.ENTER_OTHER_COLLISION_AREA, self.__onEnterHandler, self)
	preFight.ShowManager:removeEventListener(preFight.ShowManager.LEAVE_OTHER_COLLISION_AREA, self.__onLeaveHandler, self)
	preFight.ShowManager:removeEventListener(preFight.ShowManager.FINISH_COLLISION_LISTEN, self.__onFinishHandler, self)
end

function __onEnterHandler(self, args)
	if(args.dragShwVo.isAttacker == self.m_modelShowVo.isAttacker and args.collisionIndex == self.m_modelShowVo.index) then
		gs.TransQuick:LPos(self.m_itemGo.transform, args.dragShwVo.pos.x, args.dragShwVo.pos.y, args.dragShwVo.pos.z)
	end
end

function __onLeaveHandler(self, args)
	if(args.dragShwVo.isAttacker == self.m_modelShowVo.isAttacker and args.collisionIndex == self.m_modelShowVo.index) then
		gs.TransQuick:LPos(self.m_itemGo.transform, args.m_modelShowVo.pos.x, args.m_modelShowVo.pos.y, args.m_modelShowVo.pos.z)
	end
end

function __onFinishHandler(self, args)
	if(args.updateShwVo.isAttacker == self.m_modelShowVo.isAttacker and args.updateShwVo.index == self.m_modelShowVo.index) then
		gs.TransQuick:LPos(self.m_itemGo.transform, args.m_modelShowVo.pos.x, args.m_modelShowVo.pos.y, args.m_modelShowVo.pos.z)
	end
end

function updateView(self)
	self.m_childDic[self.m_itemPrefabName].childGoDic["m_textLvl"]:GetComponent(ty.Text).text = self.m_heroVo.name
end

function compareHash(self, cusHashCode)
	if(cusHashCode == self.m_itemGo:GetHashCode()) then
		return true
	end
	return false
end

function dispose(self)
	self:__removeEvent()
	if(self.m_itemGo) then
		gs.GOPoolMgr:Recover(self.m_itemGo, self.m_itemPrefabName)
	end
	if(self.m_modelGo) then
		gs.GOPoolMgr:Recover(self.m_modelGo, self.m_heroVo.prefabName)
	end
	self.m_itemGo = nil
	self.m_modelGo = nil
	self.m_modelShowVo = nil
	self.m_heroVo = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
