return {
	Play416142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416142001
		arg_1_1.duration_ = 5.7

		local var_1_0 = {
			zh = 5.6,
			ja = 5.7
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.I13i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13i")
				var_4_0.name = "I13i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I13i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I13i

				arg_1_1.bgs_.I13i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I13i" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				local var_4_9 = arg_1_1.var_.effect112

				if not arg_1_1.var_.effect112 then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_in"), manager.ui.mainCamera.transform)
					var_4_9.name = "112"
					arg_1_1.var_.effect112 = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9000)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_12 = var_4_9.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_2, iter_4_3 in ipairs((var_4_12:ToTable())) do
					iter_4_3.transform.localScale = Vector3.New(iter_4_3.transform.localScale.x / var_4_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_12 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_3.transform.localScale.y / var_4_11, iter_4_3.transform.localScale.z)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_23 = arg_1_1:GetWordFromCfg(416142001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 9 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 9)

				if (9 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 9)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142001", "story_v_out_416142.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_416142", "416142001", "story_v_out_416142.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_416142", "416142001", "story_v_out_416142.awb")

						arg_1_1:RecordAudio("416142001", var_4_28)
						arg_1_1:RecordAudio("416142001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416142", "416142001", "story_v_out_416142.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416142", "416142001", "story_v_out_416142.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416142002
		arg_9_1.duration_ = 4.5

		local var_9_0 = {
			zh = 2.833,
			ja = 4.5
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				if arg_9_1.var_.effect112 then
					Object.Destroy(arg_9_1.var_.effect112)

					arg_9_1.var_.effect112 = nil
				end
			end

			local var_12_1 = 0
			local var_12_2 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(416142002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 13 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 13)

				if (13 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 13)) > 0 and var_12_2 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142002", "story_v_out_416142.awb") ~= 0 then
					local var_12_7 = manager.audio:GetVoiceLength("story_v_out_416142", "416142002", "story_v_out_416142.awb") / 1000

					if var_12_7 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_1
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_416142", "416142002", "story_v_out_416142.awb")

						arg_9_1:RecordAudio("416142002", var_12_8)
						arg_9_1:RecordAudio("416142002", var_12_8)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416142", "416142002", "story_v_out_416142.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416142", "416142002", "story_v_out_416142.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_9 and arg_9_1.time_ < var_12_1 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play416142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416142003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(416142003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 43 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 43)

				if (43 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 43)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play416142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416142004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 2.766,
			ja = 4.3
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play416142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(416142004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 10 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 10)

				if (10 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 10)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142004", "story_v_out_416142.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142004", "story_v_out_416142.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_416142", "416142004", "story_v_out_416142.awb")

						arg_17_1:RecordAudio("416142004", var_20_6)
						arg_17_1:RecordAudio("416142004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416142", "416142004", "story_v_out_416142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416142", "416142004", "story_v_out_416142.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416142005
		arg_21_1.duration_ = 6.17

		local var_21_0 = {
			zh = 5.266,
			ja = 6.166
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(416142005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 17 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 17)

				if (17 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 17)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142005", "story_v_out_416142.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142005", "story_v_out_416142.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_416142", "416142005", "story_v_out_416142.awb")

						arg_21_1:RecordAudio("416142005", var_24_6)
						arg_21_1:RecordAudio("416142005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416142", "416142005", "story_v_out_416142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416142", "416142005", "story_v_out_416142.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416142006
		arg_25_1.duration_ = 4.23

		local var_25_0 = {
			zh = 3.133,
			ja = 4.233
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play416142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(416142006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 12 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 12)

				if (12 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 12)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142006", "story_v_out_416142.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142006", "story_v_out_416142.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_416142", "416142006", "story_v_out_416142.awb")

						arg_25_1:RecordAudio("416142006", var_28_6)
						arg_25_1:RecordAudio("416142006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416142", "416142006", "story_v_out_416142.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416142", "416142006", "story_v_out_416142.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play416142007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416142007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416142008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(416142007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 49 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 49)

				if (49 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 49)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416142008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416142008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416142009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.975

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(416142008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 39 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 39)

				if (39 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 39)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416142009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416142009
		arg_37_1.duration_ = 4.6

		local var_37_0 = {
			zh = 4.6,
			ja = 4.5
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play416142010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["1028"] == nil then
				local var_40_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_40_0) then
					local var_40_1 = Object.Instantiate(var_40_0, arg_37_1.canvasGo_.transform)

					var_40_1.transform:SetSiblingIndex(1)

					var_40_1.name = "1028"
					var_40_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_["1028"] = var_40_1

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs((var_40_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_2 = arg_37_1.actors_["1028"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1028 == nil then
				arg_37_1.var_.actorSpriteComps1028 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1028 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								iter_40_3.color = Color.New(Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_3.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_3.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1028 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1028 = nil
			end

			local var_40_5 = arg_37_1.actors_["1028"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1028 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1028", 3)

				for iter_40_6 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_6)

					if var_40_6.name == "split_2" or not string.find(var_40_6.name, "split") then
						var_40_6.gameObject:SetActive(true)
					else
						var_40_6.gameObject:SetActive(false)
					end
				end
			end

			local var_40_7 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_37_1.time_ - 0) / var_40_7)
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_40_8 = 0
			local var_40_9 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(416142009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 17 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 17)

				if (17 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 17)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142009", "story_v_out_416142.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_416142", "416142009", "story_v_out_416142.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_416142", "416142009", "story_v_out_416142.awb")

						arg_37_1:RecordAudio("416142009", var_40_15)
						arg_37_1:RecordAudio("416142009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416142", "416142009", "story_v_out_416142.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416142", "416142009", "story_v_out_416142.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play416142010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416142010
		arg_41_1.duration_ = 5.9

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play416142011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_9000

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1028"]) and arg_41_1.var_.actorSpriteComps1028 == nil then
				arg_41_1.var_.actorSpriteComps1028 = arg_41_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1028"]) then
				if arg_41_1.var_.actorSpriteComps1028 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1028"]) and arg_41_1.var_.actorSpriteComps1028 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1028 = nil
			end

			local var_44_2 = arg_41_1.actors_["1028"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1028 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1028", 7)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_5 = 0.2

			if 0.2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 0.333333333333333

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(1, 1, 1)

				var_44_7.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(1, 1, 1)

				arg_41_1.mask_.enabled = false
				var_44_8.a = 0
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = 0.533333333333333

			if 0.533333333333333 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_10 = 0.233333333333333

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				local var_44_11 = Color.New(1, 1, 1)

				var_44_11.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_9) / var_44_10)
				arg_41_1.mask_.color = var_44_11
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				local var_44_12 = Color.New(1, 1, 1)

				arg_41_1.mask_.enabled = false
				var_44_12.a = 0
				arg_41_1.mask_.color = var_44_12
			end

			local var_44_13 = manager.ui.mainCamera.transform

			if 0.333333333333333 < arg_41_1.time_ and arg_41_1.time_ <= 0.333333333333333 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = var_44_13.localPosition
			end

			local var_44_14 = 0.566666666666667

			if 0.333333333333333 <= arg_41_1.time_ and arg_41_1.time_ < 0.333333333333333 + var_44_14 then
				local var_44_15, var_44_16 = math.modf((arg_41_1.time_ - 0.333333333333333) / 0.066)

				var_44_13.localPosition = Vector3.New(var_44_16 * 0.13, var_44_16 * 0.13, var_44_16 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= 0.333333333333333 + var_44_14 and arg_41_1.time_ < 0.333333333333333 + var_44_14 + arg_44_0 then
				var_44_13.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_17 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_17 + 1.16666666666667 and arg_41_1.time_ < var_44_17 + 1.16666666666667 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				if arg_41_1.var_.effect112 then
					Object.Destroy(arg_41_1.var_.effect112)

					arg_41_1.var_.effect112 = nil
				end
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_19 = arg_41_1.var_.effect116

				if not arg_41_1.var_.effect116 then
					var_44_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_44_19.name = "116"
					arg_41_1.var_.effect116 = var_44_19
				else
					var_44_19.transform:SetParent(var_44_9000)
				end

				var_44_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_44_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_44_21 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_44_22 = var_44_19.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_44_5, iter_44_6 in ipairs((var_44_22:ToTable())) do
					iter_44_6.transform.localScale = Vector3.New(iter_44_6.transform.localScale.x / var_44_21 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_44_22 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_44_6.transform.localScale.y / var_44_21, iter_44_6.transform.localScale.z)
				end
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder", "")
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_25 = 0.9
			local var_44_26 = 1.65

			if 0.9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_27 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_27:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_28 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(416142010).content)

				arg_41_1.text_.text = var_44_28

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_30 = 66 <= 0 and var_44_26 or var_44_26 * (utf8.len(var_44_28) / 66)

				if (66 <= 0 and var_44_26 or var_44_26 * (utf8.len(var_44_28) / 66)) > 0 and var_44_26 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30
					var_44_25 = var_44_25 + 0.3

					if var_44_30 + var_44_25 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_25
					end
				end

				arg_41_1.text_.text = var_44_28
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_31 = var_44_25 + 0.3
			local var_44_32 = math.max(var_44_26, arg_41_1.talkMaxDuration)

			if var_44_25 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_31 + var_44_32 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_31) / var_44_32

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_31 + var_44_32 and arg_41_1.time_ < var_44_31 + var_44_32 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play416142011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 416142011
		arg_47_1.duration_ = 3.63

		local var_47_0 = {
			zh = 2.066,
			ja = 3.633
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play416142012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1028"]) and arg_47_1.var_.actorSpriteComps1028 == nil then
				arg_47_1.var_.actorSpriteComps1028 = arg_47_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1028"]) then
				if arg_47_1.var_.actorSpriteComps1028 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								iter_50_1.color = Color.New(Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_0), Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_0), (Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_0)))
							else
								local var_50_1 = Mathf.Lerp(iter_50_1.color.r, 1, (arg_47_1.time_ - 0) / var_50_0)

								iter_50_1.color = Color.New(var_50_1, var_50_1, var_50_1)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1028"]) and arg_47_1.var_.actorSpriteComps1028 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_50_3 then
						iter_50_3.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1028 = nil
			end

			local var_50_2 = 0
			local var_50_3 = 0.175

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_4 = arg_47_1:GetWordFromCfg(416142011)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 7 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 7)

				if (7 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 7)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142011", "story_v_out_416142.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142011", "story_v_out_416142.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_416142", "416142011", "story_v_out_416142.awb")

						arg_47_1:RecordAudio("416142011", var_50_9)
						arg_47_1:RecordAudio("416142011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_416142", "416142011", "story_v_out_416142.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_416142", "416142011", "story_v_out_416142.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play416142012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416142012
		arg_51_1.duration_ = 4.83

		local var_51_0 = {
			zh = 4.4,
			ja = 4.833
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play416142013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.275

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(416142012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 11 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 11)

				if (11 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 11)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142012", "story_v_out_416142.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142012", "story_v_out_416142.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_416142", "416142012", "story_v_out_416142.awb")

						arg_51_1:RecordAudio("416142012", var_54_6)
						arg_51_1:RecordAudio("416142012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_416142", "416142012", "story_v_out_416142.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_416142", "416142012", "story_v_out_416142.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play416142013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416142013
		arg_55_1.duration_ = 7.17

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play416142014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.STwhite == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_58_0.name = "STwhite"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.STwhite = var_58_0
			end

			if 1 < arg_55_1.time_ and arg_55_1.time_ <= 1 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.STwhite

				arg_55_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "STwhite" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			if arg_55_1.time_ >= var_58_4 + 0.3 and arg_55_1.time_ < var_58_4 + 0.3 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_5 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_6 = 1

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 then
				local var_58_7 = Color.New(1, 1, 1)

				var_58_7.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_5) / var_58_6)
				arg_55_1.mask_.color = var_58_7
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 then
				local var_58_8 = Color.New(1, 1, 1)

				var_58_8.a = 1
				arg_55_1.mask_.color = var_58_8
			end

			local var_58_9 = 1

			if 1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_10 = 0.866666666666667

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_10 then
				local var_58_11 = Color.New(1, 1, 1)

				var_58_11.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_9) / var_58_10)
				arg_55_1.mask_.color = var_58_11
			end

			if arg_55_1.time_ >= var_58_9 + var_58_10 and arg_55_1.time_ < var_58_9 + var_58_10 + arg_58_0 then
				local var_58_12 = Color.New(1, 1, 1)

				arg_55_1.mask_.enabled = false
				var_58_12.a = 0
				arg_55_1.mask_.color = var_58_12
			end

			if 1 < arg_55_1.time_ and arg_55_1.time_ <= 1 + arg_58_0 then
				if arg_55_1.var_.effect116 then
					Object.Destroy(arg_55_1.var_.effect116)

					arg_55_1.var_.effect116 = nil
				end
			end

			if 1.66666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.66666666666667 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_138", "se_story_138_elecskill01", "")
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_15 = 2.16666666666667
			local var_58_16 = 1.575

			if 2.16666666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_17 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_17:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(416142013).content)

				arg_55_1.text_.text = var_58_18

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 63 <= 0 and var_58_16 or var_58_16 * (utf8.len(var_58_18) / 63)

				if (63 <= 0 and var_58_16 or var_58_16 * (utf8.len(var_58_18) / 63)) > 0 and var_58_16 < var_58_20 then
					arg_55_1.talkMaxDuration = var_58_20
					var_58_15 = var_58_15 + 0.3

					if var_58_20 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_20 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_18
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_21 = var_58_15 + 0.3
			local var_58_22 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_22 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_21) / var_58_22

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_21 + var_58_22 and arg_55_1.time_ < var_58_21 + var_58_22 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play416142014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416142014
		arg_61_1.duration_ = 9.23

		local var_61_0 = {
			zh = 7.633,
			ja = 9.233
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416142015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 1 < arg_61_1.time_ and arg_61_1.time_ <= 1 + arg_64_0 then
				local var_64_0 = arg_61_1.bgs_.I13i

				arg_61_1.bgs_.I13i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_1 = var_64_0:GetComponent("SpriteRenderer")

				if var_64_1 and var_64_1.sprite then
					local var_64_2 = 2 * (var_64_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_0.transform.localScale = Vector3.New(var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "I13i" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_3 = 1

			if 1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_3 + 0.3 and arg_61_1.time_ < var_64_3 + 0.3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_4 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_5 = 1

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_5 then
				local var_64_6 = Color.New(0, 0, 0)

				var_64_6.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_4) / var_64_5)
				arg_61_1.mask_.color = var_64_6
			end

			if arg_61_1.time_ >= var_64_4 + var_64_5 and arg_61_1.time_ < var_64_4 + var_64_5 + arg_64_0 then
				local var_64_7 = Color.New(0, 0, 0)

				var_64_7.a = 1
				arg_61_1.mask_.color = var_64_7
			end

			local var_64_8 = 1

			if 1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_9 = 2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 then
				local var_64_10 = Color.New(0, 0, 0)

				var_64_10.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_8) / var_64_9)
				arg_61_1.mask_.color = var_64_10
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 then
				local var_64_11 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_11.a = 0
				arg_61_1.mask_.color = var_64_11
			end

			local var_64_12 = arg_61_1.actors_["1028"]

			if 2.6 < arg_61_1.time_ and arg_61_1.time_ <= 2.6 + arg_64_0 and not isNil(var_64_12) and arg_61_1.var_.actorSpriteComps1028 == nil then
				arg_61_1.var_.actorSpriteComps1028 = var_64_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_13 = 0.2

			if 2.6 <= arg_61_1.time_ and arg_61_1.time_ < 2.6 + var_64_13 and not isNil(var_64_12) then
				if arg_61_1.var_.actorSpriteComps1028 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								iter_64_3.color = Color.New(Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 2.6) / var_64_13), Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 2.6) / var_64_13), (Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 2.6) / var_64_13)))
							else
								local var_64_14 = Mathf.Lerp(iter_64_3.color.r, 1, (arg_61_1.time_ - 2.6) / var_64_13)

								iter_64_3.color = Color.New(var_64_14, var_64_14, var_64_14)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 2.6 + var_64_13 and arg_61_1.time_ < 2.6 + var_64_13 + arg_64_0 and not isNil(var_64_12) and arg_61_1.var_.actorSpriteComps1028 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_64_5 then
						iter_64_5.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1028 = nil
			end

			local var_64_15 = arg_61_1.actors_["1028"].transform

			if 2.6 < arg_61_1.time_ and arg_61_1.time_ <= 2.6 + arg_64_0 then
				arg_61_1.var_.moveOldPos1028 = var_64_15.localPosition
				var_64_15.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1028", 3)

				for iter_64_6 = 0, var_64_15.childCount - 1 do
					local var_64_16 = var_64_15:GetChild(iter_64_6)

					if var_64_16.name == "" or not string.find(var_64_16.name, "split") then
						var_64_16.gameObject:SetActive(true)
					else
						var_64_16.gameObject:SetActive(false)
					end
				end
			end

			local var_64_17 = 0.001

			if 2.6 <= arg_61_1.time_ and arg_61_1.time_ < 2.6 + var_64_17 then
				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_61_1.time_ - 2.6) / var_64_17)
			end

			if arg_61_1.time_ >= 2.6 + var_64_17 and arg_61_1.time_ < 2.6 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			if 2.56666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 2.56666666666667 + arg_64_0 then
				local var_64_18 = arg_61_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_18 then
					arg_61_1.var_.alphaOldValue1028 = var_64_18.alpha
					arg_61_1.var_.characterEffect1028 = var_64_18
				end

				arg_61_1.var_.alphaOldValue1028 = 0
			end

			local var_64_19 = 0.233333333333333

			if 2.56666666666667 <= arg_61_1.time_ and arg_61_1.time_ < 2.56666666666667 + var_64_19 then
				if arg_61_1.var_.characterEffect1028 then
					arg_61_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue1028, 1, (arg_61_1.time_ - 2.56666666666667) / var_64_19)
				end
			end

			if arg_61_1.time_ >= 2.56666666666667 + var_64_19 and arg_61_1.time_ < 2.56666666666667 + var_64_19 + arg_64_0 and arg_61_1.var_.characterEffect1028 then
				arg_61_1.var_.characterEffect1028.alpha = 1
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_20 = 3
			local var_64_21 = 0.4

			if 3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_20 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_22 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_22:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_23 = arg_61_1:GetWordFromCfg(416142014)
				local var_64_24 = arg_61_1:FormatText(var_64_23.content)

				arg_61_1.text_.text = var_64_24

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_26 = 16 <= 0 and var_64_21 or var_64_21 * (utf8.len(var_64_24) / 16)

				if (16 <= 0 and var_64_21 or var_64_21 * (utf8.len(var_64_24) / 16)) > 0 and var_64_21 < var_64_26 then
					arg_61_1.talkMaxDuration = var_64_26
					var_64_20 = var_64_20 + 0.3

					if var_64_26 + var_64_20 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_26 + var_64_20
					end
				end

				arg_61_1.text_.text = var_64_24
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142014", "story_v_out_416142.awb") ~= 0 then
					local var_64_27 = manager.audio:GetVoiceLength("story_v_out_416142", "416142014", "story_v_out_416142.awb") / 1000

					if var_64_27 + var_64_20 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_27 + var_64_20
					end

					if var_64_23.prefab_name ~= "" and arg_61_1.actors_[var_64_23.prefab_name] ~= nil then
						local var_64_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_23.prefab_name].transform, "story_v_out_416142", "416142014", "story_v_out_416142.awb")

						arg_61_1:RecordAudio("416142014", var_64_28)
						arg_61_1:RecordAudio("416142014", var_64_28)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416142", "416142014", "story_v_out_416142.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416142", "416142014", "story_v_out_416142.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_29 = var_64_20 + 0.3
			local var_64_30 = math.max(var_64_21, arg_61_1.talkMaxDuration)

			if var_64_20 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_29 + var_64_30 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_29) / var_64_30

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_29 + var_64_30 and arg_61_1.time_ < var_64_29 + var_64_30 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play416142015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416142015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416142016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1028"]) and arg_67_1.var_.actorSpriteComps1028 == nil then
				arg_67_1.var_.actorSpriteComps1028 = arg_67_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1028"]) then
				if arg_67_1.var_.actorSpriteComps1028 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								iter_70_1.color = Color.New(Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_0), Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_0), (Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_0)))
							else
								local var_70_1 = Mathf.Lerp(iter_70_1.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_0)

								iter_70_1.color = Color.New(var_70_1, var_70_1, var_70_1)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1028"]) and arg_67_1.var_.actorSpriteComps1028 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1028 = nil
			end

			local var_70_2 = 0
			local var_70_3 = 1.375

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(416142015).content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 55 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_4) / 55)

				if (55 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_4) / 55)) > 0 and var_70_3 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_7 and arg_67_1.time_ < var_70_2 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play416142016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416142016
		arg_71_1.duration_ = 4.4

		local var_71_0 = {
			zh = 4.233,
			ja = 4.4
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play416142017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["1086"] == nil then
				local var_74_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_74_0) then
					local var_74_1 = Object.Instantiate(var_74_0, arg_71_1.canvasGo_.transform)

					var_74_1.transform:SetSiblingIndex(1)

					var_74_1.name = "1086"
					var_74_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_71_1.actors_["1086"] = var_74_1

					if arg_71_1.isInRecall_ then
						for iter_74_0, iter_74_1 in ipairs((var_74_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_74_1.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_74_2 = arg_71_1.actors_["1086"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1086 == nil then
				arg_71_1.var_.actorSpriteComps1086 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps1086 then
					for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_74_3 then
							if arg_71_1.isInRecall_ then
								iter_74_3.color = Color.New(Mathf.Lerp(iter_74_3.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_3.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_3.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_3.color.r, 1, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_3.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1086 then
				for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_74_5 then
						iter_74_5.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps1086 = nil
			end

			local var_74_5 = arg_71_1.actors_["1028"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1028 = var_74_5.localPosition
				var_74_5.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1028", 7)

				for iter_74_6 = 0, var_74_5.childCount - 1 do
					local var_74_6 = var_74_5:GetChild(iter_74_6)

					if var_74_6.name == "" or not string.find(var_74_6.name, "split") then
						var_74_6.gameObject:SetActive(true)
					else
						var_74_6.gameObject:SetActive(false)
					end
				end
			end

			local var_74_7 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				var_74_5.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_71_1.time_ - 0) / var_74_7)
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				var_74_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_8 = arg_71_1.actors_["1086"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1086 = var_74_8.localPosition
				var_74_8.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1086", 3)

				for iter_74_7 = 0, var_74_8.childCount - 1 do
					local var_74_9 = var_74_8:GetChild(iter_74_7)

					if var_74_9.name == "" or not string.find(var_74_9.name, "split") then
						var_74_9.gameObject:SetActive(true)
					else
						var_74_9.gameObject:SetActive(false)
					end
				end
			end

			local var_74_10 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_10 then
				var_74_8.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_71_1.time_ - 0) / var_74_10)
			end

			if arg_71_1.time_ >= 0 + var_74_10 and arg_71_1.time_ < 0 + var_74_10 + arg_74_0 then
				var_74_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_74_11 = 0
			local var_74_12 = 0.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_13 = arg_71_1:GetWordFromCfg(416142016)
				local var_74_14 = arg_71_1:FormatText(var_74_13.content)

				arg_71_1.text_.text = var_74_14

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_16 = 20 <= 0 and var_74_12 or var_74_12 * (utf8.len(var_74_14) / 20)

				if (20 <= 0 and var_74_12 or var_74_12 * (utf8.len(var_74_14) / 20)) > 0 and var_74_12 < var_74_16 then
					arg_71_1.talkMaxDuration = var_74_16

					if var_74_16 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_11
					end
				end

				arg_71_1.text_.text = var_74_14
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142016", "story_v_out_416142.awb") ~= 0 then
					local var_74_17 = manager.audio:GetVoiceLength("story_v_out_416142", "416142016", "story_v_out_416142.awb") / 1000

					if var_74_17 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_11
					end

					if var_74_13.prefab_name ~= "" and arg_71_1.actors_[var_74_13.prefab_name] ~= nil then
						local var_74_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_13.prefab_name].transform, "story_v_out_416142", "416142016", "story_v_out_416142.awb")

						arg_71_1:RecordAudio("416142016", var_74_18)
						arg_71_1:RecordAudio("416142016", var_74_18)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416142", "416142016", "story_v_out_416142.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416142", "416142016", "story_v_out_416142.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_19 = math.max(var_74_12, arg_71_1.talkMaxDuration)

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_19 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_11) / var_74_19

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_11 + var_74_19 and arg_71_1.time_ < var_74_11 + var_74_19 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play416142017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416142017
		arg_75_1.duration_ = 3.1

		local var_75_0 = {
			zh = 3.1,
			ja = 2.433
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play416142018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1028"]) and arg_75_1.var_.actorSpriteComps1028 == nil then
				arg_75_1.var_.actorSpriteComps1028 = arg_75_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1028"]) then
				if arg_75_1.var_.actorSpriteComps1028 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 1, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1028"]) and arg_75_1.var_.actorSpriteComps1028 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1028 = nil
			end

			local var_78_2 = arg_75_1.actors_["1086"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1086 == nil then
				arg_75_1.var_.actorSpriteComps1086 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps1086 then
					for iter_78_4, iter_78_5 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_78_5 then
							if arg_75_1.isInRecall_ then
								iter_78_5.color = Color.New(Mathf.Lerp(iter_78_5.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_5.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_5.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_5.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_5.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1086 then
				for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_78_7 then
						iter_78_7.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps1086 = nil
			end

			local var_78_5 = arg_75_1.actors_["1028"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1028 = var_78_5.localPosition
				var_78_5.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1028", 2)

				for iter_78_8 = 0, var_78_5.childCount - 1 do
					local var_78_6 = var_78_5:GetChild(iter_78_8)

					if var_78_6.name == "" or not string.find(var_78_6.name, "split") then
						var_78_6.gameObject:SetActive(true)
					else
						var_78_6.gameObject:SetActive(false)
					end
				end
			end

			local var_78_7 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_75_1.time_ - 0) / var_78_7)
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_78_8 = arg_75_1.actors_["1086"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1086 = var_78_8.localPosition
				var_78_8.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1086", 4)

				for iter_78_9 = 0, var_78_8.childCount - 1 do
					local var_78_9 = var_78_8:GetChild(iter_78_9)

					if var_78_9.name == "" or not string.find(var_78_9.name, "split") then
						var_78_9.gameObject:SetActive(true)
					else
						var_78_9.gameObject:SetActive(false)
					end
				end
			end

			local var_78_10 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_10 then
				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_75_1.time_ - 0) / var_78_10)
			end

			if arg_75_1.time_ >= 0 + var_78_10 and arg_75_1.time_ < 0 + var_78_10 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_78_11 = 0
			local var_78_12 = 0.175

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(416142017)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_16 = 7 <= 0 and var_78_12 or var_78_12 * (utf8.len(var_78_14) / 7)

				if (7 <= 0 and var_78_12 or var_78_12 * (utf8.len(var_78_14) / 7)) > 0 and var_78_12 < var_78_16 then
					arg_75_1.talkMaxDuration = var_78_16

					if var_78_16 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_16 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142017", "story_v_out_416142.awb") ~= 0 then
					local var_78_17 = manager.audio:GetVoiceLength("story_v_out_416142", "416142017", "story_v_out_416142.awb") / 1000

					if var_78_17 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_11
					end

					if var_78_13.prefab_name ~= "" and arg_75_1.actors_[var_78_13.prefab_name] ~= nil then
						local var_78_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_13.prefab_name].transform, "story_v_out_416142", "416142017", "story_v_out_416142.awb")

						arg_75_1:RecordAudio("416142017", var_78_18)
						arg_75_1:RecordAudio("416142017", var_78_18)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416142", "416142017", "story_v_out_416142.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416142", "416142017", "story_v_out_416142.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_19 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_19 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_19

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_19 and arg_75_1.time_ < var_78_11 + var_78_19 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play416142018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416142018
		arg_79_1.duration_ = 4.2

		local var_79_0 = {
			zh = 3.333,
			ja = 4.2
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416142019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1086"]) and arg_79_1.var_.actorSpriteComps1086 == nil then
				arg_79_1.var_.actorSpriteComps1086 = arg_79_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1086"]) then
				if arg_79_1.var_.actorSpriteComps1086 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 1, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1086"]) and arg_79_1.var_.actorSpriteComps1086 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps1086 = nil
			end

			local var_82_2 = arg_79_1.actors_["1028"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps1028 == nil then
				arg_79_1.var_.actorSpriteComps1028 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps1028 then
					for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_82_5 then
							if arg_79_1.isInRecall_ then
								iter_82_5.color = Color.New(Mathf.Lerp(iter_82_5.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_5.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_5.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_5.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_5.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps1028 then
				for iter_82_6, iter_82_7 in pairs(arg_79_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_82_7 then
						iter_82_7.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1028 = nil
			end

			local var_82_5 = arg_79_1.actors_["1086"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1086 = var_82_5.localPosition
				var_82_5.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1086", 4)

				for iter_82_8 = 0, var_82_5.childCount - 1 do
					local var_82_6 = var_82_5:GetChild(iter_82_8)

					if var_82_6.name == "split_6" or not string.find(var_82_6.name, "split") then
						var_82_6.gameObject:SetActive(true)
					else
						var_82_6.gameObject:SetActive(false)
					end
				end
			end

			local var_82_7 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				var_82_5.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_79_1.time_ - 0) / var_82_7)
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				var_82_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_82_8 = 0
			local var_82_9 = 0.3

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(416142018)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 12 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 12)

				if (12 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 12)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142018", "story_v_out_416142.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_416142", "416142018", "story_v_out_416142.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_416142", "416142018", "story_v_out_416142.awb")

						arg_79_1:RecordAudio("416142018", var_82_15)
						arg_79_1:RecordAudio("416142018", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_416142", "416142018", "story_v_out_416142.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_416142", "416142018", "story_v_out_416142.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play416142019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416142019
		arg_83_1.duration_ = 5.53

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play416142020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_9000

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1086"]) and arg_83_1.var_.actorSpriteComps1086 == nil then
				arg_83_1.var_.actorSpriteComps1086 = arg_83_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1086"]) then
				if arg_83_1.var_.actorSpriteComps1086 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1086"]) and arg_83_1.var_.actorSpriteComps1086 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps1086 = nil
			end

			local var_86_2 = arg_83_1.actors_["1028"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1028 = var_86_2.localPosition
				var_86_2.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1028", 7)

				for iter_86_4 = 0, var_86_2.childCount - 1 do
					local var_86_3 = var_86_2:GetChild(iter_86_4)

					if var_86_3.name == "" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_2.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_83_1.time_ - 0) / var_86_4)
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_5 = arg_83_1.actors_["1086"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1086 = var_86_5.localPosition
				var_86_5.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1086", 7)

				for iter_86_5 = 0, var_86_5.childCount - 1 do
					local var_86_6 = var_86_5:GetChild(iter_86_5)

					if var_86_6.name == "" or not string.find(var_86_6.name, "split") then
						var_86_6.gameObject:SetActive(true)
					else
						var_86_6.gameObject:SetActive(false)
					end
				end
			end

			local var_86_7 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_83_1.time_ - 0) / var_86_7)
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				local var_86_8 = arg_83_1.var_.effect7777

				if not arg_83_1.var_.effect7777 then
					var_86_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_86_8.name = "7777"
					arg_83_1.var_.effect7777 = var_86_8
				else
					var_86_8.transform:SetParent(var_86_9000)
				end

				var_86_8.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_86_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_86_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_86_11 = var_86_8.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_86_6, iter_86_7 in ipairs((var_86_11:ToTable())) do
					iter_86_7.transform.localScale = Vector3.New(iter_86_7.transform.localScale.x / var_86_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_86_11 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_86_7.transform.localScale.y / var_86_10, iter_86_7.transform.localScale.z)
				end
			end

			if 0.733333333333333 < arg_83_1.time_ and arg_83_1.time_ <= 0.733333333333333 + arg_86_0 then
				if arg_83_1.var_.effect7777 then
					Object.Destroy(arg_83_1.var_.effect7777)

					arg_83_1.var_.effect7777 = nil
				end
			end

			local var_86_14 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			if arg_83_1.time_ >= var_86_14 + 0.833333333333333 and arg_83_1.time_ < var_86_14 + 0.833333333333333 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_127", "se_story_127_hit", "")
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_16 = 0.533333333333333
			local var_86_17 = 1.5

			if 0.533333333333333 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_18 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_18:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_19 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(416142019).content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_21 = 60 <= 0 and var_86_17 or var_86_17 * (utf8.len(var_86_19) / 60)

				if (60 <= 0 and var_86_17 or var_86_17 * (utf8.len(var_86_19) / 60)) > 0 and var_86_17 < var_86_21 then
					arg_83_1.talkMaxDuration = var_86_21
					var_86_16 = var_86_16 + 0.3

					if var_86_21 + var_86_16 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_21 + var_86_16
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = var_86_16 + 0.3
			local var_86_23 = math.max(var_86_17, arg_83_1.talkMaxDuration)

			if var_86_16 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_22 + var_86_23 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_22) / var_86_23

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_22 + var_86_23 and arg_83_1.time_ < var_86_22 + var_86_23 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play416142020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416142020
		arg_89_1.duration_ = 7.07

		local var_89_0 = {
			zh = 5.7,
			ja = 7.066
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play416142021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(416142020)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)

				if (18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142020", "story_v_out_416142.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142020", "story_v_out_416142.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_416142", "416142020", "story_v_out_416142.awb")

						arg_89_1:RecordAudio("416142020", var_92_6)
						arg_89_1:RecordAudio("416142020", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416142", "416142020", "story_v_out_416142.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416142", "416142020", "story_v_out_416142.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416142021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416142021
		arg_93_1.duration_ = 5.5

		local var_93_0 = {
			zh = 5,
			ja = 5.5
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play416142022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(416142021)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 14 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 14)

				if (14 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 14)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142021", "story_v_out_416142.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142021", "story_v_out_416142.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_416142", "416142021", "story_v_out_416142.awb")

						arg_93_1:RecordAudio("416142021", var_96_6)
						arg_93_1:RecordAudio("416142021", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416142", "416142021", "story_v_out_416142.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416142", "416142021", "story_v_out_416142.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play416142022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416142022
		arg_97_1.duration_ = 6

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416142023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_100_0 = 0.8

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				local var_100_1, var_100_2 = math.modf((arg_97_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_100_2 * 0.13, var_100_2 * 0.13, var_100_2 * 0.13) + arg_97_1.var_.shakeOldPos
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				manager.ui.mainCamera.transform.localPosition = arg_97_1.var_.shakeOldPos
			end

			local var_100_3 = 0.6

			if 0.6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_4 = 0.5

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_4 then
				local var_100_5 = Color.New(0.5188679, 0.03671235, 0.03671235)

				var_100_5.a = Mathf.Lerp(1, 0, (arg_97_1.time_ - var_100_3) / var_100_4)
				arg_97_1.mask_.color = var_100_5
			end

			if arg_97_1.time_ >= var_100_3 + var_100_4 and arg_97_1.time_ < var_100_3 + var_100_4 + arg_100_0 then
				local var_100_6 = Color.New(0.5188679, 0.03671235, 0.03671235)

				arg_97_1.mask_.enabled = false
				var_100_6.a = 0
				arg_97_1.mask_.color = var_100_6
			end

			local var_100_7 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			if arg_97_1.time_ >= var_100_7 + 1.33333333333333 and arg_97_1.time_ < var_100_7 + 1.33333333333333 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			if 0.7 < arg_97_1.time_ and arg_97_1.time_ <= 0.7 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_15", "se_story_15_shock", "")
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_9 = 1
			local var_100_10 = 2.15

			if 1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_11 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_11:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_12 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(416142022).content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_14 = 86 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_12) / 86)

				if (86 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_12) / 86)) > 0 and var_100_10 < var_100_14 then
					arg_97_1.talkMaxDuration = var_100_14
					var_100_9 = var_100_9 + 0.3

					if var_100_14 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_15 = var_100_9 + 0.3
			local var_100_16 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 + 0.3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_16 and arg_97_1.time_ < var_100_15 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play416142023 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416142023
		arg_103_1.duration_ = 3.47

		local var_103_0 = {
			zh = 3.466,
			ja = 3.366
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play416142024(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1028"]) and arg_103_1.var_.actorSpriteComps1028 == nil then
				arg_103_1.var_.actorSpriteComps1028 = arg_103_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1028"]) then
				if arg_103_1.var_.actorSpriteComps1028 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1028"]) and arg_103_1.var_.actorSpriteComps1028 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1028 = nil
			end

			local var_106_2 = arg_103_1.actors_["1028"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1028 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1028", 3)

				for iter_106_4 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_4)

					if var_106_3.name == "split_2" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_106_5 = 0
			local var_106_6 = 0.4

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(416142023)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 16 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 16)

				if (16 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 16)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142023", "story_v_out_416142.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_416142", "416142023", "story_v_out_416142.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_416142", "416142023", "story_v_out_416142.awb")

						arg_103_1:RecordAudio("416142023", var_106_12)
						arg_103_1:RecordAudio("416142023", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416142", "416142023", "story_v_out_416142.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416142", "416142023", "story_v_out_416142.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play416142024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416142024
		arg_107_1.duration_ = 6.6

		local var_107_0 = {
			zh = 3.333,
			ja = 6.6
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416142025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1086"]) and arg_107_1.var_.actorSpriteComps1086 == nil then
				arg_107_1.var_.actorSpriteComps1086 = arg_107_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1086"]) then
				if arg_107_1.var_.actorSpriteComps1086 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 1, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1086"]) and arg_107_1.var_.actorSpriteComps1086 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps1086 = nil
			end

			local var_110_2 = arg_107_1.actors_["1086"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1086 = var_110_2.localPosition
				var_110_2.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1086", 4)

				for iter_110_4 = 0, var_110_2.childCount - 1 do
					local var_110_3 = var_110_2:GetChild(iter_110_4)

					if var_110_3.name == "split_6" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_107_1.time_ - 0) / var_110_4)
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_110_5 = arg_107_1.actors_["1028"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1028 = var_110_5.localPosition
				var_110_5.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1028", 2)

				for iter_110_5 = 0, var_110_5.childCount - 1 do
					local var_110_6 = var_110_5:GetChild(iter_110_5)

					if var_110_6.name == "" or not string.find(var_110_6.name, "split") then
						var_110_6.gameObject:SetActive(true)
					else
						var_110_6.gameObject:SetActive(false)
					end
				end
			end

			local var_110_7 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_107_1.time_ - 0) / var_110_7)
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_110_8 = arg_107_1.actors_["1028"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps1028 == nil then
				arg_107_1.var_.actorSpriteComps1028 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_9 and not isNil(var_110_8) then
				if arg_107_1.var_.actorSpriteComps1028 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								iter_110_7.color = Color.New(Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_9), Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_9), (Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_9)))
							else
								local var_110_10 = Mathf.Lerp(iter_110_7.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_9)

								iter_110_7.color = Color.New(var_110_10, var_110_10, var_110_10)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_9 and arg_107_1.time_ < 0 + var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps1028 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_110_9 then
						iter_110_9.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1028 = nil
			end

			local var_110_11 = 0
			local var_110_12 = 0.35

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(416142024)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 14 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 14)

				if (14 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 14)) > 0 and var_110_12 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142024", "story_v_out_416142.awb") ~= 0 then
					local var_110_17 = manager.audio:GetVoiceLength("story_v_out_416142", "416142024", "story_v_out_416142.awb") / 1000

					if var_110_17 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_11
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_416142", "416142024", "story_v_out_416142.awb")

						arg_107_1:RecordAudio("416142024", var_110_18)
						arg_107_1:RecordAudio("416142024", var_110_18)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416142", "416142024", "story_v_out_416142.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416142", "416142024", "story_v_out_416142.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_19 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_19 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_19

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_19 and arg_107_1.time_ < var_110_11 + var_110_19 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play416142025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416142025
		arg_111_1.duration_ = 5.93

		local var_111_0 = {
			zh = 4.766,
			ja = 5.933
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play416142026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1028"]) and arg_111_1.var_.actorSpriteComps1028 == nil then
				arg_111_1.var_.actorSpriteComps1028 = arg_111_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1028"]) then
				if arg_111_1.var_.actorSpriteComps1028 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 1, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1028"]) and arg_111_1.var_.actorSpriteComps1028 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1028 = nil
			end

			local var_114_2 = arg_111_1.actors_["1086"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1086 == nil then
				arg_111_1.var_.actorSpriteComps1086 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps1086 then
					for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_114_5 then
							if arg_111_1.isInRecall_ then
								iter_114_5.color = Color.New(Mathf.Lerp(iter_114_5.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_5.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_5.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_5.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_5.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1086 then
				for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_114_7 then
						iter_114_7.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps1086 = nil
			end

			local var_114_5 = 0
			local var_114_6 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(416142025)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 20 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 20)

				if (20 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 20)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142025", "story_v_out_416142.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_416142", "416142025", "story_v_out_416142.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_416142", "416142025", "story_v_out_416142.awb")

						arg_111_1:RecordAudio("416142025", var_114_12)
						arg_111_1:RecordAudio("416142025", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416142", "416142025", "story_v_out_416142.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416142", "416142025", "story_v_out_416142.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_13 and arg_111_1.time_ < var_114_5 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416142026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416142026
		arg_115_1.duration_ = 6.37

		local var_115_0 = {
			zh = 4.566,
			ja = 6.366
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play416142027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1028 = arg_115_1.actors_["1028"].transform.localPosition
				arg_115_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1028", 2)

				for iter_118_0 = 0, arg_115_1.actors_["1028"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1028"].transform:GetChild(iter_118_0)

					if var_118_0.name == "split_2" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1028"].transform.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_118_2 = 0
			local var_118_3 = 0.35

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(416142026)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 14 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 14)

				if (14 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 14)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142026", "story_v_out_416142.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142026", "story_v_out_416142.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_416142", "416142026", "story_v_out_416142.awb")

						arg_115_1:RecordAudio("416142026", var_118_9)
						arg_115_1:RecordAudio("416142026", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416142", "416142026", "story_v_out_416142.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416142", "416142026", "story_v_out_416142.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play416142027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416142027
		arg_119_1.duration_ = 8.07

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play416142028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_9000

			if arg_119_1.bgs_.SS1606a == nil then
				local var_122_0 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1606a")
				var_122_0.name = "SS1606a"
				var_122_0.transform.parent = arg_119_1.stage_.transform
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_.SS1606a = var_122_0
			end

			if 1.33333333333333 < arg_119_1.time_ and arg_119_1.time_ <= 1.33333333333333 + arg_122_0 then
				local var_122_1 = arg_119_1.bgs_.SS1606a

				arg_119_1.bgs_.SS1606a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_2 = var_122_1:GetComponent("SpriteRenderer")

				if var_122_2 and var_122_2.sprite then
					local var_122_3 = 2 * (var_122_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_1.transform.localScale = Vector3.New(var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "SS1606a" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_4 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			if arg_119_1.time_ >= var_122_4 + 0.3 and arg_119_1.time_ < var_122_4 + 0.3 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_5 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_6 = 1.33333333333333

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 then
				local var_122_7 = Color.New(1, 1, 1)

				var_122_7.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_5) / var_122_6)
				arg_119_1.mask_.color = var_122_7
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 then
				local var_122_8 = Color.New(1, 1, 1)

				var_122_8.a = 1
				arg_119_1.mask_.color = var_122_8
			end

			local var_122_9 = 1.33333333333333

			if 1.33333333333333 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_10 = 1.16666666666667

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 then
				local var_122_11 = Color.New(1, 1, 1)

				var_122_11.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_9) / var_122_10)
				arg_119_1.mask_.color = var_122_11
			end

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 then
				local var_122_12 = Color.New(1, 1, 1)

				arg_119_1.mask_.enabled = false
				var_122_12.a = 0
				arg_119_1.mask_.color = var_122_12
			end

			local var_122_13 = arg_119_1.actors_["1028"].transform

			if 1.3 < arg_119_1.time_ and arg_119_1.time_ <= 1.3 + arg_122_0 then
				arg_119_1.var_.moveOldPos1028 = var_122_13.localPosition
				var_122_13.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1028", 7)

				for iter_122_2 = 0, var_122_13.childCount - 1 do
					local var_122_14 = var_122_13:GetChild(iter_122_2)

					if var_122_14.name == "" or not string.find(var_122_14.name, "split") then
						var_122_14.gameObject:SetActive(true)
					else
						var_122_14.gameObject:SetActive(false)
					end
				end
			end

			local var_122_15 = 0.001

			if 1.3 <= arg_119_1.time_ and arg_119_1.time_ < 1.3 + var_122_15 then
				var_122_13.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 1.3) / var_122_15)
			end

			if arg_119_1.time_ >= 1.3 + var_122_15 and arg_119_1.time_ < 1.3 + var_122_15 + arg_122_0 then
				var_122_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_16 = arg_119_1.actors_["1086"].transform

			if 1.3 < arg_119_1.time_ and arg_119_1.time_ <= 1.3 + arg_122_0 then
				arg_119_1.var_.moveOldPos1086 = var_122_16.localPosition
				var_122_16.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1086", 7)

				for iter_122_3 = 0, var_122_16.childCount - 1 do
					local var_122_17 = var_122_16:GetChild(iter_122_3)

					if var_122_17.name == "" or not string.find(var_122_17.name, "split") then
						var_122_17.gameObject:SetActive(true)
					else
						var_122_17.gameObject:SetActive(false)
					end
				end
			end

			local var_122_18 = 0.001

			if 1.3 <= arg_119_1.time_ and arg_119_1.time_ < 1.3 + var_122_18 then
				var_122_16.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 1.3) / var_122_18)
			end

			if arg_119_1.time_ >= 1.3 + var_122_18 and arg_119_1.time_ < 1.3 + var_122_18 + arg_122_0 then
				var_122_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.334 < arg_119_1.time_ and arg_119_1.time_ <= 1.334 + arg_122_0 then
				local var_122_19 = arg_119_1.var_.effect119

				if not arg_119_1.var_.effect119 then
					var_122_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_122_19.name = "119"
					arg_119_1.var_.effect119 = var_122_19
				else
					var_122_19.transform:SetParent(var_122_9000)
				end

				var_122_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_122_21 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_122_22 = var_122_19.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_122_4, iter_122_5 in ipairs((var_122_22:ToTable())) do
					iter_122_5.transform.localScale = Vector3.New(iter_122_5.transform.localScale.x / var_122_21 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_122_22 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_122_5.transform.localScale.y / var_122_21, iter_122_5.transform.localScale.z)
				end
			end

			if 1.334 < arg_119_1.time_ and arg_119_1.time_ <= 1.334 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_25 = 3.06666666666667
			local var_122_26 = 1.025

			if 3.06666666666667 < arg_119_1.time_ and arg_119_1.time_ <= var_122_25 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_27 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_27:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_28 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(416142027).content)

				arg_119_1.text_.text = var_122_28

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_30 = 41 <= 0 and var_122_26 or var_122_26 * (utf8.len(var_122_28) / 41)

				if (41 <= 0 and var_122_26 or var_122_26 * (utf8.len(var_122_28) / 41)) > 0 and var_122_26 < var_122_30 then
					arg_119_1.talkMaxDuration = var_122_30
					var_122_25 = var_122_25 + 0.3

					if var_122_30 + var_122_25 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_30 + var_122_25
					end
				end

				arg_119_1.text_.text = var_122_28
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_31 = var_122_25 + 0.3
			local var_122_32 = math.max(var_122_26, arg_119_1.talkMaxDuration)

			if var_122_25 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_31 + var_122_32 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_31) / var_122_32

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_31 + var_122_32 and arg_119_1.time_ < var_122_31 + var_122_32 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play416142028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416142028
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play416142029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(416142028).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 56 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 56)

				if (56 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 56)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play416142029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416142029
		arg_129_1.duration_ = 5.03

		local var_129_0 = {
			zh = 4.6,
			ja = 5.033
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play416142030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(416142029)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 21 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 21)

				if (21 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 21)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142029", "story_v_out_416142.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142029", "story_v_out_416142.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_416142", "416142029", "story_v_out_416142.awb")

						arg_129_1:RecordAudio("416142029", var_132_6)
						arg_129_1:RecordAudio("416142029", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416142", "416142029", "story_v_out_416142.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416142", "416142029", "story_v_out_416142.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416142030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416142030
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play416142031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.3

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(416142030).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 52 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 52)

				if (52 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 52)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play416142031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416142031
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play416142032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.35

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(416142031).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 54 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 54)

				if (54 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 54)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play416142032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416142032
		arg_141_1.duration_ = 8.27

		local var_141_0 = {
			zh = 4.866,
			ja = 8.266
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416142033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.8

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(416142032)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 32 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 32)

				if (32 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 32)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142032", "story_v_out_416142.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142032", "story_v_out_416142.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_416142", "416142032", "story_v_out_416142.awb")

						arg_141_1:RecordAudio("416142032", var_144_6)
						arg_141_1:RecordAudio("416142032", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416142", "416142032", "story_v_out_416142.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416142", "416142032", "story_v_out_416142.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play416142033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416142033
		arg_145_1.duration_ = 4.43

		local var_145_0 = {
			zh = 2.9,
			ja = 4.433
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play416142034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.35

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(416142033)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 14 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 14)

				if (14 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 14)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142033", "story_v_out_416142.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142033", "story_v_out_416142.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_416142", "416142033", "story_v_out_416142.awb")

						arg_145_1:RecordAudio("416142033", var_148_6)
						arg_145_1:RecordAudio("416142033", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416142", "416142033", "story_v_out_416142.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416142", "416142033", "story_v_out_416142.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play416142034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416142034
		arg_149_1.duration_ = 6.53

		local var_149_0 = {
			zh = 5.633,
			ja = 6.533
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play416142035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.825

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(416142034)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 33 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 33)

				if (33 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 33)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142034", "story_v_out_416142.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142034", "story_v_out_416142.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_416142", "416142034", "story_v_out_416142.awb")

						arg_149_1:RecordAudio("416142034", var_152_6)
						arg_149_1:RecordAudio("416142034", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416142", "416142034", "story_v_out_416142.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416142", "416142034", "story_v_out_416142.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416142035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416142035
		arg_153_1.duration_ = 7.37

		local var_153_0 = {
			zh = 4.4,
			ja = 7.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play416142036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(416142035)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 26 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 26)

				if (26 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 26)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142035", "story_v_out_416142.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142035", "story_v_out_416142.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_416142", "416142035", "story_v_out_416142.awb")

						arg_153_1:RecordAudio("416142035", var_156_6)
						arg_153_1:RecordAudio("416142035", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416142", "416142035", "story_v_out_416142.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416142", "416142035", "story_v_out_416142.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416142036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416142036
		arg_157_1.duration_ = 6.37

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416142037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_0 = 0.866666666666667

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				local var_160_1 = Color.New(1, 1, 1)

				var_160_1.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.mask_.color = var_160_1
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				local var_160_2 = Color.New(1, 1, 1)

				arg_157_1.mask_.enabled = false
				var_160_2.a = 0
				arg_157_1.mask_.color = var_160_2
			end

			local var_160_3 = arg_157_1.bgs_.SS1606a.transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPosSS1606a = var_160_3.localPosition
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosSS1606a, Vector3.New(0, 1, 10), (arg_157_1.time_ - 0) / var_160_4)
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, 1, 10)
			end

			local var_160_5 = arg_157_1.bgs_.SS1606a.transform

			if 0.034 < arg_157_1.time_ and arg_157_1.time_ <= 0.034 + arg_160_0 then
				arg_157_1.var_.moveOldPosSS1606a = var_160_5.localPosition
			end

			local var_160_6 = 2.39933333333333

			if 0.034 <= arg_157_1.time_ and arg_157_1.time_ < 0.034 + var_160_6 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosSS1606a, Vector3.New(0, 1, 9), (arg_157_1.time_ - 0.034) / var_160_6)
			end

			if arg_157_1.time_ >= 0.034 + var_160_6 and arg_157_1.time_ < 0.034 + var_160_6 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(0, 1, 9)
			end

			local var_160_7 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_7 + 2.23333333333333 and arg_157_1.time_ < var_160_7 + 2.23333333333333 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			if 0.266666666666667 < arg_157_1.time_ and arg_157_1.time_ <= 0.266666666666667 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_leiguang", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_9 = 1.36666666666667
			local var_160_10 = 1.775

			if 1.36666666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_11 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_11:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_12 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(416142036).content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_14 = 71 <= 0 and var_160_10 or var_160_10 * (utf8.len(var_160_12) / 71)

				if (71 <= 0 and var_160_10 or var_160_10 * (utf8.len(var_160_12) / 71)) > 0 and var_160_10 < var_160_14 then
					arg_157_1.talkMaxDuration = var_160_14
					var_160_9 = var_160_9 + 0.3

					if var_160_14 + var_160_9 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_9
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_15 = var_160_9 + 0.3
			local var_160_16 = math.max(var_160_10, arg_157_1.talkMaxDuration)

			if var_160_9 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_16 and arg_157_1.time_ < var_160_15 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1606a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1606a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play416142037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416142037
		arg_163_1.duration_ = 8.03

		local var_163_0 = {
			zh = 8.03333333333333,
			ja = 7.06633333333333
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play416142038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if arg_163_1.bgs_.I13f == nil then
				local var_166_0 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13f")
				var_166_0.name = "I13f"
				var_166_0.transform.parent = arg_163_1.stage_.transform
				var_166_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_.I13f = var_166_0
			end

			if 1.33333333333333 < arg_163_1.time_ and arg_163_1.time_ <= 1.33333333333333 + arg_166_0 then
				local var_166_1 = arg_163_1.bgs_.I13f

				arg_163_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_166_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_2 = var_166_1:GetComponent("SpriteRenderer")

				if var_166_2 and var_166_2.sprite then
					local var_166_3 = 2 * (var_166_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_166_1.transform.localScale = Vector3.New(var_166_3 / var_166_2.sprite.bounds.size.y < var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x and var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x or var_166_3 / var_166_2.sprite.bounds.size.y, var_166_3 / var_166_2.sprite.bounds.size.y < var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x and var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x or var_166_3 / var_166_2.sprite.bounds.size.y, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "I13f" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_4 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_4 + 0.3 and arg_163_1.time_ < var_166_4 + 0.3 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_5 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_6 = 1.33333333333333

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 then
				local var_166_7 = Color.New(0, 0, 0)

				var_166_7.a = Mathf.Lerp(0, 1, (arg_163_1.time_ - var_166_5) / var_166_6)
				arg_163_1.mask_.color = var_166_7
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 then
				local var_166_8 = Color.New(0, 0, 0)

				var_166_8.a = 1
				arg_163_1.mask_.color = var_166_8
			end

			local var_166_9 = 1.33333333333333

			if 1.33333333333333 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_10 = 2

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_10 then
				local var_166_11 = Color.New(0, 0, 0)

				var_166_11.a = Mathf.Lerp(1, 0, (arg_163_1.time_ - var_166_9) / var_166_10)
				arg_163_1.mask_.color = var_166_11
			end

			if arg_163_1.time_ >= var_166_9 + var_166_10 and arg_163_1.time_ < var_166_9 + var_166_10 + arg_166_0 then
				local var_166_12 = Color.New(0, 0, 0)

				arg_163_1.mask_.enabled = false
				var_166_12.a = 0
				arg_163_1.mask_.color = var_166_12
			end

			local var_166_13 = "10122"

			if arg_163_1.actors_["10122"] == nil then
				local var_166_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

				if not isNil(var_166_14) then
					local var_166_15 = Object.Instantiate(var_166_14, arg_163_1.canvasGo_.transform)

					var_166_15.transform:SetSiblingIndex(1)

					var_166_15.name = var_166_13
					var_166_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_163_1.actors_[var_166_13] = var_166_15

					if arg_163_1.isInRecall_ then
						for iter_166_2, iter_166_3 in ipairs((var_166_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_166_16 = arg_163_1.actors_["10122"]

			if 3 < arg_163_1.time_ and arg_163_1.time_ <= 3 + arg_166_0 and not isNil(var_166_16) and arg_163_1.var_.actorSpriteComps10122 == nil then
				arg_163_1.var_.actorSpriteComps10122 = var_166_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_17 = 0.2

			if 3 <= arg_163_1.time_ and arg_163_1.time_ < 3 + var_166_17 and not isNil(var_166_16) then
				if arg_163_1.var_.actorSpriteComps10122 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_166_5 then
							if arg_163_1.isInRecall_ then
								iter_166_5.color = Color.New(Mathf.Lerp(iter_166_5.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 3) / var_166_17), Mathf.Lerp(iter_166_5.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 3) / var_166_17), (Mathf.Lerp(iter_166_5.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 3) / var_166_17)))
							else
								local var_166_18 = Mathf.Lerp(iter_166_5.color.r, 1, (arg_163_1.time_ - 3) / var_166_17)

								iter_166_5.color = Color.New(var_166_18, var_166_18, var_166_18)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 3 + var_166_17 and arg_163_1.time_ < 3 + var_166_17 + arg_166_0 and not isNil(var_166_16) and arg_163_1.var_.actorSpriteComps10122 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_166_7 then
						iter_166_7.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10122 = nil
			end

			local var_166_19 = arg_163_1.actors_["10122"].transform

			if 3 < arg_163_1.time_ and arg_163_1.time_ <= 3 + arg_166_0 then
				arg_163_1.var_.moveOldPos10122 = var_166_19.localPosition
				var_166_19.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10122", 2)

				for iter_166_8 = 0, var_166_19.childCount - 1 do
					local var_166_20 = var_166_19:GetChild(iter_166_8)

					if var_166_20.name == "split_5" or not string.find(var_166_20.name, "split") then
						var_166_20.gameObject:SetActive(true)
					else
						var_166_20.gameObject:SetActive(false)
					end
				end
			end

			local var_166_21 = 0.001

			if 3 <= arg_163_1.time_ and arg_163_1.time_ < 3 + var_166_21 then
				var_166_19.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_163_1.time_ - 3) / var_166_21)
			end

			if arg_163_1.time_ >= 3 + var_166_21 and arg_163_1.time_ < 3 + var_166_21 + arg_166_0 then
				var_166_19.localPosition = Vector3.New(-390, -380, -100)
			end

			if 3 < arg_163_1.time_ and arg_163_1.time_ <= 3 + arg_166_0 then
				local var_166_22 = arg_163_1.actors_["10122"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_166_22 then
					arg_163_1.var_.alphaOldValue10122 = var_166_22.alpha
					arg_163_1.var_.characterEffect10122 = var_166_22
				end

				arg_163_1.var_.alphaOldValue10122 = 0
			end

			local var_166_23 = 0.2

			if 3 <= arg_163_1.time_ and arg_163_1.time_ < 3 + var_166_23 then
				if arg_163_1.var_.characterEffect10122 then
					arg_163_1.var_.characterEffect10122.alpha = Mathf.Lerp(arg_163_1.var_.alphaOldValue10122, 1, (arg_163_1.time_ - 3) / var_166_23)
				end
			end

			if arg_163_1.time_ >= 3 + var_166_23 and arg_163_1.time_ < 3 + var_166_23 + arg_166_0 and arg_163_1.var_.characterEffect10122 then
				arg_163_1.var_.characterEffect10122.alpha = 1
			end

			if 1.334 < arg_163_1.time_ and arg_163_1.time_ <= 1.334 + arg_166_0 then
				if arg_163_1.var_.effect119 then
					Object.Destroy(arg_163_1.var_.effect119)

					arg_163_1.var_.effect119 = nil
				end
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_25 = 3.33333333333333
			local var_166_26 = 0.5

			if 3.33333333333333 < arg_163_1.time_ and arg_163_1.time_ <= var_166_25 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_27 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_27:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_28 = arg_163_1:GetWordFromCfg(416142037)
				local var_166_29 = arg_163_1:FormatText(var_166_28.content)

				arg_163_1.text_.text = var_166_29

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_31 = 20 <= 0 and var_166_26 or var_166_26 * (utf8.len(var_166_29) / 20)

				if (20 <= 0 and var_166_26 or var_166_26 * (utf8.len(var_166_29) / 20)) > 0 and var_166_26 < var_166_31 then
					arg_163_1.talkMaxDuration = var_166_31
					var_166_25 = var_166_25 + 0.3

					if var_166_31 + var_166_25 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_25
					end
				end

				arg_163_1.text_.text = var_166_29
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142037", "story_v_out_416142.awb") ~= 0 then
					local var_166_32 = manager.audio:GetVoiceLength("story_v_out_416142", "416142037", "story_v_out_416142.awb") / 1000

					if var_166_32 + var_166_25 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_32 + var_166_25
					end

					if var_166_28.prefab_name ~= "" and arg_163_1.actors_[var_166_28.prefab_name] ~= nil then
						local var_166_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_28.prefab_name].transform, "story_v_out_416142", "416142037", "story_v_out_416142.awb")

						arg_163_1:RecordAudio("416142037", var_166_33)
						arg_163_1:RecordAudio("416142037", var_166_33)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416142", "416142037", "story_v_out_416142.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416142", "416142037", "story_v_out_416142.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_34 = var_166_25 + 0.3
			local var_166_35 = math.max(var_166_26, arg_163_1.talkMaxDuration)

			if var_166_25 + 0.3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_34 + var_166_35 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_34) / var_166_35

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_34 + var_166_35 and arg_163_1.time_ < var_166_34 + var_166_35 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play416142038 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416142038
		arg_169_1.duration_ = 5.9

		local var_169_0 = {
			zh = 4.233,
			ja = 5.9
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play416142039(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if arg_169_1.actors_["10127"] == nil then
				local var_172_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_172_0) then
					local var_172_1 = Object.Instantiate(var_172_0, arg_169_1.canvasGo_.transform)

					var_172_1.transform:SetSiblingIndex(1)

					var_172_1.name = "10127"
					var_172_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_169_1.actors_["10127"] = var_172_1

					if arg_169_1.isInRecall_ then
						for iter_172_0, iter_172_1 in ipairs((var_172_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_172_1.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_172_2 = arg_169_1.actors_["10127"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10127 == nil then
				arg_169_1.var_.actorSpriteComps10127 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps10127 then
					for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_172_3 then
							if arg_169_1.isInRecall_ then
								iter_172_3.color = Color.New(Mathf.Lerp(iter_172_3.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_3.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_3.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_3.color.r, 1, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_3.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10127 then
				for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_172_5 then
						iter_172_5.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10127 = nil
			end

			local var_172_5 = arg_169_1.actors_["10122"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10122 == nil then
				arg_169_1.var_.actorSpriteComps10122 = var_172_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.actorSpriteComps10122 then
					for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_172_7 then
							if arg_169_1.isInRecall_ then
								iter_172_7.color = Color.New(Mathf.Lerp(iter_172_7.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_6), Mathf.Lerp(iter_172_7.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_6), (Mathf.Lerp(iter_172_7.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_6)))
							else
								local var_172_7 = Mathf.Lerp(iter_172_7.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_6)

								iter_172_7.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10122 then
				for iter_172_8, iter_172_9 in pairs(arg_169_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_172_9 then
						iter_172_9.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10122 = nil
			end

			local var_172_8 = arg_169_1.actors_["10127"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10127 = var_172_8.localPosition
				var_172_8.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10127", 4)

				for iter_172_10 = 0, var_172_8.childCount - 1 do
					local var_172_9 = var_172_8:GetChild(iter_172_10)

					if var_172_9.name == "split_1" or not string.find(var_172_9.name, "split") then
						var_172_9.gameObject:SetActive(true)
					else
						var_172_9.gameObject:SetActive(false)
					end
				end
			end

			local var_172_10 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_10 then
				var_172_8.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_169_1.time_ - 0) / var_172_10)
			end

			if arg_169_1.time_ >= 0 + var_172_10 and arg_169_1.time_ < 0 + var_172_10 + arg_172_0 then
				var_172_8.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_172_11 = 0
			local var_172_12 = 0.625

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_13 = arg_169_1:GetWordFromCfg(416142038)
				local var_172_14 = arg_169_1:FormatText(var_172_13.content)

				arg_169_1.text_.text = var_172_14

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_16 = 25 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_14) / 25)

				if (25 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_14) / 25)) > 0 and var_172_12 < var_172_16 then
					arg_169_1.talkMaxDuration = var_172_16

					if var_172_16 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_11
					end
				end

				arg_169_1.text_.text = var_172_14
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142038", "story_v_out_416142.awb") ~= 0 then
					local var_172_17 = manager.audio:GetVoiceLength("story_v_out_416142", "416142038", "story_v_out_416142.awb") / 1000

					if var_172_17 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_11
					end

					if var_172_13.prefab_name ~= "" and arg_169_1.actors_[var_172_13.prefab_name] ~= nil then
						local var_172_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_13.prefab_name].transform, "story_v_out_416142", "416142038", "story_v_out_416142.awb")

						arg_169_1:RecordAudio("416142038", var_172_18)
						arg_169_1:RecordAudio("416142038", var_172_18)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416142", "416142038", "story_v_out_416142.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416142", "416142038", "story_v_out_416142.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_19 = math.max(var_172_12, arg_169_1.talkMaxDuration)

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_19 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_19

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_19 and arg_169_1.time_ < var_172_11 + var_172_19 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play416142039 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416142039
		arg_173_1.duration_ = 8.17

		local var_173_0 = {
			zh = 4.1,
			ja = 8.166
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416142040(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.6

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(416142039)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 24 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 24)

				if (24 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 24)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142039", "story_v_out_416142.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142039", "story_v_out_416142.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_416142", "416142039", "story_v_out_416142.awb")

						arg_173_1:RecordAudio("416142039", var_176_6)
						arg_173_1:RecordAudio("416142039", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416142", "416142039", "story_v_out_416142.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416142", "416142039", "story_v_out_416142.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416142040 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416142040
		arg_177_1.duration_ = 1.9

		local var_177_0 = {
			zh = 1.9,
			ja = 1.5
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play416142041(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10122"]) and arg_177_1.var_.actorSpriteComps10122 == nil then
				arg_177_1.var_.actorSpriteComps10122 = arg_177_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10122"]) then
				if arg_177_1.var_.actorSpriteComps10122 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10122"]) and arg_177_1.var_.actorSpriteComps10122 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10122 = nil
			end

			local var_180_2 = arg_177_1.actors_["10127"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10127 == nil then
				arg_177_1.var_.actorSpriteComps10127 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps10127 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								iter_180_5.color = Color.New(Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_5.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_5.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10127 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_180_7 then
						iter_180_7.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10127 = nil
			end

			local var_180_5 = arg_177_1.actors_["10122"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10122 = var_180_5.localPosition
				var_180_5.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10122", 2)

				for iter_180_8 = 0, var_180_5.childCount - 1 do
					local var_180_6 = var_180_5:GetChild(iter_180_8)

					if var_180_6.name == "split_4" or not string.find(var_180_6.name, "split") then
						var_180_6.gameObject:SetActive(true)
					else
						var_180_6.gameObject:SetActive(false)
					end
				end
			end

			local var_180_7 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				var_180_5.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_177_1.time_ - 0) / var_180_7)
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				var_180_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_180_8 = 0
			local var_180_9 = 0.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(416142040)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 4 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 4)

				if (4 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 4)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142040", "story_v_out_416142.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_416142", "416142040", "story_v_out_416142.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_416142", "416142040", "story_v_out_416142.awb")

						arg_177_1:RecordAudio("416142040", var_180_15)
						arg_177_1:RecordAudio("416142040", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416142", "416142040", "story_v_out_416142.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416142", "416142040", "story_v_out_416142.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play416142041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416142041
		arg_181_1.duration_ = 5.9

		local var_181_0 = {
			zh = 3.6,
			ja = 5.9
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play416142042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10127"]) and arg_181_1.var_.actorSpriteComps10127 == nil then
				arg_181_1.var_.actorSpriteComps10127 = arg_181_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10127"]) then
				if arg_181_1.var_.actorSpriteComps10127 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10127"]) and arg_181_1.var_.actorSpriteComps10127 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10127 = nil
			end

			local var_184_2 = arg_181_1.actors_["10122"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10122 == nil then
				arg_181_1.var_.actorSpriteComps10122 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps10122 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10122 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10122 = nil
			end

			local var_184_5 = arg_181_1.actors_["10127"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10127 = var_184_5.localPosition
				var_184_5.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10127", 4)

				for iter_184_8 = 0, var_184_5.childCount - 1 do
					local var_184_6 = var_184_5:GetChild(iter_184_8)

					if var_184_6.name == "split_1" or not string.find(var_184_6.name, "split") then
						var_184_6.gameObject:SetActive(true)
					else
						var_184_6.gameObject:SetActive(false)
					end
				end
			end

			local var_184_7 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				var_184_5.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_181_1.time_ - 0) / var_184_7)
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				var_184_5.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_184_8 = 0
			local var_184_9 = 0.475

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(416142041)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 19 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 19)

				if (19 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 19)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142041", "story_v_out_416142.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_416142", "416142041", "story_v_out_416142.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_416142", "416142041", "story_v_out_416142.awb")

						arg_181_1:RecordAudio("416142041", var_184_15)
						arg_181_1:RecordAudio("416142041", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416142", "416142041", "story_v_out_416142.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416142", "416142041", "story_v_out_416142.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play416142042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416142042
		arg_185_1.duration_ = 4

		local var_185_0 = {
			zh = 2.333,
			ja = 4
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416142043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.225

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(416142042)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 9 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 9)

				if (9 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 9)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142042", "story_v_out_416142.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_416142", "416142042", "story_v_out_416142.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_416142", "416142042", "story_v_out_416142.awb")

						arg_185_1:RecordAudio("416142042", var_188_6)
						arg_185_1:RecordAudio("416142042", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416142", "416142042", "story_v_out_416142.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416142", "416142042", "story_v_out_416142.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play416142043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416142043
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
			arg_189_1.auto_ = false
		end

		function arg_189_1.playNext_(arg_191_0)
			arg_189_1.onStoryFinished_()
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10127"]) and arg_189_1.var_.actorSpriteComps10127 == nil then
				arg_189_1.var_.actorSpriteComps10127 = arg_189_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10127"]) then
				if arg_189_1.var_.actorSpriteComps10127 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10127"]) and arg_189_1.var_.actorSpriteComps10127 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10127 = nil
			end

			local var_192_2 = arg_189_1.actors_["10122"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10122 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10122", 7)

				for iter_192_4 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_4)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_5 = arg_189_1.actors_["10127"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10127 = var_192_5.localPosition
				var_192_5.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10127", 7)

				for iter_192_5 = 0, var_192_5.childCount - 1 do
					local var_192_6 = var_192_5:GetChild(iter_192_5)

					if var_192_6.name == "" or not string.find(var_192_6.name, "split") then
						var_192_6.gameObject:SetActive(true)
					else
						var_192_6.gameObject:SetActive(false)
					end
				end
			end

			local var_192_7 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_7)
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_8 = 0
			local var_192_9 = 1.25

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(416142043).content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_12 = 50 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_10) / 50)

				if (50 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_10) / 50)) > 0 and var_192_9 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_13 and arg_189_1.time_ < var_192_8 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13i",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1606a",
		"TextureConfig/Background/I13f"
	},
	voices = {
		"story_v_out_416142.awb"
	}
}
