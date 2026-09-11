local var_0_0 = {
	Play900102003 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 900102003
		arg_1_1.duration_ = 1.03

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play900102004(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.Volume == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "Volume")
				var_4_0.name = "Volume"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.Volume = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.Volume

				arg_1_1.bgs_.Volume.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "Volume" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				SetActive(arg_1_1.hideBtn_, false)
				SetActive(arg_1_1.narrativeGo_, true)
				SetActive(arg_1_1.lastBtn_.gameObject, false)
				SetActive(arg_1_1.bgmBtn_.gameObject, false)

				arg_1_0.narr_chapter_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900102001).content)
				arg_1_0.narr_time_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900102002).content)
				arg_1_1.narrativeListGo_.movementType = ScrollRect.MovementType.Clamped

				local var_4_4 = arg_1_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_4_4 then
					var_4_4.raycastTarget = false
				end

				SetActive(arg_1_1.narrativeContinueBtn_.gameObject, false)
			end

			local var_4_5 = 0.0334

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0.0334 < arg_1_1.time_ and arg_1_1.time_ <= 0.0334 + arg_4_0 then
				local var_4_6 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_7 = var_4_6:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_6)

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900102003).content)

				var_4_6.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_6.transform.localPosition = Vector3(0, 0, 0)
				var_4_6.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_6, true)
			end

			local var_4_8 = 1

			if 0.0334 <= arg_1_1.time_ and arg_1_1.time_ < 0.0334 + var_4_8 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0.0334 + var_4_8 and arg_1_1.time_ < 0.0334 + var_4_8 + arg_4_0 then
				-- block empty
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play900102004 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 900102004
		arg_6_1.duration_ = 1

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play900102005(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_6_0, arg_6_1.narrativeGo_)

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_0 = Object.Instantiate(arg_6_1.narrativeItemGo_)
				local var_9_1 = var_9_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_6_0, var_9_0)

				arg_6_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_1")
				arg_6_0.narr_item_content.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(900102004).content)

				var_9_0.transform:SetParent(arg_6_1.narrativeItemGo_.transform.parent)

				var_9_0.transform.localPosition = Vector3(0, 0, 0)
				var_9_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_9_0, true)
			end

			local var_9_2 = 1

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_2 and arg_6_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_6_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_6_1.time_ >= 0 + var_9_2 and arg_6_1.time_ < 0 + var_9_2 + arg_9_0 then
				-- block empty
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1:AudioAction("play", "music", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_9_5 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if "" ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_5 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_5

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_5
						arg_6_1.bgmTxt2_.text = var_9_5
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play900102005 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 900102005
		arg_11_1.duration_ = 1

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play900102006(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_11_0, arg_11_1.narrativeGo_)

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				local var_14_0 = Object.Instantiate(arg_11_1.narrativeItemGo_)
				local var_14_1 = var_14_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_11_0, var_14_0)

				arg_11_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_11_0.narr_item_content.text = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(900102005).content)

				var_14_0.transform:SetParent(arg_11_1.narrativeItemGo_.transform.parent)

				var_14_0.transform.localPosition = Vector3(0, 0, 0)
				var_14_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_14_0, true)
			end

			local var_14_2 = 1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and arg_11_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_11_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 then
				-- block empty
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play900102006 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 900102006
		arg_15_1.duration_ = 1

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play900102007(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_15_0, arg_15_1.narrativeGo_)

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_0 = Object.Instantiate(arg_15_1.narrativeItemGo_)
				local var_18_1 = var_18_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_15_0, var_18_0)

				arg_15_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_15_0.narr_item_content.text = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(900102006).content)

				var_18_0.transform:SetParent(arg_15_1.narrativeItemGo_.transform.parent)

				var_18_0.transform.localPosition = Vector3(0, 0, 0)
				var_18_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_18_0, true)
			end

			local var_18_2 = 1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and arg_15_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_15_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 then
				-- block empty
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play900102007 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 900102007
		arg_19_1.duration_ = 1

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play900102008(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_19_0, arg_19_1.narrativeGo_)

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_0 = Object.Instantiate(arg_19_1.narrativeItemGo_)
				local var_22_1 = var_22_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_19_0, var_22_0)

				arg_19_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_1")
				arg_19_0.narr_item_content.text = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(900102007).content)

				var_22_0.transform:SetParent(arg_19_1.narrativeItemGo_.transform.parent)

				var_22_0.transform.localPosition = Vector3(0, 0, 0)
				var_22_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_22_0, true)
			end

			local var_22_2 = 1

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and arg_19_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_19_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 then
				-- block empty
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play900102008 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 900102008
		arg_23_1.duration_ = 1

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play900102009(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_23_0, arg_23_1.narrativeGo_)

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_0 = Object.Instantiate(arg_23_1.narrativeItemGo_)
				local var_26_1 = var_26_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_23_0, var_26_0)

				arg_23_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_23_0.narr_item_content.text = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(900102008).content)

				var_26_0.transform:SetParent(arg_23_1.narrativeItemGo_.transform.parent)

				var_26_0.transform.localPosition = Vector3(0, 0, 0)
				var_26_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_26_0, true)
			end

			local var_26_2 = 1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and arg_23_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_23_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				-- block empty
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play900102009 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 900102009
		arg_27_1.duration_ = 1

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play900102010(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_27_0, arg_27_1.narrativeGo_)

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_0 = Object.Instantiate(arg_27_1.narrativeItemGo_)
				local var_30_1 = var_30_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_27_0, var_30_0)

				arg_27_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_27_0.narr_item_content.text = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(900102009).content)

				var_30_0.transform:SetParent(arg_27_1.narrativeItemGo_.transform.parent)

				var_30_0.transform.localPosition = Vector3(0, 0, 0)
				var_30_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_30_0, true)
			end

			local var_30_2 = 1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and arg_27_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_27_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 then
				-- block empty
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play900102010 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 900102010
		arg_31_1.duration_ = 1

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play900102011(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_31_0, arg_31_1.narrativeGo_)

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_0 = Object.Instantiate(arg_31_1.narrativeItemGo_)
				local var_34_1 = var_34_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_31_0, var_34_0)

				arg_31_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_31_0.narr_item_content.text = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(900102010).content)

				var_34_0.transform:SetParent(arg_31_1.narrativeItemGo_.transform.parent)

				var_34_0.transform.localPosition = Vector3(0, 0, 0)
				var_34_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_34_0, true)
			end

			local var_34_2 = 1

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and arg_31_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_31_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 then
				-- block empty
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play900102011 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 900102011
		arg_35_1.duration_ = 1

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play900102012(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_35_0, arg_35_1.narrativeGo_)

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_0 = Object.Instantiate(arg_35_1.narrativeItemGo_)
				local var_38_1 = var_38_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_35_0, var_38_0)

				arg_35_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_35_0.narr_item_content.text = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(900102011).content)

				var_38_0.transform:SetParent(arg_35_1.narrativeItemGo_.transform.parent)

				var_38_0.transform.localPosition = Vector3(0, 0, 0)
				var_38_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_38_0, true)
			end

			local var_38_2 = 1

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and arg_35_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_35_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 then
				-- block empty
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play900102012 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 900102012
		arg_39_1.duration_ = 1

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play900102013(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_39_0, arg_39_1.narrativeGo_)

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_0 = Object.Instantiate(arg_39_1.narrativeItemGo_)
				local var_42_1 = var_42_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_39_0, var_42_0)

				arg_39_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_39_0.narr_item_content.text = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(900102012).content)

				var_42_0.transform:SetParent(arg_39_1.narrativeItemGo_.transform.parent)

				var_42_0.transform.localPosition = Vector3(0, 0, 0)
				var_42_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_42_0, true)
			end

			local var_42_2 = 1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and arg_39_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_39_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 then
				-- block empty
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play900102013 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 900102013
		arg_43_1.duration_ = 1

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play900102014(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_43_0, arg_43_1.narrativeGo_)

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_0 = Object.Instantiate(arg_43_1.narrativeItemGo_)
				local var_46_1 = var_46_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_43_0, var_46_0)

				arg_43_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_43_0.narr_item_content.text = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(900102013).content)

				var_46_0.transform:SetParent(arg_43_1.narrativeItemGo_.transform.parent)

				var_46_0.transform.localPosition = Vector3(0, 0, 0)
				var_46_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_46_0, true)
			end

			local var_46_2 = 1

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and arg_43_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_43_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 then
				-- block empty
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play900102014 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 900102014
		arg_47_1.duration_ = 1

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play900102015(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_47_0, arg_47_1.narrativeGo_)

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_0 = Object.Instantiate(arg_47_1.narrativeItemGo_)
				local var_50_1 = var_50_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_47_0, var_50_0)

				arg_47_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_47_0.narr_item_content.text = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(900102014).content)

				var_50_0.transform:SetParent(arg_47_1.narrativeItemGo_.transform.parent)

				var_50_0.transform.localPosition = Vector3(0, 0, 0)
				var_50_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_50_0, true)
			end

			local var_50_2 = 1

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and arg_47_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_47_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 then
				-- block empty
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play900102015 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 900102015
		arg_51_1.duration_ = 1

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play900102016(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_51_0, arg_51_1.narrativeGo_)

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				local var_54_0 = Object.Instantiate(arg_51_1.narrativeItemGo_)
				local var_54_1 = var_54_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_51_0, var_54_0)

				arg_51_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_51_0.narr_item_content.text = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(900102015).content)

				var_54_0.transform:SetParent(arg_51_1.narrativeItemGo_.transform.parent)

				var_54_0.transform.localPosition = Vector3(0, 0, 0)
				var_54_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_54_0, true)
			end

			local var_54_2 = 1

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and arg_51_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_51_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 then
				-- block empty
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play900102016 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 900102016
		arg_55_1.duration_ = 1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play900102017(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_55_0, arg_55_1.narrativeGo_)

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				local var_58_0 = Object.Instantiate(arg_55_1.narrativeItemGo_)
				local var_58_1 = var_58_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_55_0, var_58_0)

				arg_55_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_4")
				arg_55_0.narr_item_content.text = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(900102016).content)

				var_58_0.transform:SetParent(arg_55_1.narrativeItemGo_.transform.parent)

				var_58_0.transform.localPosition = Vector3(0, 0, 0)
				var_58_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_58_0, true)
			end

			local var_58_2 = 1

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and arg_55_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_55_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				-- block empty
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play900102017 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 900102017
		arg_59_1.duration_ = 1

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play900102018(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_59_0, arg_59_1.narrativeGo_)

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_0 = Object.Instantiate(arg_59_1.narrativeItemGo_)
				local var_62_1 = var_62_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_59_0, var_62_0)

				arg_59_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_59_0.narr_item_content.text = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(900102017).content)

				var_62_0.transform:SetParent(arg_59_1.narrativeItemGo_.transform.parent)

				var_62_0.transform.localPosition = Vector3(0, 0, 0)
				var_62_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_62_0, true)
			end

			local var_62_2 = 1

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and arg_59_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_59_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 then
				-- block empty
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play900102018 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 900102018
		arg_63_1.duration_ = 1

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play900102019(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_63_0, arg_63_1.narrativeGo_)

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_0 = Object.Instantiate(arg_63_1.narrativeItemGo_)
				local var_66_1 = var_66_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_63_0, var_66_0)

				arg_63_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_63_0.narr_item_content.text = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(900102018).content)

				var_66_0.transform:SetParent(arg_63_1.narrativeItemGo_.transform.parent)

				var_66_0.transform.localPosition = Vector3(0, 0, 0)
				var_66_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_66_0, true)
			end

			local var_66_2 = 1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and arg_63_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_63_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 then
				-- block empty
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play900102019 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 900102019
		arg_67_1.duration_ = 1

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play900102020(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_67_0, arg_67_1.narrativeGo_)

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				local var_70_0 = Object.Instantiate(arg_67_1.narrativeItemGo_)
				local var_70_1 = var_70_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_67_0, var_70_0)

				arg_67_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_4")
				arg_67_0.narr_item_content.text = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(900102019).content)

				var_70_0.transform:SetParent(arg_67_1.narrativeItemGo_.transform.parent)

				var_70_0.transform.localPosition = Vector3(0, 0, 0)
				var_70_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_70_0, true)
			end

			local var_70_2 = 1

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and arg_67_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_67_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 then
				-- block empty
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play900102020 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 900102020
		arg_71_1.duration_ = 1

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play900102021(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_71_0, arg_71_1.narrativeGo_)

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				local var_74_0 = Object.Instantiate(arg_71_1.narrativeItemGo_)
				local var_74_1 = var_74_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_71_0, var_74_0)

				arg_71_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_1")
				arg_71_0.narr_item_content.text = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(900102020).content)

				var_74_0.transform:SetParent(arg_71_1.narrativeItemGo_.transform.parent)

				var_74_0.transform.localPosition = Vector3(0, 0, 0)
				var_74_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_74_0, true)
			end

			local var_74_2 = 1

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and arg_71_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_71_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 then
				-- block empty
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play900102021 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 900102021
		arg_75_1.duration_ = 1

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play900102022(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_75_0, arg_75_1.narrativeGo_)

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_0 = Object.Instantiate(arg_75_1.narrativeItemGo_)
				local var_78_1 = var_78_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_75_0, var_78_0)

				arg_75_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_75_0.narr_item_content.text = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(900102021).content)

				var_78_0.transform:SetParent(arg_75_1.narrativeItemGo_.transform.parent)

				var_78_0.transform.localPosition = Vector3(0, 0, 0)
				var_78_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_78_0, true)
			end

			local var_78_2 = 1

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and arg_75_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_75_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 then
				-- block empty
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play900102022 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 900102022
		arg_79_1.duration_ = 1

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play900102023(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_79_0, arg_79_1.narrativeGo_)

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_0 = Object.Instantiate(arg_79_1.narrativeItemGo_)
				local var_82_1 = var_82_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_79_0, var_82_0)

				arg_79_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")
				arg_79_0.narr_item_content.text = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(900102022).content)

				var_82_0.transform:SetParent(arg_79_1.narrativeItemGo_.transform.parent)

				var_82_0.transform.localPosition = Vector3(0, 0, 0)
				var_82_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_82_0, true)
			end

			local var_82_2 = 1

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and arg_79_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_79_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 then
				-- block empty
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play900102023 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 900102023
		arg_83_1.duration_ = 1

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play900102024(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_83_0, arg_83_1.narrativeGo_)

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				local var_86_0 = Object.Instantiate(arg_83_1.narrativeItemGo_)
				local var_86_1 = var_86_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_83_0, var_86_0)

				arg_83_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10026")
				arg_83_0.narr_item_content.text = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(900102023).content)

				var_86_0.transform:SetParent(arg_83_1.narrativeItemGo_.transform.parent)

				var_86_0.transform.localPosition = Vector3(0, 0, 0)
				var_86_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_86_0, true)
			end

			local var_86_2 = 1

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and arg_83_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_83_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 then
				-- block empty
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play900102024 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 900102024
		arg_87_1.duration_ = 1

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play900102025(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_87_0, arg_87_1.narrativeGo_)

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_0 = Object.Instantiate(arg_87_1.narrativeItemGo_)
				local var_90_1 = var_90_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_87_0, var_90_0)

				arg_87_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10026")
				arg_87_0.narr_item_content.text = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(900102024).content)

				var_90_0.transform:SetParent(arg_87_1.narrativeItemGo_.transform.parent)

				var_90_0.transform.localPosition = Vector3(0, 0, 0)
				var_90_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_90_0, true)
			end

			local var_90_2 = 1

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and arg_87_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_87_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 then
				-- block empty
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play900102025 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 900102025
		arg_91_1.duration_ = 1

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play900102026(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_91_0, arg_91_1.narrativeGo_)

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_0 = Object.Instantiate(arg_91_1.narrativeItemGo_)
				local var_94_1 = var_94_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_91_0, var_94_0)

				arg_91_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")
				arg_91_0.narr_item_content.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(900102025).content)

				var_94_0.transform:SetParent(arg_91_1.narrativeItemGo_.transform.parent)

				var_94_0.transform.localPosition = Vector3(0, 0, 0)
				var_94_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_94_0, true)
			end

			local var_94_2 = 1

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and arg_91_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_91_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 then
				-- block empty
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play900102026 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 900102026
		arg_95_1.duration_ = 1

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play900102027(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_95_0, arg_95_1.narrativeGo_)

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				local var_98_0 = Object.Instantiate(arg_95_1.narrativeItemGo_)
				local var_98_1 = var_98_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_95_0, var_98_0)

				arg_95_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")
				arg_95_0.narr_item_content.text = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(900102026).content)

				var_98_0.transform:SetParent(arg_95_1.narrativeItemGo_.transform.parent)

				var_98_0.transform.localPosition = Vector3(0, 0, 0)
				var_98_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_98_0, true)
			end

			local var_98_2 = 1

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and arg_95_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_95_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 then
				-- block empty
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play900102027 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 900102027
		arg_99_1.duration_ = 1

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play900102028(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_99_0, arg_99_1.narrativeGo_)

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				local var_102_0 = Object.Instantiate(arg_99_1.narrativeItemGo_)
				local var_102_1 = var_102_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_99_0, var_102_0)

				arg_99_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")
				arg_99_0.narr_item_content.text = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(900102027).content)

				var_102_0.transform:SetParent(arg_99_1.narrativeItemGo_.transform.parent)

				var_102_0.transform.localPosition = Vector3(0, 0, 0)
				var_102_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_102_0, true)
			end

			local var_102_2 = 1

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and arg_99_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_99_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 then
				-- block empty
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play900102028 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 900102028
		arg_103_1.duration_ = 1

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play900102029(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_103_0, arg_103_1.narrativeGo_)

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				local var_106_0 = Object.Instantiate(arg_103_1.narrativeItemGo_)
				local var_106_1 = var_106_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_103_0, var_106_0)

				arg_103_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")
				arg_103_0.narr_item_content.text = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(900102028).content)

				var_106_0.transform:SetParent(arg_103_1.narrativeItemGo_.transform.parent)

				var_106_0.transform.localPosition = Vector3(0, 0, 0)
				var_106_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_106_0, true)
			end

			local var_106_2 = 1

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and arg_103_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_103_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 then
				-- block empty
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play900102029 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 900102029
		arg_107_1.duration_ = 1

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play900102030(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_107_0, arg_107_1.narrativeGo_)

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_0 = Object.Instantiate(arg_107_1.narrativeItemGo_)
				local var_110_1 = var_110_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_107_0, var_110_0)

				arg_107_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")
				arg_107_0.narr_item_content.text = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(900102029).content)

				var_110_0.transform:SetParent(arg_107_1.narrativeItemGo_.transform.parent)

				var_110_0.transform.localPosition = Vector3(0, 0, 0)
				var_110_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_110_0, true)
			end

			local var_110_2 = 1

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and arg_107_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_107_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 then
				-- block empty
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play900102030 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 900102030
		arg_111_1.duration_ = 1

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play900102031(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_111_0, arg_111_1.narrativeGo_)

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_0 = Object.Instantiate(arg_111_1.narrativeItemGo_)
				local var_114_1 = var_114_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_111_0, var_114_0)

				arg_111_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")
				arg_111_0.narr_item_content.text = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(900102030).content)

				var_114_0.transform:SetParent(arg_111_1.narrativeItemGo_.transform.parent)

				var_114_0.transform.localPosition = Vector3(0, 0, 0)
				var_114_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_114_0, true)
			end

			local var_114_2 = 1

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and arg_111_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_111_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 then
				-- block empty
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play900102031 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 900102031
		arg_115_1.duration_ = 1

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play900102032(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_115_0, arg_115_1.narrativeGo_)

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_0 = Object.Instantiate(arg_115_1.narrativeItemGo_)
				local var_118_1 = var_118_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_115_0, var_118_0)

				arg_115_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")
				arg_115_0.narr_item_content.text = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(900102031).content)

				var_118_0.transform:SetParent(arg_115_1.narrativeItemGo_.transform.parent)

				var_118_0.transform.localPosition = Vector3(0, 0, 0)
				var_118_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_118_0, true)
			end

			local var_118_2 = 1

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and arg_115_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_115_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 then
				-- block empty
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play900102032 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 900102032
		arg_119_1.duration_ = 1.03

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
			arg_119_1.auto_ = false
		end

		function arg_119_1.playNext_(arg_121_0)
			arg_119_1.onStoryFinished_()
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_119_0, arg_119_1.narrativeGo_)

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				local var_122_0 = Object.Instantiate(arg_119_1.narrativeItemGo_)
				local var_122_1 = var_122_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_119_0, var_122_0)

				arg_119_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")
				arg_119_0.narr_item_content.text = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(900102032).content)

				var_122_0.transform:SetParent(arg_119_1.narrativeItemGo_.transform.parent)

				var_122_0.transform.localPosition = Vector3(0, 0, 0)
				var_122_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_122_0, true)
			end

			local var_122_2 = 1

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and arg_119_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_119_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_119_0, arg_119_1.narrativeGo_)

			if 1 < arg_119_1.time_ and arg_119_1.time_ <= 1 + arg_122_0 then
				-- block empty
			end

			local var_122_3 = 0.0334

			if 1 <= arg_119_1.time_ and arg_119_1.time_ < 1 + var_122_3 and arg_119_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_119_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_119_1.time_ >= 1 + var_122_3 and arg_119_1.time_ < 1 + var_122_3 + arg_122_0 then
				arg_119_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_122_4 = arg_119_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_122_4 then
					var_122_4.raycastTarget = true
				end

				SetActive(arg_119_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/Volume"
	},
	voices = {}
}

var_0_0.narrativeChapter = 900102001
var_0_0.narrativeTime = 900102002
var_0_0.narrativeData = {
	{
		"story_1033_split_1",
		900102003
	},
	{
		"story_1038_split_1",
		900102004
	},
	{
		"story_1033_split_1",
		900102005
	},
	{
		"story_10022_split_1",
		900102006
	},
	{
		"story_1038_split_1",
		900102007
	},
	{
		"story_1019_split_1",
		900102008
	},
	{
		"story_10022_split_1",
		900102009
	},
	{
		"story_10022_split_1",
		900102010
	},
	{
		"story_10022_split_1",
		900102011
	},
	{
		"story_1019_split_1",
		900102012
	},
	{
		"story_10022_split_1",
		900102013
	},
	{
		"story_1033_split_1",
		900102014
	},
	{
		"story_1033_split_1",
		900102015
	},
	{
		"story_1019_split_4",
		900102016
	},
	{
		"story_1033_split_1",
		900102017
	},
	{
		"story_1033_split_1",
		900102018
	},
	{
		"story_1019_split_4",
		900102019
	},
	{
		"story_1038_split_1",
		900102020
	},
	{
		"story_1019_split_1",
		900102021
	},
	{
		"story_citizenwc",
		900102022
	},
	{
		"story_10026",
		900102023
	},
	{
		"story_10026",
		900102024
	},
	{
		"story_1038_split_5",
		900102025
	},
	{
		"story_yakuzab",
		900102026
	},
	{
		"story_fathera",
		900102027
	},
	{
		"story_fathera",
		900102028
	},
	{
		"story_fathera",
		900102029
	},
	{
		"story_citizenwc",
		900102030
	},
	{
		"story_yakuzab",
		900102031
	},
	{
		"story_10022_split_3",
		900102032
	}
}

return var_0_0
