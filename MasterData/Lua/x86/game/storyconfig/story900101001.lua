local var_0_0 = {
	Play900101003 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 900101003
		arg_1_1.duration_ = 1.03

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play900101004(arg_1_1)
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

				arg_1_0.narr_chapter_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900101001).content)
				arg_1_0.narr_time_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900101002).content)
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
				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900101003).content)

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
	Play900101004 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 900101004
		arg_6_1.duration_ = 1

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play900101005(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_6_0, arg_6_1.narrativeGo_)

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_0 = Object.Instantiate(arg_6_1.narrativeItemGo_)
				local var_9_1 = var_9_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_6_0, var_9_0)

				arg_6_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_6_0.narr_item_content.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(900101004).content)

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
	Play900101005 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 900101005
		arg_11_1.duration_ = 1

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play900101006(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_11_0, arg_11_1.narrativeGo_)

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				local var_14_0 = Object.Instantiate(arg_11_1.narrativeItemGo_)
				local var_14_1 = var_14_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_11_0, var_14_0)

				arg_11_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_2")
				arg_11_0.narr_item_content.text = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(900101005).content)

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
	Play900101006 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 900101006
		arg_15_1.duration_ = 1

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play900101007(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_15_0, arg_15_1.narrativeGo_)

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_0 = Object.Instantiate(arg_15_1.narrativeItemGo_)
				local var_18_1 = var_18_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_15_0, var_18_0)

				arg_15_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")
				arg_15_0.narr_item_content.text = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(900101006).content)

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
	Play900101007 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 900101007
		arg_19_1.duration_ = 1

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play900101008(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_19_0, arg_19_1.narrativeGo_)

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_0 = Object.Instantiate(arg_19_1.narrativeItemGo_)
				local var_22_1 = var_22_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_19_0, var_22_0)

				arg_19_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")
				arg_19_0.narr_item_content.text = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(900101007).content)

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
	Play900101008 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 900101008
		arg_23_1.duration_ = 1

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play900101009(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_23_0, arg_23_1.narrativeGo_)

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_0 = Object.Instantiate(arg_23_1.narrativeItemGo_)
				local var_26_1 = var_26_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_23_0, var_26_0)

				arg_23_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_7")
				arg_23_0.narr_item_content.text = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(900101008).content)

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
	Play900101009 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 900101009
		arg_27_1.duration_ = 1

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play900101010(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_27_0, arg_27_1.narrativeGo_)

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_0 = Object.Instantiate(arg_27_1.narrativeItemGo_)
				local var_30_1 = var_30_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_27_0, var_30_0)

				arg_27_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_27_0.narr_item_content.text = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(900101009).content)

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
	Play900101010 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 900101010
		arg_31_1.duration_ = 1.8

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play900101011(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_31_0, arg_31_1.narrativeGo_)

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_0 = Object.Instantiate(arg_31_1.narrativeItemGo_)
				local var_34_1 = var_34_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_31_0, var_34_0)

				arg_31_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_5")
				arg_31_0.narr_item_content.text = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(900101010).content)

				var_34_0.transform:SetParent(arg_31_1.narrativeItemGo_.transform.parent)

				var_34_0.transform.localPosition = Vector3(0, 0, 0)
				var_34_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_34_0, true)
			end

			local var_34_2 = 1.8

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
	Play900101011 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 900101011
		arg_35_1.duration_ = 1

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play900101012(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_35_0, arg_35_1.narrativeGo_)

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_0 = Object.Instantiate(arg_35_1.narrativeItemGo_)
				local var_38_1 = var_38_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_35_0, var_38_0)

				arg_35_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_35_0.narr_item_content.text = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(900101011).content)

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
	Play900101012 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 900101012
		arg_39_1.duration_ = 1.2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play900101013(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_39_0, arg_39_1.narrativeGo_)

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_0 = Object.Instantiate(arg_39_1.narrativeItemGo_)
				local var_42_1 = var_42_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_39_0, var_42_0)

				arg_39_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_7")
				arg_39_0.narr_item_content.text = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(900101012).content)

				var_42_0.transform:SetParent(arg_39_1.narrativeItemGo_.transform.parent)

				var_42_0.transform.localPosition = Vector3(0, 0, 0)
				var_42_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_42_0, true)
			end

			local var_42_2 = 1.2

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
	Play900101013 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 900101013
		arg_43_1.duration_ = 1

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play900101014(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_43_0, arg_43_1.narrativeGo_)

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_0 = Object.Instantiate(arg_43_1.narrativeItemGo_)
				local var_46_1 = var_46_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_43_0, var_46_0)

				arg_43_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_43_0.narr_item_content.text = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(900101013).content)

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
	Play900101014 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 900101014
		arg_47_1.duration_ = 1

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play900101015(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_47_0, arg_47_1.narrativeGo_)

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_0 = Object.Instantiate(arg_47_1.narrativeItemGo_)
				local var_50_1 = var_50_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_47_0, var_50_0)

				arg_47_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_7")
				arg_47_0.narr_item_content.text = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(900101014).content)

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
	Play900101015 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 900101015
		arg_51_1.duration_ = 1

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play900101016(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_51_0, arg_51_1.narrativeGo_)

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				local var_54_0 = Object.Instantiate(arg_51_1.narrativeItemGo_)
				local var_54_1 = var_54_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_51_0, var_54_0)

				arg_51_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_51_0.narr_item_content.text = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(900101015).content)

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
	Play900101016 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 900101016
		arg_55_1.duration_ = 1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play900101017(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_55_0, arg_55_1.narrativeGo_)

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				local var_58_0 = Object.Instantiate(arg_55_1.narrativeItemGo_)
				local var_58_1 = var_58_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_55_0, var_58_0)

				arg_55_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_55_0.narr_item_content.text = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(900101016).content)

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
	Play900101017 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 900101017
		arg_59_1.duration_ = 1

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play900101018(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_59_0, arg_59_1.narrativeGo_)

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_0 = Object.Instantiate(arg_59_1.narrativeItemGo_)
				local var_62_1 = var_62_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_59_0, var_62_0)

				arg_59_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_9")
				arg_59_0.narr_item_content.text = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(900101017).content)

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
	Play900101018 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 900101018
		arg_63_1.duration_ = 1

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play900101019(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_63_0, arg_63_1.narrativeGo_)

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_0 = Object.Instantiate(arg_63_1.narrativeItemGo_)
				local var_66_1 = var_66_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_63_0, var_66_0)

				arg_63_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_2")
				arg_63_0.narr_item_content.text = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(900101018).content)

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
	Play900101019 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 900101019
		arg_67_1.duration_ = 1

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play900101020(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_67_0, arg_67_1.narrativeGo_)

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				local var_70_0 = Object.Instantiate(arg_67_1.narrativeItemGo_)
				local var_70_1 = var_70_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_67_0, var_70_0)

				arg_67_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_1")
				arg_67_0.narr_item_content.text = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(900101019).content)

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
	Play900101020 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 900101020
		arg_71_1.duration_ = 1

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play900101021(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_71_0, arg_71_1.narrativeGo_)

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				local var_74_0 = Object.Instantiate(arg_71_1.narrativeItemGo_)
				local var_74_1 = var_74_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_71_0, var_74_0)

				arg_71_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				arg_71_0.narr_item_content.text = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(900101020).content)

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
	Play900101021 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 900101021
		arg_75_1.duration_ = 1.5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play900101022(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_75_0, arg_75_1.narrativeGo_)

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_0 = Object.Instantiate(arg_75_1.narrativeItemGo_)
				local var_78_1 = var_78_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_75_0, var_78_0)

				arg_75_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")
				arg_75_0.narr_item_content.text = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(900101021).content)

				var_78_0.transform:SetParent(arg_75_1.narrativeItemGo_.transform.parent)

				var_78_0.transform.localPosition = Vector3(0, 0, 0)
				var_78_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_78_0, true)
			end

			local var_78_2 = 1.5

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
	Play900101022 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 900101022
		arg_79_1.duration_ = 1

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play900101023(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_79_0, arg_79_1.narrativeGo_)

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_0 = Object.Instantiate(arg_79_1.narrativeItemGo_)
				local var_82_1 = var_82_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_79_0, var_82_0)

				arg_79_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_2")
				arg_79_0.narr_item_content.text = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(900101022).content)

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
	Play900101023 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 900101023
		arg_83_1.duration_ = 1

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play900101024(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_83_0, arg_83_1.narrativeGo_)

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				local var_86_0 = Object.Instantiate(arg_83_1.narrativeItemGo_)
				local var_86_1 = var_86_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_83_0, var_86_0)

				arg_83_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_2")
				arg_83_0.narr_item_content.text = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(900101023).content)

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
	Play900101024 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 900101024
		arg_87_1.duration_ = 1

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play900101025(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_87_0, arg_87_1.narrativeGo_)

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_0 = Object.Instantiate(arg_87_1.narrativeItemGo_)
				local var_90_1 = var_90_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_87_0, var_90_0)

				arg_87_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")
				arg_87_0.narr_item_content.text = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(900101024).content)

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
	Play900101025 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 900101025
		arg_91_1.duration_ = 1

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play900101026(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_91_0, arg_91_1.narrativeGo_)

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_0 = Object.Instantiate(arg_91_1.narrativeItemGo_)
				local var_94_1 = var_94_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_91_0, var_94_0)

				arg_91_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")
				arg_91_0.narr_item_content.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(900101025).content)

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
	Play900101026 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 900101026
		arg_95_1.duration_ = 1.03

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
			arg_95_1.auto_ = false
		end

		function arg_95_1.playNext_(arg_97_0)
			arg_95_1.onStoryFinished_()
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_95_0, arg_95_1.narrativeGo_)

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				local var_98_0 = Object.Instantiate(arg_95_1.narrativeItemGo_)
				local var_98_1 = var_98_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_95_0, var_98_0)

				arg_95_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_9")
				arg_95_0.narr_item_content.text = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(900101026).content)

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

			ComponentBinder.GetInstance():BindCfgUI(arg_95_0, arg_95_1.narrativeGo_)

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				-- block empty
			end

			local var_98_3 = 0.0334

			if 1 <= arg_95_1.time_ and arg_95_1.time_ < 1 + var_98_3 and arg_95_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_95_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_95_1.time_ >= 1 + var_98_3 and arg_95_1.time_ < 1 + var_98_3 + arg_98_0 then
				arg_95_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_98_4 = arg_95_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_98_4 then
					var_98_4.raycastTarget = true
				end

				SetActive(arg_95_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/Volume"
	},
	voices = {}
}

var_0_0.narrativeChapter = 900101001
var_0_0.narrativeTime = 900101002
var_0_0.narrativeData = {
	{
		"story_1033_split_1",
		900101003
	},
	{
		"story_1019_split_1",
		900101004
	},
	{
		"story_1033_split_2",
		900101005
	},
	{
		"story_1038_split_5",
		900101006
	},
	{
		"story_10022_split_6",
		900101007
	},
	{
		"story_1038_split_7",
		900101008
	},
	{
		"story_10022_split_1",
		900101009
	},
	{
		"story_1033_split_5",
		900101010
	},
	{
		"story_1019_split_1",
		900101011
	},
	{
		"story_10022_split_7",
		900101012
	},
	{
		"story_1019_split_1",
		900101013
	},
	{
		"story_1038_split_7",
		900101014
	},
	{
		"story_10022_split_1",
		900101015
	},
	{
		"story_10022_split_1",
		900101016
	},
	{
		"story_1038_split_9",
		900101017
	},
	{
		"story_1019_split_2",
		900101018
	},
	{
		"story_1038_split_1",
		900101019
	},
	{
		"story_1019_split_1",
		900101020
	},
	{
		"story_10022_split_2",
		900101021
	},
	{
		"story_1033_split_2",
		900101022
	},
	{
		"story_1019_split_2",
		900101023
	},
	{
		"story_1033_split_1",
		900101024
	},
	{
		"story_10022_split_1",
		900101025
	},
	{
		"story_1038_split_9",
		900101026
	}
}

return var_0_0
