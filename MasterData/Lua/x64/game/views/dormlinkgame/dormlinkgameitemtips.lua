local DormLinkGameItemTips = class("DormLinkGameItemTips", ReduxView)

function DormLinkGameItemTips:UIName()
	return "Widget/Version/Alone_LinkGame/Alone_LGExplainPop"
end

function DormLinkGameItemTips:UIParent()
	return manager.ui.uiPop.transform
end

function DormLinkGameItemTips:OnCtor()
	return
end

function DormLinkGameItemTips:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormLinkGameItemTips:InitUI()
	self:BindCfgUI()
end

function DormLinkGameItemTips:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools:Back()
	end)
end

function DormLinkGameItemTips:OnEnter()
	self.itemID = self.params_.itemID

	self:RefreshView()
end

function DormLinkGameItemTips:RefreshView()
	if ActivityLinkGameGoodsCfg[self.itemID] then
		self.title_.text = ActivityLinkGameGoodsCfg[self.itemID].name
		self.text_.text = ActivityLinkGameGoodsCfg[self.itemID].goods_des
		self.icon_.sprite = DormLinkGameTools:GetDormLinkGameItemIcon(DormLinkGameData:GetMainActivityID(), self.itemID)
	end
end

function DormLinkGameItemTips:OnExit()
	return
end

function DormLinkGameItemTips:OnExitInput()
	JumpTools.Back()

	return true
end

function DormLinkGameItemTips:Dispose()
	DormLinkGameItemTips.super.Dispose(self)
end

return DormLinkGameItemTips
