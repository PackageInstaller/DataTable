local var_0_0 = class("QWBlackFadeController")
local var_0_1 = "QWWorld/UI/Story/StoryCross"

function var_0_0.Ctor(arg_1_0)
	arg_1_0.stroyPage = nil
	arg_1_0.timer = nil
	arg_1_0.curCtx = nil
	arg_1_0.startTimestamp = -1
end

function var_0_0.Load(arg_2_0)
	if not arg_2_0.stroyPage then
		local var_2_0 = Asset.Load(var_0_1)
		local var_2_1 = GameObject.Instantiate(var_2_0, manager.ui.uiTips.transform)

		var_2_1.transform:SetAsLastSibling()

		arg_2_0.stroyPage = {
			gameObject = var_2_1,
			transform = var_2_1.transform,
			textComp = var_2_1.transform:Find("Text").gameObject:GetComponent(typeof(Text)),
			textEffect_ = var_2_1.transform:Find("Text").gameObject:GetComponent("UITypewriterEffect"),
			canvasGroup = var_2_1:GetComponent(typeof(CanvasGroup))
		}
	end
end

function var_0_0.UnLoad(arg_3_0)
	arg_3_0:Reset()

	if arg_3_0.stroyPage and not isNil(arg_3_0.stroyPage.gameObject) then
		GameObject.Destroy(arg_3_0.stroyPage.gameObject)
		Asset.Unload(var_0_1)
	end

	arg_3_0.stroyPage = nil
end

function var_0_0.StopTimer(arg_4_0)
	if arg_4_0.timer then
		arg_4_0.timer:Stop()

		arg_4_0.timer = nil
	end
end

function var_0_0.StartFade(arg_5_0, arg_5_1)
	arg_5_0.curCtx = arg_5_1
	arg_5_0.startTimestamp = Time.time

	arg_5_0:Load()
	arg_5_0:StopTimer()

	arg_5_0.stroyPage.textEffect_.percent = 0

	arg_5_0.stroyPage.textEffect_:SetDirty()
	arg_5_0.stroyPage.gameObject:SetActive(true)
	arg_5_0.stroyPage.transform:SetAsLastSibling()

	arg_5_0.stroyPage.canvasGroup.alpha = 0
	arg_5_0.timer = FrameTimer.New(function()
		local var_6_0 = Time.time - arg_5_0.startTimestamp
		local var_6_1 = var_6_0 / arg_5_1.showTimer

		if var_6_1 > 1 then
			var_6_1 = 1
		end

		arg_5_0.stroyPage.canvasGroup.alpha = var_6_1

		if var_6_0 >= arg_5_1.showTimer then
			arg_5_0:StopTimer()

			if arg_5_1.showContent then
				if arg_5_1.centerAction then
					arg_5_1.centerAction()
				end

				manager.gc:Collect()
				Resources.UnloadUnusedAssets()
				arg_5_0:ShowContent()
			elseif arg_5_1.action then
				arg_5_1.action()
			else
				arg_5_0:ContinueFade()
			end
		end
	end, 1, -1)

	arg_5_0.timer:Start()
end

function var_0_0.ShowContent(arg_7_0)
	arg_7_0:Load()

	if arg_7_0.curCtx.content and arg_7_0.curCtx.content > 0 then
		arg_7_0.stroyPage.textComp.text = GetI18NText(SandplayStoryTalkCfg[tonumber(arg_7_0.curCtx.content)].dialogue_text)
	else
		arg_7_0.stroyPage.textComp.text = ""
	end

	arg_7_0:StopTimer()

	arg_7_0.startTimestamp = Time.time
	arg_7_0.timer = FrameTimer.New(function()
		local var_8_0 = Time.time - arg_7_0.startTimestamp
		local var_8_1 = var_8_0 / (arg_7_0.curCtx.contentTime / 1.5)

		if var_8_1 > 1 then
			var_8_1 = 1
		end

		arg_7_0.stroyPage.textEffect_.percent = var_8_1

		arg_7_0.stroyPage.textEffect_:SetDirty()

		if var_8_0 >= arg_7_0.curCtx.contentTime then
			arg_7_0:StopTimer()

			if arg_7_0.curCtx.action then
				arg_7_0.curCtx.action()
			else
				arg_7_0:ContinueFade()
			end
		end
	end, 1, -1)

	arg_7_0.timer:Start()
end

function var_0_0.ContinueFade(arg_9_0)
	arg_9_0:Load()

	arg_9_0.stroyPage.textEffect_.percent = 0

	arg_9_0.stroyPage.textEffect_:SetDirty()

	if arg_9_0.curCtx then
		arg_9_0:StopTimer()

		arg_9_0.startTimestamp = Time.time
		arg_9_0.timer = FrameTimer.New(function()
			local var_10_0 = Time.time - arg_9_0.startTimestamp
			local var_10_1 = var_10_0 / arg_9_0.curCtx.outTimer

			if var_10_1 > 1 then
				var_10_1 = 1
			end

			arg_9_0.stroyPage.canvasGroup.alpha = 1 - var_10_1

			if var_10_0 >= arg_9_0.curCtx.outTimer then
				arg_9_0:StopTimer()

				local var_10_2 = arg_9_0.curCtx.done

				arg_9_0:Reset()

				if var_10_2 then
					var_10_2()
				end
			end
		end, 1, -1)

		arg_9_0.timer:Start()
	end
end

function var_0_0.ForceStop(arg_11_0)
	arg_11_0:Reset()
end

function var_0_0.Reset(arg_12_0)
	arg_12_0:StopTimer()

	arg_12_0.curCtx = nil
	arg_12_0.startTimestamp = -1

	if arg_12_0.stroyPage then
		arg_12_0.stroyPage.gameObject:SetActive(false)
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:UnLoad()
end

return var_0_0
