return {
	Play103042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103042001
		arg_1_1.duration_ = 6.13

		local var_1_0 = {
			ja = 5.566,
			ko = 4.966,
			zh = 6.133,
			en = 6
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
				arg_1_0:Play103042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = 0

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_10) / var_4_11
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(1, 0, var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)
				local var_4_15 = 0

				arg_1_1.mask_.enabled = false
				var_4_14.a = var_4_15
				arg_1_1.mask_.color = var_4_14
			end

			local var_4_16 = "B08b"

			if arg_1_1.bgs_[var_4_16] == nil then
				local var_4_17 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_16)
				var_4_17.name = var_4_16
				var_4_17.transform.parent = arg_1_1.stage_.transform
				var_4_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_16] = var_4_17
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = manager.ui.mainCamera.transform.localPosition
				local var_4_20 = Vector3.New(0, 0, 10) + Vector3.New(var_4_19.x, var_4_19.y, 0)
				local var_4_21 = arg_1_1.bgs_.B08b

				var_4_21.transform.localPosition = var_4_20
				var_4_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_22 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_22 and var_4_22.sprite then
					local var_4_23 = (var_4_21.transform.localPosition - var_4_19).z
					local var_4_24 = manager.ui.mainCameraCom_
					local var_4_25 = 2 * var_4_23 * Mathf.Tan(var_4_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_26 = var_4_25 * var_4_24.aspect
					local var_4_27 = var_4_22.sprite.bounds.size.x
					local var_4_28 = var_4_22.sprite.bounds.size.y
					local var_4_29 = var_4_26 / var_4_27
					local var_4_30 = var_4_25 / var_4_28
					local var_4_31 = var_4_30 < var_4_29 and var_4_29 or var_4_30

					var_4_21.transform.localScale = Vector3.New(var_4_31, var_4_31, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 0.35

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_35 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_36 = arg_1_1:GetWordFromCfg(103042001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 14
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_33 or var_4_33 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_33 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_32 = var_4_32 + 0.3

					if var_4_40 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042001", "story_v_out_103042.awb") ~= 0 then
					local var_4_41 = manager.audio:GetVoiceLength("story_v_out_103042", "103042001", "story_v_out_103042.awb") / 1000

					if var_4_41 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_32
					end

					if var_4_36.prefab_name ~= "" and arg_1_1.actors_[var_4_36.prefab_name] ~= nil then
						local var_4_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_36.prefab_name].transform, "story_v_out_103042", "103042001", "story_v_out_103042.awb")

						arg_1_1:RecordAudio("103042001", var_4_42)
						arg_1_1:RecordAudio("103042001", var_4_42)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103042", "103042001", "story_v_out_103042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103042", "103042001", "story_v_out_103042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_32 + 0.3
			local var_4_44 = math.max(var_4_33, arg_1_1.talkMaxDuration)

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
	Play103042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103042002
		arg_8_1.duration_ = 9.27

		local var_8_0 = {
			ja = 9.266,
			ko = 4.633,
			zh = 5.266,
			en = 5.9
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
				arg_8_0:Play103042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.45

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[42].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(103042002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 18
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042002", "story_v_out_103042.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_103042", "103042002", "story_v_out_103042.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_103042", "103042002", "story_v_out_103042.awb")

						arg_8_1:RecordAudio("103042002", var_11_9)
						arg_8_1:RecordAudio("103042002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103042", "103042002", "story_v_out_103042.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103042", "103042002", "story_v_out_103042.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play103042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103042003
		arg_12_1.duration_ = 4.47

		local var_12_0 = {
			ja = 4.1,
			ko = 4.4,
			zh = 2.966,
			en = 4.466
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play103042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1084ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.325

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(103042003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042003", "story_v_out_103042.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_103042", "103042003", "story_v_out_103042.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_103042", "103042003", "story_v_out_103042.awb")

						arg_12_1:RecordAudio("103042003", var_15_15)
						arg_12_1:RecordAudio("103042003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103042", "103042003", "story_v_out_103042.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103042", "103042003", "story_v_out_103042.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play103042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103042004
		arg_16_1.duration_ = 12.8

		local var_16_0 = {
			ja = 9.433,
			ko = 12,
			zh = 12.8,
			en = 12.666
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
				arg_16_0:Play103042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.075

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[42].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(103042004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042004", "story_v_out_103042.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_103042", "103042004", "story_v_out_103042.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_103042", "103042004", "story_v_out_103042.awb")

						arg_16_1:RecordAudio("103042004", var_19_9)
						arg_16_1:RecordAudio("103042004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103042", "103042004", "story_v_out_103042.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103042", "103042004", "story_v_out_103042.awb")
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
	Play103042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103042005
		arg_20_1.duration_ = 2.5

		local var_20_0 = {
			ja = 1.999999999999,
			ko = 2.5,
			zh = 2.233,
			en = 2.5
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
				arg_20_0:Play103042006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "3008ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["3008ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect3008ui_story == nil then
				arg_20_1.var_.characterEffect3008ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect3008ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect3008ui_story then
				arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["3008ui_story"].transform
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.var_.moveOldPos3008ui_story = var_23_9.localPosition
			end

			local var_23_11 = 0.001

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11
				local var_23_13 = Vector3.New(0, -1.51, -4.3)

				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3008ui_story, var_23_13, var_23_12)

				local var_23_14 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_14.x, var_23_14.y, var_23_14.z)

				local var_23_15 = var_23_9.localEulerAngles

				var_23_15.z = 0
				var_23_15.x = 0
				var_23_9.localEulerAngles = var_23_15
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_23_16 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_16.x, var_23_16.y, var_23_16.z)

				local var_23_17 = var_23_9.localEulerAngles

				var_23_17.z = 0
				var_23_17.x = 0
				var_23_9.localEulerAngles = var_23_17
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_20 = 0
			local var_23_21 = 0.2

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[20].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(103042005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042005", "story_v_out_103042.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_out_103042", "103042005", "story_v_out_103042.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_103042", "103042005", "story_v_out_103042.awb")

						arg_20_1:RecordAudio("103042005", var_23_29)
						arg_20_1:RecordAudio("103042005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_103042", "103042005", "story_v_out_103042.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_103042", "103042005", "story_v_out_103042.awb")
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play103042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103042006
		arg_24_1.duration_ = 4.87

		local var_24_0 = {
			ja = 4.866,
			ko = 4.4,
			zh = 3.9,
			en = 3.6
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play103042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action442")
			end

			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_2 = 0
			local var_27_3 = 0.45

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_4 = arg_24_1:FormatText(StoryNameCfg[20].name)

				arg_24_1.leftNameTxt_.text = var_27_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:GetWordFromCfg(103042006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 18
				local var_27_8 = utf8.len(var_27_6)
				local var_27_9 = var_27_7 <= 0 and var_27_3 or var_27_3 * (var_27_8 / var_27_7)

				if var_27_9 > 0 and var_27_3 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042006", "story_v_out_103042.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_103042", "103042006", "story_v_out_103042.awb") / 1000

					if var_27_10 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_2
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_103042", "103042006", "story_v_out_103042.awb")

						arg_24_1:RecordAudio("103042006", var_27_11)
						arg_24_1:RecordAudio("103042006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103042", "103042006", "story_v_out_103042.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103042", "103042006", "story_v_out_103042.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_12 and arg_24_1.time_ < var_27_2 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play103042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103042007
		arg_28_1.duration_ = 3.3

		local var_28_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play103042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1019ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1019ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["3008ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.1

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_9) then
					local var_31_13 = Mathf.Lerp(0, 0.5, var_31_12)

					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_13
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect3008ui_story then
				local var_31_14 = 0.5

				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_14
			end

			local var_31_15 = arg_28_1.actors_["3008ui_story"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos3008ui_story = var_31_15.localPosition
			end

			local var_31_17 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Vector3.New(0, 100, 0)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3008ui_story, var_31_19, var_31_18)

				local var_31_20 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_20.x, var_31_20.y, var_31_20.z)

				local var_31_21 = var_31_15.localEulerAngles

				var_31_21.z = 0
				var_31_21.x = 0
				var_31_15.localEulerAngles = var_31_21
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(0, 100, 0)

				local var_31_22 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_22.x, var_31_22.y, var_31_22.z)

				local var_31_23 = var_31_15.localEulerAngles

				var_31_23.z = 0
				var_31_23.x = 0
				var_31_15.localEulerAngles = var_31_23
			end

			local var_31_24 = 0

			if var_31_24 < arg_28_1.time_ and arg_28_1.time_ <= var_31_24 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_31_25 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_26 = 0

			if var_31_26 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_25.localPosition
			end

			local var_31_27 = 0.001

			if var_31_26 <= arg_28_1.time_ and arg_28_1.time_ < var_31_26 + var_31_27 then
				local var_31_28 = (arg_28_1.time_ - var_31_26) / var_31_27
				local var_31_29 = Vector3.New(-0.7, -1.08, -5.9)

				var_31_25.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_29, var_31_28)

				local var_31_30 = manager.ui.mainCamera.transform.position - var_31_25.position

				var_31_25.forward = Vector3.New(var_31_30.x, var_31_30.y, var_31_30.z)

				local var_31_31 = var_31_25.localEulerAngles

				var_31_31.z = 0
				var_31_31.x = 0
				var_31_25.localEulerAngles = var_31_31
			end

			if arg_28_1.time_ >= var_31_26 + var_31_27 and arg_28_1.time_ < var_31_26 + var_31_27 + arg_31_0 then
				var_31_25.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_31_32 = manager.ui.mainCamera.transform.position - var_31_25.position

				var_31_25.forward = Vector3.New(var_31_32.x, var_31_32.y, var_31_32.z)

				local var_31_33 = var_31_25.localEulerAngles

				var_31_33.z = 0
				var_31_33.x = 0
				var_31_25.localEulerAngles = var_31_33
			end

			local var_31_34 = 0

			if var_31_34 < arg_28_1.time_ and arg_28_1.time_ <= var_31_34 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_31_35 = 0
			local var_31_36 = 0.075

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_37 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_38 = arg_28_1:GetWordFromCfg(103042007)
				local var_31_39 = arg_28_1:FormatText(var_31_38.content)

				arg_28_1.text_.text = var_31_39

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_40 = 3
				local var_31_41 = utf8.len(var_31_39)
				local var_31_42 = var_31_40 <= 0 and var_31_36 or var_31_36 * (var_31_41 / var_31_40)

				if var_31_42 > 0 and var_31_36 < var_31_42 then
					arg_28_1.talkMaxDuration = var_31_42

					if var_31_42 + var_31_35 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_42 + var_31_35
					end
				end

				arg_28_1.text_.text = var_31_39
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042007", "story_v_out_103042.awb") ~= 0 then
					local var_31_43 = manager.audio:GetVoiceLength("story_v_out_103042", "103042007", "story_v_out_103042.awb") / 1000

					if var_31_43 + var_31_35 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_43 + var_31_35
					end

					if var_31_38.prefab_name ~= "" and arg_28_1.actors_[var_31_38.prefab_name] ~= nil then
						local var_31_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_38.prefab_name].transform, "story_v_out_103042", "103042007", "story_v_out_103042.awb")

						arg_28_1:RecordAudio("103042007", var_31_44)
						arg_28_1:RecordAudio("103042007", var_31_44)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103042", "103042007", "story_v_out_103042.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103042", "103042007", "story_v_out_103042.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_45 = math.max(var_31_36, arg_28_1.talkMaxDuration)

			if var_31_35 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_45 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_35) / var_31_45

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_35 + var_31_45 and arg_28_1.time_ < var_31_35 + var_31_45 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play103042008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103042008
		arg_32_1.duration_ = 4.5

		local var_32_0 = {
			ja = 4.5,
			ko = 3,
			zh = 3.1,
			en = 3.933
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
				arg_32_0:Play103042009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1011ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1011ui_story"]
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1011ui_story == nil then
				arg_32_1.var_.characterEffect1011ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.1

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 and not isNil(var_35_5) then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7

				if arg_32_1.var_.characterEffect1011ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1011ui_story then
				arg_32_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_35_9 = arg_32_1.actors_["1019ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.1

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_9) then
					local var_35_13 = Mathf.Lerp(0, 0.5, var_35_12)

					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_13
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1019ui_story then
				local var_35_14 = 0.5

				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_14
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_35_16 = arg_32_1.actors_["1011ui_story"].transform
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.var_.moveOldPos1011ui_story = var_35_16.localPosition
			end

			local var_35_18 = 0.001

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 then
				local var_35_19 = (arg_32_1.time_ - var_35_17) / var_35_18
				local var_35_20 = Vector3.New(0.7, -0.71, -6)

				var_35_16.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1011ui_story, var_35_20, var_35_19)

				local var_35_21 = manager.ui.mainCamera.transform.position - var_35_16.position

				var_35_16.forward = Vector3.New(var_35_21.x, var_35_21.y, var_35_21.z)

				local var_35_22 = var_35_16.localEulerAngles

				var_35_22.z = 0
				var_35_22.x = 0
				var_35_16.localEulerAngles = var_35_22
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 then
				var_35_16.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_35_23 = manager.ui.mainCamera.transform.position - var_35_16.position

				var_35_16.forward = Vector3.New(var_35_23.x, var_35_23.y, var_35_23.z)

				local var_35_24 = var_35_16.localEulerAngles

				var_35_24.z = 0
				var_35_24.x = 0
				var_35_16.localEulerAngles = var_35_24
			end

			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_35_26 = 0
			local var_35_27 = 0.3

			if var_35_26 < arg_32_1.time_ and arg_32_1.time_ <= var_35_26 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_28 = arg_32_1:FormatText(StoryNameCfg[37].name)

				arg_32_1.leftNameTxt_.text = var_35_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_29 = arg_32_1:GetWordFromCfg(103042008)
				local var_35_30 = arg_32_1:FormatText(var_35_29.content)

				arg_32_1.text_.text = var_35_30

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_31 = 12
				local var_35_32 = utf8.len(var_35_30)
				local var_35_33 = var_35_31 <= 0 and var_35_27 or var_35_27 * (var_35_32 / var_35_31)

				if var_35_33 > 0 and var_35_27 < var_35_33 then
					arg_32_1.talkMaxDuration = var_35_33

					if var_35_33 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_33 + var_35_26
					end
				end

				arg_32_1.text_.text = var_35_30
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042008", "story_v_out_103042.awb") ~= 0 then
					local var_35_34 = manager.audio:GetVoiceLength("story_v_out_103042", "103042008", "story_v_out_103042.awb") / 1000

					if var_35_34 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_34 + var_35_26
					end

					if var_35_29.prefab_name ~= "" and arg_32_1.actors_[var_35_29.prefab_name] ~= nil then
						local var_35_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_29.prefab_name].transform, "story_v_out_103042", "103042008", "story_v_out_103042.awb")

						arg_32_1:RecordAudio("103042008", var_35_35)
						arg_32_1:RecordAudio("103042008", var_35_35)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_103042", "103042008", "story_v_out_103042.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_103042", "103042008", "story_v_out_103042.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_36 = math.max(var_35_27, arg_32_1.talkMaxDuration)

			if var_35_26 <= arg_32_1.time_ and arg_32_1.time_ < var_35_26 + var_35_36 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_26) / var_35_36

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_26 + var_35_36 and arg_32_1.time_ < var_35_26 + var_35_36 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play103042009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103042009
		arg_36_1.duration_ = 7.87

		local var_36_0 = {
			ja = 5.533,
			ko = 2.933,
			zh = 6.033,
			en = 7.866
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
				arg_36_0:Play103042010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "4010ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["4010ui_story"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect4010ui_story == nil then
				arg_36_1.var_.characterEffect4010ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.1

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect4010ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect4010ui_story then
				arg_36_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_39_9 = arg_36_1.actors_["1011ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = arg_36_1.actors_["1019ui_story"].transform
			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_18.localPosition
			end

			local var_39_20 = 0.001

			if var_39_19 <= arg_36_1.time_ and arg_36_1.time_ < var_39_19 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_19) / var_39_20
				local var_39_22 = Vector3.New(0, 100, 0)

				var_39_18.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, var_39_22, var_39_21)

				local var_39_23 = manager.ui.mainCamera.transform.position - var_39_18.position

				var_39_18.forward = Vector3.New(var_39_23.x, var_39_23.y, var_39_23.z)

				local var_39_24 = var_39_18.localEulerAngles

				var_39_24.z = 0
				var_39_24.x = 0
				var_39_18.localEulerAngles = var_39_24
			end

			if arg_36_1.time_ >= var_39_19 + var_39_20 and arg_36_1.time_ < var_39_19 + var_39_20 + arg_39_0 then
				var_39_18.localPosition = Vector3.New(0, 100, 0)

				local var_39_25 = manager.ui.mainCamera.transform.position - var_39_18.position

				var_39_18.forward = Vector3.New(var_39_25.x, var_39_25.y, var_39_25.z)

				local var_39_26 = var_39_18.localEulerAngles

				var_39_26.z = 0
				var_39_26.x = 0
				var_39_18.localEulerAngles = var_39_26
			end

			local var_39_27 = arg_36_1.actors_["4010ui_story"].transform
			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1.var_.moveOldPos4010ui_story = var_39_27.localPosition
			end

			local var_39_29 = 0.001

			if var_39_28 <= arg_36_1.time_ and arg_36_1.time_ < var_39_28 + var_39_29 then
				local var_39_30 = (arg_36_1.time_ - var_39_28) / var_39_29
				local var_39_31 = Vector3.New(0, -1.59, -5.2)

				var_39_27.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4010ui_story, var_39_31, var_39_30)

				local var_39_32 = manager.ui.mainCamera.transform.position - var_39_27.position

				var_39_27.forward = Vector3.New(var_39_32.x, var_39_32.y, var_39_32.z)

				local var_39_33 = var_39_27.localEulerAngles

				var_39_33.z = 0
				var_39_33.x = 0
				var_39_27.localEulerAngles = var_39_33
			end

			if arg_36_1.time_ >= var_39_28 + var_39_29 and arg_36_1.time_ < var_39_28 + var_39_29 + arg_39_0 then
				var_39_27.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_39_34 = manager.ui.mainCamera.transform.position - var_39_27.position

				var_39_27.forward = Vector3.New(var_39_34.x, var_39_34.y, var_39_34.z)

				local var_39_35 = var_39_27.localEulerAngles

				var_39_35.z = 0
				var_39_35.x = 0
				var_39_27.localEulerAngles = var_39_35
			end

			local var_39_36 = 0

			if var_39_36 < arg_36_1.time_ and arg_36_1.time_ <= var_39_36 + arg_39_0 then
				arg_36_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			local var_39_37 = 0

			if var_39_37 < arg_36_1.time_ and arg_36_1.time_ <= var_39_37 + arg_39_0 then
				arg_36_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_39_38 = 0
			local var_39_39 = 0.45

			if var_39_38 < arg_36_1.time_ and arg_36_1.time_ <= var_39_38 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_40 = arg_36_1:FormatText(StoryNameCfg[42].name)

				arg_36_1.leftNameTxt_.text = var_39_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_41 = arg_36_1:GetWordFromCfg(103042009)
				local var_39_42 = arg_36_1:FormatText(var_39_41.content)

				arg_36_1.text_.text = var_39_42

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_43 = 18
				local var_39_44 = utf8.len(var_39_42)
				local var_39_45 = var_39_43 <= 0 and var_39_39 or var_39_39 * (var_39_44 / var_39_43)

				if var_39_45 > 0 and var_39_39 < var_39_45 then
					arg_36_1.talkMaxDuration = var_39_45

					if var_39_45 + var_39_38 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_45 + var_39_38
					end
				end

				arg_36_1.text_.text = var_39_42
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042009", "story_v_out_103042.awb") ~= 0 then
					local var_39_46 = manager.audio:GetVoiceLength("story_v_out_103042", "103042009", "story_v_out_103042.awb") / 1000

					if var_39_46 + var_39_38 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_46 + var_39_38
					end

					if var_39_41.prefab_name ~= "" and arg_36_1.actors_[var_39_41.prefab_name] ~= nil then
						local var_39_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_41.prefab_name].transform, "story_v_out_103042", "103042009", "story_v_out_103042.awb")

						arg_36_1:RecordAudio("103042009", var_39_47)
						arg_36_1:RecordAudio("103042009", var_39_47)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103042", "103042009", "story_v_out_103042.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103042", "103042009", "story_v_out_103042.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_48 = math.max(var_39_39, arg_36_1.talkMaxDuration)

			if var_39_38 <= arg_36_1.time_ and arg_36_1.time_ < var_39_38 + var_39_48 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_38) / var_39_48

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_38 + var_39_48 and arg_36_1.time_ < var_39_38 + var_39_48 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play103042010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103042010
		arg_40_1.duration_ = 8.33

		local var_40_0 = {
			ja = 6.4,
			ko = 5.633,
			zh = 5.433,
			en = 8.333
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
				arg_40_0:Play103042011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_43_1 = 0
			local var_43_2 = 0.5

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_3 = arg_40_1:FormatText(StoryNameCfg[42].name)

				arg_40_1.leftNameTxt_.text = var_43_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(103042010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042010", "story_v_out_103042.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_103042", "103042010", "story_v_out_103042.awb") / 1000

					if var_43_9 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_1
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_103042", "103042010", "story_v_out_103042.awb")

						arg_40_1:RecordAudio("103042010", var_43_10)
						arg_40_1:RecordAudio("103042010", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_103042", "103042010", "story_v_out_103042.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_103042", "103042010", "story_v_out_103042.awb")
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
	Play103042011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103042011
		arg_44_1.duration_ = 7.53

		local var_44_0 = {
			ja = 6.533,
			ko = 7.533,
			zh = 5.066,
			en = 4.833
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
				arg_44_0:Play103042012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3008ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3008ui_story == nil then
				arg_44_1.var_.characterEffect3008ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect3008ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3008ui_story then
				arg_44_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["4010ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect4010ui_story == nil then
				arg_44_1.var_.characterEffect4010ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect4010ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4010ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect4010ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4010ui_story.fillRatio = var_47_9
			end

			local var_47_10 = arg_44_1.actors_["3008ui_story"].transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.moveOldPos3008ui_story = var_47_10.localPosition
			end

			local var_47_12 = 0.001

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / var_47_12
				local var_47_14 = Vector3.New(0.7, -1.51, -4.3)

				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3008ui_story, var_47_14, var_47_13)

				local var_47_15 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_15.x, var_47_15.y, var_47_15.z)

				local var_47_16 = var_47_10.localEulerAngles

				var_47_16.z = 0
				var_47_16.x = 0
				var_47_10.localEulerAngles = var_47_16
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_10.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_10.localEulerAngles = var_47_18
			end

			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 then
				arg_44_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_47_20 = arg_44_1.actors_["4010ui_story"].transform
			local var_47_21 = 0

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.var_.moveOldPos4010ui_story = var_47_20.localPosition
			end

			local var_47_22 = 0.001

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22
				local var_47_24 = Vector3.New(0, 100, 0)

				var_47_20.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos4010ui_story, var_47_24, var_47_23)

				local var_47_25 = manager.ui.mainCamera.transform.position - var_47_20.position

				var_47_20.forward = Vector3.New(var_47_25.x, var_47_25.y, var_47_25.z)

				local var_47_26 = var_47_20.localEulerAngles

				var_47_26.z = 0
				var_47_26.x = 0
				var_47_20.localEulerAngles = var_47_26
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 then
				var_47_20.localPosition = Vector3.New(0, 100, 0)

				local var_47_27 = manager.ui.mainCamera.transform.position - var_47_20.position

				var_47_20.forward = Vector3.New(var_47_27.x, var_47_27.y, var_47_27.z)

				local var_47_28 = var_47_20.localEulerAngles

				var_47_28.z = 0
				var_47_28.x = 0
				var_47_20.localEulerAngles = var_47_28
			end

			local var_47_29 = 0
			local var_47_30 = 0.7

			if var_47_29 < arg_44_1.time_ and arg_44_1.time_ <= var_47_29 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_31 = arg_44_1:FormatText(StoryNameCfg[20].name)

				arg_44_1.leftNameTxt_.text = var_47_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_32 = arg_44_1:GetWordFromCfg(103042011)
				local var_47_33 = arg_44_1:FormatText(var_47_32.content)

				arg_44_1.text_.text = var_47_33

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_34 = 27
				local var_47_35 = utf8.len(var_47_33)
				local var_47_36 = var_47_34 <= 0 and var_47_30 or var_47_30 * (var_47_35 / var_47_34)

				if var_47_36 > 0 and var_47_30 < var_47_36 then
					arg_44_1.talkMaxDuration = var_47_36

					if var_47_36 + var_47_29 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_36 + var_47_29
					end
				end

				arg_44_1.text_.text = var_47_33
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042011", "story_v_out_103042.awb") ~= 0 then
					local var_47_37 = manager.audio:GetVoiceLength("story_v_out_103042", "103042011", "story_v_out_103042.awb") / 1000

					if var_47_37 + var_47_29 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_37 + var_47_29
					end

					if var_47_32.prefab_name ~= "" and arg_44_1.actors_[var_47_32.prefab_name] ~= nil then
						local var_47_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_32.prefab_name].transform, "story_v_out_103042", "103042011", "story_v_out_103042.awb")

						arg_44_1:RecordAudio("103042011", var_47_38)
						arg_44_1:RecordAudio("103042011", var_47_38)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103042", "103042011", "story_v_out_103042.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103042", "103042011", "story_v_out_103042.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_39 = math.max(var_47_30, arg_44_1.talkMaxDuration)

			if var_47_29 <= arg_44_1.time_ and arg_44_1.time_ < var_47_29 + var_47_39 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_29) / var_47_39

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_29 + var_47_39 and arg_44_1.time_ < var_47_29 + var_47_39 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play103042012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103042012
		arg_48_1.duration_ = 7.4

		local var_48_0 = {
			ja = 4,
			ko = 4.166,
			zh = 3.666,
			en = 7.4
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
				arg_48_0:Play103042013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["4010ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect4010ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["3008ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_48_1.var_.characterEffect3008ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect3008ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_48_1.var_.characterEffect3008ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["4010ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos4010ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(-0.7, -1.59, -5.2)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4010ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_20 = 0
			local var_51_21 = 0.375

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_22 = arg_48_1:FormatText(StoryNameCfg[42].name)

				arg_48_1.leftNameTxt_.text = var_51_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_23 = arg_48_1:GetWordFromCfg(103042012)
				local var_51_24 = arg_48_1:FormatText(var_51_23.content)

				arg_48_1.text_.text = var_51_24

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_25 = 15
				local var_51_26 = utf8.len(var_51_24)
				local var_51_27 = var_51_25 <= 0 and var_51_21 or var_51_21 * (var_51_26 / var_51_25)

				if var_51_27 > 0 and var_51_21 < var_51_27 then
					arg_48_1.talkMaxDuration = var_51_27

					if var_51_27 + var_51_20 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_27 + var_51_20
					end
				end

				arg_48_1.text_.text = var_51_24
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042012", "story_v_out_103042.awb") ~= 0 then
					local var_51_28 = manager.audio:GetVoiceLength("story_v_out_103042", "103042012", "story_v_out_103042.awb") / 1000

					if var_51_28 + var_51_20 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_20
					end

					if var_51_23.prefab_name ~= "" and arg_48_1.actors_[var_51_23.prefab_name] ~= nil then
						local var_51_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_23.prefab_name].transform, "story_v_out_103042", "103042012", "story_v_out_103042.awb")

						arg_48_1:RecordAudio("103042012", var_51_29)
						arg_48_1:RecordAudio("103042012", var_51_29)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103042", "103042012", "story_v_out_103042.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103042", "103042012", "story_v_out_103042.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_30 = math.max(var_51_21, arg_48_1.talkMaxDuration)

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_30 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_20) / var_51_30

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_20 + var_51_30 and arg_48_1.time_ < var_51_20 + var_51_30 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play103042013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103042013
		arg_52_1.duration_ = 5.7

		local var_52_0 = {
			ja = 5.266,
			ko = 4.933,
			zh = 3.9,
			en = 5.7
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
				arg_52_0:Play103042014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["3008ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect3008ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3008ui_story then
				arg_52_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["4010ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_52_1.var_.characterEffect4010ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect4010ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_52_1.var_.characterEffect4010ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_55_12 = 0
			local var_55_13 = 0.475

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[20].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(103042013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 19
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042013", "story_v_out_103042.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_103042", "103042013", "story_v_out_103042.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_103042", "103042013", "story_v_out_103042.awb")

						arg_52_1:RecordAudio("103042013", var_55_21)
						arg_52_1:RecordAudio("103042013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103042", "103042013", "story_v_out_103042.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103042", "103042013", "story_v_out_103042.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play103042014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103042014
		arg_56_1.duration_ = 8.5

		local var_56_0 = {
			ja = 5.933,
			ko = 8.5,
			zh = 6.866,
			en = 5.7
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
				arg_56_0:Play103042015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["4010ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect4010ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect4010ui_story then
				arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["3008ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect3008ui_story == nil then
				arg_56_1.var_.characterEffect3008ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect3008ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_56_1.var_.characterEffect3008ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect3008ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_56_1.var_.characterEffect3008ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_11 = 0
			local var_59_12 = 0.825

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_13 = arg_56_1:FormatText(StoryNameCfg[42].name)

				arg_56_1.leftNameTxt_.text = var_59_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(103042014)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_16 = 32
				local var_59_17 = utf8.len(var_59_15)
				local var_59_18 = var_59_16 <= 0 and var_59_12 or var_59_12 * (var_59_17 / var_59_16)

				if var_59_18 > 0 and var_59_12 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042014", "story_v_out_103042.awb") ~= 0 then
					local var_59_19 = manager.audio:GetVoiceLength("story_v_out_103042", "103042014", "story_v_out_103042.awb") / 1000

					if var_59_19 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_11
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_out_103042", "103042014", "story_v_out_103042.awb")

						arg_56_1:RecordAudio("103042014", var_59_20)
						arg_56_1:RecordAudio("103042014", var_59_20)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_103042", "103042014", "story_v_out_103042.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_103042", "103042014", "story_v_out_103042.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_21 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_21 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_11) / var_59_21

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_11 + var_59_21 and arg_56_1.time_ < var_59_11 + var_59_21 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103042015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103042015
		arg_60_1.duration_ = 2.7

		local var_60_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_60_0:Play103042016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["3008ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect3008ui_story == nil then
				arg_60_1.var_.characterEffect3008ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect3008ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect3008ui_story then
				arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["4010ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect4010ui_story == nil then
				arg_60_1.var_.characterEffect4010ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect4010ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_60_1.var_.characterEffect4010ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect4010ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_60_1.var_.characterEffect4010ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_2")
			end

			local var_63_12 = 0
			local var_63_13 = 0.15

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[20].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(103042015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 6
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042015", "story_v_out_103042.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_103042", "103042015", "story_v_out_103042.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_103042", "103042015", "story_v_out_103042.awb")

						arg_60_1:RecordAudio("103042015", var_63_21)
						arg_60_1:RecordAudio("103042015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103042", "103042015", "story_v_out_103042.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103042", "103042015", "story_v_out_103042.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play103042016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103042016
		arg_64_1.duration_ = 3.4

		local var_64_0 = {
			ja = 2.766,
			ko = 3.2,
			zh = 2.9,
			en = 3.4
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
				arg_64_0:Play103042017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "3009ui_story"

			if arg_64_1.actors_[var_67_0] == nil then
				local var_67_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_67_1) then
					local var_67_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_64_1.stage_.transform)

					var_67_2.name = var_67_0
					var_67_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_64_1.actors_[var_67_0] = var_67_2

					local var_67_3 = var_67_2:GetComponentInChildren(typeof(CharacterEffect))

					var_67_3.enabled = true

					local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_2, typeof(DynamicBoneHelper))

					if var_67_4 then
						var_67_4:EnableDynamicBone(false)
					end

					arg_64_1:ShowWeapon(var_67_3.transform, false)

					arg_64_1.var_[var_67_0 .. "Animator"] = var_67_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_64_1.var_[var_67_0 .. "Animator"].applyRootMotion = true
					arg_64_1.var_[var_67_0 .. "LipSync"] = var_67_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_67_5 = arg_64_1.actors_["3009ui_story"]
			local var_67_6 = 0

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 and not isNil(var_67_5) and arg_64_1.var_.characterEffect3009ui_story == nil then
				arg_64_1.var_.characterEffect3009ui_story = var_67_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_7 = 0.1

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_7 and not isNil(var_67_5) then
				local var_67_8 = (arg_64_1.time_ - var_67_6) / var_67_7

				if arg_64_1.var_.characterEffect3009ui_story and not isNil(var_67_5) then
					arg_64_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_6 + var_67_7 and arg_64_1.time_ < var_67_6 + var_67_7 + arg_67_0 and not isNil(var_67_5) and arg_64_1.var_.characterEffect3009ui_story then
				arg_64_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_67_9 = arg_64_1.actors_["3008ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos3008ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3008ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = arg_64_1.actors_["3009ui_story"].transform
			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1.var_.moveOldPos3009ui_story = var_67_18.localPosition

				local var_67_20 = "3009ui_story"

				arg_64_1:ShowWeapon(arg_64_1.var_[var_67_20 .. "Animator"].transform, true)
			end

			local var_67_21 = 0.001

			if var_67_19 <= arg_64_1.time_ and arg_64_1.time_ < var_67_19 + var_67_21 then
				local var_67_22 = (arg_64_1.time_ - var_67_19) / var_67_21
				local var_67_23 = Vector3.New(0.7, -1.75, -4.8)

				var_67_18.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3009ui_story, var_67_23, var_67_22)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_18.position

				var_67_18.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_18.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_18.localEulerAngles = var_67_25
			end

			if arg_64_1.time_ >= var_67_19 + var_67_21 and arg_64_1.time_ < var_67_19 + var_67_21 + arg_67_0 then
				var_67_18.localPosition = Vector3.New(0.7, -1.75, -4.8)

				local var_67_26 = manager.ui.mainCamera.transform.position - var_67_18.position

				var_67_18.forward = Vector3.New(var_67_26.x, var_67_26.y, var_67_26.z)

				local var_67_27 = var_67_18.localEulerAngles

				var_67_27.z = 0
				var_67_27.x = 0
				var_67_18.localEulerAngles = var_67_27
			end

			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action4_1")
			end

			local var_67_29 = 0

			if var_67_29 < arg_64_1.time_ and arg_64_1.time_ <= var_67_29 + arg_67_0 then
				arg_64_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_67_30 = 0
			local var_67_31 = 0.325

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[43].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(103042016)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 13
				local var_67_36 = utf8.len(var_67_34)
				local var_67_37 = var_67_35 <= 0 and var_67_31 or var_67_31 * (var_67_36 / var_67_35)

				if var_67_37 > 0 and var_67_31 < var_67_37 then
					arg_64_1.talkMaxDuration = var_67_37

					if var_67_37 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_37 + var_67_30
					end
				end

				arg_64_1.text_.text = var_67_34
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042016", "story_v_out_103042.awb") ~= 0 then
					local var_67_38 = manager.audio:GetVoiceLength("story_v_out_103042", "103042016", "story_v_out_103042.awb") / 1000

					if var_67_38 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_38 + var_67_30
					end

					if var_67_33.prefab_name ~= "" and arg_64_1.actors_[var_67_33.prefab_name] ~= nil then
						local var_67_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_33.prefab_name].transform, "story_v_out_103042", "103042016", "story_v_out_103042.awb")

						arg_64_1:RecordAudio("103042016", var_67_39)
						arg_64_1:RecordAudio("103042016", var_67_39)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_103042", "103042016", "story_v_out_103042.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_103042", "103042016", "story_v_out_103042.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_40 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_40 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_40

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_40 and arg_64_1.time_ < var_67_30 + var_67_40 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play103042017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103042017
		arg_68_1.duration_ = 5.23

		local var_68_0 = {
			ja = 4.833,
			ko = 5.233,
			zh = 3.433,
			en = 3.133
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play103042018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["4010ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect4010ui_story == nil then
				arg_68_1.var_.characterEffect4010ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect4010ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect4010ui_story then
				arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["3009ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect3009ui_story == nil then
				arg_68_1.var_.characterEffect3009ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect3009ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_68_1.var_.characterEffect3009ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect3009ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_68_1.var_.characterEffect3009ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_71_11 = 0
			local var_71_12 = 0.475

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_13 = arg_68_1:FormatText(StoryNameCfg[42].name)

				arg_68_1.leftNameTxt_.text = var_71_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_14 = arg_68_1:GetWordFromCfg(103042017)
				local var_71_15 = arg_68_1:FormatText(var_71_14.content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 19
				local var_71_17 = utf8.len(var_71_15)
				local var_71_18 = var_71_16 <= 0 and var_71_12 or var_71_12 * (var_71_17 / var_71_16)

				if var_71_18 > 0 and var_71_12 < var_71_18 then
					arg_68_1.talkMaxDuration = var_71_18

					if var_71_18 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_11
					end
				end

				arg_68_1.text_.text = var_71_15
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042017", "story_v_out_103042.awb") ~= 0 then
					local var_71_19 = manager.audio:GetVoiceLength("story_v_out_103042", "103042017", "story_v_out_103042.awb") / 1000

					if var_71_19 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_11
					end

					if var_71_14.prefab_name ~= "" and arg_68_1.actors_[var_71_14.prefab_name] ~= nil then
						local var_71_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_14.prefab_name].transform, "story_v_out_103042", "103042017", "story_v_out_103042.awb")

						arg_68_1:RecordAudio("103042017", var_71_20)
						arg_68_1:RecordAudio("103042017", var_71_20)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103042", "103042017", "story_v_out_103042.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103042", "103042017", "story_v_out_103042.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_21 = math.max(var_71_12, arg_68_1.talkMaxDuration)

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_21 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_11) / var_71_21

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_11 + var_71_21 and arg_68_1.time_ < var_71_11 + var_71_21 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play103042018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103042018
		arg_72_1.duration_ = 7.67

		local var_72_0 = {
			ja = 6.299999999999,
			ko = 7.666,
			zh = 6.6,
			en = 6.366
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
				arg_72_0:Play103042019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"]
			local var_75_1 = 1.79999995231628

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_75_4 = 0

			if var_75_4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_5 = 2

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_5 then
				local var_75_6 = (arg_72_1.time_ - var_75_4) / var_75_5
				local var_75_7 = Color.New(0, 0, 0)

				var_75_7.a = Mathf.Lerp(0, 1, var_75_6)
				arg_72_1.mask_.color = var_75_7
			end

			if arg_72_1.time_ >= var_75_4 + var_75_5 and arg_72_1.time_ < var_75_4 + var_75_5 + arg_75_0 then
				local var_75_8 = Color.New(0, 0, 0)

				var_75_8.a = 1
				arg_72_1.mask_.color = var_75_8
			end

			local var_75_9 = 2

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_10 = 2

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 then
				local var_75_11 = (arg_72_1.time_ - var_75_9) / var_75_10
				local var_75_12 = Color.New(0, 0, 0)

				var_75_12.a = Mathf.Lerp(1, 0, var_75_11)
				arg_72_1.mask_.color = var_75_12
			end

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 then
				local var_75_13 = Color.New(0, 0, 0)
				local var_75_14 = 0

				arg_72_1.mask_.enabled = false
				var_75_13.a = var_75_14
				arg_72_1.mask_.color = var_75_13
			end

			local var_75_15 = arg_72_1.actors_["4010ui_story"].transform
			local var_75_16 = 1.967

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.var_.moveOldPos4010ui_story = var_75_15.localPosition
			end

			local var_75_17 = 0.001

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17
				local var_75_19 = Vector3.New(0, 100, 0)

				var_75_15.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos4010ui_story, var_75_19, var_75_18)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_15.position

				var_75_15.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_15.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_15.localEulerAngles = var_75_21
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 then
				var_75_15.localPosition = Vector3.New(0, 100, 0)

				local var_75_22 = manager.ui.mainCamera.transform.position - var_75_15.position

				var_75_15.forward = Vector3.New(var_75_22.x, var_75_22.y, var_75_22.z)

				local var_75_23 = var_75_15.localEulerAngles

				var_75_23.z = 0
				var_75_23.x = 0
				var_75_15.localEulerAngles = var_75_23
			end

			local var_75_24 = arg_72_1.actors_["3009ui_story"].transform
			local var_75_25 = 1.967

			if var_75_25 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 then
				arg_72_1.var_.moveOldPos3009ui_story = var_75_24.localPosition
			end

			local var_75_26 = 0.001

			if var_75_25 <= arg_72_1.time_ and arg_72_1.time_ < var_75_25 + var_75_26 then
				local var_75_27 = (arg_72_1.time_ - var_75_25) / var_75_26
				local var_75_28 = Vector3.New(0, 100, 0)

				var_75_24.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos3009ui_story, var_75_28, var_75_27)

				local var_75_29 = manager.ui.mainCamera.transform.position - var_75_24.position

				var_75_24.forward = Vector3.New(var_75_29.x, var_75_29.y, var_75_29.z)

				local var_75_30 = var_75_24.localEulerAngles

				var_75_30.z = 0
				var_75_30.x = 0
				var_75_24.localEulerAngles = var_75_30
			end

			if arg_72_1.time_ >= var_75_25 + var_75_26 and arg_72_1.time_ < var_75_25 + var_75_26 + arg_75_0 then
				var_75_24.localPosition = Vector3.New(0, 100, 0)

				local var_75_31 = manager.ui.mainCamera.transform.position - var_75_24.position

				var_75_24.forward = Vector3.New(var_75_31.x, var_75_31.y, var_75_31.z)

				local var_75_32 = var_75_24.localEulerAngles

				var_75_32.z = 0
				var_75_32.x = 0
				var_75_24.localEulerAngles = var_75_32
			end

			local var_75_33 = 3.8

			if var_75_33 < arg_72_1.time_ and arg_72_1.time_ <= var_75_33 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_75_34 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_35 = 3.8

			if var_75_35 < arg_72_1.time_ and arg_72_1.time_ <= var_75_35 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_34.localPosition
			end

			local var_75_36 = 0.001

			if var_75_35 <= arg_72_1.time_ and arg_72_1.time_ < var_75_35 + var_75_36 then
				local var_75_37 = (arg_72_1.time_ - var_75_35) / var_75_36
				local var_75_38 = Vector3.New(0, -0.97, -6)

				var_75_34.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_38, var_75_37)

				local var_75_39 = manager.ui.mainCamera.transform.position - var_75_34.position

				var_75_34.forward = Vector3.New(var_75_39.x, var_75_39.y, var_75_39.z)

				local var_75_40 = var_75_34.localEulerAngles

				var_75_40.z = 0
				var_75_40.x = 0
				var_75_34.localEulerAngles = var_75_40
			end

			if arg_72_1.time_ >= var_75_35 + var_75_36 and arg_72_1.time_ < var_75_35 + var_75_36 + arg_75_0 then
				var_75_34.localPosition = Vector3.New(0, -0.97, -6)

				local var_75_41 = manager.ui.mainCamera.transform.position - var_75_34.position

				var_75_34.forward = Vector3.New(var_75_41.x, var_75_41.y, var_75_41.z)

				local var_75_42 = var_75_34.localEulerAngles

				var_75_42.z = 0
				var_75_42.x = 0
				var_75_34.localEulerAngles = var_75_42
			end

			local var_75_43 = 3.8

			if var_75_43 < arg_72_1.time_ and arg_72_1.time_ <= var_75_43 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_44 = 4
			local var_75_45 = 0.35

			if var_75_44 < arg_72_1.time_ and arg_72_1.time_ <= var_75_44 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_46 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_46:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_47 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_48 = arg_72_1:GetWordFromCfg(103042018)
				local var_75_49 = arg_72_1:FormatText(var_75_48.content)

				arg_72_1.text_.text = var_75_49

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_50 = 12
				local var_75_51 = utf8.len(var_75_49)
				local var_75_52 = var_75_50 <= 0 and var_75_45 or var_75_45 * (var_75_51 / var_75_50)

				if var_75_52 > 0 and var_75_45 < var_75_52 then
					arg_72_1.talkMaxDuration = var_75_52
					var_75_44 = var_75_44 + 0.3

					if var_75_52 + var_75_44 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_52 + var_75_44
					end
				end

				arg_72_1.text_.text = var_75_49
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042018", "story_v_out_103042.awb") ~= 0 then
					local var_75_53 = manager.audio:GetVoiceLength("story_v_out_103042", "103042018", "story_v_out_103042.awb") / 1000

					if var_75_53 + var_75_44 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_53 + var_75_44
					end

					if var_75_48.prefab_name ~= "" and arg_72_1.actors_[var_75_48.prefab_name] ~= nil then
						local var_75_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_48.prefab_name].transform, "story_v_out_103042", "103042018", "story_v_out_103042.awb")

						arg_72_1:RecordAudio("103042018", var_75_54)
						arg_72_1:RecordAudio("103042018", var_75_54)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_103042", "103042018", "story_v_out_103042.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_103042", "103042018", "story_v_out_103042.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_55 = var_75_44 + 0.3
			local var_75_56 = math.max(var_75_45, arg_72_1.talkMaxDuration)

			if var_75_55 <= arg_72_1.time_ and arg_72_1.time_ < var_75_55 + var_75_56 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_55) / var_75_56

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_55 + var_75_56 and arg_72_1.time_ < var_75_55 + var_75_56 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play103042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 103042019
		arg_78_1.duration_ = 7.2

		local var_78_0 = {
			ja = 7.2,
			ko = 5.4,
			zh = 4.433,
			en = 5.7
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
				arg_78_0:Play103042020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1019ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1019ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1019ui_story then
				arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["1084ui_story"].transform
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.var_.moveOldPos1084ui_story = var_81_4.localPosition
			end

			local var_81_6 = 0.001

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6
				local var_81_8 = Vector3.New(0, 100, 0)

				var_81_4.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1084ui_story, var_81_8, var_81_7)

				local var_81_9 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_9.x, var_81_9.y, var_81_9.z)

				local var_81_10 = var_81_4.localEulerAngles

				var_81_10.z = 0
				var_81_10.x = 0
				var_81_4.localEulerAngles = var_81_10
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 then
				var_81_4.localPosition = Vector3.New(0, 100, 0)

				local var_81_11 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_11.x, var_81_11.y, var_81_11.z)

				local var_81_12 = var_81_4.localEulerAngles

				var_81_12.z = 0
				var_81_12.x = 0
				var_81_4.localEulerAngles = var_81_12
			end

			local var_81_13 = 0

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_81_14 = arg_78_1.actors_["1019ui_story"].transform
			local var_81_15 = 0

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.var_.moveOldPos1019ui_story = var_81_14.localPosition
			end

			local var_81_16 = 0.001

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_16 then
				local var_81_17 = (arg_78_1.time_ - var_81_15) / var_81_16
				local var_81_18 = Vector3.New(-0.2, -1.08, -5.9)

				var_81_14.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1019ui_story, var_81_18, var_81_17)

				local var_81_19 = manager.ui.mainCamera.transform.position - var_81_14.position

				var_81_14.forward = Vector3.New(var_81_19.x, var_81_19.y, var_81_19.z)

				local var_81_20 = var_81_14.localEulerAngles

				var_81_20.z = 0
				var_81_20.x = 0
				var_81_14.localEulerAngles = var_81_20
			end

			if arg_78_1.time_ >= var_81_15 + var_81_16 and arg_78_1.time_ < var_81_15 + var_81_16 + arg_81_0 then
				var_81_14.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_81_21 = manager.ui.mainCamera.transform.position - var_81_14.position

				var_81_14.forward = Vector3.New(var_81_21.x, var_81_21.y, var_81_21.z)

				local var_81_22 = var_81_14.localEulerAngles

				var_81_22.z = 0
				var_81_22.x = 0
				var_81_14.localEulerAngles = var_81_22
			end

			local var_81_23 = 0

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_24 = 0
			local var_81_25 = 0.725

			if var_81_24 < arg_78_1.time_ and arg_78_1.time_ <= var_81_24 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_26 = arg_78_1:FormatText(StoryNameCfg[13].name)

				arg_78_1.leftNameTxt_.text = var_81_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_27 = arg_78_1:GetWordFromCfg(103042019)
				local var_81_28 = arg_78_1:FormatText(var_81_27.content)

				arg_78_1.text_.text = var_81_28

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_29 = 28
				local var_81_30 = utf8.len(var_81_28)
				local var_81_31 = var_81_29 <= 0 and var_81_25 or var_81_25 * (var_81_30 / var_81_29)

				if var_81_31 > 0 and var_81_25 < var_81_31 then
					arg_78_1.talkMaxDuration = var_81_31

					if var_81_31 + var_81_24 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_31 + var_81_24
					end
				end

				arg_78_1.text_.text = var_81_28
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042019", "story_v_out_103042.awb") ~= 0 then
					local var_81_32 = manager.audio:GetVoiceLength("story_v_out_103042", "103042019", "story_v_out_103042.awb") / 1000

					if var_81_32 + var_81_24 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_32 + var_81_24
					end

					if var_81_27.prefab_name ~= "" and arg_78_1.actors_[var_81_27.prefab_name] ~= nil then
						local var_81_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_27.prefab_name].transform, "story_v_out_103042", "103042019", "story_v_out_103042.awb")

						arg_78_1:RecordAudio("103042019", var_81_33)
						arg_78_1:RecordAudio("103042019", var_81_33)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_103042", "103042019", "story_v_out_103042.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_103042", "103042019", "story_v_out_103042.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_34 = math.max(var_81_25, arg_78_1.talkMaxDuration)

			if var_81_24 <= arg_78_1.time_ and arg_78_1.time_ < var_81_24 + var_81_34 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_24) / var_81_34

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_24 + var_81_34 and arg_78_1.time_ < var_81_24 + var_81_34 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play103042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 103042020
		arg_82_1.duration_ = 2.87

		local var_82_0 = {
			ja = 2.866,
			ko = 2.666,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play103042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_85_2 = 0
			local var_85_3 = 0.275

			if var_85_2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_4 = arg_82_1:FormatText(StoryNameCfg[13].name)

				arg_82_1.leftNameTxt_.text = var_85_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_5 = arg_82_1:GetWordFromCfg(103042020)
				local var_85_6 = arg_82_1:FormatText(var_85_5.content)

				arg_82_1.text_.text = var_85_6

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 11
				local var_85_8 = utf8.len(var_85_6)
				local var_85_9 = var_85_7 <= 0 and var_85_3 or var_85_3 * (var_85_8 / var_85_7)

				if var_85_9 > 0 and var_85_3 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_6
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042020", "story_v_out_103042.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_103042", "103042020", "story_v_out_103042.awb") / 1000

					if var_85_10 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_2
					end

					if var_85_5.prefab_name ~= "" and arg_82_1.actors_[var_85_5.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_5.prefab_name].transform, "story_v_out_103042", "103042020", "story_v_out_103042.awb")

						arg_82_1:RecordAudio("103042020", var_85_11)
						arg_82_1:RecordAudio("103042020", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_103042", "103042020", "story_v_out_103042.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_103042", "103042020", "story_v_out_103042.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_12 and arg_82_1.time_ < var_85_2 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play103042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 103042021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
			arg_86_1.auto_ = false
		end

		function arg_86_1.playNext_(arg_88_0)
			arg_86_1.onStoryFinished_()
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1019ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1019ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1019ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1019ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1019ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.625

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(103042021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 25
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_103042.awb"
	}
}
