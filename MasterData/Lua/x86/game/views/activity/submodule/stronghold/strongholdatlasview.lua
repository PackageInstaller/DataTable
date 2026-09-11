local StrongholdAtlasView = class("StrongholdAtlasView", ReduxView)

function StrongholdAtlasView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdAtlasUI"
end

function StrongholdAtlasView:UIParent()
	return manager.ui.uiMain.transform
end

function StrongholdAtlasView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdAtlasView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, StrongholdAtlasItem)
	self.typeController = ControllerUtil.GetController(self.transform_, "type")
end

function StrongholdAtlasView:AddUIListener()
	self:AddBtnListener(nil, self.atlasType1Btn, function()
		self:SelectAtlas(0)
	end)
	self:AddBtnListener(nil, self.atlasType2Btn, function()
		self:SelectAtlas(1)
	end)
	self:AddBtnListener(nil, self.atlasType3Btn, function()
		self:SelectAtlas(2)
	end)
	self:AddBtnListener(nil, self.atlasType4Btn, function()
		self:SelectAtlas(3)
	end)
end

function StrongholdAtlasView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function StrongholdAtlasView:OnEnter()
	self.activity_id = self.params_.activity_id

	self:SelectAtlas(0, true)
end

function StrongholdAtlasView:OnExit()
	manager.windowBar:HideBar()
end

function StrongholdAtlasView:SelectAtlas(arg_13_1, arg_13_2)
	if arg_13_1 == self.curIndex_ and not arg_13_2 then
		return
	end

	self.curIndex_ = arg_13_1

	self.typeController:SetSelectedIndex(arg_13_1)

	self.atlas = ActivityStrongholdArtifactCfg.get_id_list_by_type[arg_13_1] or {}

	table.sort(self.atlas, function(arg_14_0, arg_14_1)
		local var_14_0 = StrongholdData:GetAtlasUseCount(self.activity_id, arg_14_0) == 0 and 0 or 1
		local var_14_1 = StrongholdData:GetAtlasUseCount(self.activity_id, arg_14_1) == 0 and 0 or 1

		if var_14_0 == var_14_1 then
			return ActivityStrongholdArtifactCfg[arg_14_0].rare > ActivityStrongholdArtifactCfg[arg_14_1].rare
		else
			return var_14_1 < var_14_0
		end
	end)

	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(self.atlas) do
		if StrongholdData:GetAtlasUseCount(self.activity_id, iter_13_1) ~= 0 then
			var_13_0 = var_13_0 + 1
		end
	end

	self.m_processLab.text = var_13_0 .. "/" .. #self.atlas

	self.list:StartScroll(#self.atlas)
end

function StrongholdAtlasView:Dispose()
	self.list:Dispose()
	StrongholdAtlasView.super.Dispose(self)
end

function StrongholdAtlasView:IndexItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.atlas[arg_16_1], self.activity_id)
end

return StrongholdAtlasView
