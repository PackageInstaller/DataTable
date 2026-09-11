local QWorldHintView = class("QWorldHintView", ReduxView)

function QWorldHintView:UIName()
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_HintUI"
end

function QWorldHintView:Init()
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiPop.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AdaptScreen()
	self:AddUIListener()

	self.hasTagController_ = self.controller_:GetController("hasTag")
	self.stateController_ = self.controller_:GetController("state")
	self.itemList_ = {}
end

function QWorldHintView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		QWorldMgr:GetQWorldTagMgr():GotoTag(self.tag_, self.entityId)
	end)
end

function QWorldHintView:DisplayHint(arg_5_1, arg_5_2)
	if isNil(self.gameObject_) then
		self:Init()
	end

	SetActive(self.gameObject_, true)

	if arg_5_1 then
		SetActive(self.eventGo_, true)
		self.hintAni_:Play("UI_SandPlay_Hint_cx", -1, 0)
		self.hintAni_:Update(0)
		self:Refresh(arg_5_1)
	elseif not arg_5_2 or #arg_5_2 == 0 then
		self:HideHintTips()
	end

	self.isShow_ = true

	self.transform_:SetAsLastSibling()

	if arg_5_2 and #arg_5_2 > 0 then
		SetActive(self.bookGo_, true)

		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			self.itemList_[iter_5_0] = self.itemList_[iter_5_0] or QWorldHintItem.New((Object.Instantiate(self.bookTipsGo_, self.bookBaseTrs_)))

			self.itemList_[iter_5_0]:SetData(iter_5_1)
			self.itemList_[iter_5_0]:Show(true)
		end

		for iter_5_2 = #arg_5_2 + 1, #self.itemList_ do
			self.itemList_[iter_5_2]:Show(false)
		end
	else
		SetActive(self.bookGo_, false)
	end
end

function QWorldHintView:Refresh(arg_6_1)
	self.id_ = arg_6_1
	self.cfg_ = SandPlayHintCfg[arg_6_1]

	if not self.cfg_ then
		Debug.LogError("有不存在的Hint ID：" .. arg_6_1)

		return
	end

	self.icon_.spriteAsync = "TextureConfig/SandPlay/MiniIcon/" .. self.cfg_.icon
	self.desc_.text = GetI18NText(self.cfg_.desc)
	self.tag_ = self.cfg_.tag

	self.hasTagController_:SetSelectedState(tostring(self.tag_ ~= 0))

	if arg_6_1 == 323641001 then
		self.stateController_:SetSelectedState("photo")
	else
		self.stateController_:SetSelectedState("normal")
	end
end

function QWorldHintView:HideHint(arg_7_1)
	if isNil(self.gameObject_) then
		self:Init()
	end

	if self.itemList_ then
		for iter_7_0, iter_7_1 in ipairs(self.itemList_) do
			if iter_7_1 and iter_7_1.Dispose then
				iter_7_1:Dispose()
			end
		end

		self.itemList_ = {}
	end

	self:HideHintTips(arg_7_1)

	self.isShow_ = false
end

function QWorldHintView:HideHintTips(arg_8_1)
	if self.hideTimer_ then
		self.hideTimer_:Stop()

		self.hideTimer_ = nil
	end

	if not arg_8_1 then
		if self.hintAni_ then
			self.hintAni_:Play("UI_SandPlay_Hint_xs", -1, 0)
			self.hintAni_:Update(0)

			self.hideTimer_ = Timer.New(function()
				SetActive(self.eventGo_, false)
				SetActive(self.gameObject_, false)
			end, 0.1, 1)

			self.hideTimer_:Start()
		end
	else
		SetActive(self.eventGo_, false)
		SetActive(self.gameObject_, false)
	end
end

function QWorldHintView:Dispose()
	QWorldHintView.super.Dispose(self)

	if self.hideTimer_ then
		self.hideTimer_:Stop()

		self.hideTimer_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
	self.hintAni_ = nil
end

return QWorldHintView
