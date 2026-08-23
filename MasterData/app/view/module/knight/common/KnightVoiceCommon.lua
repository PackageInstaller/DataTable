local var_0_0 = g.core.config.knight_show_info
local var_0_1 = g.core.model.User
local AssistantCommon = require("app.view.module.assistant.common.AssistantCommon")
local var_0_3 = g.core.sound.SoundManager
local var_0_4 = {}

function var_0_4.playLoginVoice()
	local var_1_0 = AssistantCommon.getAssistantData()

	var_0_4.playVoice({
		voiceType = "login_sound",
		knightId = var_1_0.assistantId,
		skinId = var_1_0.skinId
	})
end

function var_0_4:playVoice()
	if g.core.model.User.storyData:isInStory() then
		return
	end

	local var_2_0

	if self.voiceName then
		var_2_0 = self.voiceName
	else
		local var_2_1 = {}
		local var_2_2 = self.voiceType

		var_2_1 = self.knight and self.knight:getVoiceResInfo() or self.resId and var_0_0.fetch(self.resId) or var_0_1.knightsData:getKnightVoiceResInfo(self)

		if var_2_1 and var_2_1[var_2_2] then
			var_2_0 = var_2_1[var_2_2]
		end
	end

	if self.func then
		print(".....")
	end

	if var_2_0 then
		var_0_3:stopCurrentVoice()
		var_0_3:playSound(var_2_0, self.func)
	end
end

function var_0_4.stopVoice()
	var_0_3:stopCurrentVoice()
end

function var_0_4:getVoiceLinesStr(arg_4_1)
	if not g.core.config.knight_show_info.hasKey(arg_4_1 .. "_woman") then
		return self[arg_4_1]
	end

	local var_4_0 = self[arg_4_1 .. "_woman"]

	if self[arg_4_1 .. "_woman"] ~= "" and var_4_0 ~= self[arg_4_1] and not var_0_1:isBoy() then
		return var_4_0
	else
		return self[arg_4_1]
	end
end

return var_0_4
