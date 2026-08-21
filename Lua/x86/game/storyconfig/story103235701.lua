return {
	Play323571001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323571001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323571002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2015a"

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
				local var_4_5 = arg_1_1.bgs_.ST2015a

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
					if iter_4_0 ~= "ST2015a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.3

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(323571001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 12
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323571002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 323571002
		arg_8_1.duration_ = 1.3

		local var_8_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play323571003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1033ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1033ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1033ui_story == nil then
				arg_8_1.var_.characterEffect1033ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1033ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1033ui_story then
				arg_8_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_11_9 = 0
			local var_11_10 = 0.075

			if var_11_9 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_11 = arg_8_1:FormatText(StoryNameCfg[1450].name)

				arg_8_1.leftNameTxt_.text = var_11_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_12 = arg_8_1:GetWordFromCfg(323571002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 3
				local var_11_15 = utf8.len(var_11_13)
				local var_11_16 = var_11_14 <= 0 and var_11_10 or var_11_10 * (var_11_15 / var_11_14)

				if var_11_16 > 0 and var_11_10 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_9
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571002", "story_v_out_323571.awb") ~= 0 then
					local var_11_17 = manager.audio:GetVoiceLength("story_v_out_323571", "323571002", "story_v_out_323571.awb") / 1000

					if var_11_17 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_9
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_323571", "323571002", "story_v_out_323571.awb")

						arg_8_1:RecordAudio("323571002", var_11_18)
						arg_8_1:RecordAudio("323571002", var_11_18)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_323571", "323571002", "story_v_out_323571.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_323571", "323571002", "story_v_out_323571.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_19 = math.max(var_11_10, arg_8_1.talkMaxDuration)

			if var_11_9 <= arg_8_1.time_ and arg_8_1.time_ < var_11_9 + var_11_19 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_9) / var_11_19

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_9 + var_11_19 and arg_8_1.time_ < var_11_9 + var_11_19 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play323571003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 323571003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play323571004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1033ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1033ui_story == nil then
				arg_12_1.var_.characterEffect1033ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1033ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1033ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1033ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1033ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.1

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(323571003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 4
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play323571004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 323571004
		arg_16_1.duration_ = 6.63

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play323571005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = manager.ui.mainCamera.transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				local var_19_2 = arg_16_1.var_.effect3334
				local var_19_3
				local var_19_4 = var_19_0

				if not var_19_2 then
					var_19_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), var_19_4)
					var_19_2.name = "3334"
					arg_16_1.var_.effect3334 = var_19_2
				else
					var_19_2.transform:SetParent(var_19_4)
				end

				var_19_2.transform.localPosition = Vector3.New(0, 0.28, 1.31)
				var_19_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_6 = 1.9

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_7 = 1.63333333333333
			local var_19_8 = 1.125

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_9 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_9:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(323571004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_12 = 45
				local var_19_13 = utf8.len(var_19_11)
				local var_19_14 = var_19_12 <= 0 and var_19_8 or var_19_8 * (var_19_13 / var_19_12)

				if var_19_14 > 0 and var_19_8 < var_19_14 then
					arg_16_1.talkMaxDuration = var_19_14
					var_19_7 = var_19_7 + 0.3

					if var_19_14 + var_19_7 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_7
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_15 = var_19_7 + 0.3
			local var_19_16 = math.max(var_19_8, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play323571005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 323571005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play323571006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 1.075

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_2 = arg_22_1:GetWordFromCfg(323571005)
				local var_25_3 = arg_22_1:FormatText(var_25_2.content)

				arg_22_1.text_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 43
				local var_25_5 = utf8.len(var_25_3)
				local var_25_6 = var_25_4 <= 0 and var_25_1 or var_25_1 * (var_25_5 / var_25_4)

				if var_25_6 > 0 and var_25_1 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_3
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_7 and arg_22_1.time_ < var_25_0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play323571006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 323571006
		arg_26_1.duration_ = 2.2

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play323571007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "10170ui_story"

			if arg_26_1.actors_[var_29_0] == nil then
				local var_29_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_29_1) then
					local var_29_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_26_1.stage_.transform)

					var_29_2.name = var_29_0
					var_29_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_26_1.actors_[var_29_0] = var_29_2

					local var_29_3 = var_29_2:GetComponentInChildren(typeof(CharacterEffect))

					var_29_3.enabled = true

					local var_29_4 = GameObjectTools.GetOrAddComponent(var_29_2, typeof(DynamicBoneHelper))

					if var_29_4 then
						var_29_4:EnableDynamicBone(false)
					end

					arg_26_1:ShowWeapon(var_29_3.transform, false)

					arg_26_1.var_[var_29_0 .. "Animator"] = var_29_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_26_1.var_[var_29_0 .. "Animator"].applyRootMotion = true
					arg_26_1.var_[var_29_0 .. "LipSync"] = var_29_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_29_5 = arg_26_1.actors_["10170ui_story"].transform
			local var_29_6 = 0

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.var_.moveOldPos10170ui_story = var_29_5.localPosition

				local var_29_7 = GameObjectTools.GetOrAddComponent(var_29_5.gameObject, typeof(DynamicBoneHelper))

				if var_29_7 then
					var_29_7:EnableDynamicBone(false)
				end
			end

			local var_29_8 = 0.001

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_8 then
				local var_29_9 = (arg_26_1.time_ - var_29_6) / var_29_8
				local var_29_10 = Vector3.New(0, -1.03, -6.05)

				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10170ui_story, var_29_10, var_29_9)

				local var_29_11 = manager.ui.mainCamera.transform.position - var_29_5.position

				var_29_5.forward = Vector3.New(var_29_11.x, var_29_11.y, var_29_11.z)

				local var_29_12 = var_29_5.localEulerAngles

				var_29_12.z = 0
				var_29_12.x = 0
				var_29_5.localEulerAngles = var_29_12
			end

			if arg_26_1.time_ >= var_29_6 + var_29_8 and arg_26_1.time_ < var_29_6 + var_29_8 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_29_13 = manager.ui.mainCamera.transform.position - var_29_5.position

				var_29_5.forward = Vector3.New(var_29_13.x, var_29_13.y, var_29_13.z)

				local var_29_14 = var_29_5.localEulerAngles

				var_29_14.z = 0
				var_29_14.x = 0
				var_29_5.localEulerAngles = var_29_14

				local var_29_15 = GameObjectTools.GetOrAddComponent(var_29_5.gameObject, typeof(DynamicBoneHelper))

				if var_29_15 then
					var_29_15:EnableDynamicBone(true)
				end
			end

			local var_29_16 = arg_26_1.actors_["10170ui_story"]
			local var_29_17 = 0

			if var_29_17 < arg_26_1.time_ and arg_26_1.time_ <= var_29_17 + arg_29_0 and not isNil(var_29_16) and arg_26_1.var_.characterEffect10170ui_story == nil then
				arg_26_1.var_.characterEffect10170ui_story = var_29_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_18 = 0.200000002980232

			if var_29_17 <= arg_26_1.time_ and arg_26_1.time_ < var_29_17 + var_29_18 and not isNil(var_29_16) then
				local var_29_19 = (arg_26_1.time_ - var_29_17) / var_29_18

				if arg_26_1.var_.characterEffect10170ui_story and not isNil(var_29_16) then
					arg_26_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_17 + var_29_18 and arg_26_1.time_ < var_29_17 + var_29_18 + arg_29_0 and not isNil(var_29_16) and arg_26_1.var_.characterEffect10170ui_story then
				arg_26_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_29_20 = 0

			if var_29_20 < arg_26_1.time_ and arg_26_1.time_ <= var_29_20 + arg_29_0 then
				arg_26_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_29_21 = 0

			if var_29_21 < arg_26_1.time_ and arg_26_1.time_ <= var_29_21 + arg_29_0 then
				arg_26_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action28_1")
			end

			local var_29_22 = 0
			local var_29_23 = 0.425

			if var_29_22 < arg_26_1.time_ and arg_26_1.time_ <= var_29_22 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_24 = arg_26_1:FormatText(StoryNameCfg[1450].name)

				arg_26_1.leftNameTxt_.text = var_29_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_25 = arg_26_1:GetWordFromCfg(323571006)
				local var_29_26 = arg_26_1:FormatText(var_29_25.content)

				arg_26_1.text_.text = var_29_26

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_27 = 17
				local var_29_28 = utf8.len(var_29_26)
				local var_29_29 = var_29_27 <= 0 and var_29_23 or var_29_23 * (var_29_28 / var_29_27)

				if var_29_29 > 0 and var_29_23 < var_29_29 then
					arg_26_1.talkMaxDuration = var_29_29

					if var_29_29 + var_29_22 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_29 + var_29_22
					end
				end

				arg_26_1.text_.text = var_29_26
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571006", "story_v_out_323571.awb") ~= 0 then
					local var_29_30 = manager.audio:GetVoiceLength("story_v_out_323571", "323571006", "story_v_out_323571.awb") / 1000

					if var_29_30 + var_29_22 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_30 + var_29_22
					end

					if var_29_25.prefab_name ~= "" and arg_26_1.actors_[var_29_25.prefab_name] ~= nil then
						local var_29_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_25.prefab_name].transform, "story_v_out_323571", "323571006", "story_v_out_323571.awb")

						arg_26_1:RecordAudio("323571006", var_29_31)
						arg_26_1:RecordAudio("323571006", var_29_31)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_323571", "323571006", "story_v_out_323571.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_323571", "323571006", "story_v_out_323571.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_32 = math.max(var_29_23, arg_26_1.talkMaxDuration)

			if var_29_22 <= arg_26_1.time_ and arg_26_1.time_ < var_29_22 + var_29_32 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_22) / var_29_32

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_22 + var_29_32 and arg_26_1.time_ < var_29_22 + var_29_32 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play323571007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323571007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play323571008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10170ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10170ui_story == nil then
				arg_30_1.var_.characterEffect10170ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect10170ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_30_1.var_.characterEffect10170ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10170ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_30_1.var_.characterEffect10170ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 1.5

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_9 = arg_30_1:GetWordFromCfg(323571007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 60
				local var_33_12 = utf8.len(var_33_10)
				local var_33_13 = var_33_11 <= 0 and var_33_7 or var_33_7 * (var_33_12 / var_33_11)

				if var_33_13 > 0 and var_33_7 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_10
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_14 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_14 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_14

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_14 and arg_30_1.time_ < var_33_6 + var_33_14 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play323571008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 323571008
		arg_34_1.duration_ = 3.27

		local var_34_0 = {
			zh = 2.166,
			ja = 3.266
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play323571009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10170ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10170ui_story == nil then
				arg_34_1.var_.characterEffect10170ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect10170ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10170ui_story then
				arg_34_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_37_4 = 0
			local var_37_5 = 0.375

			if var_37_4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_6 = arg_34_1:FormatText(StoryNameCfg[1450].name)

				arg_34_1.leftNameTxt_.text = var_37_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:GetWordFromCfg(323571008)
				local var_37_8 = arg_34_1:FormatText(var_37_7.content)

				arg_34_1.text_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 15
				local var_37_10 = utf8.len(var_37_8)
				local var_37_11 = var_37_9 <= 0 and var_37_5 or var_37_5 * (var_37_10 / var_37_9)

				if var_37_11 > 0 and var_37_5 < var_37_11 then
					arg_34_1.talkMaxDuration = var_37_11

					if var_37_11 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_8
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571008", "story_v_out_323571.awb") ~= 0 then
					local var_37_12 = manager.audio:GetVoiceLength("story_v_out_323571", "323571008", "story_v_out_323571.awb") / 1000

					if var_37_12 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_12 + var_37_4
					end

					if var_37_7.prefab_name ~= "" and arg_34_1.actors_[var_37_7.prefab_name] ~= nil then
						local var_37_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_7.prefab_name].transform, "story_v_out_323571", "323571008", "story_v_out_323571.awb")

						arg_34_1:RecordAudio("323571008", var_37_13)
						arg_34_1:RecordAudio("323571008", var_37_13)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_323571", "323571008", "story_v_out_323571.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_323571", "323571008", "story_v_out_323571.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_14 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_14 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_14

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_14 and arg_34_1.time_ < var_37_4 + var_37_14 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play323571009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 323571009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play323571010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10170ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10170ui_story == nil then
				arg_38_1.var_.characterEffect10170ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect10170ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_38_1.var_.characterEffect10170ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10170ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_38_1.var_.characterEffect10170ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.3

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(323571009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 12
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play323571010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 323571010
		arg_42_1.duration_ = 3.2

		local var_42_0 = {
			zh = 2.633,
			ja = 3.2
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play323571011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10170ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10170ui_story == nil then
				arg_42_1.var_.characterEffect10170ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10170ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10170ui_story then
				arg_42_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_45_4 = 0

			if var_45_4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action28_2")
			end

			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_7 = 1.25

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_8 = 1
			local var_45_9 = 0.25

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_10 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_10:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_11 = arg_42_1:FormatText(StoryNameCfg[1450].name)

				arg_42_1.leftNameTxt_.text = var_45_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_12 = arg_42_1:GetWordFromCfg(323571010)
				local var_45_13 = arg_42_1:FormatText(var_45_12.content)

				arg_42_1.text_.text = var_45_13

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_14 = 10
				local var_45_15 = utf8.len(var_45_13)
				local var_45_16 = var_45_14 <= 0 and var_45_9 or var_45_9 * (var_45_15 / var_45_14)

				if var_45_16 > 0 and var_45_9 < var_45_16 then
					arg_42_1.talkMaxDuration = var_45_16
					var_45_8 = var_45_8 + 0.3

					if var_45_16 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_13
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571010", "story_v_out_323571.awb") ~= 0 then
					local var_45_17 = manager.audio:GetVoiceLength("story_v_out_323571", "323571010", "story_v_out_323571.awb") / 1000

					if var_45_17 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_8
					end

					if var_45_12.prefab_name ~= "" and arg_42_1.actors_[var_45_12.prefab_name] ~= nil then
						local var_45_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_12.prefab_name].transform, "story_v_out_323571", "323571010", "story_v_out_323571.awb")

						arg_42_1:RecordAudio("323571010", var_45_18)
						arg_42_1:RecordAudio("323571010", var_45_18)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_323571", "323571010", "story_v_out_323571.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_323571", "323571010", "story_v_out_323571.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_19 = var_45_8 + 0.3
			local var_45_20 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_19 <= arg_42_1.time_ and arg_42_1.time_ < var_45_19 + var_45_20 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_19) / var_45_20

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_19 + var_45_20 and arg_42_1.time_ < var_45_19 + var_45_20 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play323571011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 323571011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play323571012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10170ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10170ui_story == nil then
				arg_48_1.var_.characterEffect10170ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10170ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10170ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10170ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10170ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.375

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(323571011)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 15
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play323571012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 323571012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play323571013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10170ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos10170ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10170ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = 0
			local var_55_12 = 1.2

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_13 = arg_52_1:GetWordFromCfg(323571012)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 48
				local var_55_16 = utf8.len(var_55_14)
				local var_55_17 = var_55_15 <= 0 and var_55_12 or var_55_12 * (var_55_16 / var_55_15)

				if var_55_17 > 0 and var_55_12 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17

					if var_55_17 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_11
					end
				end

				arg_52_1.text_.text = var_55_14
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_18 = math.max(var_55_12, arg_52_1.talkMaxDuration)

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_18 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_11) / var_55_18

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_11 + var_55_18 and arg_52_1.time_ < var_55_11 + var_55_18 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play323571013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 323571013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play323571014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.425

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(323571013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 17
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play323571014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 323571014
		arg_60_1.duration_ = 4.57

		local var_60_0 = {
			zh = 3.69933333333333,
			ja = 4.56633333333333
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
				arg_60_0:Play323571015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "J16f"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 1.23333333333333

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.J16f

				var_63_5.transform.localPosition = var_63_4
				var_63_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_6 = var_63_5:GetComponent("SpriteRenderer")

				if var_63_6 and var_63_6.sprite then
					local var_63_7 = (var_63_5.transform.localPosition - var_63_3).z
					local var_63_8 = manager.ui.mainCameraCom_
					local var_63_9 = 2 * var_63_7 * Mathf.Tan(var_63_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_10 = var_63_9 * var_63_8.aspect
					local var_63_11 = var_63_6.sprite.bounds.size.x
					local var_63_12 = var_63_6.sprite.bounds.size.y
					local var_63_13 = var_63_10 / var_63_11
					local var_63_14 = var_63_9 / var_63_12
					local var_63_15 = var_63_14 < var_63_13 and var_63_13 or var_63_14

					var_63_5.transform.localScale = Vector3.New(var_63_15, var_63_15, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "J16f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_17 = 0.3

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_19 = 1.23333333333333

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_18) / var_63_19
				local var_63_21 = Color.New(0, 0, 0)

				var_63_21.a = Mathf.Lerp(0, 1, var_63_20)
				arg_60_1.mask_.color = var_63_21
			end

			if arg_60_1.time_ >= var_63_18 + var_63_19 and arg_60_1.time_ < var_63_18 + var_63_19 + arg_63_0 then
				local var_63_22 = Color.New(0, 0, 0)

				var_63_22.a = 1
				arg_60_1.mask_.color = var_63_22
			end

			local var_63_23 = 1.23333333333333

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_24 = 1.66666666666667

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24
				local var_63_26 = Color.New(0, 0, 0)

				var_63_26.a = Mathf.Lerp(1, 0, var_63_25)
				arg_60_1.mask_.color = var_63_26
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 then
				local var_63_27 = Color.New(0, 0, 0)
				local var_63_28 = 0

				arg_60_1.mask_.enabled = false
				var_63_27.a = var_63_28
				arg_60_1.mask_.color = var_63_27
			end

			local var_63_29 = arg_60_1.actors_["10170ui_story"].transform
			local var_63_30 = 1.23333333333333

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.var_.moveOldPos10170ui_story = var_63_29.localPosition

				local var_63_31 = GameObjectTools.GetOrAddComponent(var_63_29.gameObject, typeof(DynamicBoneHelper))

				if var_63_31 then
					var_63_31:EnableDynamicBone(false)
				end
			end

			local var_63_32 = 0.001

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_32 then
				local var_63_33 = (arg_60_1.time_ - var_63_30) / var_63_32
				local var_63_34 = Vector3.New(0, 100, 0)

				var_63_29.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10170ui_story, var_63_34, var_63_33)

				local var_63_35 = manager.ui.mainCamera.transform.position - var_63_29.position

				var_63_29.forward = Vector3.New(var_63_35.x, var_63_35.y, var_63_35.z)

				local var_63_36 = var_63_29.localEulerAngles

				var_63_36.z = 0
				var_63_36.x = 0
				var_63_29.localEulerAngles = var_63_36
			end

			if arg_60_1.time_ >= var_63_30 + var_63_32 and arg_60_1.time_ < var_63_30 + var_63_32 + arg_63_0 then
				var_63_29.localPosition = Vector3.New(0, 100, 0)

				local var_63_37 = manager.ui.mainCamera.transform.position - var_63_29.position

				var_63_29.forward = Vector3.New(var_63_37.x, var_63_37.y, var_63_37.z)

				local var_63_38 = var_63_29.localEulerAngles

				var_63_38.z = 0
				var_63_38.x = 0
				var_63_29.localEulerAngles = var_63_38

				local var_63_39 = GameObjectTools.GetOrAddComponent(var_63_29.gameObject, typeof(DynamicBoneHelper))

				if var_63_39 then
					var_63_39:EnableDynamicBone(true)
				end
			end

			local var_63_40 = 0.1
			local var_63_41 = 1

			if var_63_40 < arg_60_1.time_ and arg_60_1.time_ <= var_63_40 + arg_63_0 then
				local var_63_42 = "stop"
				local var_63_43 = "effect"

				arg_60_1:AudioAction(var_63_42, var_63_43, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_63_44 = 1
			local var_63_45 = 1

			if var_63_44 < arg_60_1.time_ and arg_60_1.time_ <= var_63_44 + arg_63_0 then
				local var_63_46 = "play"
				local var_63_47 = "effect"

				arg_60_1:AudioAction(var_63_46, var_63_47, "se_story_side_1058", "se_story_side_1058_forest", "")
			end

			local var_63_48 = manager.ui.mainCamera.transform
			local var_63_49 = 1.23333333333333

			if var_63_49 < arg_60_1.time_ and arg_60_1.time_ <= var_63_49 + arg_63_0 then
				local var_63_50 = arg_60_1.var_.effect3334

				if var_63_50 then
					Object.Destroy(var_63_50)

					arg_60_1.var_.effect3334 = nil
				end
			end

			local var_63_51 = manager.ui.mainCamera.transform
			local var_63_52 = 1.23333333333267

			if var_63_52 < arg_60_1.time_ and arg_60_1.time_ <= var_63_52 + arg_63_0 then
				local var_63_53 = arg_60_1.var_.effect3334

				if var_63_53 then
					Object.Destroy(var_63_53)

					arg_60_1.var_.effect3334 = nil
				end
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_54 = 2.73333333333333
			local var_63_55 = 0.05

			if var_63_54 < arg_60_1.time_ and arg_60_1.time_ <= var_63_54 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_56 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_56:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_57 = arg_60_1:FormatText(StoryNameCfg[1467].name)

				arg_60_1.leftNameTxt_.text = var_63_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_58 = arg_60_1:GetWordFromCfg(323571014)
				local var_63_59 = arg_60_1:FormatText(var_63_58.content)

				arg_60_1.text_.text = var_63_59

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_60 = 2
				local var_63_61 = utf8.len(var_63_59)
				local var_63_62 = var_63_60 <= 0 and var_63_55 or var_63_55 * (var_63_61 / var_63_60)

				if var_63_62 > 0 and var_63_55 < var_63_62 then
					arg_60_1.talkMaxDuration = var_63_62
					var_63_54 = var_63_54 + 0.3

					if var_63_62 + var_63_54 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_62 + var_63_54
					end
				end

				arg_60_1.text_.text = var_63_59
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571014", "story_v_out_323571.awb") ~= 0 then
					local var_63_63 = manager.audio:GetVoiceLength("story_v_out_323571", "323571014", "story_v_out_323571.awb") / 1000

					if var_63_63 + var_63_54 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_63 + var_63_54
					end

					if var_63_58.prefab_name ~= "" and arg_60_1.actors_[var_63_58.prefab_name] ~= nil then
						local var_63_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_58.prefab_name].transform, "story_v_out_323571", "323571014", "story_v_out_323571.awb")

						arg_60_1:RecordAudio("323571014", var_63_64)
						arg_60_1:RecordAudio("323571014", var_63_64)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_323571", "323571014", "story_v_out_323571.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_323571", "323571014", "story_v_out_323571.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_65 = var_63_54 + 0.3
			local var_63_66 = math.max(var_63_55, arg_60_1.talkMaxDuration)

			if var_63_65 <= arg_60_1.time_ and arg_60_1.time_ < var_63_65 + var_63_66 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_65) / var_63_66

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_65 + var_63_66 and arg_60_1.time_ < var_63_65 + var_63_66 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play323571015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 323571015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play323571016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.1

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(323571015)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 44
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play323571016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 323571016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play323571017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.425

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(323571016)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 57
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play323571017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 323571017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play323571018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.45

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(323571017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 18
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play323571018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 323571018
		arg_78_1.duration_ = 3.93

		local var_78_0 = {
			zh = 2.3,
			ja = 3.933
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play323571019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10170ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos10170ui_story = var_81_0.localPosition

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end
			end

			local var_81_3 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_3 then
				local var_81_4 = (arg_78_1.time_ - var_81_1) / var_81_3
				local var_81_5 = Vector3.New(0, -1.03, -6.05)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10170ui_story, var_81_5, var_81_4)

				local var_81_6 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_6.x, var_81_6.y, var_81_6.z)

				local var_81_7 = var_81_0.localEulerAngles

				var_81_7.z = 0
				var_81_7.x = 0
				var_81_0.localEulerAngles = var_81_7
			end

			if arg_78_1.time_ >= var_81_1 + var_81_3 and arg_78_1.time_ < var_81_1 + var_81_3 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_81_8 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_8.x, var_81_8.y, var_81_8.z)

				local var_81_9 = var_81_0.localEulerAngles

				var_81_9.z = 0
				var_81_9.x = 0
				var_81_0.localEulerAngles = var_81_9

				local var_81_10 = GameObjectTools.GetOrAddComponent(var_81_0.gameObject, typeof(DynamicBoneHelper))

				if var_81_10 then
					var_81_10:EnableDynamicBone(true)
				end
			end

			local var_81_11 = arg_78_1.actors_["10170ui_story"]
			local var_81_12 = 0

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 and not isNil(var_81_11) and arg_78_1.var_.characterEffect10170ui_story == nil then
				arg_78_1.var_.characterEffect10170ui_story = var_81_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_13 = 0.200000002980232

			if var_81_12 <= arg_78_1.time_ and arg_78_1.time_ < var_81_12 + var_81_13 and not isNil(var_81_11) then
				local var_81_14 = (arg_78_1.time_ - var_81_12) / var_81_13

				if arg_78_1.var_.characterEffect10170ui_story and not isNil(var_81_11) then
					arg_78_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_12 + var_81_13 and arg_78_1.time_ < var_81_12 + var_81_13 + arg_81_0 and not isNil(var_81_11) and arg_78_1.var_.characterEffect10170ui_story then
				arg_78_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_81_15 = 0

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_81_16 = 0

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_81_17 = 0
			local var_81_18 = 0.25

			if var_81_17 < arg_78_1.time_ and arg_78_1.time_ <= var_81_17 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_19 = arg_78_1:FormatText(StoryNameCfg[1450].name)

				arg_78_1.leftNameTxt_.text = var_81_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_20 = arg_78_1:GetWordFromCfg(323571018)
				local var_81_21 = arg_78_1:FormatText(var_81_20.content)

				arg_78_1.text_.text = var_81_21

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_22 = 10
				local var_81_23 = utf8.len(var_81_21)
				local var_81_24 = var_81_22 <= 0 and var_81_18 or var_81_18 * (var_81_23 / var_81_22)

				if var_81_24 > 0 and var_81_18 < var_81_24 then
					arg_78_1.talkMaxDuration = var_81_24

					if var_81_24 + var_81_17 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_17
					end
				end

				arg_78_1.text_.text = var_81_21
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571018", "story_v_out_323571.awb") ~= 0 then
					local var_81_25 = manager.audio:GetVoiceLength("story_v_out_323571", "323571018", "story_v_out_323571.awb") / 1000

					if var_81_25 + var_81_17 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_25 + var_81_17
					end

					if var_81_20.prefab_name ~= "" and arg_78_1.actors_[var_81_20.prefab_name] ~= nil then
						local var_81_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_20.prefab_name].transform, "story_v_out_323571", "323571018", "story_v_out_323571.awb")

						arg_78_1:RecordAudio("323571018", var_81_26)
						arg_78_1:RecordAudio("323571018", var_81_26)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_323571", "323571018", "story_v_out_323571.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_323571", "323571018", "story_v_out_323571.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_27 = math.max(var_81_18, arg_78_1.talkMaxDuration)

			if var_81_17 <= arg_78_1.time_ and arg_78_1.time_ < var_81_17 + var_81_27 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_17) / var_81_27

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_17 + var_81_27 and arg_78_1.time_ < var_81_17 + var_81_27 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play323571019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 323571019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play323571020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10170ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10170ui_story == nil then
				arg_82_1.var_.characterEffect10170ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10170ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_82_1.var_.characterEffect10170ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10170ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_82_1.var_.characterEffect10170ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 0.1

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_9 = arg_82_1:GetWordFromCfg(323571019)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 4
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play323571020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 323571020
		arg_86_1.duration_ = 9.87

		local var_86_0 = {
			zh = 6.466,
			ja = 9.866
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play323571021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10170ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10170ui_story == nil then
				arg_86_1.var_.characterEffect10170ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10170ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10170ui_story then
				arg_86_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_89_4 = 0
			local var_89_5 = 0.7

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_6 = arg_86_1:FormatText(StoryNameCfg[1450].name)

				arg_86_1.leftNameTxt_.text = var_89_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:GetWordFromCfg(323571020)
				local var_89_8 = arg_86_1:FormatText(var_89_7.content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 28
				local var_89_10 = utf8.len(var_89_8)
				local var_89_11 = var_89_9 <= 0 and var_89_5 or var_89_5 * (var_89_10 / var_89_9)

				if var_89_11 > 0 and var_89_5 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571020", "story_v_out_323571.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_323571", "323571020", "story_v_out_323571.awb") / 1000

					if var_89_12 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_4
					end

					if var_89_7.prefab_name ~= "" and arg_86_1.actors_[var_89_7.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_7.prefab_name].transform, "story_v_out_323571", "323571020", "story_v_out_323571.awb")

						arg_86_1:RecordAudio("323571020", var_89_13)
						arg_86_1:RecordAudio("323571020", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_323571", "323571020", "story_v_out_323571.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_323571", "323571020", "story_v_out_323571.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_14 and arg_86_1.time_ < var_89_4 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play323571021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 323571021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play323571022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10170ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10170ui_story == nil then
				arg_90_1.var_.characterEffect10170ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect10170ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10170ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10170ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10170ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.1

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(323571021)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 4
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play323571022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 323571022
		arg_94_1.duration_ = 3

		local var_94_0 = {
			zh = 1.999999999999,
			ja = 3
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play323571023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10170ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10170ui_story == nil then
				arg_94_1.var_.characterEffect10170ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10170ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10170ui_story then
				arg_94_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_97_4 = 0

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_1")
			end

			local var_97_6 = 0
			local var_97_7 = 0.175

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[1450].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_9 = arg_94_1:GetWordFromCfg(323571022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 7
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571022", "story_v_out_323571.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_323571", "323571022", "story_v_out_323571.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_323571", "323571022", "story_v_out_323571.awb")

						arg_94_1:RecordAudio("323571022", var_97_15)
						arg_94_1:RecordAudio("323571022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_323571", "323571022", "story_v_out_323571.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_323571", "323571022", "story_v_out_323571.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play323571023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 323571023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play323571024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10170ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10170ui_story == nil then
				arg_98_1.var_.characterEffect10170ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10170ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10170ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10170ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10170ui_story.fillRatio = var_101_5
			end

			local var_101_6 = arg_98_1.actors_["10170ui_story"].transform
			local var_101_7 = 0

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1.var_.moveOldPos10170ui_story = var_101_6.localPosition

				local var_101_8 = GameObjectTools.GetOrAddComponent(var_101_6.gameObject, typeof(DynamicBoneHelper))

				if var_101_8 then
					var_101_8:EnableDynamicBone(false)
				end
			end

			local var_101_9 = 0.001

			if var_101_7 <= arg_98_1.time_ and arg_98_1.time_ < var_101_7 + var_101_9 then
				local var_101_10 = (arg_98_1.time_ - var_101_7) / var_101_9
				local var_101_11 = Vector3.New(0, 100, 0)

				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10170ui_story, var_101_11, var_101_10)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_6.position

				var_101_6.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_6.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_6.localEulerAngles = var_101_13
			end

			if arg_98_1.time_ >= var_101_7 + var_101_9 and arg_98_1.time_ < var_101_7 + var_101_9 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(0, 100, 0)

				local var_101_14 = manager.ui.mainCamera.transform.position - var_101_6.position

				var_101_6.forward = Vector3.New(var_101_14.x, var_101_14.y, var_101_14.z)

				local var_101_15 = var_101_6.localEulerAngles

				var_101_15.z = 0
				var_101_15.x = 0
				var_101_6.localEulerAngles = var_101_15

				local var_101_16 = GameObjectTools.GetOrAddComponent(var_101_6.gameObject, typeof(DynamicBoneHelper))

				if var_101_16 then
					var_101_16:EnableDynamicBone(true)
				end
			end

			local var_101_17 = 0
			local var_101_18 = 0.925

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_19 = arg_98_1:GetWordFromCfg(323571023)
				local var_101_20 = arg_98_1:FormatText(var_101_19.content)

				arg_98_1.text_.text = var_101_20

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_21 = 36
				local var_101_22 = utf8.len(var_101_20)
				local var_101_23 = var_101_21 <= 0 and var_101_18 or var_101_18 * (var_101_22 / var_101_21)

				if var_101_23 > 0 and var_101_18 < var_101_23 then
					arg_98_1.talkMaxDuration = var_101_23

					if var_101_23 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_17
					end
				end

				arg_98_1.text_.text = var_101_20
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_24 = math.max(var_101_18, arg_98_1.talkMaxDuration)

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_24 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_17) / var_101_24

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_17 + var_101_24 and arg_98_1.time_ < var_101_17 + var_101_24 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play323571024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 323571024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play323571025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.225

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(323571024)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 9
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_8 and arg_102_1.time_ < var_105_0 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play323571025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 323571025
		arg_106_1.duration_ = 4.67

		local var_106_0 = {
			zh = 3.6,
			ja = 4.666
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play323571026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10170ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10170ui_story == nil then
				arg_106_1.var_.characterEffect10170ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10170ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10170ui_story then
				arg_106_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_109_4 = 0

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_109_6 = arg_106_1.actors_["10170ui_story"].transform
			local var_109_7 = 0

			if var_109_7 < arg_106_1.time_ and arg_106_1.time_ <= var_109_7 + arg_109_0 then
				arg_106_1.var_.moveOldPos10170ui_story = var_109_6.localPosition

				local var_109_8 = GameObjectTools.GetOrAddComponent(var_109_6.gameObject, typeof(DynamicBoneHelper))

				if var_109_8 then
					var_109_8:EnableDynamicBone(false)
				end
			end

			local var_109_9 = 0.001

			if var_109_7 <= arg_106_1.time_ and arg_106_1.time_ < var_109_7 + var_109_9 then
				local var_109_10 = (arg_106_1.time_ - var_109_7) / var_109_9
				local var_109_11 = Vector3.New(0, -1.03, -6.05)

				var_109_6.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10170ui_story, var_109_11, var_109_10)

				local var_109_12 = manager.ui.mainCamera.transform.position - var_109_6.position

				var_109_6.forward = Vector3.New(var_109_12.x, var_109_12.y, var_109_12.z)

				local var_109_13 = var_109_6.localEulerAngles

				var_109_13.z = 0
				var_109_13.x = 0
				var_109_6.localEulerAngles = var_109_13
			end

			if arg_106_1.time_ >= var_109_7 + var_109_9 and arg_106_1.time_ < var_109_7 + var_109_9 + arg_109_0 then
				var_109_6.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_109_14 = manager.ui.mainCamera.transform.position - var_109_6.position

				var_109_6.forward = Vector3.New(var_109_14.x, var_109_14.y, var_109_14.z)

				local var_109_15 = var_109_6.localEulerAngles

				var_109_15.z = 0
				var_109_15.x = 0
				var_109_6.localEulerAngles = var_109_15

				local var_109_16 = GameObjectTools.GetOrAddComponent(var_109_6.gameObject, typeof(DynamicBoneHelper))

				if var_109_16 then
					var_109_16:EnableDynamicBone(true)
				end
			end

			local var_109_17 = 0
			local var_109_18 = 0.45

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_19 = arg_106_1:FormatText(StoryNameCfg[1450].name)

				arg_106_1.leftNameTxt_.text = var_109_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_20 = arg_106_1:GetWordFromCfg(323571025)
				local var_109_21 = arg_106_1:FormatText(var_109_20.content)

				arg_106_1.text_.text = var_109_21

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_22 = 18
				local var_109_23 = utf8.len(var_109_21)
				local var_109_24 = var_109_22 <= 0 and var_109_18 or var_109_18 * (var_109_23 / var_109_22)

				if var_109_24 > 0 and var_109_18 < var_109_24 then
					arg_106_1.talkMaxDuration = var_109_24

					if var_109_24 + var_109_17 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_24 + var_109_17
					end
				end

				arg_106_1.text_.text = var_109_21
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571025", "story_v_out_323571.awb") ~= 0 then
					local var_109_25 = manager.audio:GetVoiceLength("story_v_out_323571", "323571025", "story_v_out_323571.awb") / 1000

					if var_109_25 + var_109_17 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_25 + var_109_17
					end

					if var_109_20.prefab_name ~= "" and arg_106_1.actors_[var_109_20.prefab_name] ~= nil then
						local var_109_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_20.prefab_name].transform, "story_v_out_323571", "323571025", "story_v_out_323571.awb")

						arg_106_1:RecordAudio("323571025", var_109_26)
						arg_106_1:RecordAudio("323571025", var_109_26)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_323571", "323571025", "story_v_out_323571.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_323571", "323571025", "story_v_out_323571.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_27 = math.max(var_109_18, arg_106_1.talkMaxDuration)

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_27 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_17) / var_109_27

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_17 + var_109_27 and arg_106_1.time_ < var_109_17 + var_109_27 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play323571026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 323571026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play323571027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10170ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10170ui_story == nil then
				arg_110_1.var_.characterEffect10170ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect10170ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10170ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10170ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10170ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.925

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_8 = arg_110_1:GetWordFromCfg(323571026)
				local var_113_9 = arg_110_1:FormatText(var_113_8.content)

				arg_110_1.text_.text = var_113_9

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_10 = 37
				local var_113_11 = utf8.len(var_113_9)
				local var_113_12 = var_113_10 <= 0 and var_113_7 or var_113_7 * (var_113_11 / var_113_10)

				if var_113_12 > 0 and var_113_7 < var_113_12 then
					arg_110_1.talkMaxDuration = var_113_12

					if var_113_12 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_9
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_13 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_13 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_13

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_13 and arg_110_1.time_ < var_113_6 + var_113_13 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play323571027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 323571027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play323571028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10170ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos10170ui_story = var_117_0.localPosition

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end
			end

			local var_117_3 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_3 then
				local var_117_4 = (arg_114_1.time_ - var_117_1) / var_117_3
				local var_117_5 = Vector3.New(0, 100, 0)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10170ui_story, var_117_5, var_117_4)

				local var_117_6 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_6.x, var_117_6.y, var_117_6.z)

				local var_117_7 = var_117_0.localEulerAngles

				var_117_7.z = 0
				var_117_7.x = 0
				var_117_0.localEulerAngles = var_117_7
			end

			if arg_114_1.time_ >= var_117_1 + var_117_3 and arg_114_1.time_ < var_117_1 + var_117_3 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, 100, 0)

				local var_117_8 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_8.x, var_117_8.y, var_117_8.z)

				local var_117_9 = var_117_0.localEulerAngles

				var_117_9.z = 0
				var_117_9.x = 0
				var_117_0.localEulerAngles = var_117_9

				local var_117_10 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_10 then
					var_117_10:EnableDynamicBone(true)
				end
			end

			local var_117_11 = 0
			local var_117_12 = 1.275

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_13 = arg_114_1:GetWordFromCfg(323571027)
				local var_117_14 = arg_114_1:FormatText(var_117_13.content)

				arg_114_1.text_.text = var_117_14

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_15 = 51
				local var_117_16 = utf8.len(var_117_14)
				local var_117_17 = var_117_15 <= 0 and var_117_12 or var_117_12 * (var_117_16 / var_117_15)

				if var_117_17 > 0 and var_117_12 < var_117_17 then
					arg_114_1.talkMaxDuration = var_117_17

					if var_117_17 + var_117_11 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_17 + var_117_11
					end
				end

				arg_114_1.text_.text = var_117_14
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_18 = math.max(var_117_12, arg_114_1.talkMaxDuration)

			if var_117_11 <= arg_114_1.time_ and arg_114_1.time_ < var_117_11 + var_117_18 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_11) / var_117_18

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_11 + var_117_18 and arg_114_1.time_ < var_117_11 + var_117_18 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play323571028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 323571028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play323571029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.125

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(323571028)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 5
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_8 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_8 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_8

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_8 and arg_118_1.time_ < var_121_0 + var_121_8 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play323571029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 323571029
		arg_122_1.duration_ = 2

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play323571030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10170ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos10170ui_story = var_125_0.localPosition

				local var_125_2 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(false)
				end
			end

			local var_125_3 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_3 then
				local var_125_4 = (arg_122_1.time_ - var_125_1) / var_125_3
				local var_125_5 = Vector3.New(0, -1.03, -6.05)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10170ui_story, var_125_5, var_125_4)

				local var_125_6 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_6.x, var_125_6.y, var_125_6.z)

				local var_125_7 = var_125_0.localEulerAngles

				var_125_7.z = 0
				var_125_7.x = 0
				var_125_0.localEulerAngles = var_125_7
			end

			if arg_122_1.time_ >= var_125_1 + var_125_3 and arg_122_1.time_ < var_125_1 + var_125_3 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_125_8 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_8.x, var_125_8.y, var_125_8.z)

				local var_125_9 = var_125_0.localEulerAngles

				var_125_9.z = 0
				var_125_9.x = 0
				var_125_0.localEulerAngles = var_125_9

				local var_125_10 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_10 then
					var_125_10:EnableDynamicBone(true)
				end
			end

			local var_125_11 = arg_122_1.actors_["10170ui_story"]
			local var_125_12 = 0

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect10170ui_story == nil then
				arg_122_1.var_.characterEffect10170ui_story = var_125_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_13 = 0.200000002980232

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_13 and not isNil(var_125_11) then
				local var_125_14 = (arg_122_1.time_ - var_125_12) / var_125_13

				if arg_122_1.var_.characterEffect10170ui_story and not isNil(var_125_11) then
					arg_122_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_12 + var_125_13 and arg_122_1.time_ < var_125_12 + var_125_13 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect10170ui_story then
				arg_122_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_125_15 = 0

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_125_17 = 0
			local var_125_18 = 0.2

			if var_125_17 < arg_122_1.time_ and arg_122_1.time_ <= var_125_17 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_19 = arg_122_1:FormatText(StoryNameCfg[1450].name)

				arg_122_1.leftNameTxt_.text = var_125_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_20 = arg_122_1:GetWordFromCfg(323571029)
				local var_125_21 = arg_122_1:FormatText(var_125_20.content)

				arg_122_1.text_.text = var_125_21

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_22 = 8
				local var_125_23 = utf8.len(var_125_21)
				local var_125_24 = var_125_22 <= 0 and var_125_18 or var_125_18 * (var_125_23 / var_125_22)

				if var_125_24 > 0 and var_125_18 < var_125_24 then
					arg_122_1.talkMaxDuration = var_125_24

					if var_125_24 + var_125_17 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_24 + var_125_17
					end
				end

				arg_122_1.text_.text = var_125_21
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323571", "323571029", "story_v_out_323571.awb") ~= 0 then
					local var_125_25 = manager.audio:GetVoiceLength("story_v_out_323571", "323571029", "story_v_out_323571.awb") / 1000

					if var_125_25 + var_125_17 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_25 + var_125_17
					end

					if var_125_20.prefab_name ~= "" and arg_122_1.actors_[var_125_20.prefab_name] ~= nil then
						local var_125_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_20.prefab_name].transform, "story_v_out_323571", "323571029", "story_v_out_323571.awb")

						arg_122_1:RecordAudio("323571029", var_125_26)
						arg_122_1:RecordAudio("323571029", var_125_26)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_323571", "323571029", "story_v_out_323571.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_323571", "323571029", "story_v_out_323571.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_27 = math.max(var_125_18, arg_122_1.talkMaxDuration)

			if var_125_17 <= arg_122_1.time_ and arg_122_1.time_ < var_125_17 + var_125_27 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_17) / var_125_27

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_17 + var_125_27 and arg_122_1.time_ < var_125_17 + var_125_27 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play323571030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 323571030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play323571031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10170ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10170ui_story == nil then
				arg_126_1.var_.characterEffect10170ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect10170ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10170ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10170ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10170ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.125

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(323571030)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 5
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play323571031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 323571031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play323571032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10170ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos10170ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10170ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = 0
			local var_133_12 = 1.625

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_13 = arg_130_1:GetWordFromCfg(323571031)
				local var_133_14 = arg_130_1:FormatText(var_133_13.content)

				arg_130_1.text_.text = var_133_14

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_15 = 65
				local var_133_16 = utf8.len(var_133_14)
				local var_133_17 = var_133_15 <= 0 and var_133_12 or var_133_12 * (var_133_16 / var_133_15)

				if var_133_17 > 0 and var_133_12 < var_133_17 then
					arg_130_1.talkMaxDuration = var_133_17

					if var_133_17 + var_133_11 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_17 + var_133_11
					end
				end

				arg_130_1.text_.text = var_133_14
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_18 = math.max(var_133_12, arg_130_1.talkMaxDuration)

			if var_133_11 <= arg_130_1.time_ and arg_130_1.time_ < var_133_11 + var_133_18 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_11) / var_133_18

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_11 + var_133_18 and arg_130_1.time_ < var_133_11 + var_133_18 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play323571032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 323571032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
			arg_134_1.auto_ = false
		end

		function arg_134_1.playNext_(arg_136_0)
			arg_134_1.onStoryFinished_()
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.375

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(323571032)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 15
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2015a",
		"TextureConfig/Background/J16f"
	},
	voices = {
		"story_v_out_323571.awb"
	}
}
