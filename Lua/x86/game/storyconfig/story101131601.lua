return {
	Play113161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F04"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.F04

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.566666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_activity_1_3_ui", "bgm_activity_1_3_ui", "bgm_activity_1_3_ui.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_activity_1_3_ui", "bgm_activity_1_3_ui")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 2
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(113161001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 12
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113161002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play113161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.325

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(113161002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 53
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play113161003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113161003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play113161004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.775

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(113161003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 71
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play113161004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 113161004
		arg_16_1.duration_ = 15.37

		local var_16_0 = {
			ja = 15.133,
			ko = 13.533,
			zh = 13.033,
			en = 15.366
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play113161005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.6

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[133].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(113161004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 64
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161004", "story_v_out_113161.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161004", "story_v_out_113161.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_113161", "113161004", "story_v_out_113161.awb")

						arg_16_1:RecordAudio("113161004", var_19_9)
						arg_16_1:RecordAudio("113161004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_113161", "113161004", "story_v_out_113161.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_113161", "113161004", "story_v_out_113161.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play113161005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 113161005
		arg_20_1.duration_ = 2.53

		local var_20_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 2.533,
			en = 1.999999999999
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play113161006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1068ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1068ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1068ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1068ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(-0.7, -0.95, -5.88)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1068ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(-0.7, -0.95, -5.88)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_23_16 = arg_20_1.actors_["1068ui_story"]
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1068ui_story == nil then
				arg_20_1.var_.characterEffect1068ui_story = var_23_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_18 = 0.2

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_18 and not isNil(var_23_16) then
				local var_23_19 = (arg_20_1.time_ - var_23_17) / var_23_18

				if arg_20_1.var_.characterEffect1068ui_story and not isNil(var_23_16) then
					arg_20_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1068ui_story then
				arg_20_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_23_20 = 0
			local var_23_21 = 0.275

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[218].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(113161005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 11
				local var_23_26 = utf8.len(var_23_24)
				local var_23_27 = var_23_25 <= 0 and var_23_21 or var_23_21 * (var_23_26 / var_23_25)

				if var_23_27 > 0 and var_23_21 < var_23_27 then
					arg_20_1.talkMaxDuration = var_23_27

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161005", "story_v_out_113161.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_out_113161", "113161005", "story_v_out_113161.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_113161", "113161005", "story_v_out_113161.awb")

						arg_20_1:RecordAudio("113161005", var_23_29)
						arg_20_1:RecordAudio("113161005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_113161", "113161005", "story_v_out_113161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_113161", "113161005", "story_v_out_113161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_20) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_20 + var_23_30 and arg_20_1.time_ < var_23_20 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play113161006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 113161006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play113161007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1067ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1067ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos1067ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(0.7, -1.06, -6.2)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1067ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = 0

			if var_27_14 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_27_15 = arg_24_1.actors_["1067ui_story"]
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 and not isNil(var_27_15) and arg_24_1.var_.characterEffect1067ui_story == nil then
				arg_24_1.var_.characterEffect1067ui_story = var_27_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_17 = 0.2

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 and not isNil(var_27_15) then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17

				if arg_24_1.var_.characterEffect1067ui_story and not isNil(var_27_15) then
					arg_24_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 and not isNil(var_27_15) and arg_24_1.var_.characterEffect1067ui_story then
				arg_24_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				arg_24_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_27_20 = arg_24_1.actors_["1068ui_story"]
			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 and not isNil(var_27_20) and arg_24_1.var_.characterEffect1068ui_story == nil then
				arg_24_1.var_.characterEffect1068ui_story = var_27_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_22 = 0.2

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_22 and not isNil(var_27_20) then
				local var_27_23 = (arg_24_1.time_ - var_27_21) / var_27_22

				if arg_24_1.var_.characterEffect1068ui_story and not isNil(var_27_20) then
					local var_27_24 = Mathf.Lerp(0, 0.5, var_27_23)

					arg_24_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1068ui_story.fillRatio = var_27_24
				end
			end

			if arg_24_1.time_ >= var_27_21 + var_27_22 and arg_24_1.time_ < var_27_21 + var_27_22 + arg_27_0 and not isNil(var_27_20) and arg_24_1.var_.characterEffect1068ui_story then
				local var_27_25 = 0.5

				arg_24_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1068ui_story.fillRatio = var_27_25
			end

			local var_27_26 = 0
			local var_27_27 = 0.05

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_28 = arg_24_1:FormatText(StoryNameCfg[206].name)

				arg_24_1.leftNameTxt_.text = var_27_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_29 = arg_24_1:GetWordFromCfg(113161006)
				local var_27_30 = arg_24_1:FormatText(var_27_29.content)

				arg_24_1.text_.text = var_27_30

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_31 = 2
				local var_27_32 = utf8.len(var_27_30)
				local var_27_33 = var_27_31 <= 0 and var_27_27 or var_27_27 * (var_27_32 / var_27_31)

				if var_27_33 > 0 and var_27_27 < var_27_33 then
					arg_24_1.talkMaxDuration = var_27_33

					if var_27_33 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_33 + var_27_26
					end
				end

				arg_24_1.text_.text = var_27_30
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161006", "story_v_out_113161.awb") ~= 0 then
					local var_27_34 = manager.audio:GetVoiceLength("story_v_out_113161", "113161006", "story_v_out_113161.awb") / 1000

					if var_27_34 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_26
					end

					if var_27_29.prefab_name ~= "" and arg_24_1.actors_[var_27_29.prefab_name] ~= nil then
						local var_27_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_29.prefab_name].transform, "story_v_out_113161", "113161006", "story_v_out_113161.awb")

						arg_24_1:RecordAudio("113161006", var_27_35)
						arg_24_1:RecordAudio("113161006", var_27_35)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_113161", "113161006", "story_v_out_113161.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_113161", "113161006", "story_v_out_113161.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_36 = math.max(var_27_27, arg_24_1.talkMaxDuration)

			if var_27_26 <= arg_24_1.time_ and arg_24_1.time_ < var_27_26 + var_27_36 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_26) / var_27_36

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_26 + var_27_36 and arg_24_1.time_ < var_27_26 + var_27_36 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play113161007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 113161007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play113161008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1067ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1067ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0, 100, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1067ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, 100, 0)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1068ui_story"].transform
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.var_.moveOldPos1068ui_story = var_31_9.localPosition
			end

			local var_31_11 = 0.001

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11
				local var_31_13 = Vector3.New(0, 100, 0)

				var_31_9.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1068ui_story, var_31_13, var_31_12)

				local var_31_14 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_14.x, var_31_14.y, var_31_14.z)

				local var_31_15 = var_31_9.localEulerAngles

				var_31_15.z = 0
				var_31_15.x = 0
				var_31_9.localEulerAngles = var_31_15
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 then
				var_31_9.localPosition = Vector3.New(0, 100, 0)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_9.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_9.localEulerAngles = var_31_17
			end

			local var_31_18 = 0
			local var_31_19 = 0.75

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_20 = arg_28_1:GetWordFromCfg(113161007)
				local var_31_21 = arg_28_1:FormatText(var_31_20.content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_22 = 30
				local var_31_23 = utf8.len(var_31_21)
				local var_31_24 = var_31_22 <= 0 and var_31_19 or var_31_19 * (var_31_23 / var_31_22)

				if var_31_24 > 0 and var_31_19 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24

					if var_31_24 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_18
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_19, arg_28_1.talkMaxDuration)

			if var_31_18 <= arg_28_1.time_ and arg_28_1.time_ < var_31_18 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_18) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_18 + var_31_25 and arg_28_1.time_ < var_31_18 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play113161008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 113161008
		arg_32_1.duration_ = 6.8

		local var_32_0 = {
			ja = 6.8,
			ko = 6.7,
			zh = 6.633,
			en = 6.3
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play113161009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1067ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1067ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, -1.06, -6.2)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1067ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_35_10 = arg_32_1.actors_["1067ui_story"]
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1067ui_story == nil then
				arg_32_1.var_.characterEffect1067ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_12 = 0.2

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 and not isNil(var_35_10) then
				local var_35_13 = (arg_32_1.time_ - var_35_11) / var_35_12

				if arg_32_1.var_.characterEffect1067ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_11 + var_35_12 and arg_32_1.time_ < var_35_11 + var_35_12 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1067ui_story then
				arg_32_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_35_15 = 0
			local var_35_16 = 0.775

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[206].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(113161008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 31
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161008", "story_v_out_113161.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_out_113161", "113161008", "story_v_out_113161.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_113161", "113161008", "story_v_out_113161.awb")

						arg_32_1:RecordAudio("113161008", var_35_24)
						arg_32_1:RecordAudio("113161008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_113161", "113161008", "story_v_out_113161.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_113161", "113161008", "story_v_out_113161.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_25 and arg_32_1.time_ < var_35_15 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play113161009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113161009
		arg_36_1.duration_ = 8.3

		local var_36_0 = {
			ja = 7.8,
			ko = 7.833,
			zh = 7.933,
			en = 8.3
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play113161010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_1 = 0
			local var_39_2 = 0.85

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_3 = arg_36_1:FormatText(StoryNameCfg[206].name)

				arg_36_1.leftNameTxt_.text = var_39_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(113161009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 34
				local var_39_7 = utf8.len(var_39_5)
				local var_39_8 = var_39_6 <= 0 and var_39_2 or var_39_2 * (var_39_7 / var_39_6)

				if var_39_8 > 0 and var_39_2 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161009", "story_v_out_113161.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161009", "story_v_out_113161.awb") / 1000

					if var_39_9 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_1
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_113161", "113161009", "story_v_out_113161.awb")

						arg_36_1:RecordAudio("113161009", var_39_10)
						arg_36_1:RecordAudio("113161009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113161", "113161009", "story_v_out_113161.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113161", "113161009", "story_v_out_113161.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_11 and arg_36_1.time_ < var_39_1 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play113161010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113161010
		arg_40_1.duration_ = 11.37

		local var_40_0 = {
			ja = 11.2,
			ko = 11.033,
			zh = 11.366,
			en = 8.1
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113161011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_1 = 0
			local var_43_2 = 1.15

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_3 = arg_40_1:FormatText(StoryNameCfg[206].name)

				arg_40_1.leftNameTxt_.text = var_43_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(113161010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 46
				local var_43_7 = utf8.len(var_43_5)
				local var_43_8 = var_43_6 <= 0 and var_43_2 or var_43_2 * (var_43_7 / var_43_6)

				if var_43_8 > 0 and var_43_2 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161010", "story_v_out_113161.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161010", "story_v_out_113161.awb") / 1000

					if var_43_9 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_1
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_113161", "113161010", "story_v_out_113161.awb")

						arg_40_1:RecordAudio("113161010", var_43_10)
						arg_40_1:RecordAudio("113161010", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_113161", "113161010", "story_v_out_113161.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_113161", "113161010", "story_v_out_113161.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_11 and arg_40_1.time_ < var_43_1 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play113161011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113161011
		arg_44_1.duration_ = 12.83

		local var_44_0 = {
			ja = 12.833,
			ko = 10.9,
			zh = 11.9,
			en = 10.9
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play113161012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_1 = 0
			local var_47_2 = 1.125

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_3 = arg_44_1:FormatText(StoryNameCfg[206].name)

				arg_44_1.leftNameTxt_.text = var_47_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(113161011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 45
				local var_47_7 = utf8.len(var_47_5)
				local var_47_8 = var_47_6 <= 0 and var_47_2 or var_47_2 * (var_47_7 / var_47_6)

				if var_47_8 > 0 and var_47_2 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161011", "story_v_out_113161.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161011", "story_v_out_113161.awb") / 1000

					if var_47_9 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_1
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_113161", "113161011", "story_v_out_113161.awb")

						arg_44_1:RecordAudio("113161011", var_47_10)
						arg_44_1:RecordAudio("113161011", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113161", "113161011", "story_v_out_113161.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113161", "113161011", "story_v_out_113161.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_11 and arg_44_1.time_ < var_47_1 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play113161012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113161012
		arg_48_1.duration_ = 10.6

		local var_48_0 = {
			ja = 8.9,
			ko = 8,
			zh = 9.5,
			en = 10.6
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play113161013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_1 = 0
			local var_51_2 = 0.9

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_3 = arg_48_1:FormatText(StoryNameCfg[206].name)

				arg_48_1.leftNameTxt_.text = var_51_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(113161012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 36
				local var_51_7 = utf8.len(var_51_5)
				local var_51_8 = var_51_6 <= 0 and var_51_2 or var_51_2 * (var_51_7 / var_51_6)

				if var_51_8 > 0 and var_51_2 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161012", "story_v_out_113161.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161012", "story_v_out_113161.awb") / 1000

					if var_51_9 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_1
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_113161", "113161012", "story_v_out_113161.awb")

						arg_48_1:RecordAudio("113161012", var_51_10)
						arg_48_1:RecordAudio("113161012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113161", "113161012", "story_v_out_113161.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113161", "113161012", "story_v_out_113161.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_11 and arg_48_1.time_ < var_51_1 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play113161013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113161013
		arg_52_1.duration_ = 11.13

		local var_52_0 = {
			ja = 11.133,
			ko = 8.033,
			zh = 7.666,
			en = 9.266
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play113161014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_1 = 0
			local var_55_2 = 0.75

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_3 = arg_52_1:FormatText(StoryNameCfg[206].name)

				arg_52_1.leftNameTxt_.text = var_55_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(113161013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 30
				local var_55_7 = utf8.len(var_55_5)
				local var_55_8 = var_55_6 <= 0 and var_55_2 or var_55_2 * (var_55_7 / var_55_6)

				if var_55_8 > 0 and var_55_2 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161013", "story_v_out_113161.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161013", "story_v_out_113161.awb") / 1000

					if var_55_9 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_1
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_113161", "113161013", "story_v_out_113161.awb")

						arg_52_1:RecordAudio("113161013", var_55_10)
						arg_52_1:RecordAudio("113161013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113161", "113161013", "story_v_out_113161.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113161", "113161013", "story_v_out_113161.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_11 and arg_52_1.time_ < var_55_1 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play113161014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 113161014
		arg_56_1.duration_ = 12.37

		local var_56_0 = {
			ja = 12.366,
			ko = 8.666,
			zh = 11.5,
			en = 11.933
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play113161015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action436")
			end

			local var_59_2 = 0
			local var_59_3 = 1.1

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_4 = arg_56_1:FormatText(StoryNameCfg[206].name)

				arg_56_1.leftNameTxt_.text = var_59_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(113161014)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 44
				local var_59_8 = utf8.len(var_59_6)
				local var_59_9 = var_59_7 <= 0 and var_59_3 or var_59_3 * (var_59_8 / var_59_7)

				if var_59_9 > 0 and var_59_3 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161014", "story_v_out_113161.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_113161", "113161014", "story_v_out_113161.awb") / 1000

					if var_59_10 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_2
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_out_113161", "113161014", "story_v_out_113161.awb")

						arg_56_1:RecordAudio("113161014", var_59_11)
						arg_56_1:RecordAudio("113161014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_113161", "113161014", "story_v_out_113161.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_113161", "113161014", "story_v_out_113161.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_12 and arg_56_1.time_ < var_59_2 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play113161015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 113161015
		arg_60_1.duration_ = 11.4

		local var_60_0 = {
			ja = 8.566,
			ko = 6.633,
			zh = 8.033,
			en = 11.4
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play113161016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_63_1 = 0
			local var_63_2 = 0.725

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_3 = arg_60_1:FormatText(StoryNameCfg[206].name)

				arg_60_1.leftNameTxt_.text = var_63_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(113161015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 29
				local var_63_7 = utf8.len(var_63_5)
				local var_63_8 = var_63_6 <= 0 and var_63_2 or var_63_2 * (var_63_7 / var_63_6)

				if var_63_8 > 0 and var_63_2 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8

					if var_63_8 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161015", "story_v_out_113161.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161015", "story_v_out_113161.awb") / 1000

					if var_63_9 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_1
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_113161", "113161015", "story_v_out_113161.awb")

						arg_60_1:RecordAudio("113161015", var_63_10)
						arg_60_1:RecordAudio("113161015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_113161", "113161015", "story_v_out_113161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_113161", "113161015", "story_v_out_113161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_11 and arg_60_1.time_ < var_63_1 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play113161016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 113161016
		arg_64_1.duration_ = 10.9

		local var_64_0 = {
			ja = 9.5,
			ko = 7.8,
			zh = 10.9,
			en = 9.033
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play113161017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action463")
			end

			local var_67_2 = 0
			local var_67_3 = 0.95

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_4 = arg_64_1:FormatText(StoryNameCfg[206].name)

				arg_64_1.leftNameTxt_.text = var_67_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:GetWordFromCfg(113161016)
				local var_67_6 = arg_64_1:FormatText(var_67_5.content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 38
				local var_67_8 = utf8.len(var_67_6)
				local var_67_9 = var_67_7 <= 0 and var_67_3 or var_67_3 * (var_67_8 / var_67_7)

				if var_67_9 > 0 and var_67_3 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161016", "story_v_out_113161.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_113161", "113161016", "story_v_out_113161.awb") / 1000

					if var_67_10 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_2
					end

					if var_67_5.prefab_name ~= "" and arg_64_1.actors_[var_67_5.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_5.prefab_name].transform, "story_v_out_113161", "113161016", "story_v_out_113161.awb")

						arg_64_1:RecordAudio("113161016", var_67_11)
						arg_64_1:RecordAudio("113161016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_113161", "113161016", "story_v_out_113161.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_113161", "113161016", "story_v_out_113161.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_12 and arg_64_1.time_ < var_67_2 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play113161017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 113161017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play113161018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1067ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1067ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1067ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = 0
			local var_71_10 = 1

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				local var_71_11 = "play"
				local var_71_12 = "effect"

				arg_68_1:AudioAction(var_71_11, var_71_12, "se_story_10", "se_story_10_cheer", "")
			end

			local var_71_13 = 0
			local var_71_14 = 0.675

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_15 = arg_68_1:GetWordFromCfg(113161017)
				local var_71_16 = arg_68_1:FormatText(var_71_15.content)

				arg_68_1.text_.text = var_71_16

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_17 = 27
				local var_71_18 = utf8.len(var_71_16)
				local var_71_19 = var_71_17 <= 0 and var_71_14 or var_71_14 * (var_71_18 / var_71_17)

				if var_71_19 > 0 and var_71_14 < var_71_19 then
					arg_68_1.talkMaxDuration = var_71_19

					if var_71_19 + var_71_13 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_13
					end
				end

				arg_68_1.text_.text = var_71_16
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_20 = math.max(var_71_14, arg_68_1.talkMaxDuration)

			if var_71_13 <= arg_68_1.time_ and arg_68_1.time_ < var_71_13 + var_71_20 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_13) / var_71_20

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_13 + var_71_20 and arg_68_1.time_ < var_71_13 + var_71_20 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play113161018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 113161018
		arg_72_1.duration_ = 7.3

		local var_72_0 = {
			ja = 7.3,
			ko = 3.833,
			zh = 3.866,
			en = 4.633
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play113161019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "1042ui_story"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_72_1.stage_.transform)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentInChildren(typeof(CharacterEffect))

					var_75_3.enabled = true

					local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_2, typeof(DynamicBoneHelper))

					if var_75_4 then
						var_75_4:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_3.transform, false)

					arg_72_1.var_[var_75_0 .. "Animator"] = var_75_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_0 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_0 .. "LipSync"] = var_75_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_5 = arg_72_1.actors_["1042ui_story"].transform
			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.var_.moveOldPos1042ui_story = var_75_5.localPosition
			end

			local var_75_7 = 0.001

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 then
				local var_75_8 = (arg_72_1.time_ - var_75_6) / var_75_7
				local var_75_9 = Vector3.New(-0.7, -1.06, -6.2)

				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1042ui_story, var_75_9, var_75_8)

				local var_75_10 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_10.x, var_75_10.y, var_75_10.z)

				local var_75_11 = var_75_5.localEulerAngles

				var_75_11.z = 0
				var_75_11.x = 0
				var_75_5.localEulerAngles = var_75_11
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_75_12 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_12.x, var_75_12.y, var_75_12.z)

				local var_75_13 = var_75_5.localEulerAngles

				var_75_13.z = 0
				var_75_13.x = 0
				var_75_5.localEulerAngles = var_75_13
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_75_16 = arg_72_1.actors_["1042ui_story"]
			local var_75_17 = 0

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 and not isNil(var_75_16) and arg_72_1.var_.characterEffect1042ui_story == nil then
				arg_72_1.var_.characterEffect1042ui_story = var_75_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_18 = 0.2

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_18 and not isNil(var_75_16) then
				local var_75_19 = (arg_72_1.time_ - var_75_17) / var_75_18

				if arg_72_1.var_.characterEffect1042ui_story and not isNil(var_75_16) then
					arg_72_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_17 + var_75_18 and arg_72_1.time_ < var_75_17 + var_75_18 + arg_75_0 and not isNil(var_75_16) and arg_72_1.var_.characterEffect1042ui_story then
				arg_72_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_75_20 = 0
			local var_75_21 = 0.475

			if var_75_20 < arg_72_1.time_ and arg_72_1.time_ <= var_75_20 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_22 = arg_72_1:FormatText(StoryNameCfg[205].name)

				arg_72_1.leftNameTxt_.text = var_75_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_23 = arg_72_1:GetWordFromCfg(113161018)
				local var_75_24 = arg_72_1:FormatText(var_75_23.content)

				arg_72_1.text_.text = var_75_24

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_25 = 19
				local var_75_26 = utf8.len(var_75_24)
				local var_75_27 = var_75_25 <= 0 and var_75_21 or var_75_21 * (var_75_26 / var_75_25)

				if var_75_27 > 0 and var_75_21 < var_75_27 then
					arg_72_1.talkMaxDuration = var_75_27

					if var_75_27 + var_75_20 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_27 + var_75_20
					end
				end

				arg_72_1.text_.text = var_75_24
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161018", "story_v_out_113161.awb") ~= 0 then
					local var_75_28 = manager.audio:GetVoiceLength("story_v_out_113161", "113161018", "story_v_out_113161.awb") / 1000

					if var_75_28 + var_75_20 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_20
					end

					if var_75_23.prefab_name ~= "" and arg_72_1.actors_[var_75_23.prefab_name] ~= nil then
						local var_75_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_23.prefab_name].transform, "story_v_out_113161", "113161018", "story_v_out_113161.awb")

						arg_72_1:RecordAudio("113161018", var_75_29)
						arg_72_1:RecordAudio("113161018", var_75_29)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_113161", "113161018", "story_v_out_113161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_113161", "113161018", "story_v_out_113161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_30 = math.max(var_75_21, arg_72_1.talkMaxDuration)

			if var_75_20 <= arg_72_1.time_ and arg_72_1.time_ < var_75_20 + var_75_30 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_20) / var_75_30

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_20 + var_75_30 and arg_72_1.time_ < var_75_20 + var_75_30 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play113161019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 113161019
		arg_76_1.duration_ = 2.2

		local var_76_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.2,
			en = 1.999999999999
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play113161020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1067ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1067ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0.7, -1.06, -6.2)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1067ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_79_10 = arg_76_1.actors_["1067ui_story"]
			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 and not isNil(var_79_10) and arg_76_1.var_.characterEffect1067ui_story == nil then
				arg_76_1.var_.characterEffect1067ui_story = var_79_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_12 = 0.2

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_12 and not isNil(var_79_10) then
				local var_79_13 = (arg_76_1.time_ - var_79_11) / var_79_12

				if arg_76_1.var_.characterEffect1067ui_story and not isNil(var_79_10) then
					arg_76_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_11 + var_79_12 and arg_76_1.time_ < var_79_11 + var_79_12 + arg_79_0 and not isNil(var_79_10) and arg_76_1.var_.characterEffect1067ui_story then
				arg_76_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_79_15 = arg_76_1.actors_["1042ui_story"]
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect1042ui_story == nil then
				arg_76_1.var_.characterEffect1042ui_story = var_79_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_17 = 0.2

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 and not isNil(var_79_15) then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17

				if arg_76_1.var_.characterEffect1042ui_story and not isNil(var_79_15) then
					local var_79_19 = Mathf.Lerp(0, 0.5, var_79_18)

					arg_76_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1042ui_story.fillRatio = var_79_19
				end
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect1042ui_story then
				local var_79_20 = 0.5

				arg_76_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1042ui_story.fillRatio = var_79_20
			end

			local var_79_21 = 0
			local var_79_22 = 0.075

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_23 = arg_76_1:FormatText(StoryNameCfg[206].name)

				arg_76_1.leftNameTxt_.text = var_79_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:GetWordFromCfg(113161019)
				local var_79_25 = arg_76_1:FormatText(var_79_24.content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_26 = 3
				local var_79_27 = utf8.len(var_79_25)
				local var_79_28 = var_79_26 <= 0 and var_79_22 or var_79_22 * (var_79_27 / var_79_26)

				if var_79_28 > 0 and var_79_22 < var_79_28 then
					arg_76_1.talkMaxDuration = var_79_28

					if var_79_28 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_21
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161019", "story_v_out_113161.awb") ~= 0 then
					local var_79_29 = manager.audio:GetVoiceLength("story_v_out_113161", "113161019", "story_v_out_113161.awb") / 1000

					if var_79_29 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_29 + var_79_21
					end

					if var_79_24.prefab_name ~= "" and arg_76_1.actors_[var_79_24.prefab_name] ~= nil then
						local var_79_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_24.prefab_name].transform, "story_v_out_113161", "113161019", "story_v_out_113161.awb")

						arg_76_1:RecordAudio("113161019", var_79_30)
						arg_76_1:RecordAudio("113161019", var_79_30)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_113161", "113161019", "story_v_out_113161.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_113161", "113161019", "story_v_out_113161.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_31 = math.max(var_79_22, arg_76_1.talkMaxDuration)

			if var_79_21 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_21) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_21 + var_79_31 and arg_76_1.time_ < var_79_21 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play113161020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 113161020
		arg_80_1.duration_ = 6.63

		local var_80_0 = {
			ja = 6.633,
			ko = 4.9,
			zh = 4.866,
			en = 6.633
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play113161021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_83_1 = arg_80_1.actors_["1042ui_story"]
			local var_83_2 = 0

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1042ui_story == nil then
				arg_80_1.var_.characterEffect1042ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.2

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_3 and not isNil(var_83_1) then
				local var_83_4 = (arg_80_1.time_ - var_83_2) / var_83_3

				if arg_80_1.var_.characterEffect1042ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_2 + var_83_3 and arg_80_1.time_ < var_83_2 + var_83_3 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1042ui_story then
				arg_80_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_83_5 = arg_80_1.actors_["1067ui_story"]
			local var_83_6 = 0

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect1067ui_story == nil then
				arg_80_1.var_.characterEffect1067ui_story = var_83_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_7 = 0.2

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_7 and not isNil(var_83_5) then
				local var_83_8 = (arg_80_1.time_ - var_83_6) / var_83_7

				if arg_80_1.var_.characterEffect1067ui_story and not isNil(var_83_5) then
					local var_83_9 = Mathf.Lerp(0, 0.5, var_83_8)

					arg_80_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1067ui_story.fillRatio = var_83_9
				end
			end

			if arg_80_1.time_ >= var_83_6 + var_83_7 and arg_80_1.time_ < var_83_6 + var_83_7 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect1067ui_story then
				local var_83_10 = 0.5

				arg_80_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1067ui_story.fillRatio = var_83_10
			end

			local var_83_11 = 0
			local var_83_12 = 0.575

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_13 = arg_80_1:FormatText(StoryNameCfg[205].name)

				arg_80_1.leftNameTxt_.text = var_83_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_14 = arg_80_1:GetWordFromCfg(113161020)
				local var_83_15 = arg_80_1:FormatText(var_83_14.content)

				arg_80_1.text_.text = var_83_15

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_16 = 23
				local var_83_17 = utf8.len(var_83_15)
				local var_83_18 = var_83_16 <= 0 and var_83_12 or var_83_12 * (var_83_17 / var_83_16)

				if var_83_18 > 0 and var_83_12 < var_83_18 then
					arg_80_1.talkMaxDuration = var_83_18

					if var_83_18 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_11
					end
				end

				arg_80_1.text_.text = var_83_15
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161020", "story_v_out_113161.awb") ~= 0 then
					local var_83_19 = manager.audio:GetVoiceLength("story_v_out_113161", "113161020", "story_v_out_113161.awb") / 1000

					if var_83_19 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_11
					end

					if var_83_14.prefab_name ~= "" and arg_80_1.actors_[var_83_14.prefab_name] ~= nil then
						local var_83_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_14.prefab_name].transform, "story_v_out_113161", "113161020", "story_v_out_113161.awb")

						arg_80_1:RecordAudio("113161020", var_83_20)
						arg_80_1:RecordAudio("113161020", var_83_20)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_113161", "113161020", "story_v_out_113161.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_113161", "113161020", "story_v_out_113161.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_21 = math.max(var_83_12, arg_80_1.talkMaxDuration)

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_21 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_21

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_21 and arg_80_1.time_ < var_83_11 + var_83_21 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play113161021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 113161021
		arg_84_1.duration_ = 6.13

		local var_84_0 = {
			ja = 5.2,
			ko = 5,
			zh = 5.133,
			en = 6.133
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play113161022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_87_1 = 0
			local var_87_2 = 0.65

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_3 = arg_84_1:FormatText(StoryNameCfg[205].name)

				arg_84_1.leftNameTxt_.text = var_87_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(113161021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 26
				local var_87_7 = utf8.len(var_87_5)
				local var_87_8 = var_87_6 <= 0 and var_87_2 or var_87_2 * (var_87_7 / var_87_6)

				if var_87_8 > 0 and var_87_2 < var_87_8 then
					arg_84_1.talkMaxDuration = var_87_8

					if var_87_8 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161021", "story_v_out_113161.awb") ~= 0 then
					local var_87_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161021", "story_v_out_113161.awb") / 1000

					if var_87_9 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_1
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_113161", "113161021", "story_v_out_113161.awb")

						arg_84_1:RecordAudio("113161021", var_87_10)
						arg_84_1:RecordAudio("113161021", var_87_10)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_113161", "113161021", "story_v_out_113161.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_113161", "113161021", "story_v_out_113161.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_11 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_11 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_11

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_11 and arg_84_1.time_ < var_87_1 + var_87_11 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play113161022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 113161022
		arg_88_1.duration_ = 3.83

		local var_88_0 = {
			ja = 3.6,
			ko = 1.999999999999,
			zh = 3.833,
			en = 1.999999999999
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play113161023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1067ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1067ui_story == nil then
				arg_88_1.var_.characterEffect1067ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1067ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1067ui_story then
				arg_88_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_5 = arg_88_1.actors_["1042ui_story"]
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1042ui_story == nil then
				arg_88_1.var_.characterEffect1042ui_story = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_7 = 0.2

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_7 and not isNil(var_91_5) then
				local var_91_8 = (arg_88_1.time_ - var_91_6) / var_91_7

				if arg_88_1.var_.characterEffect1042ui_story and not isNil(var_91_5) then
					local var_91_9 = Mathf.Lerp(0, 0.5, var_91_8)

					arg_88_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1042ui_story.fillRatio = var_91_9
				end
			end

			if arg_88_1.time_ >= var_91_6 + var_91_7 and arg_88_1.time_ < var_91_6 + var_91_7 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1042ui_story then
				local var_91_10 = 0.5

				arg_88_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1042ui_story.fillRatio = var_91_10
			end

			local var_91_11 = 0
			local var_91_12 = 0.175

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_13 = arg_88_1:FormatText(StoryNameCfg[206].name)

				arg_88_1.leftNameTxt_.text = var_91_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_14 = arg_88_1:GetWordFromCfg(113161022)
				local var_91_15 = arg_88_1:FormatText(var_91_14.content)

				arg_88_1.text_.text = var_91_15

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_16 = 7
				local var_91_17 = utf8.len(var_91_15)
				local var_91_18 = var_91_16 <= 0 and var_91_12 or var_91_12 * (var_91_17 / var_91_16)

				if var_91_18 > 0 and var_91_12 < var_91_18 then
					arg_88_1.talkMaxDuration = var_91_18

					if var_91_18 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_18 + var_91_11
					end
				end

				arg_88_1.text_.text = var_91_15
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161022", "story_v_out_113161.awb") ~= 0 then
					local var_91_19 = manager.audio:GetVoiceLength("story_v_out_113161", "113161022", "story_v_out_113161.awb") / 1000

					if var_91_19 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_11
					end

					if var_91_14.prefab_name ~= "" and arg_88_1.actors_[var_91_14.prefab_name] ~= nil then
						local var_91_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_14.prefab_name].transform, "story_v_out_113161", "113161022", "story_v_out_113161.awb")

						arg_88_1:RecordAudio("113161022", var_91_20)
						arg_88_1:RecordAudio("113161022", var_91_20)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_113161", "113161022", "story_v_out_113161.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_113161", "113161022", "story_v_out_113161.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_21 = math.max(var_91_12, arg_88_1.talkMaxDuration)

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_21 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_11) / var_91_21

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_11 + var_91_21 and arg_88_1.time_ < var_91_11 + var_91_21 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play113161023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 113161023
		arg_92_1.duration_ = 4.17

		local var_92_0 = {
			ja = 4.166,
			ko = 2.166,
			zh = 2.833,
			en = 2.433
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play113161024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1067ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1067ui_story == nil then
				arg_92_1.var_.characterEffect1067ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1067ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1067ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1067ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1067ui_story.fillRatio = var_95_5
			end

			local var_95_6 = arg_92_1.actors_["1042ui_story"]
			local var_95_7 = 0

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1042ui_story == nil then
				arg_92_1.var_.characterEffect1042ui_story = var_95_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_8 = 0.2

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_8 and not isNil(var_95_6) then
				local var_95_9 = (arg_92_1.time_ - var_95_7) / var_95_8

				if arg_92_1.var_.characterEffect1042ui_story and not isNil(var_95_6) then
					arg_92_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_7 + var_95_8 and arg_92_1.time_ < var_95_7 + var_95_8 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1042ui_story then
				arg_92_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action424")
			end

			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_95_12 = 0
			local var_95_13 = 0.225

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_14 = arg_92_1:FormatText(StoryNameCfg[205].name)

				arg_92_1.leftNameTxt_.text = var_95_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_15 = arg_92_1:GetWordFromCfg(113161023)
				local var_95_16 = arg_92_1:FormatText(var_95_15.content)

				arg_92_1.text_.text = var_95_16

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 9
				local var_95_18 = utf8.len(var_95_16)
				local var_95_19 = var_95_17 <= 0 and var_95_13 or var_95_13 * (var_95_18 / var_95_17)

				if var_95_19 > 0 and var_95_13 < var_95_19 then
					arg_92_1.talkMaxDuration = var_95_19

					if var_95_19 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_12
					end
				end

				arg_92_1.text_.text = var_95_16
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161023", "story_v_out_113161.awb") ~= 0 then
					local var_95_20 = manager.audio:GetVoiceLength("story_v_out_113161", "113161023", "story_v_out_113161.awb") / 1000

					if var_95_20 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_20 + var_95_12
					end

					if var_95_15.prefab_name ~= "" and arg_92_1.actors_[var_95_15.prefab_name] ~= nil then
						local var_95_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_15.prefab_name].transform, "story_v_out_113161", "113161023", "story_v_out_113161.awb")

						arg_92_1:RecordAudio("113161023", var_95_21)
						arg_92_1:RecordAudio("113161023", var_95_21)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_113161", "113161023", "story_v_out_113161.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_113161", "113161023", "story_v_out_113161.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_22 = math.max(var_95_13, arg_92_1.talkMaxDuration)

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_22 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_12) / var_95_22

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_12 + var_95_22 and arg_92_1.time_ < var_95_12 + var_95_22 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play113161024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 113161024
		arg_96_1.duration_ = 9

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play113161025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_1 = 2

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_1 then
				local var_99_2 = (arg_96_1.time_ - var_99_0) / var_99_1
				local var_99_3 = Color.New(0, 0, 0)

				var_99_3.a = Mathf.Lerp(0, 1, var_99_2)
				arg_96_1.mask_.color = var_99_3
			end

			if arg_96_1.time_ >= var_99_0 + var_99_1 and arg_96_1.time_ < var_99_0 + var_99_1 + arg_99_0 then
				local var_99_4 = Color.New(0, 0, 0)

				var_99_4.a = 1
				arg_96_1.mask_.color = var_99_4
			end

			local var_99_5 = 2

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_6 = 2

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6
				local var_99_8 = Color.New(0, 0, 0)

				var_99_8.a = Mathf.Lerp(1, 0, var_99_7)
				arg_96_1.mask_.color = var_99_8
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 then
				local var_99_9 = Color.New(0, 0, 0)
				local var_99_10 = 0

				arg_96_1.mask_.enabled = false
				var_99_9.a = var_99_10
				arg_96_1.mask_.color = var_99_9
			end

			local var_99_11 = arg_96_1.actors_["1042ui_story"].transform
			local var_99_12 = 1.966

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.var_.moveOldPos1042ui_story = var_99_11.localPosition
			end

			local var_99_13 = 0.001

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_13 then
				local var_99_14 = (arg_96_1.time_ - var_99_12) / var_99_13
				local var_99_15 = Vector3.New(0, 100, 0)

				var_99_11.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1042ui_story, var_99_15, var_99_14)

				local var_99_16 = manager.ui.mainCamera.transform.position - var_99_11.position

				var_99_11.forward = Vector3.New(var_99_16.x, var_99_16.y, var_99_16.z)

				local var_99_17 = var_99_11.localEulerAngles

				var_99_17.z = 0
				var_99_17.x = 0
				var_99_11.localEulerAngles = var_99_17
			end

			if arg_96_1.time_ >= var_99_12 + var_99_13 and arg_96_1.time_ < var_99_12 + var_99_13 + arg_99_0 then
				var_99_11.localPosition = Vector3.New(0, 100, 0)

				local var_99_18 = manager.ui.mainCamera.transform.position - var_99_11.position

				var_99_11.forward = Vector3.New(var_99_18.x, var_99_18.y, var_99_18.z)

				local var_99_19 = var_99_11.localEulerAngles

				var_99_19.z = 0
				var_99_19.x = 0
				var_99_11.localEulerAngles = var_99_19
			end

			local var_99_20 = arg_96_1.actors_["1067ui_story"].transform
			local var_99_21 = 1.966

			if var_99_21 < arg_96_1.time_ and arg_96_1.time_ <= var_99_21 + arg_99_0 then
				arg_96_1.var_.moveOldPos1067ui_story = var_99_20.localPosition
			end

			local var_99_22 = 0.001

			if var_99_21 <= arg_96_1.time_ and arg_96_1.time_ < var_99_21 + var_99_22 then
				local var_99_23 = (arg_96_1.time_ - var_99_21) / var_99_22
				local var_99_24 = Vector3.New(0, 100, 0)

				var_99_20.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1067ui_story, var_99_24, var_99_23)

				local var_99_25 = manager.ui.mainCamera.transform.position - var_99_20.position

				var_99_20.forward = Vector3.New(var_99_25.x, var_99_25.y, var_99_25.z)

				local var_99_26 = var_99_20.localEulerAngles

				var_99_26.z = 0
				var_99_26.x = 0
				var_99_20.localEulerAngles = var_99_26
			end

			if arg_96_1.time_ >= var_99_21 + var_99_22 and arg_96_1.time_ < var_99_21 + var_99_22 + arg_99_0 then
				var_99_20.localPosition = Vector3.New(0, 100, 0)

				local var_99_27 = manager.ui.mainCamera.transform.position - var_99_20.position

				var_99_20.forward = Vector3.New(var_99_27.x, var_99_27.y, var_99_27.z)

				local var_99_28 = var_99_20.localEulerAngles

				var_99_28.z = 0
				var_99_28.x = 0
				var_99_20.localEulerAngles = var_99_28
			end

			local var_99_29 = "F03a"

			if arg_96_1.bgs_[var_99_29] == nil then
				local var_99_30 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_30:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_29)
				var_99_30.name = var_99_29
				var_99_30.transform.parent = arg_96_1.stage_.transform
				var_99_30.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_29] = var_99_30
			end

			local var_99_31 = 2

			if var_99_31 < arg_96_1.time_ and arg_96_1.time_ <= var_99_31 + arg_99_0 then
				local var_99_32 = manager.ui.mainCamera.transform.localPosition
				local var_99_33 = Vector3.New(0, 0, 10) + Vector3.New(var_99_32.x, var_99_32.y, 0)
				local var_99_34 = arg_96_1.bgs_.F03a

				var_99_34.transform.localPosition = var_99_33
				var_99_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_35 = var_99_34:GetComponent("SpriteRenderer")

				if var_99_35 and var_99_35.sprite then
					local var_99_36 = (var_99_34.transform.localPosition - var_99_32).z
					local var_99_37 = manager.ui.mainCameraCom_
					local var_99_38 = 2 * var_99_36 * Mathf.Tan(var_99_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_99_39 = var_99_38 * var_99_37.aspect
					local var_99_40 = var_99_35.sprite.bounds.size.x
					local var_99_41 = var_99_35.sprite.bounds.size.y
					local var_99_42 = var_99_39 / var_99_40
					local var_99_43 = var_99_38 / var_99_41
					local var_99_44 = var_99_43 < var_99_42 and var_99_42 or var_99_43

					var_99_34.transform.localScale = Vector3.New(var_99_44, var_99_44, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "F03a" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_45 = 0
			local var_99_46 = 0.566666666666667

			if var_99_45 < arg_96_1.time_ and arg_96_1.time_ <= var_99_45 + arg_99_0 then
				local var_99_47 = "play"
				local var_99_48 = "music"

				arg_96_1:AudioAction(var_99_47, var_99_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_99_49 = ""
				local var_99_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_99_50 ~= "" then
					if arg_96_1.bgmTxt_.text ~= var_99_50 and arg_96_1.bgmTxt_.text ~= "" then
						if arg_96_1.bgmTxt2_.text ~= "" then
							arg_96_1.bgmTxt_.text = arg_96_1.bgmTxt2_.text
						end

						arg_96_1.bgmTxt2_.text = var_99_50

						arg_96_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_96_1.bgmTxt_.text = var_99_50
						arg_96_1.bgmTxt2_.text = var_99_50
					end

					if arg_96_1.bgmTimer then
						arg_96_1.bgmTimer:Stop()

						arg_96_1.bgmTimer = nil
					end

					if arg_96_1.settingData.show_music_name == 1 then
						arg_96_1.musicController:SetSelectedState("show")
						arg_96_1.musicAnimator_:Play("open", 0, 0)

						if arg_96_1.settingData.music_time ~= 0 then
							arg_96_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_96_1.settingData.music_time), function()
								if arg_96_1 == nil or isNil(arg_96_1.bgmTxt_) then
									return
								end

								arg_96_1.musicController:SetSelectedState("hide")
								arg_96_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_51 = 4
			local var_99_52 = 0.2

			if var_99_51 < arg_96_1.time_ and arg_96_1.time_ <= var_99_51 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_53 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_53:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_96_1.dialogCg_.alpha = arg_101_0
				end))
				var_99_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_54 = arg_96_1:GetWordFromCfg(113161024)
				local var_99_55 = arg_96_1:FormatText(var_99_54.content)

				arg_96_1.text_.text = var_99_55

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_56 = 8
				local var_99_57 = utf8.len(var_99_55)
				local var_99_58 = var_99_56 <= 0 and var_99_52 or var_99_52 * (var_99_57 / var_99_56)

				if var_99_58 > 0 and var_99_52 < var_99_58 then
					arg_96_1.talkMaxDuration = var_99_58
					var_99_51 = var_99_51 + 0.3

					if var_99_58 + var_99_51 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_58 + var_99_51
					end
				end

				arg_96_1.text_.text = var_99_55
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_59 = var_99_51 + 0.3
			local var_99_60 = math.max(var_99_52, arg_96_1.talkMaxDuration)

			if var_99_59 <= arg_96_1.time_ and arg_96_1.time_ < var_99_59 + var_99_60 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_59) / var_99_60

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_59 + var_99_60 and arg_96_1.time_ < var_99_59 + var_99_60 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play113161025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 113161025
		arg_103_1.duration_ = 3.23

		local var_103_0 = {
			ja = 3.233,
			ko = 1.233,
			zh = 3.166,
			en = 2.733
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
				arg_103_0:Play113161026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.566666666666667

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_2 = "play"
				local var_106_3 = "music"

				arg_103_1:AudioAction(var_106_2, var_106_3, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_106_4 = ""
				local var_106_5 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_106_5 ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_5 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_5

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_5
						arg_103_1.bgmTxt2_.text = var_106_5
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_106_6 = 0
			local var_106_7 = 0.2

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[212].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_9 = arg_103_1:GetWordFromCfg(113161025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 8
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161025", "story_v_out_113161.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161025", "story_v_out_113161.awb") / 1000

					if var_106_14 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_6
					end

					if var_106_9.prefab_name ~= "" and arg_103_1.actors_[var_106_9.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_9.prefab_name].transform, "story_v_out_113161", "113161025", "story_v_out_113161.awb")

						arg_103_1:RecordAudio("113161025", var_106_15)
						arg_103_1:RecordAudio("113161025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_113161", "113161025", "story_v_out_113161.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_113161", "113161025", "story_v_out_113161.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_16 and arg_103_1.time_ < var_106_6 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play113161026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 113161026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play113161027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.55

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(113161026)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 22
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play113161027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 113161027
		arg_112_1.duration_ = 7.43

		local var_112_0 = {
			ja = 7.433,
			ko = 6.6,
			zh = 6.633,
			en = 6.6
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play113161028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "1041ui_story"

			if arg_112_1.actors_[var_115_0] == nil then
				local var_115_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_115_1) then
					local var_115_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_112_1.stage_.transform)

					var_115_2.name = var_115_0
					var_115_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_112_1.actors_[var_115_0] = var_115_2

					local var_115_3 = var_115_2:GetComponentInChildren(typeof(CharacterEffect))

					var_115_3.enabled = true

					local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_2, typeof(DynamicBoneHelper))

					if var_115_4 then
						var_115_4:EnableDynamicBone(false)
					end

					arg_112_1:ShowWeapon(var_115_3.transform, false)

					arg_112_1.var_[var_115_0 .. "Animator"] = var_115_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_112_1.var_[var_115_0 .. "Animator"].applyRootMotion = true
					arg_112_1.var_[var_115_0 .. "LipSync"] = var_115_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_115_5 = arg_112_1.actors_["1041ui_story"].transform
			local var_115_6 = 0

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.var_.moveOldPos1041ui_story = var_115_5.localPosition
			end

			local var_115_7 = 0.001

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_7 then
				local var_115_8 = (arg_112_1.time_ - var_115_6) / var_115_7
				local var_115_9 = Vector3.New(-0.7, -1.11, -5.9)

				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1041ui_story, var_115_9, var_115_8)

				local var_115_10 = manager.ui.mainCamera.transform.position - var_115_5.position

				var_115_5.forward = Vector3.New(var_115_10.x, var_115_10.y, var_115_10.z)

				local var_115_11 = var_115_5.localEulerAngles

				var_115_11.z = 0
				var_115_11.x = 0
				var_115_5.localEulerAngles = var_115_11
			end

			if arg_112_1.time_ >= var_115_6 + var_115_7 and arg_112_1.time_ < var_115_6 + var_115_7 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_115_12 = manager.ui.mainCamera.transform.position - var_115_5.position

				var_115_5.forward = Vector3.New(var_115_12.x, var_115_12.y, var_115_12.z)

				local var_115_13 = var_115_5.localEulerAngles

				var_115_13.z = 0
				var_115_13.x = 0
				var_115_5.localEulerAngles = var_115_13
			end

			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 then
				arg_112_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_115_15 = 0

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_115_16 = arg_112_1.actors_["1041ui_story"]
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 and not isNil(var_115_16) and arg_112_1.var_.characterEffect1041ui_story == nil then
				arg_112_1.var_.characterEffect1041ui_story = var_115_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_18 = 0.2

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_18 and not isNil(var_115_16) then
				local var_115_19 = (arg_112_1.time_ - var_115_17) / var_115_18

				if arg_112_1.var_.characterEffect1041ui_story and not isNil(var_115_16) then
					arg_112_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_17 + var_115_18 and arg_112_1.time_ < var_115_17 + var_115_18 + arg_115_0 and not isNil(var_115_16) and arg_112_1.var_.characterEffect1041ui_story then
				arg_112_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_115_20 = 0
			local var_115_21 = 0.775

			if var_115_20 < arg_112_1.time_ and arg_112_1.time_ <= var_115_20 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_22 = arg_112_1:FormatText(StoryNameCfg[208].name)

				arg_112_1.leftNameTxt_.text = var_115_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_23 = arg_112_1:GetWordFromCfg(113161027)
				local var_115_24 = arg_112_1:FormatText(var_115_23.content)

				arg_112_1.text_.text = var_115_24

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_25 = 31
				local var_115_26 = utf8.len(var_115_24)
				local var_115_27 = var_115_25 <= 0 and var_115_21 or var_115_21 * (var_115_26 / var_115_25)

				if var_115_27 > 0 and var_115_21 < var_115_27 then
					arg_112_1.talkMaxDuration = var_115_27

					if var_115_27 + var_115_20 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_27 + var_115_20
					end
				end

				arg_112_1.text_.text = var_115_24
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161027", "story_v_out_113161.awb") ~= 0 then
					local var_115_28 = manager.audio:GetVoiceLength("story_v_out_113161", "113161027", "story_v_out_113161.awb") / 1000

					if var_115_28 + var_115_20 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_28 + var_115_20
					end

					if var_115_23.prefab_name ~= "" and arg_112_1.actors_[var_115_23.prefab_name] ~= nil then
						local var_115_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_23.prefab_name].transform, "story_v_out_113161", "113161027", "story_v_out_113161.awb")

						arg_112_1:RecordAudio("113161027", var_115_29)
						arg_112_1:RecordAudio("113161027", var_115_29)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_113161", "113161027", "story_v_out_113161.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_113161", "113161027", "story_v_out_113161.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_30 = math.max(var_115_21, arg_112_1.talkMaxDuration)

			if var_115_20 <= arg_112_1.time_ and arg_112_1.time_ < var_115_20 + var_115_30 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_20) / var_115_30

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_20 + var_115_30 and arg_112_1.time_ < var_115_20 + var_115_30 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play113161028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 113161028
		arg_116_1.duration_ = 6.67

		local var_116_0 = {
			ja = 6.666,
			ko = 4.5,
			zh = 5,
			en = 4.2
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play113161029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1041ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1041ui_story == nil then
				arg_116_1.var_.characterEffect1041ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1041ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1041ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1041ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1041ui_story.fillRatio = var_119_5
			end

			local var_119_6 = "10006ui_story"

			if arg_116_1.actors_[var_119_6] == nil then
				local var_119_7 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_119_7) then
					local var_119_8 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_116_1.stage_.transform)

					var_119_8.name = var_119_6
					var_119_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_116_1.actors_[var_119_6] = var_119_8

					local var_119_9 = var_119_8:GetComponentInChildren(typeof(CharacterEffect))

					var_119_9.enabled = true

					local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_8, typeof(DynamicBoneHelper))

					if var_119_10 then
						var_119_10:EnableDynamicBone(false)
					end

					arg_116_1:ShowWeapon(var_119_9.transform, false)

					arg_116_1.var_[var_119_6 .. "Animator"] = var_119_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_116_1.var_[var_119_6 .. "Animator"].applyRootMotion = true
					arg_116_1.var_[var_119_6 .. "LipSync"] = var_119_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_119_11 = arg_116_1.actors_["10006ui_story"].transform
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.var_.moveOldPos10006ui_story = var_119_11.localPosition
			end

			local var_119_13 = 0.001

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_13 then
				local var_119_14 = (arg_116_1.time_ - var_119_12) / var_119_13
				local var_119_15 = Vector3.New(0.7, -0.98, -5.65)

				var_119_11.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10006ui_story, var_119_15, var_119_14)

				local var_119_16 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_16.x, var_119_16.y, var_119_16.z)

				local var_119_17 = var_119_11.localEulerAngles

				var_119_17.z = 0
				var_119_17.x = 0
				var_119_11.localEulerAngles = var_119_17
			end

			if arg_116_1.time_ >= var_119_12 + var_119_13 and arg_116_1.time_ < var_119_12 + var_119_13 + arg_119_0 then
				var_119_11.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_119_18 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_18.x, var_119_18.y, var_119_18.z)

				local var_119_19 = var_119_11.localEulerAngles

				var_119_19.z = 0
				var_119_19.x = 0
				var_119_11.localEulerAngles = var_119_19
			end

			local var_119_20 = 0

			if var_119_20 < arg_116_1.time_ and arg_116_1.time_ <= var_119_20 + arg_119_0 then
				arg_116_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_1")
			end

			local var_119_21 = 0

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_119_22 = arg_116_1.actors_["10006ui_story"]
			local var_119_23 = 0

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 and not isNil(var_119_22) and arg_116_1.var_.characterEffect10006ui_story == nil then
				arg_116_1.var_.characterEffect10006ui_story = var_119_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_24 = 0.2

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_24 and not isNil(var_119_22) then
				local var_119_25 = (arg_116_1.time_ - var_119_23) / var_119_24

				if arg_116_1.var_.characterEffect10006ui_story and not isNil(var_119_22) then
					arg_116_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_23 + var_119_24 and arg_116_1.time_ < var_119_23 + var_119_24 + arg_119_0 and not isNil(var_119_22) and arg_116_1.var_.characterEffect10006ui_story then
				arg_116_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_119_26 = 0
			local var_119_27 = 0.45

			if var_119_26 < arg_116_1.time_ and arg_116_1.time_ <= var_119_26 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_28 = arg_116_1:FormatText(StoryNameCfg[212].name)

				arg_116_1.leftNameTxt_.text = var_119_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_29 = arg_116_1:GetWordFromCfg(113161028)
				local var_119_30 = arg_116_1:FormatText(var_119_29.content)

				arg_116_1.text_.text = var_119_30

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_31 = 18
				local var_119_32 = utf8.len(var_119_30)
				local var_119_33 = var_119_31 <= 0 and var_119_27 or var_119_27 * (var_119_32 / var_119_31)

				if var_119_33 > 0 and var_119_27 < var_119_33 then
					arg_116_1.talkMaxDuration = var_119_33

					if var_119_33 + var_119_26 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_33 + var_119_26
					end
				end

				arg_116_1.text_.text = var_119_30
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161028", "story_v_out_113161.awb") ~= 0 then
					local var_119_34 = manager.audio:GetVoiceLength("story_v_out_113161", "113161028", "story_v_out_113161.awb") / 1000

					if var_119_34 + var_119_26 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_34 + var_119_26
					end

					if var_119_29.prefab_name ~= "" and arg_116_1.actors_[var_119_29.prefab_name] ~= nil then
						local var_119_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_29.prefab_name].transform, "story_v_out_113161", "113161028", "story_v_out_113161.awb")

						arg_116_1:RecordAudio("113161028", var_119_35)
						arg_116_1:RecordAudio("113161028", var_119_35)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_113161", "113161028", "story_v_out_113161.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_113161", "113161028", "story_v_out_113161.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_36 = math.max(var_119_27, arg_116_1.talkMaxDuration)

			if var_119_26 <= arg_116_1.time_ and arg_116_1.time_ < var_119_26 + var_119_36 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_26) / var_119_36

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_26 + var_119_36 and arg_116_1.time_ < var_119_26 + var_119_36 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play113161029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 113161029
		arg_120_1.duration_ = 5.1

		local var_120_0 = {
			ja = 4.8,
			ko = 3.666,
			zh = 4,
			en = 5.1
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play113161030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10006ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10006ui_story == nil then
				arg_120_1.var_.characterEffect10006ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect10006ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10006ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10006ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10006ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_2")
			end

			local var_123_7 = 0
			local var_123_8 = 0.525

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_9 = arg_120_1:FormatText(StoryNameCfg[225].name)

				arg_120_1.leftNameTxt_.text = var_123_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(113161029)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_12 = 21
				local var_123_13 = utf8.len(var_123_11)
				local var_123_14 = var_123_12 <= 0 and var_123_8 or var_123_8 * (var_123_13 / var_123_12)

				if var_123_14 > 0 and var_123_8 < var_123_14 then
					arg_120_1.talkMaxDuration = var_123_14

					if var_123_14 + var_123_7 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_7
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161029", "story_v_out_113161.awb") ~= 0 then
					local var_123_15 = manager.audio:GetVoiceLength("story_v_out_113161", "113161029", "story_v_out_113161.awb") / 1000

					if var_123_15 + var_123_7 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_7
					end

					if var_123_10.prefab_name ~= "" and arg_120_1.actors_[var_123_10.prefab_name] ~= nil then
						local var_123_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_10.prefab_name].transform, "story_v_out_113161", "113161029", "story_v_out_113161.awb")

						arg_120_1:RecordAudio("113161029", var_123_16)
						arg_120_1:RecordAudio("113161029", var_123_16)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_113161", "113161029", "story_v_out_113161.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_113161", "113161029", "story_v_out_113161.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_17 = math.max(var_123_8, arg_120_1.talkMaxDuration)

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_17 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_7) / var_123_17

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_7 + var_123_17 and arg_120_1.time_ < var_123_7 + var_123_17 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play113161030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 113161030
		arg_124_1.duration_ = 4.23

		local var_124_0 = {
			ja = 4.233,
			ko = 1.633,
			zh = 2.333,
			en = 3.7
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play113161031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.275

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[225].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(113161030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 11
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161030", "story_v_out_113161.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161030", "story_v_out_113161.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_113161", "113161030", "story_v_out_113161.awb")

						arg_124_1:RecordAudio("113161030", var_127_9)
						arg_124_1:RecordAudio("113161030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_113161", "113161030", "story_v_out_113161.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_113161", "113161030", "story_v_out_113161.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play113161031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 113161031
		arg_128_1.duration_ = 3.63

		local var_128_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play113161032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_131_1 = arg_128_1.actors_["10006ui_story"]
			local var_131_2 = 0

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect10006ui_story == nil then
				arg_128_1.var_.characterEffect10006ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.2

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_3 and not isNil(var_131_1) then
				local var_131_4 = (arg_128_1.time_ - var_131_2) / var_131_3

				if arg_128_1.var_.characterEffect10006ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_2 + var_131_3 and arg_128_1.time_ < var_131_2 + var_131_3 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect10006ui_story then
				arg_128_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_131_5 = 0
			local var_131_6 = 0.175

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_7 = arg_128_1:FormatText(StoryNameCfg[212].name)

				arg_128_1.leftNameTxt_.text = var_131_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(113161031)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 7
				local var_131_11 = utf8.len(var_131_9)
				local var_131_12 = var_131_10 <= 0 and var_131_6 or var_131_6 * (var_131_11 / var_131_10)

				if var_131_12 > 0 and var_131_6 < var_131_12 then
					arg_128_1.talkMaxDuration = var_131_12

					if var_131_12 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161031", "story_v_out_113161.awb") ~= 0 then
					local var_131_13 = manager.audio:GetVoiceLength("story_v_out_113161", "113161031", "story_v_out_113161.awb") / 1000

					if var_131_13 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_5
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_out_113161", "113161031", "story_v_out_113161.awb")

						arg_128_1:RecordAudio("113161031", var_131_14)
						arg_128_1:RecordAudio("113161031", var_131_14)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_113161", "113161031", "story_v_out_113161.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_113161", "113161031", "story_v_out_113161.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_15 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_15 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_15

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_15 and arg_128_1.time_ < var_131_5 + var_131_15 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play113161032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 113161032
		arg_132_1.duration_ = 8.8

		local var_132_0 = {
			ja = 8.8,
			ko = 3.5,
			zh = 3.033,
			en = 3.666
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play113161033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10006ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10006ui_story == nil then
				arg_132_1.var_.characterEffect10006ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect10006ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10006ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10006ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10006ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.45

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[225].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(113161032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 17
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161032", "story_v_out_113161.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161032", "story_v_out_113161.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_113161", "113161032", "story_v_out_113161.awb")

						arg_132_1:RecordAudio("113161032", var_135_15)
						arg_132_1:RecordAudio("113161032", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_113161", "113161032", "story_v_out_113161.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_113161", "113161032", "story_v_out_113161.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_16 and arg_132_1.time_ < var_135_6 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play113161033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 113161033
		arg_136_1.duration_ = 5.33

		local var_136_0 = {
			ja = 5.333,
			ko = 3.8,
			zh = 3.366,
			en = 2.2
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play113161034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10006ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10006ui_story == nil then
				arg_136_1.var_.characterEffect10006ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect10006ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10006ui_story then
				arg_136_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_139_4 = 0
			local var_139_5 = 0.375

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_6 = arg_136_1:FormatText(StoryNameCfg[212].name)

				arg_136_1.leftNameTxt_.text = var_139_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(113161033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 15
				local var_139_10 = utf8.len(var_139_8)
				local var_139_11 = var_139_9 <= 0 and var_139_5 or var_139_5 * (var_139_10 / var_139_9)

				if var_139_11 > 0 and var_139_5 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161033", "story_v_out_113161.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_113161", "113161033", "story_v_out_113161.awb") / 1000

					if var_139_12 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_4
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_113161", "113161033", "story_v_out_113161.awb")

						arg_136_1:RecordAudio("113161033", var_139_13)
						arg_136_1:RecordAudio("113161033", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_113161", "113161033", "story_v_out_113161.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_113161", "113161033", "story_v_out_113161.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_14 and arg_136_1.time_ < var_139_4 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play113161034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 113161034
		arg_140_1.duration_ = 12.13

		local var_140_0 = {
			ja = 12.133,
			ko = 7.466,
			zh = 8.1,
			en = 10.566
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play113161035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10006ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10006ui_story == nil then
				arg_140_1.var_.characterEffect10006ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect10006ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10006ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10006ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10006ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 1

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[225].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(113161034)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 40
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161034", "story_v_out_113161.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161034", "story_v_out_113161.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_113161", "113161034", "story_v_out_113161.awb")

						arg_140_1:RecordAudio("113161034", var_143_15)
						arg_140_1:RecordAudio("113161034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_113161", "113161034", "story_v_out_113161.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_113161", "113161034", "story_v_out_113161.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_16 and arg_140_1.time_ < var_143_6 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play113161035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 113161035
		arg_144_1.duration_ = 3.67

		local var_144_0 = {
			ja = 3.033,
			ko = 3.666,
			zh = 2.933,
			en = 1.833
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play113161036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10006ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10006ui_story == nil then
				arg_144_1.var_.characterEffect10006ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect10006ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10006ui_story then
				arg_144_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 0.3

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_6 = arg_144_1:FormatText(StoryNameCfg[212].name)

				arg_144_1.leftNameTxt_.text = var_147_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:GetWordFromCfg(113161035)
				local var_147_8 = arg_144_1:FormatText(var_147_7.content)

				arg_144_1.text_.text = var_147_8

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 12
				local var_147_10 = utf8.len(var_147_8)
				local var_147_11 = var_147_9 <= 0 and var_147_5 or var_147_5 * (var_147_10 / var_147_9)

				if var_147_11 > 0 and var_147_5 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_8
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161035", "story_v_out_113161.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_113161", "113161035", "story_v_out_113161.awb") / 1000

					if var_147_12 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_4
					end

					if var_147_7.prefab_name ~= "" and arg_144_1.actors_[var_147_7.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_7.prefab_name].transform, "story_v_out_113161", "113161035", "story_v_out_113161.awb")

						arg_144_1:RecordAudio("113161035", var_147_13)
						arg_144_1:RecordAudio("113161035", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_113161", "113161035", "story_v_out_113161.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_113161", "113161035", "story_v_out_113161.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_14 and arg_144_1.time_ < var_147_4 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play113161036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 113161036
		arg_148_1.duration_ = 9.57

		local var_148_0 = {
			ja = 9.566,
			ko = 5.833,
			zh = 5.6,
			en = 6.333
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play113161037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10006ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10006ui_story == nil then
				arg_148_1.var_.characterEffect10006ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect10006ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10006ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10006ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10006ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 0.825

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[225].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_9 = arg_148_1:GetWordFromCfg(113161036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 33
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161036", "story_v_out_113161.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161036", "story_v_out_113161.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_113161", "113161036", "story_v_out_113161.awb")

						arg_148_1:RecordAudio("113161036", var_151_15)
						arg_148_1:RecordAudio("113161036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_113161", "113161036", "story_v_out_113161.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_113161", "113161036", "story_v_out_113161.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play113161037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 113161037
		arg_152_1.duration_ = 7.8

		local var_152_0 = {
			ja = 6.966,
			ko = 5.4,
			zh = 5.866,
			en = 7.8
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play113161038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.875

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[225].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(113161037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 35
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161037", "story_v_out_113161.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161037", "story_v_out_113161.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_113161", "113161037", "story_v_out_113161.awb")

						arg_152_1:RecordAudio("113161037", var_155_9)
						arg_152_1:RecordAudio("113161037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_113161", "113161037", "story_v_out_113161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_113161", "113161037", "story_v_out_113161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play113161038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 113161038
		arg_156_1.duration_ = 2.7

		local var_156_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.1
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play113161039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_159_1 = arg_156_1.actors_["1041ui_story"]
			local var_159_2 = 0

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1041ui_story == nil then
				arg_156_1.var_.characterEffect1041ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_3 = 0.2

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_3 and not isNil(var_159_1) then
				local var_159_4 = (arg_156_1.time_ - var_159_2) / var_159_3

				if arg_156_1.var_.characterEffect1041ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_2 + var_159_3 and arg_156_1.time_ < var_159_2 + var_159_3 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1041ui_story then
				arg_156_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_159_5 = 0
			local var_159_6 = 0.125

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_7 = arg_156_1:FormatText(StoryNameCfg[208].name)

				arg_156_1.leftNameTxt_.text = var_159_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(113161038)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 5
				local var_159_11 = utf8.len(var_159_9)
				local var_159_12 = var_159_10 <= 0 and var_159_6 or var_159_6 * (var_159_11 / var_159_10)

				if var_159_12 > 0 and var_159_6 < var_159_12 then
					arg_156_1.talkMaxDuration = var_159_12

					if var_159_12 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161038", "story_v_out_113161.awb") ~= 0 then
					local var_159_13 = manager.audio:GetVoiceLength("story_v_out_113161", "113161038", "story_v_out_113161.awb") / 1000

					if var_159_13 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_5
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_113161", "113161038", "story_v_out_113161.awb")

						arg_156_1:RecordAudio("113161038", var_159_14)
						arg_156_1:RecordAudio("113161038", var_159_14)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_113161", "113161038", "story_v_out_113161.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_113161", "113161038", "story_v_out_113161.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_15 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_15 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_15

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_15 and arg_156_1.time_ < var_159_5 + var_159_15 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play113161039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 113161039
		arg_160_1.duration_ = 9.9

		local var_160_0 = {
			ja = 9.9,
			ko = 6.766,
			zh = 6.733,
			en = 8.5
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play113161040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10006ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos10006ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0, 100, 0)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10006ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, 100, 0)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = arg_160_1.actors_["1041ui_story"].transform
			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.var_.moveOldPos1041ui_story = var_163_9.localPosition
			end

			local var_163_11 = 0.001

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_11 then
				local var_163_12 = (arg_160_1.time_ - var_163_10) / var_163_11
				local var_163_13 = Vector3.New(0, 100, 0)

				var_163_9.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1041ui_story, var_163_13, var_163_12)

				local var_163_14 = manager.ui.mainCamera.transform.position - var_163_9.position

				var_163_9.forward = Vector3.New(var_163_14.x, var_163_14.y, var_163_14.z)

				local var_163_15 = var_163_9.localEulerAngles

				var_163_15.z = 0
				var_163_15.x = 0
				var_163_9.localEulerAngles = var_163_15
			end

			if arg_160_1.time_ >= var_163_10 + var_163_11 and arg_160_1.time_ < var_163_10 + var_163_11 + arg_163_0 then
				var_163_9.localPosition = Vector3.New(0, 100, 0)

				local var_163_16 = manager.ui.mainCamera.transform.position - var_163_9.position

				var_163_9.forward = Vector3.New(var_163_16.x, var_163_16.y, var_163_16.z)

				local var_163_17 = var_163_9.localEulerAngles

				var_163_17.z = 0
				var_163_17.x = 0
				var_163_9.localEulerAngles = var_163_17
			end

			local var_163_18 = arg_160_1.bgs_.F03a.transform
			local var_163_19 = 2

			if var_163_19 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				arg_160_1.var_.shakeOldPosF03a = var_163_18.localPosition
			end

			local var_163_20 = 1

			if var_163_19 <= arg_160_1.time_ and arg_160_1.time_ < var_163_19 + var_163_20 then
				local var_163_21 = (arg_160_1.time_ - var_163_19) / 0.066
				local var_163_22, var_163_23 = math.modf(var_163_21)

				var_163_18.localPosition = Vector3.New(var_163_23 * 0.1, var_163_23 * 0.1, var_163_23 * 0) + arg_160_1.var_.shakeOldPosF03a
			end

			if arg_160_1.time_ >= var_163_19 + var_163_20 and arg_160_1.time_ < var_163_19 + var_163_20 + arg_163_0 then
				var_163_18.localPosition = arg_160_1.var_.shakeOldPosF03a
			end

			local var_163_24 = 2

			if var_163_24 < arg_160_1.time_ and arg_160_1.time_ <= var_163_24 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_25 = 1

			if arg_160_1.time_ >= var_163_24 + var_163_25 and arg_160_1.time_ < var_163_24 + var_163_25 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_26 = 0

			if var_163_26 < arg_160_1.time_ and arg_160_1.time_ <= var_163_26 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_27 = 2

			if var_163_26 <= arg_160_1.time_ and arg_160_1.time_ < var_163_26 + var_163_27 then
				local var_163_28 = (arg_160_1.time_ - var_163_26) / var_163_27
				local var_163_29 = Color.New(1, 1, 1)

				var_163_29.a = Mathf.Lerp(1, 0, var_163_28)
				arg_160_1.mask_.color = var_163_29
			end

			if arg_160_1.time_ >= var_163_26 + var_163_27 and arg_160_1.time_ < var_163_26 + var_163_27 + arg_163_0 then
				local var_163_30 = Color.New(1, 1, 1)
				local var_163_31 = 0

				arg_160_1.mask_.enabled = false
				var_163_30.a = var_163_31
				arg_160_1.mask_.color = var_163_30
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_32 = 2
			local var_163_33 = 0.375

			if var_163_32 < arg_160_1.time_ and arg_160_1.time_ <= var_163_32 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_34 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_34:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_35 = arg_160_1:FormatText(StoryNameCfg[212].name)

				arg_160_1.leftNameTxt_.text = var_163_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_36 = arg_160_1:GetWordFromCfg(113161039)
				local var_163_37 = arg_160_1:FormatText(var_163_36.content)

				arg_160_1.text_.text = var_163_37

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_38 = 15
				local var_163_39 = utf8.len(var_163_37)
				local var_163_40 = var_163_38 <= 0 and var_163_33 or var_163_33 * (var_163_39 / var_163_38)

				if var_163_40 > 0 and var_163_33 < var_163_40 then
					arg_160_1.talkMaxDuration = var_163_40
					var_163_32 = var_163_32 + 0.3

					if var_163_40 + var_163_32 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_40 + var_163_32
					end
				end

				arg_160_1.text_.text = var_163_37
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161039", "story_v_out_113161.awb") ~= 0 then
					local var_163_41 = manager.audio:GetVoiceLength("story_v_out_113161", "113161039", "story_v_out_113161.awb") / 1000

					if var_163_41 + var_163_32 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_41 + var_163_32
					end

					if var_163_36.prefab_name ~= "" and arg_160_1.actors_[var_163_36.prefab_name] ~= nil then
						local var_163_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_36.prefab_name].transform, "story_v_out_113161", "113161039", "story_v_out_113161.awb")

						arg_160_1:RecordAudio("113161039", var_163_42)
						arg_160_1:RecordAudio("113161039", var_163_42)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_113161", "113161039", "story_v_out_113161.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_113161", "113161039", "story_v_out_113161.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_43 = var_163_32 + 0.3
			local var_163_44 = math.max(var_163_33, arg_160_1.talkMaxDuration)

			if var_163_43 <= arg_160_1.time_ and arg_160_1.time_ < var_163_43 + var_163_44 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_43) / var_163_44

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_43 + var_163_44 and arg_160_1.time_ < var_163_43 + var_163_44 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play113161040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 113161040
		arg_166_1.duration_ = 3.5

		local var_166_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 2.8,
			en = 3.5
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play113161041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = "10006_tpose"

			if arg_166_1.actors_[var_169_0] == nil then
				local var_169_1 = Asset.Load("Char/" .. "10006_tpose")

				if not isNil(var_169_1) then
					local var_169_2 = Object.Instantiate(Asset.Load("Char/" .. "10006_tpose"), arg_166_1.stage_.transform)

					var_169_2.name = var_169_0
					var_169_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_166_1.actors_[var_169_0] = var_169_2

					local var_169_3 = var_169_2:GetComponentInChildren(typeof(CharacterEffect))

					var_169_3.enabled = true

					local var_169_4 = GameObjectTools.GetOrAddComponent(var_169_2, typeof(DynamicBoneHelper))

					if var_169_4 then
						var_169_4:EnableDynamicBone(false)
					end

					arg_166_1:ShowWeapon(var_169_3.transform, false)

					arg_166_1.var_[var_169_0 .. "Animator"] = var_169_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_166_1.var_[var_169_0 .. "Animator"].applyRootMotion = true
					arg_166_1.var_[var_169_0 .. "LipSync"] = var_169_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_169_5 = arg_166_1.actors_["10006_tpose"]
			local var_169_6 = 0

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect10006_tpose == nil then
				arg_166_1.var_.characterEffect10006_tpose = var_169_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_7 = 0.2

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_7 and not isNil(var_169_5) then
				local var_169_8 = (arg_166_1.time_ - var_169_6) / var_169_7

				if arg_166_1.var_.characterEffect10006_tpose and not isNil(var_169_5) then
					local var_169_9 = Mathf.Lerp(0, 0.5, var_169_8)

					arg_166_1.var_.characterEffect10006_tpose.fillFlat = true
					arg_166_1.var_.characterEffect10006_tpose.fillRatio = var_169_9
				end
			end

			if arg_166_1.time_ >= var_169_6 + var_169_7 and arg_166_1.time_ < var_169_6 + var_169_7 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect10006_tpose then
				local var_169_10 = 0.5

				arg_166_1.var_.characterEffect10006_tpose.fillFlat = true
				arg_166_1.var_.characterEffect10006_tpose.fillRatio = var_169_10
			end

			local var_169_11 = arg_166_1.actors_["1041ui_story"]
			local var_169_12 = 0

			if var_169_12 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect1041ui_story == nil then
				arg_166_1.var_.characterEffect1041ui_story = var_169_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_13 = 0.2

			if var_169_12 <= arg_166_1.time_ and arg_166_1.time_ < var_169_12 + var_169_13 and not isNil(var_169_11) then
				local var_169_14 = (arg_166_1.time_ - var_169_12) / var_169_13

				if arg_166_1.var_.characterEffect1041ui_story and not isNil(var_169_11) then
					arg_166_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_12 + var_169_13 and arg_166_1.time_ < var_169_12 + var_169_13 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect1041ui_story then
				arg_166_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_169_15 = 0

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_169_16 = arg_166_1.actors_["1041ui_story"].transform
			local var_169_17 = 0

			if var_169_17 < arg_166_1.time_ and arg_166_1.time_ <= var_169_17 + arg_169_0 then
				arg_166_1.var_.moveOldPos1041ui_story = var_169_16.localPosition
			end

			local var_169_18 = 0.001

			if var_169_17 <= arg_166_1.time_ and arg_166_1.time_ < var_169_17 + var_169_18 then
				local var_169_19 = (arg_166_1.time_ - var_169_17) / var_169_18
				local var_169_20 = Vector3.New(0, -1.11, -5.9)

				var_169_16.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1041ui_story, var_169_20, var_169_19)

				local var_169_21 = manager.ui.mainCamera.transform.position - var_169_16.position

				var_169_16.forward = Vector3.New(var_169_21.x, var_169_21.y, var_169_21.z)

				local var_169_22 = var_169_16.localEulerAngles

				var_169_22.z = 0
				var_169_22.x = 0
				var_169_16.localEulerAngles = var_169_22
			end

			if arg_166_1.time_ >= var_169_17 + var_169_18 and arg_166_1.time_ < var_169_17 + var_169_18 + arg_169_0 then
				var_169_16.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_169_23 = manager.ui.mainCamera.transform.position - var_169_16.position

				var_169_16.forward = Vector3.New(var_169_23.x, var_169_23.y, var_169_23.z)

				local var_169_24 = var_169_16.localEulerAngles

				var_169_24.z = 0
				var_169_24.x = 0
				var_169_16.localEulerAngles = var_169_24
			end

			local var_169_25 = 0
			local var_169_26 = 0.2

			if var_169_25 < arg_166_1.time_ and arg_166_1.time_ <= var_169_25 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_27 = arg_166_1:FormatText(StoryNameCfg[208].name)

				arg_166_1.leftNameTxt_.text = var_169_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_28 = arg_166_1:GetWordFromCfg(113161040)
				local var_169_29 = arg_166_1:FormatText(var_169_28.content)

				arg_166_1.text_.text = var_169_29

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_30 = 8
				local var_169_31 = utf8.len(var_169_29)
				local var_169_32 = var_169_30 <= 0 and var_169_26 or var_169_26 * (var_169_31 / var_169_30)

				if var_169_32 > 0 and var_169_26 < var_169_32 then
					arg_166_1.talkMaxDuration = var_169_32

					if var_169_32 + var_169_25 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_32 + var_169_25
					end
				end

				arg_166_1.text_.text = var_169_29
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161040", "story_v_out_113161.awb") ~= 0 then
					local var_169_33 = manager.audio:GetVoiceLength("story_v_out_113161", "113161040", "story_v_out_113161.awb") / 1000

					if var_169_33 + var_169_25 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_33 + var_169_25
					end

					if var_169_28.prefab_name ~= "" and arg_166_1.actors_[var_169_28.prefab_name] ~= nil then
						local var_169_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_28.prefab_name].transform, "story_v_out_113161", "113161040", "story_v_out_113161.awb")

						arg_166_1:RecordAudio("113161040", var_169_34)
						arg_166_1:RecordAudio("113161040", var_169_34)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_113161", "113161040", "story_v_out_113161.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_113161", "113161040", "story_v_out_113161.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_35 = math.max(var_169_26, arg_166_1.talkMaxDuration)

			if var_169_25 <= arg_166_1.time_ and arg_166_1.time_ < var_169_25 + var_169_35 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_25) / var_169_35

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_25 + var_169_35 and arg_166_1.time_ < var_169_25 + var_169_35 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play113161041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 113161041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play113161042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1041ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1041ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1041ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = 0
			local var_173_10 = 1.05

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_11 = arg_170_1:GetWordFromCfg(113161041)
				local var_173_12 = arg_170_1:FormatText(var_173_11.content)

				arg_170_1.text_.text = var_173_12

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 42
				local var_173_14 = utf8.len(var_173_12)
				local var_173_15 = var_173_13 <= 0 and var_173_10 or var_173_10 * (var_173_14 / var_173_13)

				if var_173_15 > 0 and var_173_10 < var_173_15 then
					arg_170_1.talkMaxDuration = var_173_15

					if var_173_15 + var_173_9 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_9
					end
				end

				arg_170_1.text_.text = var_173_12
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_10, arg_170_1.talkMaxDuration)

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_9) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_9 + var_173_16 and arg_170_1.time_ < var_173_9 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play113161042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 113161042
		arg_174_1.duration_ = 13.9

		local var_174_0 = {
			ja = 13.9,
			ko = 7.9,
			zh = 6.933,
			en = 8.066
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play113161043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 0.625

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[212].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:GetWordFromCfg(113161042)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 25
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161042", "story_v_out_113161.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161042", "story_v_out_113161.awb") / 1000

					if var_177_8 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_0
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_113161", "113161042", "story_v_out_113161.awb")

						arg_174_1:RecordAudio("113161042", var_177_9)
						arg_174_1:RecordAudio("113161042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_113161", "113161042", "story_v_out_113161.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_113161", "113161042", "story_v_out_113161.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_10 and arg_174_1.time_ < var_177_0 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play113161043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 113161043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play113161044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				local var_181_2 = "play"
				local var_181_3 = "effect"

				arg_178_1:AudioAction(var_181_2, var_181_3, "se_story_10", "se_story_10_fog", "")
			end

			local var_181_4 = 0
			local var_181_5 = 0.8

			if var_181_4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(113161043)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_8 = 32
				local var_181_9 = utf8.len(var_181_7)
				local var_181_10 = var_181_8 <= 0 and var_181_5 or var_181_5 * (var_181_9 / var_181_8)

				if var_181_10 > 0 and var_181_5 < var_181_10 then
					arg_178_1.talkMaxDuration = var_181_10

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_11 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_11 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_11

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_11 and arg_178_1.time_ < var_181_4 + var_181_11 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play113161044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 113161044
		arg_182_1.duration_ = 4.33

		local var_182_0 = {
			ja = 4.333,
			ko = 1.999999999999,
			zh = 2.866,
			en = 1.999999999999
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play113161045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1041ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos1041ui_story = var_185_0.localPosition

				local var_185_2 = "1041ui_story"

				arg_182_1:ShowWeapon(arg_182_1.var_[var_185_2 .. "Animator"].transform, true)
			end

			local var_185_3 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_3 then
				local var_185_4 = (arg_182_1.time_ - var_185_1) / var_185_3
				local var_185_5 = Vector3.New(0, -1.11, -5.9)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1041ui_story, var_185_5, var_185_4)

				local var_185_6 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_6.x, var_185_6.y, var_185_6.z)

				local var_185_7 = var_185_0.localEulerAngles

				var_185_7.z = 0
				var_185_7.x = 0
				var_185_0.localEulerAngles = var_185_7
			end

			if arg_182_1.time_ >= var_185_1 + var_185_3 and arg_182_1.time_ < var_185_1 + var_185_3 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_185_8 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_8.x, var_185_8.y, var_185_8.z)

				local var_185_9 = var_185_0.localEulerAngles

				var_185_9.z = 0
				var_185_9.x = 0
				var_185_0.localEulerAngles = var_185_9
			end

			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_185_12 = arg_182_1.actors_["1041ui_story"]
			local var_185_13 = 0

			if var_185_13 < arg_182_1.time_ and arg_182_1.time_ <= var_185_13 + arg_185_0 and not isNil(var_185_12) and arg_182_1.var_.characterEffect1041ui_story == nil then
				arg_182_1.var_.characterEffect1041ui_story = var_185_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_14 = 0.2

			if var_185_13 <= arg_182_1.time_ and arg_182_1.time_ < var_185_13 + var_185_14 and not isNil(var_185_12) then
				local var_185_15 = (arg_182_1.time_ - var_185_13) / var_185_14

				if arg_182_1.var_.characterEffect1041ui_story and not isNil(var_185_12) then
					arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_13 + var_185_14 and arg_182_1.time_ < var_185_13 + var_185_14 + arg_185_0 and not isNil(var_185_12) and arg_182_1.var_.characterEffect1041ui_story then
				arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_185_16 = 0
			local var_185_17 = 0.1

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_18 = arg_182_1:FormatText(StoryNameCfg[208].name)

				arg_182_1.leftNameTxt_.text = var_185_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_19 = arg_182_1:GetWordFromCfg(113161044)
				local var_185_20 = arg_182_1:FormatText(var_185_19.content)

				arg_182_1.text_.text = var_185_20

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_21 = 4
				local var_185_22 = utf8.len(var_185_20)
				local var_185_23 = var_185_21 <= 0 and var_185_17 or var_185_17 * (var_185_22 / var_185_21)

				if var_185_23 > 0 and var_185_17 < var_185_23 then
					arg_182_1.talkMaxDuration = var_185_23

					if var_185_23 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_16
					end
				end

				arg_182_1.text_.text = var_185_20
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161044", "story_v_out_113161.awb") ~= 0 then
					local var_185_24 = manager.audio:GetVoiceLength("story_v_out_113161", "113161044", "story_v_out_113161.awb") / 1000

					if var_185_24 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_24 + var_185_16
					end

					if var_185_19.prefab_name ~= "" and arg_182_1.actors_[var_185_19.prefab_name] ~= nil then
						local var_185_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_19.prefab_name].transform, "story_v_out_113161", "113161044", "story_v_out_113161.awb")

						arg_182_1:RecordAudio("113161044", var_185_25)
						arg_182_1:RecordAudio("113161044", var_185_25)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_113161", "113161044", "story_v_out_113161.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_113161", "113161044", "story_v_out_113161.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_26 = math.max(var_185_17, arg_182_1.talkMaxDuration)

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_26 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_16) / var_185_26

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_16 + var_185_26 and arg_182_1.time_ < var_185_16 + var_185_26 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play113161045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 113161045
		arg_186_1.duration_ = 9

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play113161046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_1 = 2

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_1 then
				local var_189_2 = (arg_186_1.time_ - var_189_0) / var_189_1
				local var_189_3 = Color.New(0, 0, 0)

				var_189_3.a = Mathf.Lerp(0, 1, var_189_2)
				arg_186_1.mask_.color = var_189_3
			end

			if arg_186_1.time_ >= var_189_0 + var_189_1 and arg_186_1.time_ < var_189_0 + var_189_1 + arg_189_0 then
				local var_189_4 = Color.New(0, 0, 0)

				var_189_4.a = 1
				arg_186_1.mask_.color = var_189_4
			end

			local var_189_5 = 2

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_6 = 2

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 then
				local var_189_7 = (arg_186_1.time_ - var_189_5) / var_189_6
				local var_189_8 = Color.New(0, 0, 0)

				var_189_8.a = Mathf.Lerp(1, 0, var_189_7)
				arg_186_1.mask_.color = var_189_8
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 then
				local var_189_9 = Color.New(0, 0, 0)
				local var_189_10 = 0

				arg_186_1.mask_.enabled = false
				var_189_9.a = var_189_10
				arg_186_1.mask_.color = var_189_9
			end

			local var_189_11 = "OM0103"

			if arg_186_1.bgs_[var_189_11] == nil then
				local var_189_12 = Object.Instantiate(arg_186_1.paintGo_)

				var_189_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_189_11)
				var_189_12.name = var_189_11
				var_189_12.transform.parent = arg_186_1.stage_.transform
				var_189_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.bgs_[var_189_11] = var_189_12
			end

			local var_189_13 = 2

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				local var_189_14 = manager.ui.mainCamera.transform.localPosition
				local var_189_15 = Vector3.New(0, 0, 10) + Vector3.New(var_189_14.x, var_189_14.y, 0)
				local var_189_16 = arg_186_1.bgs_.OM0103

				var_189_16.transform.localPosition = var_189_15
				var_189_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_17 = var_189_16:GetComponent("SpriteRenderer")

				if var_189_17 and var_189_17.sprite then
					local var_189_18 = (var_189_16.transform.localPosition - var_189_14).z
					local var_189_19 = manager.ui.mainCameraCom_
					local var_189_20 = 2 * var_189_18 * Mathf.Tan(var_189_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_189_21 = var_189_20 * var_189_19.aspect
					local var_189_22 = var_189_17.sprite.bounds.size.x
					local var_189_23 = var_189_17.sprite.bounds.size.y
					local var_189_24 = var_189_21 / var_189_22
					local var_189_25 = var_189_20 / var_189_23
					local var_189_26 = var_189_25 < var_189_24 and var_189_24 or var_189_25

					var_189_16.transform.localScale = Vector3.New(var_189_26, var_189_26, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "OM0103" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_27 = arg_186_1.actors_["1041ui_story"].transform
			local var_189_28 = 1.966

			if var_189_28 < arg_186_1.time_ and arg_186_1.time_ <= var_189_28 + arg_189_0 then
				arg_186_1.var_.moveOldPos1041ui_story = var_189_27.localPosition

				local var_189_29 = "1041ui_story"

				arg_186_1:ShowWeapon(arg_186_1.var_[var_189_29 .. "Animator"].transform, false)
			end

			local var_189_30 = 0.001

			if var_189_28 <= arg_186_1.time_ and arg_186_1.time_ < var_189_28 + var_189_30 then
				local var_189_31 = (arg_186_1.time_ - var_189_28) / var_189_30
				local var_189_32 = Vector3.New(0, 100, 0)

				var_189_27.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1041ui_story, var_189_32, var_189_31)

				local var_189_33 = manager.ui.mainCamera.transform.position - var_189_27.position

				var_189_27.forward = Vector3.New(var_189_33.x, var_189_33.y, var_189_33.z)

				local var_189_34 = var_189_27.localEulerAngles

				var_189_34.z = 0
				var_189_34.x = 0
				var_189_27.localEulerAngles = var_189_34
			end

			if arg_186_1.time_ >= var_189_28 + var_189_30 and arg_186_1.time_ < var_189_28 + var_189_30 + arg_189_0 then
				var_189_27.localPosition = Vector3.New(0, 100, 0)

				local var_189_35 = manager.ui.mainCamera.transform.position - var_189_27.position

				var_189_27.forward = Vector3.New(var_189_35.x, var_189_35.y, var_189_35.z)

				local var_189_36 = var_189_27.localEulerAngles

				var_189_36.z = 0
				var_189_36.x = 0
				var_189_27.localEulerAngles = var_189_36
			end

			local var_189_37 = arg_186_1.bgs_.OM0103.transform
			local var_189_38 = 2

			if var_189_38 < arg_186_1.time_ and arg_186_1.time_ <= var_189_38 + arg_189_0 then
				arg_186_1.var_.moveOldPosOM0103 = var_189_37.localPosition
			end

			local var_189_39 = 0.001

			if var_189_38 <= arg_186_1.time_ and arg_186_1.time_ < var_189_38 + var_189_39 then
				local var_189_40 = (arg_186_1.time_ - var_189_38) / var_189_39
				local var_189_41 = Vector3.New(-1.6, 0.5, 1.01)

				var_189_37.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPosOM0103, var_189_41, var_189_40)
			end

			if arg_186_1.time_ >= var_189_38 + var_189_39 and arg_186_1.time_ < var_189_38 + var_189_39 + arg_189_0 then
				var_189_37.localPosition = Vector3.New(-1.6, 0.5, 1.01)
			end

			local var_189_42 = arg_186_1.bgs_.OM0103.transform
			local var_189_43 = 2.01666666666667

			if var_189_43 < arg_186_1.time_ and arg_186_1.time_ <= var_189_43 + arg_189_0 then
				arg_186_1.var_.moveOldPosOM0103 = var_189_42.localPosition
			end

			local var_189_44 = 4

			if var_189_43 <= arg_186_1.time_ and arg_186_1.time_ < var_189_43 + var_189_44 then
				local var_189_45 = (arg_186_1.time_ - var_189_43) / var_189_44
				local var_189_46 = Vector3.New(-1.6, 0.2, 1.01)

				var_189_42.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPosOM0103, var_189_46, var_189_45)
			end

			if arg_186_1.time_ >= var_189_43 + var_189_44 and arg_186_1.time_ < var_189_43 + var_189_44 + arg_189_0 then
				var_189_42.localPosition = Vector3.New(-1.6, 0.2, 1.01)
			end

			local var_189_47 = 2

			if var_189_47 < arg_186_1.time_ and arg_186_1.time_ <= var_189_47 + arg_189_0 then
				arg_186_1.allBtn_.enabled = false
			end

			local var_189_48 = 4.01666666666667

			if arg_186_1.time_ >= var_189_47 + var_189_48 and arg_186_1.time_ < var_189_47 + var_189_48 + arg_189_0 then
				arg_186_1.allBtn_.enabled = true
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_49 = 4
			local var_189_50 = 1.025

			if var_189_49 < arg_186_1.time_ and arg_186_1.time_ <= var_189_49 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_51 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_51:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_52 = arg_186_1:GetWordFromCfg(113161045)
				local var_189_53 = arg_186_1:FormatText(var_189_52.content)

				arg_186_1.text_.text = var_189_53

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_54 = 41
				local var_189_55 = utf8.len(var_189_53)
				local var_189_56 = var_189_54 <= 0 and var_189_50 or var_189_50 * (var_189_55 / var_189_54)

				if var_189_56 > 0 and var_189_50 < var_189_56 then
					arg_186_1.talkMaxDuration = var_189_56
					var_189_49 = var_189_49 + 0.3

					if var_189_56 + var_189_49 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_56 + var_189_49
					end
				end

				arg_186_1.text_.text = var_189_53
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_57 = var_189_49 + 0.3
			local var_189_58 = math.max(var_189_50, arg_186_1.talkMaxDuration)

			if var_189_57 <= arg_186_1.time_ and arg_186_1.time_ < var_189_57 + var_189_58 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_57) / var_189_58

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_57 + var_189_58 and arg_186_1.time_ < var_189_57 + var_189_58 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play113161046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 113161046
		arg_192_1.duration_ = 5.07

		local var_192_0 = {
			ja = 5,
			ko = 3.266,
			zh = 4.433,
			en = 5.066
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play113161047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.25

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[208].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(113161046)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 10
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161046", "story_v_out_113161.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161046", "story_v_out_113161.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_113161", "113161046", "story_v_out_113161.awb")

						arg_192_1:RecordAudio("113161046", var_195_9)
						arg_192_1:RecordAudio("113161046", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_113161", "113161046", "story_v_out_113161.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_113161", "113161046", "story_v_out_113161.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play113161047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 113161047
		arg_196_1.duration_ = 12.2

		local var_196_0 = {
			ja = 10.6,
			ko = 8.533,
			zh = 11.4,
			en = 12.2
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play113161048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_1 = 2

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_1 then
				local var_199_2 = (arg_196_1.time_ - var_199_0) / var_199_1
				local var_199_3 = Color.New(0, 0, 0)

				var_199_3.a = Mathf.Lerp(0, 1, var_199_2)
				arg_196_1.mask_.color = var_199_3
			end

			if arg_196_1.time_ >= var_199_0 + var_199_1 and arg_196_1.time_ < var_199_0 + var_199_1 + arg_199_0 then
				local var_199_4 = Color.New(0, 0, 0)

				var_199_4.a = 1
				arg_196_1.mask_.color = var_199_4
			end

			local var_199_5 = 2

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_6 = 2

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 then
				local var_199_7 = (arg_196_1.time_ - var_199_5) / var_199_6
				local var_199_8 = Color.New(0, 0, 0)

				var_199_8.a = Mathf.Lerp(1, 0, var_199_7)
				arg_196_1.mask_.color = var_199_8
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 then
				local var_199_9 = Color.New(0, 0, 0)
				local var_199_10 = 0

				arg_196_1.mask_.enabled = false
				var_199_9.a = var_199_10
				arg_196_1.mask_.color = var_199_9
			end

			local var_199_11 = arg_196_1.bgs_.OM0103.transform
			local var_199_12 = 2

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.var_.moveOldPosOM0103 = var_199_11.localPosition
			end

			local var_199_13 = 0.001

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_13 then
				local var_199_14 = (arg_196_1.time_ - var_199_12) / var_199_13
				local var_199_15 = Vector3.New(0, 1, 9.5)

				var_199_11.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPosOM0103, var_199_15, var_199_14)
			end

			if arg_196_1.time_ >= var_199_12 + var_199_13 and arg_196_1.time_ < var_199_12 + var_199_13 + arg_199_0 then
				var_199_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_199_16 = arg_196_1.bgs_.OM0103.transform
			local var_199_17 = 2.01666666666667

			if var_199_17 < arg_196_1.time_ and arg_196_1.time_ <= var_199_17 + arg_199_0 then
				arg_196_1.var_.moveOldPosOM0103 = var_199_16.localPosition
			end

			local var_199_18 = 3

			if var_199_17 <= arg_196_1.time_ and arg_196_1.time_ < var_199_17 + var_199_18 then
				local var_199_19 = (arg_196_1.time_ - var_199_17) / var_199_18
				local var_199_20 = Vector3.New(0, 1, 10)

				var_199_16.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPosOM0103, var_199_20, var_199_19)
			end

			if arg_196_1.time_ >= var_199_17 + var_199_18 and arg_196_1.time_ < var_199_17 + var_199_18 + arg_199_0 then
				var_199_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_199_21 = 4

			if var_199_21 < arg_196_1.time_ and arg_196_1.time_ <= var_199_21 + arg_199_0 then
				arg_196_1.allBtn_.enabled = false
			end

			local var_199_22 = 1.01666666666667

			if arg_196_1.time_ >= var_199_21 + var_199_22 and arg_196_1.time_ < var_199_21 + var_199_22 + arg_199_0 then
				arg_196_1.allBtn_.enabled = true
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_23 = 4.2
			local var_199_24 = 0.45

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_25 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_25:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_26 = arg_196_1:FormatText(StoryNameCfg[225].name)

				arg_196_1.leftNameTxt_.text = var_199_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_27 = arg_196_1:GetWordFromCfg(113161047)
				local var_199_28 = arg_196_1:FormatText(var_199_27.content)

				arg_196_1.text_.text = var_199_28

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_29 = 18
				local var_199_30 = utf8.len(var_199_28)
				local var_199_31 = var_199_29 <= 0 and var_199_24 or var_199_24 * (var_199_30 / var_199_29)

				if var_199_31 > 0 and var_199_24 < var_199_31 then
					arg_196_1.talkMaxDuration = var_199_31
					var_199_23 = var_199_23 + 0.3

					if var_199_31 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_31 + var_199_23
					end
				end

				arg_196_1.text_.text = var_199_28
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161047", "story_v_out_113161.awb") ~= 0 then
					local var_199_32 = manager.audio:GetVoiceLength("story_v_out_113161", "113161047", "story_v_out_113161.awb") / 1000

					if var_199_32 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_32 + var_199_23
					end

					if var_199_27.prefab_name ~= "" and arg_196_1.actors_[var_199_27.prefab_name] ~= nil then
						local var_199_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_27.prefab_name].transform, "story_v_out_113161", "113161047", "story_v_out_113161.awb")

						arg_196_1:RecordAudio("113161047", var_199_33)
						arg_196_1:RecordAudio("113161047", var_199_33)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_113161", "113161047", "story_v_out_113161.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_113161", "113161047", "story_v_out_113161.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_34 = var_199_23 + 0.3
			local var_199_35 = math.max(var_199_24, arg_196_1.talkMaxDuration)

			if var_199_34 <= arg_196_1.time_ and arg_196_1.time_ < var_199_34 + var_199_35 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_34) / var_199_35

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_34 + var_199_35 and arg_196_1.time_ < var_199_34 + var_199_35 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play113161048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 113161048
		arg_202_1.duration_ = 8.6

		local var_202_0 = {
			ja = 8.6,
			ko = 7.566,
			zh = 8.2,
			en = 8.133
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play113161049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.875

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[225].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:GetWordFromCfg(113161048)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 35
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161048", "story_v_out_113161.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161048", "story_v_out_113161.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_113161", "113161048", "story_v_out_113161.awb")

						arg_202_1:RecordAudio("113161048", var_205_9)
						arg_202_1:RecordAudio("113161048", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_113161", "113161048", "story_v_out_113161.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_113161", "113161048", "story_v_out_113161.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play113161049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 113161049
		arg_206_1.duration_ = 8.47

		local var_206_0 = {
			ja = 6.9,
			ko = 7,
			zh = 6.8,
			en = 8.466
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play113161050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.725

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[225].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:GetWordFromCfg(113161049)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 29
				local var_209_6 = utf8.len(var_209_4)
				local var_209_7 = var_209_5 <= 0 and var_209_1 or var_209_1 * (var_209_6 / var_209_5)

				if var_209_7 > 0 and var_209_1 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161049", "story_v_out_113161.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161049", "story_v_out_113161.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_113161", "113161049", "story_v_out_113161.awb")

						arg_206_1:RecordAudio("113161049", var_209_9)
						arg_206_1:RecordAudio("113161049", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_113161", "113161049", "story_v_out_113161.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_113161", "113161049", "story_v_out_113161.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_10 and arg_206_1.time_ < var_209_0 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play113161050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 113161050
		arg_210_1.duration_ = 9.5

		local var_210_0 = {
			ja = 6,
			ko = 4.666,
			zh = 6.5,
			en = 9.5
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
			arg_210_1.auto_ = false
		end

		function arg_210_1.playNext_(arg_212_0)
			arg_210_1.onStoryFinished_()
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.475

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[225].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:GetWordFromCfg(113161050)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 19
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161050", "story_v_out_113161.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161050", "story_v_out_113161.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_113161", "113161050", "story_v_out_113161.awb")

						arg_210_1:RecordAudio("113161050", var_213_9)
						arg_210_1:RecordAudio("113161050", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_113161", "113161050", "story_v_out_113161.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_113161", "113161050", "story_v_out_113161.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/F03a",
		"TextureConfig/Background/OM0103"
	},
	voices = {
		"story_v_out_113161.awb"
	}
}
