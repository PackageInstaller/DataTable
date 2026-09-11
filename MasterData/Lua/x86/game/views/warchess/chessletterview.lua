local ChessLetterView = class("ChessLetterView", ReduxView)
local var_0_1 = {
	Playing = 2,
	Stop = 3,
	Init = 1
}
local var_0_3 = 1
local var_0_4 = 1.5
local var_0_5 = 0.5
local var_0_6 = false

function ChessLetterView:UIName()
	return "Widget/System/WarChess_Battle/WarChessLetterUI"
end

function ChessLetterView:UIParent()
	return manager.ui.uiMain.transform
end

function ChessLetterView:Init()
	self:InitUI()
	self:AddUIListener()

	self.typeTime_ = 0
	self.textComs = {}
end

function ChessLetterView:InitUI()
	self:BindCfgUI()
end

function ChessLetterView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.state_ == var_0_1.Playing then
			-- block empty
		elseif self.state_ == var_0_1.Stop then
			if self.contentID_ == 0 then
				self:Back()
				self.callBack()
			else
				self.state_ = var_0_1.Init
				var_0_6 = false
			end
		end
	end)
end

function ChessLetterView:OnEnter()
	self.callBack = self.params_.callBack
	self.handle = self.handle or FuncTimerManager.inst:CreateFuncFrameTimer(function()
		self:Update()
	end, -1, true)
	var_0_6 = true
	self.state_ = var_0_1.Init
	self.contentID_ = self.params_.ID
	self.scrollbar_.value = 1
end

function ChessLetterView:OnExit()
	if self.handle then
		FuncTimerManager.inst:RemoveFuncTimer(self.handle)

		self.handle = nil
	end
end

function ChessLetterView:Update()
	self:Play(Time.deltaTime)
end

function ChessLetterView:Play(arg_11_1)
	if self.state_ == var_0_1.Init then
		self.pageText_ = ""
		self.typeTime_ = 0

		local var_11_0 = 1
		local var_11_1 = -1

		while true do
			if self.contentID_ == 0 then
				error("WarchessContentCfg配置错误")
			end

			local var_11_2 = WarchessContentCfg[self.contentID_]
			local var_11_3 = WarchessContentCfg[self.contentID_].alignment or 0

			if var_11_1 == -1 then
				self.pageText_ = self.pageText_ .. GetI18NText(var_11_2.content)
				var_11_1 = var_11_3
			elseif var_11_1 == var_11_3 then
				self.pageText_ = self.pageText_ .. "\n" .. GetI18NText(var_11_2.content)
			else
				self:CreateText(var_11_0, var_11_1, self.pageText_)

				self.pageText_ = GetI18NText(var_11_2.content)
				var_11_0 = var_11_0 + 1
				var_11_1 = var_11_3
			end

			self.contentID_ = var_11_2.next

			if var_11_2.page_end ~= 0 then
				self:CreateText(var_11_0, var_11_1, self.pageText_)

				break
			end
		end

		for iter_11_0 = var_11_0 + 1, #self.textComs do
			SetActive(self.textComs[iter_11_0].gameObject, false)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.textContent_)

		if var_0_6 then
			self:SetTextColor(Color(1, 1, 1, 0))
		end

		self.state_ = var_0_1.Playing
	elseif self.state_ == var_0_1.Playing then
		self.typeTime_ = self.typeTime_ + arg_11_1

		if var_0_6 then
			if self.typeTime_ > var_0_4 then
				self.state_ = var_0_1.Stop
			else
				local var_11_4 = self.typeTime_ / var_0_3

				self:SetTextColor(Color(1, 1, 1, var_11_4 * var_11_4))
			end
		elseif self.typeTime_ > var_0_5 then
			self.state_ = var_0_1.Stop
		end
	elseif self.state_ == var_0_1.Stop then
		-- block empty
	else
		error("错误的State")
	end
end

function ChessLetterView:CreateText(arg_12_1, arg_12_2, arg_12_3)
	if not self.textComs[arg_12_1] then
		local var_12_0 = Object.Instantiate(self.textText_, self.textContent_)

		var_12_0.transform.sizeDelta = Vector2.New(self.textContent_.rect.width, 0)
		self.textComs[arg_12_1] = var_12_0:GetComponent(typeof(Text))
	end

	print("<color=#00ff00>CreateText</color> Network connected")
	SetActive(self.textComs[arg_12_1].gameObject, true)

	self.textComs[arg_12_1].alignment = self:GetAlignmentNum(arg_12_2)
	self.textComs[arg_12_1].text = GetI18NText(arg_12_3)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.textContent_)
end

function ChessLetterView:SetTextColor(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.textComs) do
		iter_13_1.color = arg_13_1
	end
end

function ChessLetterView:GetAlignmentNum(arg_14_1)
	if arg_14_1 == 1 then
		return UnityEngine.TextAnchor.UpperCenter
	elseif arg_14_1 == 2 then
		return UnityEngine.TextAnchor.UpperRight
	else
		return UnityEngine.TextAnchor.UpperLeft
	end
end

function ChessLetterView:Dispose()
	self.textComs = {}

	ChessLetterView.super.Dispose(self)
end

return ChessLetterView
