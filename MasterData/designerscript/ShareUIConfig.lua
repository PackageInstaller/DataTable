-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/DesignerScript\\ShareUIConfig.lua

local ShareUIConfig = {}

ShareUIConfig.UseFrame = {
	getLightBlackHeroDlg = -1,
	drawCardResultLightDlg = -1,
	Miku = 0,
	drawCardOperateDlg = -1,
	handBookTeamDetailDlg = -1,
	homeBg = 0,
	drawCardResultDlg = -1,
	getNewSkinDlg = -1
}
ShareUIConfig.ClosePanel = {
	drawCardOperateDlg = {
		"HeroShowPanel/HighInfoPanel/BtnPanel",
		"HeroShowPanel/HighInfoPanel/SharePanel",
		"BtnOver",
		"HeroShowPanel/HighInfoPanel/TextName/BtnTips"
	},
	drawCardResultDlg = {
		"BtnPanel",
		"SharePanel"
	},
	drawCardResultLightDlg = {
		"BtnPanel",
		"SharePanel"
	},
	getLightBlackHeroDlg = {
		"SharePanel",
		"InfoPanel/TextRule"
	},
	getNewSkinDlg = {
		"SharePanel",
		"InfoPanel/TxtClose",
		"RawImage/Bgtext2",
		"RulePanel"
	},
	homeBg = {
		"InteractPanel",
		"ModelControlPanel"
	},
	handBookTeamDetailDlg = {
		"CommonFuncEntryPanel",
		"BtnClose",
		"MainInfoPanel/InfoPanel",
		"MainInfoPanel/BtnPre",
		"MainInfoPanel/BtnNext",
		"BtnTips"
	},
	getNewPetDlg = {
		"SharePanel"
	},
	heroShowRoomLoveBookDlg = {
		"MainInfoPanel/SharePanel"
	}
}

return ShareUIConfig
