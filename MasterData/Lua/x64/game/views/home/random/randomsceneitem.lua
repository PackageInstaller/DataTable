local RandomSceneItem = class("RandomSceneItem", ReduxView)

function RandomSceneItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RandomSceneItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RandomSceneItem:InitUI()
	self:BindCfgUI()

	self.icon_.immediate = true
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function RandomSceneItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function RandomSceneItem:RefreshData(arg_6_1, arg_6_2, arg_6_3)
	self.id_ = arg_6_1
	self.cfg_ = HomeSceneSettingCfg[self.id_]
	self.title_.text = self.cfg_.title
	self.source_.text = self.cfg_.obtain_word
	self.icon_.spriteSync = "TextureConfig/SceneChangeUI/item/" .. self.id_

	self:RefreshType(arg_6_2, arg_6_3)
end

function RandomSceneItem:RefreshType(arg_7_1, arg_7_2)
	self.selectCon_:SetSelectedState(arg_7_2 and "true" or "false")

	if arg_7_1 == 0 then
		if #self.cfg_.obtain_way > 0 and not JumpTools.NeedHide(self.cfg_.obtain_way, self.id_) then
			self.typeCon_:SetSelectedState("get")
		else
			self.typeCon_:SetSelectedState("ban")
		end
	elseif HomeSceneSettingData:GetCurScene() == self.id_ then
		if arg_7_1 == 1 then
			self.typeCon_:SetSelectedState("trial")
		elseif arg_7_1 == 2 then
			self.typeCon_:SetSelectedState("normal")
		end
	else
		self.typeCon_:SetSelectedState("normal")
	end
end

function RandomSceneItem:RegistClickFunc(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function RandomSceneItem:OnExit()
	return
end

function RandomSceneItem:Dispose()
	self:RemoveAllListeners()
	RandomSceneItem.super.Dispose(self)
end

return RandomSceneItem
