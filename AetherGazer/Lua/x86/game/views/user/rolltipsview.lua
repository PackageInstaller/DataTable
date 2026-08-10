local var_0_0 = class("RollTipsView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)

	arg_2_0.bgimage_.sprite = AssetEx.LoadSprite("TextureConfig/Common/bg_funeng_details", true)
	arg_2_0.btnimage_.sprite = AssetEx.LoadSprite("TextureConfig/Common/Popup_common_b", true)
	arg_2_0.iconiamge_.sprite = AssetEx.LoadSprite("TextureConfig/Common/icon_ShutDown", true)

	arg_2_0:AddUIListeners()
end

function var_0_0.Play(arg_3_0, arg_3_1)
	arg_3_0.showString_ = arg_3_1
	arg_3_0.showtext_.text = GetI18NText(arg_3_0.showString_)
	arg_3_0.texttrans_.sizeDelta = Vector2.New(ExStringCount(arg_3_0.showtext_.text) * arg_3_0.showtext_.fontSize / 2, arg_3_0.texttrans_.rect.height)
	arg_3_0.texttrans_.localPosition = Vector3.New(0, 0, 0)

	if arg_3_0.timer_ == nil then
		arg_3_0.timer_ = FrameTimer.New(function()
			if LuaExchangeHelper.GetSceneIsHanding() then
				return
			elseif -arg_3_0.texttrans_.localPosition.x < arg_3_0.contenttrans_.rect.width + arg_3_0.texttrans_.rect.width then
				local var_4_0 = -100

				arg_3_0.texttrans_.localPosition = Vector3.New(arg_3_0.texttrans_.localPosition.x + var_4_0 * Time.deltaTime, 0, 0)
			else
				arg_3_0:StopTimer()
				SetActive(arg_3_0.gameObject_, false)
			end
		end, 1, -1)

		arg_3_0.timer_:Start()
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0.closebtn_.onClick:AddListener(function()
		arg_5_0:StopTimer()
		SetActive(arg_5_0.gameObject_, false)
	end)
end

function var_0_0.Dispose(arg_7_0)
	AssetEx.UnloadSprite("TextureConfig/Common/bg_funeng_details", true)
	AssetEx.UnloadSprite("TextureConfig/Common/Popup_common_b", true)
	AssetEx.UnloadSprite("TextureConfig/Common/icon_ShutDown", true)
	arg_7_0:StopTimer()
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

return var_0_0
