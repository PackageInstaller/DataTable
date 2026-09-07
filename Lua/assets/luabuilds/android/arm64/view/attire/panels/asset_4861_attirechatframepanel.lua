local AttireChatFramePanel = class("AttireChatFramePanel", import(".AttireFramePanel"))
local var_0_1 = setmetatable

local function var_0_2(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = AttireFramePanel.Card(arg_1_0)

	local function var_1_2(arg_3_0, arg_3_1, arg_3_2)
		setAnchoredPosition(arg_3_1, Vector2.zero)
		setText(arg_3_1.transform:Find("Text"), "")

		return
	end

	function var_1_0:Update(arg_4_1, arg_4_2, arg_4_3)
		var_1_1:Update(arg_4_1, arg_4_2, arg_4_3)
		self:ReturnIconFrame(AttireConst.TYPE_CHAT_FRAME)

		if self:isEmpty() then
			return
		end

		self:LoadPrefab(arg_4_1, function(arg_5_0)
			var_1_2(self, arg_5_0, arg_4_1)

			return
		end)

		return
	end

	function var_1_0:Dispose()
		self:ReturnIconFrame(AttireConst.TYPE_CHAT_FRAME)

		return
	end

	;(function(arg_2_0)
		return
	end)(var_1_0)

	return var_0_1(var_1_0, {
		__index = var_1_1
	})
end

function AttireChatFramePanel:getUIName()
	return "AttireChatFrameUI"
end

function AttireChatFramePanel:GetData()
	return self.rawAttireVOs.chatFrames
end

function AttireChatFramePanel:OnInitItem(arg_9_1)
	local var_9_0 = var_0_2(arg_9_1)

	self.cards[arg_9_1] = var_9_0

	onButton(self, var_9_0._go, function()
		if var_9_0:isEmpty() then
			return
		end

		if self.card then
			self.card:UpdateSelected(false)
		end

		self.contextData.chatFrameIndex = var_9_0.attireFrame.id

		self:UpdateDesc(var_9_0)
		var_9_0:UpdateSelected(true)

		self.card = var_9_0

		return
	end, SFX_PANEL)

	return
end

function AttireChatFramePanel:GetColumn()
	return 3
end

function AttireChatFramePanel:OnUpdateItem(arg_12_1, arg_12_2)
	AttireChatFramePanel.super.OnUpdateItem(self, arg_12_1, arg_12_2)

	local var_12_0 = self.cards[arg_12_2]

	if self.cards[arg_12_2].attireFrame.id == (self.contextData.chatFrameIndex or self.displayVOs[1].id) then
		triggerButton(var_12_0._go)
		var_12_0:UpdateSelected(true)
	end

	return
end

return AttireChatFramePanel
