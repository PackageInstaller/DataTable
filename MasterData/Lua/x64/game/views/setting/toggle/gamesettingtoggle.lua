local GameSettingToggle = class("GameSettingToggle", BaseSettingToggle)

function GameSettingToggle:Ctor(arg_1_1)
	self.info_ = arg_1_1
end

function GameSettingToggle:GetName()
	return "Game"
end

function GameSettingToggle:UIClass()
	return GameSettingView
end

function GameSettingToggle:GetPath()
	return "Widget/System/Setting/GameSettingUI"
end

function GameSettingToggle:Order()
	return 13
end

function GameSettingToggle:RedPointKey()
	return {
		RedPointConst.SETING_GAME_RED
	}
end

function GameSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting03")
end

function GameSettingToggle:GetParams()
	return self.info_
end

function GameSettingToggle:IsSetting()
	return true
end

return GameSettingToggle
