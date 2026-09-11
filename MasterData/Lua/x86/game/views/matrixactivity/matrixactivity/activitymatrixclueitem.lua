local ActivityMatrixClueItem = class("ActivityMatrixClueItem", ReduxView)

function ActivityMatrixClueItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityMatrixClueItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixClueItem:InitUI()
	self:BindCfgUI()
end

function ActivityMatrixClueItem:AddUIListener()
	return
end

function ActivityMatrixClueItem:SetData(arg_5_1)
	self.m_name.text = GetI18NText(ActivityMatrixClueCfg[arg_5_1].name)
	self.m_node.text = GetI18NText(ActivityMatrixClueCfg[arg_5_1].note)
	self.m_des.text = GetI18NText(ActivityMatrixClueCfg[arg_5_1].desc)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIUI/icon/" .. ActivityMatrixClueCfg[arg_5_1].icon)
end

function ActivityMatrixClueItem:Dispose()
	ActivityMatrixClueItem.super.Dispose(self)
end

return ActivityMatrixClueItem
