local var_0_0 = class("LoginSeverSelectPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = arg_3_0.m_controller:GetController("select")
	arg_3_0.playerController = arg_3_0.m_controller:GetController("player")
	arg_3_0.maintainController = arg_3_0.m_controller:GetController("maintain")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		_G.SELECT_REGION_SEVER_ID = arg_4_0.data.serverId

		manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
		PlayerPrefs.SetString("RegionServerId", arg_4_0.data.serverId)
		arg_4_0:Back()
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data = arg_6_1
	arg_6_0.m_serverName.text = arg_6_1.serverName

	if arg_6_1.maintain then
		arg_6_0.maintainController:SetSelectedIndex(1)
	else
		arg_6_0.maintainController:SetSelectedIndex(0)
	end

	if arg_6_1.serverId == _G.SELECT_REGION_SEVER_ID then
		arg_6_0.selectController:SetSelectedIndex(1)
	else
		arg_6_0.selectController:SetSelectedIndex(0)
	end

	local var_6_0 = GetSDKLoginInfo()

	if arg_6_1.player and var_6_0 then
		arg_6_0.playerController:SetSelectedIndex(1)

		arg_6_0.m_playerName.text = arg_6_1.player.nickName
		arg_6_0.m_playerLv.text = GetTipsF("REGION_SERVER_PLAYER_LEVEL", arg_6_1.player.currentLevel)
	else
		arg_6_0.playerController:SetSelectedIndex(0)
	end

	if arg_6_1.newServerFlag == 1 then
		SetActive(arg_6_0.m_newTag, true)
	else
		SetActive(arg_6_0.m_newTag, false)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
