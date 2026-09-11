local HeroInteractionGMView = class("HeroInteractionGMView", ReduxView)

function HeroInteractionGMView:UIName()
	return "UI/HeroInteractionGMUI"
end

function HeroInteractionGMView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroInteractionGMView:OnCtor()
	self.btnPool_ = {}
	self.curBtnCount_ = 0
	self.skinId_ = -1
	self.inited_ = false
end

function HeroInteractionGMView:Init()
	self:InitUI()
end

function HeroInteractionGMView:InitUI()
	self.backgroundBtn_ = self:FindCom("Button", "background")
	self.btn_prefab = self:FindGo("HeroInteractionBut_prefab")
	self.panel_go = self:FindTrs("panel")
	self.btn_list = {}
	self.btnGo_list = {}
	self.skinId_ = self.params_.skinId

	if self.skinId_ == nil then
		print("skinId 为 nil")
	end

	self.animator_ = self.params_.animator

	if self.inited_ == false then
		self:InitData()
		self:AddUIListener()

		self.inited_ = true
	end
end

function HeroInteractionGMView:OnEnter()
	self.skinId_ = self.params_.skinId

	if self.skinId_ == nil then
		print("skinId 为 nil")
	end

	self.animator_ = self.params_.animator

	if self.inited_ == false then
		self:InitData()
		self:AddUIListener()
	end
end

function HeroInteractionGMView:InitData()
	if SkinCfg[self.skinId_].hero == nil then
		print("heroID 为 nil")
	end

	self.interactionCfg_ = HeroTools.GetOldInteractionCfg(SkinCfg[self.skinId_].hero)

	if self.interactionCfg_ == nil then
		print("self.interactionCfg_ 为 nil")
	end

	self.actionTypeList_ = {}

	if self.interactionCfg_ ~= nil then
		for iter_7_0, iter_7_1 in pairs(self.interactionCfg_) do
			if type(self.interactionCfg_[iter_7_0]) == "table" and #self.interactionCfg_[iter_7_0] ~= 0 and string.find(iter_7_0, "delay") == nil and string.find(iter_7_0, "talk") == nil and string.find(iter_7_0, "weight") == nil then
				table.insert(self.actionTypeList_, iter_7_0)
			end
		end
	end

	self:GenBtn()
end

function HeroInteractionGMView:GenBtn()
	if self.actionTypeList_ ~= nil and #self.actionTypeList_ > 0 then
		local var_8_0

		for iter_8_0, iter_8_1 in ipairs(self.actionTypeList_) do
			if #self.btnPool_ > self.curBtnCount_ then
				self.curBtnCount_ = self.curBtnCount_ + 1
				var_8_0 = self.btnPool_[self.curBtnCount_]

				SetActive(self.btnPool_[self.curBtnCount_], true)
			else
				var_8_0 = Object.Instantiate(self.btn_prefab, self.panel_go)
				self.curBtnCount_ = self.curBtnCount_ + 1

				table.insert(self.btnPool_, var_8_0)

				local var_8_3 = var_8_0:GetComponent(typeof(Button))

				if var_8_3 == nil then
					print("button_:按钮为空")
				end

				table.insert(self.btn_list, var_8_3)
			end

			local var_8_4 = var_8_0:GetComponentInChildren(typeof(Text))

			if var_8_4 ~= nil then
				var_8_4.text = GetI18NText(iter_8_1)
			else
				print("btn_text为空")
			end
		end
	end
end

function HeroInteractionGMView:AddUIListener()
	for iter_9_0, iter_9_1 in ipairs(self.btn_list) do
		self:AddBtnListener(iter_9_1, nil, function()
			JumpTools.GoToSystem("heroInteractionGMContent", {
				typeName = self.actionTypeList_[iter_9_0],
				skinId = self.skinId_,
				animator = self.animator_
			})
		end)
	end

	self:AddBtnListener(self.backgroundBtn_, nil, function()
		self:Back()
	end)
end

function HeroInteractionGMView:OnExit()
	self:RemoveAllListeners()

	for iter_12_0 = 1, self.curBtnCount_ do
		SetActive(self.btnPool_[iter_12_0], false)
	end

	self.curBtnCount_ = 0
	self.inited_ = false
	self.animator_ = nil
end

function HeroInteractionGMView:Dispose()
	self.btn_list = nil

	if self.btnPool_ then
		for iter_13_0, iter_13_1 in ipairs(self.btnPool_) do
			Object.Destroy(iter_13_1)
		end

		self.btnPool_ = nil
	end

	HeroInteractionGMView.super.Dispose(self)
end

return HeroInteractionGMView
