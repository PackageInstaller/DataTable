return {
	Play323181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323181001
		arg_1_1.duration_ = 20.2

		local var_1_0 = {
			zh = 12.8969044993557,
			ja = 20.1969044993557
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
				arg_1_0:Play323181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J23f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23f")
				var_4_0.name = "J23f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J23f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J23f

				arg_1_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J23f" then
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

			local var_4_9 = "1053ui_story"

			if arg_1_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1053ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1053ui_story == nil then
				arg_1_1.var_.characterEffect1053ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1053ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1053ui_story then
				arg_1_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_wind01_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 1.7639044993557
			local var_4_24 = 1.175

			if 1.7639044993557 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_26 = arg_1_1:GetWordFromCfg(323181001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 47 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 47)

				if (47 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 47)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181001", "story_v_out_323181.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_323181", "323181001", "story_v_out_323181.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_323181", "323181001", "story_v_out_323181.awb")

						arg_1_1:RecordAudio("323181001", var_4_31)
						arg_1_1:RecordAudio("323181001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323181", "323181001", "story_v_out_323181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323181", "323181001", "story_v_out_323181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323181002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323181002
		arg_9_1.duration_ = 10.2

		local var_9_0 = {
			zh = 8.466,
			ja = 10.2
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
				arg_9_0:Play323181003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.825

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(323181002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 33 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 33)

				if (33 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 33)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181002", "story_v_out_323181.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181002", "story_v_out_323181.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_323181", "323181002", "story_v_out_323181.awb")

						arg_9_1:RecordAudio("323181002", var_12_6)
						arg_9_1:RecordAudio("323181002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_323181", "323181002", "story_v_out_323181.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_323181", "323181002", "story_v_out_323181.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323181003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323181003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323181004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1053ui_story"]) and arg_13_1.var_.characterEffect1053ui_story == nil then
				arg_13_1.var_.characterEffect1053ui_story = arg_13_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1053ui_story"]) then
				if arg_13_1.var_.characterEffect1053ui_story and not isNil(arg_13_1.actors_["1053ui_story"]) then
					arg_13_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1053ui_story"]) and arg_13_1.var_.characterEffect1053ui_story then
				arg_13_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 1.025

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(323181003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 41 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 41)

				if (41 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 41)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play323181004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323181004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323181005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(323181004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 65 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 65)

				if (65 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 65)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play323181005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323181005
		arg_21_1.duration_ = 10.1

		local var_21_0 = {
			zh = 4.9,
			ja = 10.1
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
				arg_21_0:Play323181006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1053ui_story = arg_21_1.actors_["1053ui_story"].transform.localPosition

				local var_24_0 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_0 then
					var_24_0:EnableDynamicBone(false)
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_21_1.time_ - 0) / var_24_1)
				arg_21_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1053ui_story"].transform.position).z)
				arg_21_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1053ui_story"].transform.localEulerAngles = arg_21_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_21_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1053ui_story"].transform.position).z)
				arg_21_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1053ui_story"].transform.localEulerAngles = arg_21_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_24_2 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(true)
				end
			end

			local var_24_3 = arg_21_1.actors_["1053ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1053ui_story == nil then
				arg_21_1.var_.characterEffect1053ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect1053ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1053ui_story then
				arg_21_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_24_6 = 0
			local var_24_7 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(323181005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 21 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 21)

				if (21 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 21)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181005", "story_v_out_323181.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_323181", "323181005", "story_v_out_323181.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_323181", "323181005", "story_v_out_323181.awb")

						arg_21_1:RecordAudio("323181005", var_24_13)
						arg_21_1:RecordAudio("323181005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_323181", "323181005", "story_v_out_323181.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_323181", "323181005", "story_v_out_323181.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play323181006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323181006
		arg_25_1.duration_ = 7.83

		local var_25_0 = {
			zh = 7.666,
			ja = 7.833
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
				arg_25_0:Play323181007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.725

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(323181006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 29)

				if (29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 29)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181006", "story_v_out_323181.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181006", "story_v_out_323181.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_323181", "323181006", "story_v_out_323181.awb")

						arg_25_1:RecordAudio("323181006", var_28_6)
						arg_25_1:RecordAudio("323181006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_323181", "323181006", "story_v_out_323181.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_323181", "323181006", "story_v_out_323181.awb")
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
	Play323181007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323181007
		arg_29_1.duration_ = 15.8

		local var_29_0 = {
			zh = 11,
			ja = 15.8
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play323181008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(323181007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 49 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 49)

				if (49 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 49)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181007", "story_v_out_323181.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181007", "story_v_out_323181.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_323181", "323181007", "story_v_out_323181.awb")

						arg_29_1:RecordAudio("323181007", var_32_6)
						arg_29_1:RecordAudio("323181007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323181", "323181007", "story_v_out_323181.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323181", "323181007", "story_v_out_323181.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play323181008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323181008
		arg_33_1.duration_ = 11.43

		local var_33_0 = {
			zh = 7.966,
			ja = 11.433
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play323181009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_36_0 = 0
			local var_36_1 = 0.825

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(323181008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 33 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 33)

				if (33 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 33)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181008", "story_v_out_323181.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_323181", "323181008", "story_v_out_323181.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_323181", "323181008", "story_v_out_323181.awb")

						arg_33_1:RecordAudio("323181008", var_36_7)
						arg_33_1:RecordAudio("323181008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323181", "323181008", "story_v_out_323181.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323181", "323181008", "story_v_out_323181.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323181009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323181009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play323181010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1053ui_story = arg_37_1.actors_["1053ui_story"].transform.localPosition

				local var_40_0 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_40_0 then
					var_40_0:EnableDynamicBone(false)
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_1)
				arg_37_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).z)
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles = arg_37_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).z)
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles = arg_37_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_40_2 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(true)
				end
			end

			local var_40_3 = arg_37_1.actors_["1053ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1053ui_story == nil then
				arg_37_1.var_.characterEffect1053ui_story = var_40_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_4 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 and not isNil(var_40_3) then
				if arg_37_1.var_.characterEffect1053ui_story and not isNil(var_40_3) then
					arg_37_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_4)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1053ui_story then
				arg_37_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.166666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 0.166666666666667 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_148", "se_story_148_magic_fire01", "")
			end

			local var_40_6 = 0
			local var_40_7 = 1.3

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(323181009).content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 52 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_8) / 52)

				if (52 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_8) / 52)) > 0 and var_40_7 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_11 and arg_37_1.time_ < var_40_6 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play323181010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323181010
		arg_41_1.duration_ = 6.7

		local var_41_0 = {
			zh = 5.2,
			ja = 6.7
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play323181011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1053ui_story = arg_41_1.actors_["1053ui_story"].transform.localPosition

				local var_44_0 = GameObjectTools.GetOrAddComponent(arg_41_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_44_0 then
					var_44_0:EnableDynamicBone(false)
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_41_1.time_ - 0) / var_44_1)
				arg_41_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).z)
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles = arg_41_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_41_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).z)
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles = arg_41_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_44_2 = GameObjectTools.GetOrAddComponent(arg_41_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(true)
				end
			end

			local var_44_3 = arg_41_1.actors_["1053ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1053ui_story == nil then
				arg_41_1.var_.characterEffect1053ui_story = var_44_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 and not isNil(var_44_3) then
				if arg_41_1.var_.characterEffect1053ui_story and not isNil(var_44_3) then
					arg_41_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1053ui_story then
				arg_41_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_44_6 = 0
			local var_44_7 = 0.525

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(323181010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 21 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 21)

				if (21 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 21)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181010", "story_v_out_323181.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_323181", "323181010", "story_v_out_323181.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_323181", "323181010", "story_v_out_323181.awb")

						arg_41_1:RecordAudio("323181010", var_44_13)
						arg_41_1:RecordAudio("323181010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323181", "323181010", "story_v_out_323181.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323181", "323181010", "story_v_out_323181.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play323181011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323181011
		arg_45_1.duration_ = 9.23

		local var_45_0 = {
			zh = 8.266,
			ja = 9.233
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play323181012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			local var_48_0 = 0
			local var_48_1 = 0.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(323181011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 31 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 31)

				if (31 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 31)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181011", "story_v_out_323181.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_323181", "323181011", "story_v_out_323181.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_323181", "323181011", "story_v_out_323181.awb")

						arg_45_1:RecordAudio("323181011", var_48_7)
						arg_45_1:RecordAudio("323181011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323181", "323181011", "story_v_out_323181.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323181", "323181011", "story_v_out_323181.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323181012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323181012
		arg_49_1.duration_ = 15.3

		local var_49_0 = {
			zh = 10.7,
			ja = 15.3
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323181013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_0 = 0
			local var_52_1 = 1.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(323181012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 46 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 46)

				if (46 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 46)) > 0 and var_52_1 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181012", "story_v_out_323181.awb") ~= 0 then
					local var_52_6 = manager.audio:GetVoiceLength("story_v_out_323181", "323181012", "story_v_out_323181.awb") / 1000

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end

					if var_52_2.prefab_name ~= "" and arg_49_1.actors_[var_52_2.prefab_name] ~= nil then
						local var_52_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_2.prefab_name].transform, "story_v_out_323181", "323181012", "story_v_out_323181.awb")

						arg_49_1:RecordAudio("323181012", var_52_7)
						arg_49_1:RecordAudio("323181012", var_52_7)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_323181", "323181012", "story_v_out_323181.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_323181", "323181012", "story_v_out_323181.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323181013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323181013
		arg_53_1.duration_ = 10.37

		local var_53_0 = {
			zh = 9.966,
			ja = 10.366
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play323181014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.85

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(323181013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 34 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 34)

				if (34 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 34)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181013", "story_v_out_323181.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181013", "story_v_out_323181.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_323181", "323181013", "story_v_out_323181.awb")

						arg_53_1:RecordAudio("323181013", var_56_6)
						arg_53_1:RecordAudio("323181013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323181", "323181013", "story_v_out_323181.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323181", "323181013", "story_v_out_323181.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323181014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323181014
		arg_57_1.duration_ = 11.77

		local var_57_0 = {
			zh = 10.1,
			ja = 11.766
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play323181015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_60_0 = 0
			local var_60_1 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(323181014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 28 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 28)

				if (28 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 28)) > 0 and var_60_1 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181014", "story_v_out_323181.awb") ~= 0 then
					local var_60_6 = manager.audio:GetVoiceLength("story_v_out_323181", "323181014", "story_v_out_323181.awb") / 1000

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end

					if var_60_2.prefab_name ~= "" and arg_57_1.actors_[var_60_2.prefab_name] ~= nil then
						local var_60_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_2.prefab_name].transform, "story_v_out_323181", "323181014", "story_v_out_323181.awb")

						arg_57_1:RecordAudio("323181014", var_60_7)
						arg_57_1:RecordAudio("323181014", var_60_7)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_323181", "323181014", "story_v_out_323181.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_323181", "323181014", "story_v_out_323181.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323181015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323181015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play323181016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1053ui_story"]) and arg_61_1.var_.characterEffect1053ui_story == nil then
				arg_61_1.var_.characterEffect1053ui_story = arg_61_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1053ui_story"]) then
				if arg_61_1.var_.characterEffect1053ui_story and not isNil(arg_61_1.actors_["1053ui_story"]) then
					arg_61_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1053ui_story"]) and arg_61_1.var_.characterEffect1053ui_story then
				arg_61_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 1.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(323181015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 56 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 56)

				if (56 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 56)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323181016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323181016
		arg_65_1.duration_ = 6.17

		local var_65_0 = {
			zh = 5.2,
			ja = 6.166
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323181017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1053ui_story"]) and arg_65_1.var_.characterEffect1053ui_story == nil then
				arg_65_1.var_.characterEffect1053ui_story = arg_65_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1053ui_story"]) then
				if arg_65_1.var_.characterEffect1053ui_story and not isNil(arg_65_1.actors_["1053ui_story"]) then
					arg_65_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1053ui_story"]) and arg_65_1.var_.characterEffect1053ui_story then
				arg_65_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_68_2 = 0
			local var_68_3 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(323181016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 15 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 15)

				if (15 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 15)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181016", "story_v_out_323181.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_323181", "323181016", "story_v_out_323181.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_323181", "323181016", "story_v_out_323181.awb")

						arg_65_1:RecordAudio("323181016", var_68_9)
						arg_65_1:RecordAudio("323181016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_323181", "323181016", "story_v_out_323181.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_323181", "323181016", "story_v_out_323181.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323181017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323181017
		arg_69_1.duration_ = 8.2

		local var_69_0 = {
			zh = 5,
			ja = 8.2
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323181018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(323181017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 17 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 17)

				if (17 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 17)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181017", "story_v_out_323181.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181017", "story_v_out_323181.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_323181", "323181017", "story_v_out_323181.awb")

						arg_69_1:RecordAudio("323181017", var_72_6)
						arg_69_1:RecordAudio("323181017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323181", "323181017", "story_v_out_323181.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323181", "323181017", "story_v_out_323181.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323181018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323181018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323181019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1053ui_story = arg_73_1.actors_["1053ui_story"].transform.localPosition

				local var_76_0 = GameObjectTools.GetOrAddComponent(arg_73_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_76_0 then
					var_76_0:EnableDynamicBone(false)
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_1)
				arg_73_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1053ui_story"].transform.position).z)
				arg_73_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1053ui_story"].transform.localEulerAngles = arg_73_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1053ui_story"].transform.position).z)
				arg_73_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1053ui_story"].transform.localEulerAngles = arg_73_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_76_2 = GameObjectTools.GetOrAddComponent(arg_73_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(true)
				end
			end

			local var_76_3 = arg_73_1.actors_["1053ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1053ui_story == nil then
				arg_73_1.var_.characterEffect1053ui_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect1053ui_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_4)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1053ui_story then
				arg_73_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.6 < arg_73_1.time_ and arg_73_1.time_ <= 0.6 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_148", "se_story_148_arrow", "")
			end

			local var_76_6 = 0
			local var_76_7 = 1.275

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(323181018).content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 51 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 51)

				if (51 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 51)) > 0 and var_76_7 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_11 and arg_73_1.time_ < var_76_6 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play323181019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323181019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323181020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.825

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(323181019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 33 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 33)

				if (33 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 33)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play323181020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323181020
		arg_81_1.duration_ = 2.23

		local var_81_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play323181021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1053ui_story = arg_81_1.actors_["1053ui_story"].transform.localPosition

				local var_84_0 = GameObjectTools.GetOrAddComponent(arg_81_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_84_0 then
					var_84_0:EnableDynamicBone(false)
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_81_1.time_ - 0) / var_84_1)
				arg_81_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1053ui_story"].transform.position).z)
				arg_81_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1053ui_story"].transform.localEulerAngles = arg_81_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_81_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1053ui_story"].transform.position).z)
				arg_81_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1053ui_story"].transform.localEulerAngles = arg_81_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_84_2 = GameObjectTools.GetOrAddComponent(arg_81_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(true)
				end
			end

			local var_84_3 = arg_81_1.actors_["1053ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1053ui_story == nil then
				arg_81_1.var_.characterEffect1053ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect1053ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1053ui_story then
				arg_81_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_84_6 = 0
			local var_84_7 = 0.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(323181020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 7 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 7)

				if (7 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 7)) > 0 and var_84_7 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181020", "story_v_out_323181.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_323181", "323181020", "story_v_out_323181.awb") / 1000

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_323181", "323181020", "story_v_out_323181.awb")

						arg_81_1:RecordAudio("323181020", var_84_13)
						arg_81_1:RecordAudio("323181020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323181", "323181020", "story_v_out_323181.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323181", "323181020", "story_v_out_323181.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play323181021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323181021
		arg_85_1.duration_ = 5.07

		local var_85_0 = {
			zh = 3.466,
			ja = 5.066
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323181022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(323181021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 16)

				if (16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 16)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181021", "story_v_out_323181.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181021", "story_v_out_323181.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_323181", "323181021", "story_v_out_323181.awb")

						arg_85_1:RecordAudio("323181021", var_88_6)
						arg_85_1:RecordAudio("323181021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323181", "323181021", "story_v_out_323181.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323181", "323181021", "story_v_out_323181.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323181022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323181022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323181023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1053ui_story = arg_89_1.actors_["1053ui_story"].transform.localPosition

				local var_92_0 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_92_0 then
					var_92_0:EnableDynamicBone(false)
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_1)
				arg_89_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1053ui_story"].transform.position).z)
				arg_89_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1053ui_story"].transform.localEulerAngles = arg_89_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1053ui_story"].transform.position).z)
				arg_89_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1053ui_story"].transform.localEulerAngles = arg_89_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_92_2 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(true)
				end
			end

			local var_92_3 = arg_89_1.actors_["1053ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect1053ui_story == nil then
				arg_89_1.var_.characterEffect1053ui_story = var_92_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_4 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 and not isNil(var_92_3) then
				if arg_89_1.var_.characterEffect1053ui_story and not isNil(var_92_3) then
					arg_89_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_4)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect1053ui_story then
				arg_89_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_92_5 = 0
			local var_92_6 = 0.65

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(323181022).content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 26 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 26)

				if (26 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 26)) > 0 and var_92_6 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_10 and arg_89_1.time_ < var_92_5 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play323181023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323181023
		arg_93_1.duration_ = 7.63

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play323181024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.bgs_.J23g == nil then
				local var_96_0 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23g")
				var_96_0.name = "J23g"
				var_96_0.transform.parent = arg_93_1.stage_.transform
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_.J23g = var_96_0
			end

			if 1.16666666666667 < arg_93_1.time_ and arg_93_1.time_ <= 1.16666666666667 + arg_96_0 then
				local var_96_1 = arg_93_1.bgs_.J23g

				arg_93_1.bgs_.J23g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_2 = var_96_1:GetComponent("SpriteRenderer")

				if var_96_2 and var_96_2.sprite then
					local var_96_3 = 2 * (var_96_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_1.transform.localScale = Vector3.New(var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "J23g" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_4 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			if arg_93_1.time_ >= var_96_4 + 0.3 and arg_93_1.time_ < var_96_4 + 0.3 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_5 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_6 = 1.16666666666667

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 then
				local var_96_7 = Color.New(0, 0, 0)

				var_96_7.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_5) / var_96_6)
				arg_93_1.mask_.color = var_96_7
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 then
				local var_96_8 = Color.New(0, 0, 0)

				var_96_8.a = 1
				arg_93_1.mask_.color = var_96_8
			end

			local var_96_9 = 1.16666666666667

			if 1.16666666666667 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_10 = 1.83333333333333

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 then
				local var_96_11 = Color.New(0, 0, 0)

				var_96_11.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_9) / var_96_10)
				arg_93_1.mask_.color = var_96_11
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 then
				local var_96_12 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_12.a = 0
				arg_93_1.mask_.color = var_96_12
			end

			if 0.2 < arg_93_1.time_ and arg_93_1.time_ <= 0.2 + arg_96_0 then
				arg_93_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_96_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_93_1.bgmTxt_.text ~= var_96_15 and arg_93_1.bgmTxt_.text ~= "" then
						if arg_93_1.bgmTxt2_.text ~= "" then
							arg_93_1.bgmTxt_.text = arg_93_1.bgmTxt2_.text
						end

						arg_93_1.bgmTxt2_.text = var_96_15

						arg_93_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_93_1.bgmTxt_.text = var_96_15
						arg_93_1.bgmTxt2_.text = var_96_15
					end

					if arg_93_1.bgmTimer then
						arg_93_1.bgmTimer:Stop()

						arg_93_1.bgmTimer = nil
					end

					if arg_93_1.settingData.show_music_name == 1 then
						arg_93_1.musicController:SetSelectedState("show")
						arg_93_1.musicAnimator_:Play("open", 0, 0)

						if arg_93_1.settingData.music_time ~= 0 then
							arg_93_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_93_1.settingData.music_time), function()
								if arg_93_1 == nil or isNil(arg_93_1.bgmTxt_) then
									return
								end

								arg_93_1.musicController:SetSelectedState("hide")
								arg_93_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_93_1.time_ and arg_93_1.time_ <= 0.166666666666667 + arg_96_0 then
				arg_93_1:AudioAction("stop", "effect", "se_story_side_1070", "se_story_1070_wind01_loop", "")
			end

			if 0.866666666666667 < arg_93_1.time_ and arg_93_1.time_ <= 0.866666666666667 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_workshop", "")
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_18 = 2.63333333333333
			local var_96_19 = 1.375

			if 2.63333333333333 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_20 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_20:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_93_1.dialogCg_.alpha = arg_98_0
				end))
				var_96_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_21 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(323181023).content)

				arg_93_1.text_.text = var_96_21

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_23 = 55 <= 0 and var_96_19 or var_96_19 * (utf8.len(var_96_21) / 55)

				if (55 <= 0 and var_96_19 or var_96_19 * (utf8.len(var_96_21) / 55)) > 0 and var_96_19 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23
					var_96_18 = var_96_18 + 0.3

					if var_96_23 + var_96_18 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_18
					end
				end

				arg_93_1.text_.text = var_96_21
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_24 = var_96_18 + 0.3
			local var_96_25 = math.max(var_96_19, arg_93_1.talkMaxDuration)

			if var_96_18 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_24 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_24) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_24 + var_96_25 and arg_93_1.time_ < var_96_24 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play323181024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 323181024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play323181025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(323181024).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 40 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 40)

				if (40 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 40)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play323181025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 323181025
		arg_104_1.duration_ = 6.67

		local var_104_0 = {
			zh = 3.2,
			ja = 6.666
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play323181026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1053ui_story = arg_104_1.actors_["1053ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).z)
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles = arg_104_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_104_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1053ui_story"].transform.position).z)
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1053ui_story"].transform.localEulerAngles = arg_104_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["1053ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1053ui_story == nil then
				arg_104_1.var_.characterEffect1053ui_story = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect1053ui_story and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1053ui_story then
				arg_104_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_107_6 = 0
			local var_107_7 = 0.35

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(323181025)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 14 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 14)

				if (14 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 14)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181025", "story_v_out_323181.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_323181", "323181025", "story_v_out_323181.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_323181", "323181025", "story_v_out_323181.awb")

						arg_104_1:RecordAudio("323181025", var_107_13)
						arg_104_1:RecordAudio("323181025", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_323181", "323181025", "story_v_out_323181.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_323181", "323181025", "story_v_out_323181.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play323181026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 323181026
		arg_108_1.duration_ = 14.8

		local var_108_0 = {
			zh = 9.833,
			ja = 14.8
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play323181027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.95

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(323181026)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 38 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 38)

				if (38 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 38)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181026", "story_v_out_323181.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_323181", "323181026", "story_v_out_323181.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_323181", "323181026", "story_v_out_323181.awb")

						arg_108_1:RecordAudio("323181026", var_111_6)
						arg_108_1:RecordAudio("323181026", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_323181", "323181026", "story_v_out_323181.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_323181", "323181026", "story_v_out_323181.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play323181027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 323181027
		arg_112_1.duration_ = 1.83

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play323181028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1053ui_story"]) and arg_112_1.var_.characterEffect1053ui_story == nil then
				arg_112_1.var_.characterEffect1053ui_story = arg_112_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1053ui_story"]) then
				if arg_112_1.var_.characterEffect1053ui_story and not isNil(arg_112_1.actors_["1053ui_story"]) then
					arg_112_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1053ui_story"]) and arg_112_1.var_.characterEffect1053ui_story then
				arg_112_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.05

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3057")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(323181027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 2 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 2)

				if (2 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 2)) > 0 and var_115_2 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181027", "story_v_out_323181.awb") ~= 0 then
					local var_115_7 = manager.audio:GetVoiceLength("story_v_out_323181", "323181027", "story_v_out_323181.awb") / 1000

					if var_115_7 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_1
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_323181", "323181027", "story_v_out_323181.awb")

						arg_112_1:RecordAudio("323181027", var_115_8)
						arg_112_1:RecordAudio("323181027", var_115_8)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_323181", "323181027", "story_v_out_323181.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_323181", "323181027", "story_v_out_323181.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_9 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_9

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_9 and arg_112_1.time_ < var_115_1 + var_115_9 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play323181028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 323181028
		arg_116_1.duration_ = 9.1

		local var_116_0 = {
			zh = 5.533,
			ja = 9.1
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
				arg_116_0:Play323181029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_119_0 = arg_116_1.actors_["1053ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1053ui_story == nil then
				arg_116_1.var_.characterEffect1053ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_1 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 and not isNil(var_119_0) then
				if arg_116_1.var_.characterEffect1053ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1053ui_story then
				arg_116_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_119_3 = 0
			local var_119_4 = 0.5

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_5 = arg_116_1:GetWordFromCfg(323181028)
				local var_119_6 = arg_116_1:FormatText(var_119_5.content)

				arg_116_1.text_.text = var_119_6

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_8 = 20 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_6) / 20)

				if (20 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_6) / 20)) > 0 and var_119_4 < var_119_8 then
					arg_116_1.talkMaxDuration = var_119_8

					if var_119_8 + var_119_3 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_3
					end
				end

				arg_116_1.text_.text = var_119_6
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323181", "323181028", "story_v_out_323181.awb") ~= 0 then
					local var_119_9 = manager.audio:GetVoiceLength("story_v_out_323181", "323181028", "story_v_out_323181.awb") / 1000

					if var_119_9 + var_119_3 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_3
					end

					if var_119_5.prefab_name ~= "" and arg_116_1.actors_[var_119_5.prefab_name] ~= nil then
						local var_119_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_5.prefab_name].transform, "story_v_out_323181", "323181028", "story_v_out_323181.awb")

						arg_116_1:RecordAudio("323181028", var_119_10)
						arg_116_1:RecordAudio("323181028", var_119_10)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_323181", "323181028", "story_v_out_323181.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_323181", "323181028", "story_v_out_323181.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_11 = math.max(var_119_4, arg_116_1.talkMaxDuration)

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_11 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_3) / var_119_11

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_3 + var_119_11 and arg_116_1.time_ < var_119_3 + var_119_11 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play323181029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 323181029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
			arg_120_1.auto_ = false
		end

		function arg_120_1.playNext_(arg_122_0)
			arg_120_1.onStoryFinished_()
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1053ui_story = arg_120_1.actors_["1053ui_story"].transform.localPosition

				local var_123_0 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_0 then
					var_123_0:EnableDynamicBone(false)
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_1)
				arg_120_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1053ui_story"].transform.position).z)
				arg_120_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1053ui_story"].transform.localEulerAngles = arg_120_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1053ui_story"].transform.position).z)
				arg_120_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1053ui_story"].transform.localEulerAngles = arg_120_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_123_2 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(true)
				end
			end

			local var_123_3 = arg_120_1.actors_["1053ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1053ui_story == nil then
				arg_120_1.var_.characterEffect1053ui_story = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect1053ui_story and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_4)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1053ui_story then
				arg_120_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_123_5 = 0
			local var_123_6 = 0.6

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(323181029).content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 24 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_7) / 24)

				if (24 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_7) / 24)) > 0 and var_123_6 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_10 and arg_120_1.time_ < var_123_5 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J23f",
		"TextureConfig/Background/J23g"
	},
	voices = {
		"story_v_out_323181.awb"
	}
}
