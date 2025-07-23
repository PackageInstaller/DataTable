
module('SubLayerMgr', Class.impl())

function ctor(self)
	self.m_layers = {}
end

--[[
@todo: 设置一些子层
@param: tag 子层的一个标记 用short
@param: subLayername 子层在Hierarchy中的名字
@param: subLayerPrefab 子层对应的预制体资源名
@param: InLayerTrans 子层所在具体的层级
]]
function setTagLayer( self, tag, subLayername, subLayerPrefab, InLayerTrans )
	if self.m_layers[tag] then
		Debug:log_warn('SubLayerMgr', "tag [%d] is in layer !! name [%s] ", tag, subLayername)
		return
	end
	if InLayerTrans==nil then return end
	
	local trans = InLayerTrans:Find(subLayername)
	if trans then
		local layer = trans:GetComponent(ty.Transform)
		self.m_layers[tag] = layer
	else
		local go = AssetLoader.GetGO(subLayerPrefab)
		if not go then
			Debug:log_warn('SubLayerMgr', "[%s] subLayerPrefab can't load game object ", subLayerPrefab)
			return
		end
		go.name = subLayername
		local layer = go:GetComponent(ty.Transform)
		layer:SetParent(InLayerTrans, false)
		gs.TransQuick:LPosZero(InLayerTrans)
		
		self.m_layers[tag] = layer
	end
end

--[[
@todo: 获取对应子层
@param: tag 子层的一个标记 用short
]]
function getLayer( self, tag )
	local subLayer = self.m_layers[tag]
	if subLayer==nil then
		Debug:log_warn('SubLayerMgr', "tag [%d] no sub layer in it !! ", tag)
	end
	return subLayer
end

--[[
@todo: 往对应子层添加对象
@param: tag 子层的一个标记 用short
@param: trans 要添加的对象
]]
function add2Layer( self, tag, trans )
	local subLayer = self:getLayer(tag)
	if subLayer then
		gs.TransQuick.SetParentOrg(trans, subLayer)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
