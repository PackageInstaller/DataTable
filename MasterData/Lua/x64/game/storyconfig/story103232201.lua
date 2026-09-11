return {
	Play323221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323221001
		arg_1_1.duration_ = 4.2

		local var_1_0 = {
			zh = 4.2,
			ja = 3.982241527859
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
				arg_1_0:Play323221002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.J23h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23h")
				var_4_0.name = "J23h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J23h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J23h

				arg_1_1.bgs_.J23h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J23h" then
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

			local var_4_9 = "1059ui_story"

			if arg_1_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1059ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1059ui_story == nil then
				arg_1_1.var_.characterEffect1059ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1059ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1059ui_story then
				arg_1_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect444

				if not arg_1_1.var_.effect444 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_4_16.name = "444"
					arg_1_1.var_.effect444 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9000)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_18 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_4_16.transform.localScale = Vector3.New(var_4_16.transform.localScale.x * var_4_18, var_4_16.transform.localScale.y * var_4_18, var_4_16.transform.localScale.z * var_4_18)
			end

			if 2.20778743059685 < arg_1_1.time_ and arg_1_1.time_ <= 2.20778743059685 + arg_4_0 then
				if arg_1_1.var_.effect444 then
					Object.Destroy(arg_1_1.var_.effect444)

					arg_1_1.var_.effect444 = nil
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordhit", "")
			end

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_3", "se_story_3_windspear", "")
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_29 = 1.6
			local var_4_30 = 0.25

			if 1.6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_31 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_31:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_32 = arg_1_1:GetWordFromCfg(323221001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 10 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 10)

				if (10 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 10)) > 0 and var_4_30 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_29 = var_4_29 + 0.3

					if var_4_35 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_29
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221001", "story_v_out_323221.awb") ~= 0 then
					local var_4_36 = manager.audio:GetVoiceLength("story_v_out_323221", "323221001", "story_v_out_323221.awb") / 1000

					if var_4_36 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_29
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_323221", "323221001", "story_v_out_323221.awb")

						arg_1_1:RecordAudio("323221001", var_4_37)
						arg_1_1:RecordAudio("323221001", var_4_37)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323221", "323221001", "story_v_out_323221.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323221", "323221001", "story_v_out_323221.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_29 + 0.3
			local var_4_39 = math.max(var_4_30, arg_1_1.talkMaxDuration)

			if var_4_29 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 10,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play323221002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323221002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323221003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1059ui_story"]) and arg_9_1.var_.characterEffect1059ui_story == nil then
				arg_9_1.var_.characterEffect1059ui_story = arg_9_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1059ui_story"]) then
				if arg_9_1.var_.characterEffect1059ui_story and not isNil(arg_9_1.actors_["1059ui_story"]) then
					arg_9_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1059ui_story"]) and arg_9_1.var_.characterEffect1059ui_story then
				arg_9_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323221002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 52 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 52)

				if (52 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 52)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323221003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323221003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323221004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.275

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(323221003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 51 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 51)

				if (51 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 51)) > 0 and var_16_0 < var_16_3 then
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
	Play323221004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323221004
		arg_17_1.duration_ = 12

		local var_17_0 = {
			zh = 8.5,
			ja = 12
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
				arg_17_0:Play323221005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.6

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(323221004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 24 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 24)

				if (24 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 24)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221004", "story_v_out_323221.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221004", "story_v_out_323221.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_323221", "323221004", "story_v_out_323221.awb")

						arg_17_1:RecordAudio("323221004", var_20_6)
						arg_17_1:RecordAudio("323221004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_323221", "323221004", "story_v_out_323221.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_323221", "323221004", "story_v_out_323221.awb")
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
	Play323221005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323221005
		arg_21_1.duration_ = 7.03

		local var_21_0 = {
			zh = 5.69933333333333,
			ja = 7.03333333333333
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
				arg_21_0:Play323221006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1053ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1053ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1053ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1053ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1053ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1053ui_story = var_24_3.localPosition

				local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_3.gameObject, typeof(DynamicBoneHelper))

				if var_24_4 then
					var_24_4:EnableDynamicBone(false)
				end
			end

			local var_24_5 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_21_1.time_ - 0) / var_24_5)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.08, -6)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles

				local var_24_6 = GameObjectTools.GetOrAddComponent(var_24_3.gameObject, typeof(DynamicBoneHelper))

				if var_24_6 then
					var_24_6:EnableDynamicBone(true)
				end
			end

			local var_24_7 = arg_21_1.actors_["1059ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1059ui_story = var_24_7.localPosition
			end

			local var_24_8 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_8 then
				var_24_7.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_8)
				var_24_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_7.position).x, (manager.ui.mainCamera.transform.position - var_24_7.position).y, (manager.ui.mainCamera.transform.position - var_24_7.position).z)
				var_24_7.localEulerAngles.z = 0
				var_24_7.localEulerAngles.x = 0
				var_24_7.localEulerAngles = var_24_7.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_8 and arg_21_1.time_ < 0 + var_24_8 + arg_24_0 then
				var_24_7.localPosition = Vector3.New(0, 100, 0)
				var_24_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_7.position).x, (manager.ui.mainCamera.transform.position - var_24_7.position).y, (manager.ui.mainCamera.transform.position - var_24_7.position).z)
				var_24_7.localEulerAngles.z = 0
				var_24_7.localEulerAngles.x = 0
				var_24_7.localEulerAngles = var_24_7.localEulerAngles
			end

			local var_24_9 = arg_21_1.actors_["1053ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1053ui_story == nil then
				arg_21_1.var_.characterEffect1053ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_10 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_10 and not isNil(var_24_9) then
				if arg_21_1.var_.characterEffect1053ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_10 and arg_21_1.time_ < 0 + var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1053ui_story then
				arg_21_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_24_12 = arg_21_1.actors_["1059ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_12) and arg_21_1.var_.characterEffect1059ui_story == nil then
				arg_21_1.var_.characterEffect1059ui_story = var_24_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_13 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_13 and not isNil(var_24_12) then
				if arg_21_1.var_.characterEffect1059ui_story and not isNil(var_24_12) then
					arg_21_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_13)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_13 and arg_21_1.time_ < 0 + var_24_13 + arg_24_0 and not isNil(var_24_12) and arg_21_1.var_.characterEffect1059ui_story then
				arg_21_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action8_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_24_14 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_14 + 1.33333333333333 and arg_21_1.time_ < var_24_14 + 1.33333333333333 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_15 = 0.833333333333333
			local var_24_16 = 0.5

			if 0.833333333333333 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_17 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_17:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(323221005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 20 <= 0 and var_24_16 or var_24_16 * (utf8.len(var_24_19) / 20)

				if (20 <= 0 and var_24_16 or var_24_16 * (utf8.len(var_24_19) / 20)) > 0 and var_24_16 < var_24_21 then
					arg_21_1.talkMaxDuration = var_24_21
					var_24_15 = var_24_15 + 0.3

					if var_24_21 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_21 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221005", "story_v_out_323221.awb") ~= 0 then
					local var_24_22 = manager.audio:GetVoiceLength("story_v_out_323221", "323221005", "story_v_out_323221.awb") / 1000

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_323221", "323221005", "story_v_out_323221.awb")

						arg_21_1:RecordAudio("323221005", var_24_23)
						arg_21_1:RecordAudio("323221005", var_24_23)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_323221", "323221005", "story_v_out_323221.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_323221", "323221005", "story_v_out_323221.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_24 = var_24_15 + 0.3
			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_24) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 then
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
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play323221006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 323221006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play323221007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1053ui_story = arg_27_1.actors_["1053ui_story"].transform.localPosition

				local var_30_0 = GameObjectTools.GetOrAddComponent(arg_27_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_30_0 then
					var_30_0:EnableDynamicBone(false)
				end
			end

			local var_30_1 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 then
				arg_27_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_1)
				arg_27_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1053ui_story"].transform.position).z)
				arg_27_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1053ui_story"].transform.localEulerAngles = arg_27_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 then
				arg_27_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1053ui_story"].transform.position).z)
				arg_27_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1053ui_story"].transform.localEulerAngles = arg_27_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_30_2 = GameObjectTools.GetOrAddComponent(arg_27_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(true)
				end
			end

			local var_30_3 = arg_27_1.actors_["1053ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_3) and arg_27_1.var_.characterEffect1053ui_story == nil then
				arg_27_1.var_.characterEffect1053ui_story = var_30_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_4 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 and not isNil(var_30_3) then
				if arg_27_1.var_.characterEffect1053ui_story and not isNil(var_30_3) then
					arg_27_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_4)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 and not isNil(var_30_3) and arg_27_1.var_.characterEffect1053ui_story then
				arg_27_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_30_5 = 0
			local var_30_6 = 1.15

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(323221006).content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 46 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 46)

				if (46 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 46)) > 0 and var_30_6 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_10 and arg_27_1.time_ < var_30_5 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play323221007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 323221007
		arg_31_1.duration_ = 5.4

		local var_31_0 = {
			zh = 3.4,
			ja = 5.4
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play323221008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.3

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(323221007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 12 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 12)

				if (12 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 12)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221007", "story_v_out_323221.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221007", "story_v_out_323221.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_323221", "323221007", "story_v_out_323221.awb")

						arg_31_1:RecordAudio("323221007", var_34_6)
						arg_31_1:RecordAudio("323221007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_323221", "323221007", "story_v_out_323221.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_323221", "323221007", "story_v_out_323221.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play323221008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 323221008
		arg_35_1.duration_ = 9.7

		local var_35_0 = {
			zh = 6.8,
			ja = 9.7
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play323221009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.7

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(323221008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 28 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 28)

				if (28 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 28)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221008", "story_v_out_323221.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221008", "story_v_out_323221.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_323221", "323221008", "story_v_out_323221.awb")

						arg_35_1:RecordAudio("323221008", var_38_6)
						arg_35_1:RecordAudio("323221008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_323221", "323221008", "story_v_out_323221.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_323221", "323221008", "story_v_out_323221.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play323221009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 323221009
		arg_39_1.duration_ = 6.5

		local var_39_0 = {
			zh = 5.833,
			ja = 6.5
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play323221010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1053ui_story"]) and arg_39_1.var_.characterEffect1053ui_story == nil then
				arg_39_1.var_.characterEffect1053ui_story = arg_39_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1053ui_story"]) then
				if arg_39_1.var_.characterEffect1053ui_story and not isNil(arg_39_1.actors_["1053ui_story"]) then
					arg_39_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1053ui_story"]) and arg_39_1.var_.characterEffect1053ui_story then
				arg_39_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_42_2 = arg_39_1.actors_["1059ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1059ui_story == nil then
				arg_39_1.var_.characterEffect1059ui_story = var_42_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_3 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.characterEffect1059ui_story and not isNil(var_42_2) then
					arg_39_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_3)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1059ui_story then
				arg_39_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_42_4 = arg_39_1.actors_["1053ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1053ui_story = var_42_4.localPosition

				local var_42_5 = GameObjectTools.GetOrAddComponent(var_42_4.gameObject, typeof(DynamicBoneHelper))

				if var_42_5 then
					var_42_5:EnableDynamicBone(false)
				end
			end

			local var_42_6 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_39_1.time_ - 0) / var_42_6)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(0, -1.08, -6)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles

				local var_42_7 = GameObjectTools.GetOrAddComponent(var_42_4.gameObject, typeof(DynamicBoneHelper))

				if var_42_7 then
					var_42_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action8_2")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_42_8 = 0
			local var_42_9 = 0.525

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(323221009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 21 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 21)

				if (21 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 21)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221009", "story_v_out_323221.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_323221", "323221009", "story_v_out_323221.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_323221", "323221009", "story_v_out_323221.awb")

						arg_39_1:RecordAudio("323221009", var_42_15)
						arg_39_1:RecordAudio("323221009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_323221", "323221009", "story_v_out_323221.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_323221", "323221009", "story_v_out_323221.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play323221010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 323221010
		arg_43_1.duration_ = 13.87

		local var_43_0 = {
			zh = 7.533,
			ja = 13.866
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play323221011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1059ui_story"]) and arg_43_1.var_.characterEffect1059ui_story == nil then
				arg_43_1.var_.characterEffect1059ui_story = arg_43_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1059ui_story"]) then
				if arg_43_1.var_.characterEffect1059ui_story and not isNil(arg_43_1.actors_["1059ui_story"]) then
					arg_43_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1059ui_story"]) and arg_43_1.var_.characterEffect1059ui_story then
				arg_43_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["1053ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1053ui_story == nil then
				arg_43_1.var_.characterEffect1053ui_story = var_46_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.characterEffect1053ui_story and not isNil(var_46_2) then
					arg_43_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_3)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1053ui_story then
				arg_43_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_46_4 = 0
			local var_46_5 = 0.85

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_6 = arg_43_1:GetWordFromCfg(323221010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 34 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 34)

				if (34 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 34)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221010", "story_v_out_323221.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221010", "story_v_out_323221.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_323221", "323221010", "story_v_out_323221.awb")

						arg_43_1:RecordAudio("323221010", var_46_11)
						arg_43_1:RecordAudio("323221010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_323221", "323221010", "story_v_out_323221.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_323221", "323221010", "story_v_out_323221.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play323221011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 323221011
		arg_47_1.duration_ = 5.5

		local var_47_0 = {
			zh = 3.833,
			ja = 5.5
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
				arg_47_0:Play323221012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.45

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(323221011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 18 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 18)

				if (18 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 18)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221011", "story_v_out_323221.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221011", "story_v_out_323221.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_323221", "323221011", "story_v_out_323221.awb")

						arg_47_1:RecordAudio("323221011", var_50_6)
						arg_47_1:RecordAudio("323221011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_323221", "323221011", "story_v_out_323221.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_323221", "323221011", "story_v_out_323221.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play323221012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 323221012
		arg_51_1.duration_ = 4.93

		local var_51_0 = {
			zh = 4.733,
			ja = 4.933
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
				arg_51_0:Play323221013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1053ui_story"]) and arg_51_1.var_.characterEffect1053ui_story == nil then
				arg_51_1.var_.characterEffect1053ui_story = arg_51_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1053ui_story"]) then
				if arg_51_1.var_.characterEffect1053ui_story and not isNil(arg_51_1.actors_["1053ui_story"]) then
					arg_51_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1053ui_story"]) and arg_51_1.var_.characterEffect1053ui_story then
				arg_51_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_54_2 = arg_51_1.actors_["1059ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1059ui_story == nil then
				arg_51_1.var_.characterEffect1059ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect1059ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_3)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1059ui_story then
				arg_51_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_54_4 = 0
			local var_54_5 = 0.425

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(323221012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 17 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 17)

				if (17 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 17)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221012", "story_v_out_323221.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221012", "story_v_out_323221.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_323221", "323221012", "story_v_out_323221.awb")

						arg_51_1:RecordAudio("323221012", var_54_11)
						arg_51_1:RecordAudio("323221012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_323221", "323221012", "story_v_out_323221.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_323221", "323221012", "story_v_out_323221.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play323221013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 323221013
		arg_55_1.duration_ = 3.43

		local var_55_0 = {
			zh = 2.033,
			ja = 3.433
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play323221014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1059ui_story"]) and arg_55_1.var_.characterEffect1059ui_story == nil then
				arg_55_1.var_.characterEffect1059ui_story = arg_55_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1059ui_story"]) then
				if arg_55_1.var_.characterEffect1059ui_story and not isNil(arg_55_1.actors_["1059ui_story"]) then
					arg_55_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1059ui_story"]) and arg_55_1.var_.characterEffect1059ui_story then
				arg_55_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["1053ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1053ui_story == nil then
				arg_55_1.var_.characterEffect1053ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect1053ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1053ui_story then
				arg_55_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_58_4 = 0
			local var_58_5 = 0.2

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_6 = arg_55_1:GetWordFromCfg(323221013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 8 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 8)

				if (8 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 8)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221013", "story_v_out_323221.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221013", "story_v_out_323221.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_323221", "323221013", "story_v_out_323221.awb")

						arg_55_1:RecordAudio("323221013", var_58_11)
						arg_55_1:RecordAudio("323221013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_323221", "323221013", "story_v_out_323221.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_323221", "323221013", "story_v_out_323221.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play323221014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 323221014
		arg_59_1.duration_ = 6.13

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play323221015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_9000

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1059ui_story"]) and arg_59_1.var_.characterEffect1059ui_story == nil then
				arg_59_1.var_.characterEffect1059ui_story = arg_59_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1059ui_story"]) then
				if arg_59_1.var_.characterEffect1059ui_story and not isNil(arg_59_1.actors_["1059ui_story"]) then
					arg_59_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1059ui_story"]) and arg_59_1.var_.characterEffect1059ui_story then
				arg_59_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_1 = arg_59_1.var_.effect2323

				if not arg_59_1.var_.effect2323 then
					var_62_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_62_1.name = "2323"
					arg_59_1.var_.effect2323 = var_62_1
				else
					var_62_1.transform:SetParent(var_62_9000)
				end

				var_62_1.transform.localPosition = Vector3.New(0, 0, -0.68)
				var_62_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_62_1.transform.localScale = Vector3.New(var_62_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_62_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_62_1.transform.localScale.z)
			end

			if 2.3 < arg_59_1.time_ and arg_59_1.time_ <= 2.3 + arg_62_0 then
				if arg_59_1.var_.effect2323 then
					Object.Destroy(arg_59_1.var_.effect2323)

					arg_59_1.var_.effect2323 = nil
				end
			end

			local var_62_4 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			if arg_59_1.time_ >= var_62_4 + 1.33333333333333 and arg_59_1.time_ < var_62_4 + 1.33333333333333 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_5 = arg_59_1.actors_["1053ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1053ui_story = var_62_5.localPosition

				local var_62_6 = GameObjectTools.GetOrAddComponent(var_62_5.gameObject, typeof(DynamicBoneHelper))

				if var_62_6 then
					var_62_6:EnableDynamicBone(false)
				end
			end

			local var_62_7 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_7)
				var_62_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_5.position).x, (manager.ui.mainCamera.transform.position - var_62_5.position).y, (manager.ui.mainCamera.transform.position - var_62_5.position).z)
				var_62_5.localEulerAngles.z = 0
				var_62_5.localEulerAngles.x = 0
				var_62_5.localEulerAngles = var_62_5.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(0, 100, 0)
				var_62_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_5.position).x, (manager.ui.mainCamera.transform.position - var_62_5.position).y, (manager.ui.mainCamera.transform.position - var_62_5.position).z)
				var_62_5.localEulerAngles.z = 0
				var_62_5.localEulerAngles.x = 0
				var_62_5.localEulerAngles = var_62_5.localEulerAngles

				local var_62_8 = GameObjectTools.GetOrAddComponent(var_62_5.gameObject, typeof(DynamicBoneHelper))

				if var_62_8 then
					var_62_8:EnableDynamicBone(true)
				end
			end

			local var_62_9 = arg_59_1.actors_["1059ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1059ui_story = var_62_9.localPosition
			end

			local var_62_10 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_10 then
				var_62_9.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_10)
				var_62_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_9.position).x, (manager.ui.mainCamera.transform.position - var_62_9.position).y, (manager.ui.mainCamera.transform.position - var_62_9.position).z)
				var_62_9.localEulerAngles.z = 0
				var_62_9.localEulerAngles.x = 0
				var_62_9.localEulerAngles = var_62_9.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_10 and arg_59_1.time_ < 0 + var_62_10 + arg_62_0 then
				var_62_9.localPosition = Vector3.New(0, 100, 0)
				var_62_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_9.position).x, (manager.ui.mainCamera.transform.position - var_62_9.position).y, (manager.ui.mainCamera.transform.position - var_62_9.position).z)
				var_62_9.localEulerAngles.z = 0
				var_62_9.localEulerAngles.x = 0
				var_62_9.localEulerAngles = var_62_9.localEulerAngles
			end

			if 0.034000001847744 < arg_59_1.time_ and arg_59_1.time_ <= 0.034000001847744 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword08", "")
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_12 = 1.13333333333333
			local var_62_13 = 1.45

			if 1.13333333333333 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_14 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_14:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_15 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(323221014).content)

				arg_59_1.text_.text = var_62_15

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 58 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 58)

				if (58 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 58)) > 0 and var_62_13 < var_62_17 then
					arg_59_1.talkMaxDuration = var_62_17
					var_62_12 = var_62_12 + 0.3

					if var_62_17 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_17 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_15
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_18 = var_62_12 + 0.3
			local var_62_19 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_18 + var_62_19 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_18) / var_62_19

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_18 + var_62_19 and arg_59_1.time_ < var_62_18 + var_62_19 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play323221015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323221015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323221016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0.133333333333333 < arg_65_1.time_ and arg_65_1.time_ <= 0.133333333333333 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire02", "")
			end

			local var_68_1 = 0
			local var_68_2 = 1.55

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(323221015).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 62 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 62)

				if (62 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 62)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323221016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323221016
		arg_69_1.duration_ = 3.73

		local var_69_0 = {
			zh = 2.133,
			ja = 3.733
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
				arg_69_0:Play323221017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1053ui_story = arg_69_1.actors_["1053ui_story"].transform.localPosition

				local var_72_0 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_0 then
					var_72_0:EnableDynamicBone(false)
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_69_1.time_ - 0) / var_72_1)
				arg_69_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1053ui_story"].transform.position).z)
				arg_69_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1053ui_story"].transform.localEulerAngles = arg_69_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_69_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1053ui_story"].transform.position).z)
				arg_69_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1053ui_story"].transform.localEulerAngles = arg_69_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_72_2 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(true)
				end
			end

			local var_72_3 = arg_69_1.actors_["1053ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1053ui_story == nil then
				arg_69_1.var_.characterEffect1053ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect1053ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1053ui_story then
				arg_69_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_72_6 = 0
			local var_72_7 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
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

				local var_72_8 = arg_69_1:GetWordFromCfg(323221016)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 8 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 8)

				if (8 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 8)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221016", "story_v_out_323221.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_323221", "323221016", "story_v_out_323221.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_323221", "323221016", "story_v_out_323221.awb")

						arg_69_1:RecordAudio("323221016", var_72_13)
						arg_69_1:RecordAudio("323221016", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323221", "323221016", "story_v_out_323221.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323221", "323221016", "story_v_out_323221.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play323221017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323221017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323221018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1053ui_story"]) and arg_73_1.var_.characterEffect1053ui_story == nil then
				arg_73_1.var_.characterEffect1053ui_story = arg_73_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1053ui_story"]) then
				if arg_73_1.var_.characterEffect1053ui_story and not isNil(arg_73_1.actors_["1053ui_story"]) then
					arg_73_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1053ui_story"]) and arg_73_1.var_.characterEffect1053ui_story then
				arg_73_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.775

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(323221017).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 31 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 31)

				if (31 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 31)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play323221018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323221018
		arg_77_1.duration_ = 5.5

		local var_77_0 = {
			zh = 3.733,
			ja = 5.5
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323221019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1053ui_story = arg_77_1.actors_["1053ui_story"].transform.localPosition

				local var_80_0 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_0 then
					var_80_0:EnableDynamicBone(false)
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_77_1.time_ - 0) / var_80_1)
				arg_77_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1053ui_story"].transform.position).z)
				arg_77_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1053ui_story"].transform.localEulerAngles = arg_77_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_77_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1053ui_story"].transform.position).z)
				arg_77_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1053ui_story"].transform.localEulerAngles = arg_77_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_80_2 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(true)
				end
			end

			local var_80_3 = arg_77_1.actors_["1059ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1059ui_story == nil then
				arg_77_1.var_.characterEffect1059ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect1059ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1059ui_story then
				arg_77_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_80_6 = 0
			local var_80_7 = 0.275

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_8 = arg_77_1:GetWordFromCfg(323221018)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 11 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 11)

				if (11 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 11)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221018", "story_v_out_323221.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_323221", "323221018", "story_v_out_323221.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_323221", "323221018", "story_v_out_323221.awb")

						arg_77_1:RecordAudio("323221018", var_80_13)
						arg_77_1:RecordAudio("323221018", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323221", "323221018", "story_v_out_323221.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323221", "323221018", "story_v_out_323221.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play323221019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323221019
		arg_81_1.duration_ = 9.4

		local var_81_0 = {
			zh = 4.566,
			ja = 9.4
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
				arg_81_0:Play323221020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(323221019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 15 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 15)

				if (15 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 15)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221019", "story_v_out_323221.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221019", "story_v_out_323221.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_323221", "323221019", "story_v_out_323221.awb")

						arg_81_1:RecordAudio("323221019", var_84_6)
						arg_81_1:RecordAudio("323221019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323221", "323221019", "story_v_out_323221.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323221", "323221019", "story_v_out_323221.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323221020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323221020
		arg_85_1.duration_ = 4.1

		local var_85_0 = {
			zh = 1.733,
			ja = 4.1
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
				arg_85_0:Play323221021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1053ui_story"]) and arg_85_1.var_.characterEffect1053ui_story == nil then
				arg_85_1.var_.characterEffect1053ui_story = arg_85_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1053ui_story"]) then
				if arg_85_1.var_.characterEffect1053ui_story and not isNil(arg_85_1.actors_["1053ui_story"]) then
					arg_85_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1053ui_story"]) and arg_85_1.var_.characterEffect1053ui_story then
				arg_85_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_88_2 = arg_85_1.actors_["1059ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1059ui_story == nil then
				arg_85_1.var_.characterEffect1059ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect1059ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1059ui_story then
				arg_85_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_88_4 = 0
			local var_88_5 = 0.175

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
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

				local var_88_6 = arg_85_1:GetWordFromCfg(323221020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 7 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 7)

				if (7 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 7)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221020", "story_v_out_323221.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221020", "story_v_out_323221.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_323221", "323221020", "story_v_out_323221.awb")

						arg_85_1:RecordAudio("323221020", var_88_11)
						arg_85_1:RecordAudio("323221020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323221", "323221020", "story_v_out_323221.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323221", "323221020", "story_v_out_323221.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323221021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323221021
		arg_89_1.duration_ = 6.7

		local var_89_0 = {
			zh = 4.566,
			ja = 6.7
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
				arg_89_0:Play323221022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1059ui_story"]) and arg_89_1.var_.characterEffect1059ui_story == nil then
				arg_89_1.var_.characterEffect1059ui_story = arg_89_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1059ui_story"]) then
				if arg_89_1.var_.characterEffect1059ui_story and not isNil(arg_89_1.actors_["1059ui_story"]) then
					arg_89_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1059ui_story"]) and arg_89_1.var_.characterEffect1059ui_story then
				arg_89_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["1053ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1053ui_story == nil then
				arg_89_1.var_.characterEffect1053ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1053ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1053ui_story then
				arg_89_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_6 = arg_89_1:GetWordFromCfg(323221021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 17 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 17)

				if (17 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 17)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221021", "story_v_out_323221.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221021", "story_v_out_323221.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_323221", "323221021", "story_v_out_323221.awb")

						arg_89_1:RecordAudio("323221021", var_92_11)
						arg_89_1:RecordAudio("323221021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323221", "323221021", "story_v_out_323221.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323221", "323221021", "story_v_out_323221.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323221022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323221022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play323221023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1053ui_story = arg_93_1.actors_["1053ui_story"].transform.localPosition

				local var_96_0 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_0 then
					var_96_0:EnableDynamicBone(false)
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_1)
				arg_93_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).z)
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles = arg_93_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).z)
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles = arg_93_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_96_2 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(true)
				end
			end

			local var_96_3 = arg_93_1.actors_["1059ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1059ui_story = var_96_3.localPosition
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_4)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(0, 100, 0)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			local var_96_5 = arg_93_1.actors_["1059ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1059ui_story == nil then
				arg_93_1.var_.characterEffect1059ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.characterEffect1059ui_story and not isNil(var_96_5) then
					arg_93_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_6)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1059ui_story then
				arg_93_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_93_1.time_ and arg_93_1.time_ <= 0.200000002980232 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword09", "")
			end

			local var_96_8 = 0
			local var_96_9 = 1.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(323221022).content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_12 = 48 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_10) / 48)

				if (48 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_10) / 48)) > 0 and var_96_9 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_13 and arg_93_1.time_ < var_96_8 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play323221023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323221023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play323221024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.725

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(323221023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 29 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 29)

				if (29 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 29)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play323221024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323221024
		arg_101_1.duration_ = 6

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play323221025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_0 = arg_101_1.var_.effectsssfsssf

				if not arg_101_1.var_.effectsssfsssf then
					var_104_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), manager.ui.mainCamera.transform)
					var_104_0.name = "sssf"
					arg_101_1.var_.effectsssfsssf = var_104_0
				else
					var_104_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_104_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_104_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_104_0.transform.localScale = Vector3.New(var_104_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_104_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_104_0.transform.localScale.z)
			end

			local var_104_2 = arg_101_1.bgs_.J23h.transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPosJ23h = var_104_2.localPosition
			end

			local var_104_3 = 1.999999999999

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPosJ23h, Vector3.New(0, 1, 8), (arg_101_1.time_ - 0) / var_104_3)
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(0, 1, 8)
			end

			if 0.1 < arg_101_1.time_ and arg_101_1.time_ <= 0.1 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy01", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_5 = 1
			local var_104_6 = 1

			if 1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_7 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_7:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(323221024).content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 40 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 40)

				if (40 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 40)) > 0 and var_104_6 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10
					var_104_5 = var_104_5 + 0.3

					if var_104_10 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = var_104_5 + 0.3
			local var_104_12 = math.max(var_104_6, arg_101_1.talkMaxDuration)

			if var_104_5 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_11) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_11 + var_104_12 and arg_101_1.time_ < var_104_11 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "J23h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.999999999999,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play323221025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 323221025
		arg_107_1.duration_ = 2.47

		local var_107_0 = {
			zh = 1.033,
			ja = 2.466
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
				arg_107_0:Play323221026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1059ui_story"]) and arg_107_1.var_.characterEffect1059ui_story == nil then
				arg_107_1.var_.characterEffect1059ui_story = arg_107_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1059ui_story"]) then
				if arg_107_1.var_.characterEffect1059ui_story and not isNil(arg_107_1.actors_["1059ui_story"]) then
					arg_107_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1059ui_story"]) and arg_107_1.var_.characterEffect1059ui_story then
				arg_107_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_110_2 = 0
			local var_110_3 = 0.1

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:GetWordFromCfg(323221025)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 4 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 4)

				if (4 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 4)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221025", "story_v_out_323221.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_323221", "323221025", "story_v_out_323221.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_323221", "323221025", "story_v_out_323221.awb")

						arg_107_1:RecordAudio("323221025", var_110_9)
						arg_107_1:RecordAudio("323221025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_323221", "323221025", "story_v_out_323221.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_323221", "323221025", "story_v_out_323221.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play323221026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 323221026
		arg_111_1.duration_ = 5.83

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play323221027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_9000

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1059ui_story"]) and arg_111_1.var_.characterEffect1059ui_story == nil then
				arg_111_1.var_.characterEffect1059ui_story = arg_111_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1059ui_story"]) then
				if arg_111_1.var_.characterEffect1059ui_story and not isNil(arg_111_1.actors_["1059ui_story"]) then
					arg_111_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1059ui_story"]) and arg_111_1.var_.characterEffect1059ui_story then
				arg_111_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_114_1 = arg_111_1.bgs_.J23h.transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPosJ23h = var_114_1.localPosition
			end

			local var_114_2 = 0.366666669646899

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 then
				var_114_1.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPosJ23h, Vector3.New(0, 1, 5), (arg_111_1.time_ - 0) / var_114_2)
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 then
				var_114_1.localPosition = Vector3.New(0, 1, 5)
			end

			local var_114_3 = arg_111_1.bgs_.J23h.transform

			if 0.366666669646899 < arg_111_1.time_ and arg_111_1.time_ <= 0.366666669646899 + arg_114_0 then
				arg_111_1.var_.moveOldPosJ23h = var_114_3.localPosition
			end

			local var_114_4 = 0.799999997019768

			if 0.366666669646899 <= arg_111_1.time_ and arg_111_1.time_ < 0.366666669646899 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPosJ23h, Vector3.New(0, 1, 9), (arg_111_1.time_ - 0.366666669646899) / var_114_4)
			end

			if arg_111_1.time_ >= 0.366666669646899 + var_114_4 and arg_111_1.time_ < 0.366666669646899 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0, 1, 9)
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				if arg_111_1.var_.effectsssfsssf then
					Object.Destroy(arg_111_1.var_.effectsssfsssf)

					arg_111_1.var_.effectsssfsssf = nil
				end
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_6 = arg_111_1.var_.effect2344233

				if not arg_111_1.var_.effect2344233 then
					var_114_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_114_6.name = "233"
					arg_111_1.var_.effect2344233 = var_114_6
				else
					var_114_6.transform:SetParent(var_114_9000)
				end

				var_114_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_114_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_114_8 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_114_6.transform.localScale = Vector3.New(var_114_6.transform.localScale.x * var_114_8, var_114_6.transform.localScale.y * var_114_8, var_114_6.transform.localScale.z * var_114_8)
			end

			if 1.66666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 1.66666666666667 + arg_114_0 then
				if arg_111_1.var_.effect2344233 then
					Object.Destroy(arg_111_1.var_.effect2344233)

					arg_111_1.var_.effect2344233 = nil
				end
			end

			local var_114_10 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= var_114_10 + 1.66666666666667 and arg_111_1.time_ < var_114_10 + 1.66666666666667 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_12 = 0.833333333333333
			local var_114_13 = 1.575

			if 0.833333333333333 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_14 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_14:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_15 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(323221026).content)

				arg_111_1.text_.text = var_114_15

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 63 <= 0 and var_114_13 or var_114_13 * (utf8.len(var_114_15) / 63)

				if (63 <= 0 and var_114_13 or var_114_13 * (utf8.len(var_114_15) / 63)) > 0 and var_114_13 < var_114_17 then
					arg_111_1.talkMaxDuration = var_114_17
					var_114_12 = var_114_12 + 0.3

					if var_114_17 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_15
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = var_114_12 + 0.3
			local var_114_19 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_18 + var_114_19 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_18) / var_114_19

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_18 + var_114_19 and arg_111_1.time_ < var_114_18 + var_114_19 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "J23h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666669646899,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 1, 5),
					easeType = LeanTweenType.easeInBack
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J23h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.799999997019768,
				startTime = 0.366666669646899,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 5),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play323221027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323221027
		arg_117_1.duration_ = 9.82

		local var_117_0 = {
			zh = 7.825,
			ja = 9.825
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play323221028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.bgs_.MS2304 == nil then
				local var_120_0 = Object.Instantiate(arg_117_1.paintGo_)

				var_120_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2304")
				var_120_0.name = "MS2304"
				var_120_0.transform.parent = arg_117_1.stage_.transform
				var_120_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.bgs_.MS2304 = var_120_0
			end

			if 1.76666666666667 < arg_117_1.time_ and arg_117_1.time_ <= 1.76666666666667 + arg_120_0 then
				local var_120_1 = arg_117_1.bgs_.MS2304

				arg_117_1.bgs_.MS2304.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_2 = var_120_1:GetComponent("SpriteRenderer")

				if var_120_2 and var_120_2.sprite then
					local var_120_3 = 2 * (var_120_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_1.transform.localScale = Vector3.New(var_120_3 / var_120_2.sprite.bounds.size.y < var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x and var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x or var_120_3 / var_120_2.sprite.bounds.size.y, var_120_3 / var_120_2.sprite.bounds.size.y < var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x and var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x or var_120_3 / var_120_2.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "MS2304" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_4 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_4 + 0.3 and arg_117_1.time_ < var_120_4 + 0.3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_5 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_6 = 1.8

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_6 then
				local var_120_7 = Color.New(0, 0, 0)

				var_120_7.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_5) / var_120_6)
				arg_117_1.mask_.color = var_120_7
			end

			if arg_117_1.time_ >= var_120_5 + var_120_6 and arg_117_1.time_ < var_120_5 + var_120_6 + arg_120_0 then
				local var_120_8 = Color.New(0, 0, 0)

				var_120_8.a = 1
				arg_117_1.mask_.color = var_120_8
			end

			local var_120_9 = 1.8

			if 1.8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_10 = 1.8

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 then
				local var_120_11 = Color.New(0, 0, 0)

				var_120_11.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_9) / var_120_10)
				arg_117_1.mask_.color = var_120_11
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 then
				local var_120_12 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_12.a = 0
				arg_117_1.mask_.color = var_120_12
			end

			local var_120_13 = "1048ui_story"

			if arg_117_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_120_14 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_117_1.stage_.transform)

				var_120_14.name = var_120_13
				var_120_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_[var_120_13] = var_120_14

				local var_120_15 = var_120_14:GetComponentInChildren(typeof(CharacterEffect))

				var_120_15.enabled = true

				local var_120_16 = GameObjectTools.GetOrAddComponent(var_120_14, typeof(DynamicBoneHelper))

				if var_120_16 then
					var_120_16:EnableDynamicBone(false)
				end

				arg_117_1:ShowWeapon(var_120_15.transform, false)

				arg_117_1.var_[var_120_13 .. "Animator"] = var_120_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_117_1.var_[var_120_13 .. "Animator"].applyRootMotion = true
				arg_117_1.var_[var_120_13 .. "LipSync"] = var_120_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_120_17 = arg_117_1.actors_["1048ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_17) and arg_117_1.var_.characterEffect1048ui_story == nil then
				arg_117_1.var_.characterEffect1048ui_story = var_120_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_18 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_18 and not isNil(var_120_17) then
				if arg_117_1.var_.characterEffect1048ui_story and not isNil(var_120_17) then
					arg_117_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_18 and arg_117_1.time_ < 0 + var_120_18 + arg_120_0 and not isNil(var_120_17) and arg_117_1.var_.characterEffect1048ui_story then
				arg_117_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_120_20 = arg_117_1.bgs_.MS2304.transform

			if 1.8 < arg_117_1.time_ and arg_117_1.time_ <= 1.8 + arg_120_0 then
				arg_117_1.var_.moveOldPosMS2304 = var_120_20.localPosition
			end

			local var_120_21 = 1.8

			if 1.8 <= arg_117_1.time_ and arg_117_1.time_ < 1.8 + var_120_21 then
				var_120_20.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosMS2304, Vector3.New(0, 0.57, 5.77), (arg_117_1.time_ - 1.8) / var_120_21)
			end

			if arg_117_1.time_ >= 1.8 + var_120_21 and arg_117_1.time_ < 1.8 + var_120_21 + arg_120_0 then
				var_120_20.localPosition = Vector3.New(0, 0.57, 5.77)
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_22 = 3.425
			local var_120_23 = 0.375

			if 3.425 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_24 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_24:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_25 = arg_117_1:GetWordFromCfg(323221027)
				local var_120_26 = arg_117_1:FormatText(var_120_25.content)

				arg_117_1.text_.text = var_120_26

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 15 <= 0 and var_120_23 or var_120_23 * (utf8.len(var_120_26) / 15)

				if (15 <= 0 and var_120_23 or var_120_23 * (utf8.len(var_120_26) / 15)) > 0 and var_120_23 < var_120_28 then
					arg_117_1.talkMaxDuration = var_120_28
					var_120_22 = var_120_22 + 0.3

					if var_120_28 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_28 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_26
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221027", "story_v_out_323221.awb") ~= 0 then
					local var_120_29 = manager.audio:GetVoiceLength("story_v_out_323221", "323221027", "story_v_out_323221.awb") / 1000

					if var_120_29 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_22
					end

					if var_120_25.prefab_name ~= "" and arg_117_1.actors_[var_120_25.prefab_name] ~= nil then
						local var_120_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_25.prefab_name].transform, "story_v_out_323221", "323221027", "story_v_out_323221.awb")

						arg_117_1:RecordAudio("323221027", var_120_30)
						arg_117_1:RecordAudio("323221027", var_120_30)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323221", "323221027", "story_v_out_323221.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323221", "323221027", "story_v_out_323221.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_31 = var_120_22 + 0.3
			local var_120_32 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_22 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_31 + var_120_32 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_31) / var_120_32

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_31 + var_120_32 and arg_117_1.time_ < var_120_31 + var_120_32 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.8,
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.57, 5.77),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play323221028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 323221028
		arg_123_1.duration_ = 13.2

		local var_123_0 = {
			zh = 9.633,
			ja = 13.2
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play323221029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(323221028)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 40 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 40)

				if (40 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 40)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221028", "story_v_out_323221.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221028", "story_v_out_323221.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_323221", "323221028", "story_v_out_323221.awb")

						arg_123_1:RecordAudio("323221028", var_126_6)
						arg_123_1:RecordAudio("323221028", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_323221", "323221028", "story_v_out_323221.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_323221", "323221028", "story_v_out_323221.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play323221029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 323221029
		arg_127_1.duration_ = 2.27

		local var_127_0 = {
			zh = 2,
			ja = 2.266
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play323221030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1059ui_story"]) and arg_127_1.var_.characterEffect1059ui_story == nil then
				arg_127_1.var_.characterEffect1059ui_story = arg_127_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1059ui_story"]) then
				if arg_127_1.var_.characterEffect1059ui_story and not isNil(arg_127_1.actors_["1059ui_story"]) then
					arg_127_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1059ui_story"]) and arg_127_1.var_.characterEffect1059ui_story then
				arg_127_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_130_2 = arg_127_1.actors_["1048ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1048ui_story == nil then
				arg_127_1.var_.characterEffect1048ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.characterEffect1048ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_3)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1048ui_story then
				arg_127_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_130_4 = 0
			local var_130_5 = 0.125

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_6 = arg_127_1:GetWordFromCfg(323221029)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 5 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 5)

				if (5 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 5)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221029", "story_v_out_323221.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221029", "story_v_out_323221.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_323221", "323221029", "story_v_out_323221.awb")

						arg_127_1:RecordAudio("323221029", var_130_11)
						arg_127_1:RecordAudio("323221029", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_323221", "323221029", "story_v_out_323221.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_323221", "323221029", "story_v_out_323221.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play323221030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 323221030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play323221031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1059ui_story"]) and arg_131_1.var_.characterEffect1059ui_story == nil then
				arg_131_1.var_.characterEffect1059ui_story = arg_131_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1059ui_story"]) then
				if arg_131_1.var_.characterEffect1059ui_story and not isNil(arg_131_1.actors_["1059ui_story"]) then
					arg_131_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1059ui_story"]) and arg_131_1.var_.characterEffect1059ui_story then
				arg_131_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 1.1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(323221030).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 44 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 44)

				if (44 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 44)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play323221031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 323221031
		arg_135_1.duration_ = 6.37

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play323221032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_9000

			if 0.166666666666 < arg_135_1.time_ and arg_135_1.time_ <= 0.166666666666 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_148", "se_story_148_magic_fire02", "")
			end

			local var_138_1 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_2 = 0.566666666666667

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = Color.New(1, 1, 1)

				var_138_3.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_1) / var_138_2)
				arg_135_1.mask_.color = var_138_3
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				local var_138_4 = Color.New(1, 1, 1)

				arg_135_1.mask_.enabled = false
				var_138_4.a = 0
				arg_135_1.mask_.color = var_138_4
			end

			local var_138_5 = arg_135_1.bgs_.MS2304.transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPosMS2304 = var_138_5.localPosition
			end

			local var_138_6 = 0.666666666666667

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosMS2304, Vector3.New(0, 0.87, 7.47), (arg_135_1.time_ - 0) / var_138_6)
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(0, 0.87, 7.47)
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_7 = arg_135_1.var_.effect233

				if not arg_135_1.var_.effect233 then
					var_138_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_138_7.name = "233"
					arg_135_1.var_.effect233 = var_138_7
				else
					var_138_7.transform:SetParent(var_138_9000)
				end

				var_138_7.transform.localPosition = Vector3.New(0, 0, -3.79)
				var_138_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_138_7.transform.localScale = Vector3.New(var_138_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_138_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_138_7.transform.localScale.z)
			end

			local var_138_9 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_9 + 1.7 and arg_135_1.time_ < var_138_9 + 1.7 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_10 = 1.36666666666667
			local var_138_11 = 1.05

			if 1.36666666666667 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_12 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_12:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(323221031).content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 42 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 42)

				if (42 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 42)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15
					var_138_10 = var_138_10 + 0.3

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = var_138_10 + 0.3
			local var_138_17 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_16) / var_138_17

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.666666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.42, -1.59, -5.4),
					endPos = Vector3.New(0, 0.87, 7.47),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play323221032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323221032
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play323221033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(323221032).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 48 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 48)

				if (48 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 48)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play323221033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323221033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play323221034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(323221033).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 57 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 57)

				if (57 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 57)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play323221034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 323221034
		arg_149_1.duration_ = 5.5

		local var_149_0 = {
			zh = 4.6,
			ja = 5.5
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
				arg_149_0:Play323221035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1059ui_story"]) and arg_149_1.var_.characterEffect1059ui_story == nil then
				arg_149_1.var_.characterEffect1059ui_story = arg_149_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1059ui_story"]) then
				if arg_149_1.var_.characterEffect1059ui_story and not isNil(arg_149_1.actors_["1059ui_story"]) then
					arg_149_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1059ui_story"]) and arg_149_1.var_.characterEffect1059ui_story then
				arg_149_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_152_2 = 0
			local var_152_3 = 0.475

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:GetWordFromCfg(323221034)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 19 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 19)

				if (19 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 19)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221034", "story_v_out_323221.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_323221", "323221034", "story_v_out_323221.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_323221", "323221034", "story_v_out_323221.awb")

						arg_149_1:RecordAudio("323221034", var_152_9)
						arg_149_1:RecordAudio("323221034", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_323221", "323221034", "story_v_out_323221.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_323221", "323221034", "story_v_out_323221.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play323221035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 323221035
		arg_153_1.duration_ = 8.4

		local var_153_0 = {
			zh = 4.8,
			ja = 8.4
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
				arg_153_0:Play323221036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1048ui_story"]) and arg_153_1.var_.characterEffect1048ui_story == nil then
				arg_153_1.var_.characterEffect1048ui_story = arg_153_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1048ui_story"]) then
				if arg_153_1.var_.characterEffect1048ui_story and not isNil(arg_153_1.actors_["1048ui_story"]) then
					arg_153_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1048ui_story"]) and arg_153_1.var_.characterEffect1048ui_story then
				arg_153_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1059ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1059ui_story == nil then
				arg_153_1.var_.characterEffect1059ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1059ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1059ui_story then
				arg_153_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(323221035)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 20 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 20)

				if (20 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 20)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221035", "story_v_out_323221.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_323221", "323221035", "story_v_out_323221.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_323221", "323221035", "story_v_out_323221.awb")

						arg_153_1:RecordAudio("323221035", var_156_11)
						arg_153_1:RecordAudio("323221035", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_323221", "323221035", "story_v_out_323221.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_323221", "323221035", "story_v_out_323221.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play323221036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 323221036
		arg_157_1.duration_ = 13.07

		local var_157_0 = {
			zh = 10.7,
			ja = 13.066
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play323221037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.05

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(323221036)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 42 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 42)

				if (42 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 42)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221036", "story_v_out_323221.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221036", "story_v_out_323221.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_323221", "323221036", "story_v_out_323221.awb")

						arg_157_1:RecordAudio("323221036", var_160_6)
						arg_157_1:RecordAudio("323221036", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_323221", "323221036", "story_v_out_323221.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_323221", "323221036", "story_v_out_323221.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play323221037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 323221037
		arg_161_1.duration_ = 10.23

		local var_161_0 = {
			zh = 7.533,
			ja = 10.233
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play323221038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.775

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(323221037)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 31 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 31)

				if (31 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 31)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221037", "story_v_out_323221.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221037", "story_v_out_323221.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_323221", "323221037", "story_v_out_323221.awb")

						arg_161_1:RecordAudio("323221037", var_164_6)
						arg_161_1:RecordAudio("323221037", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_323221", "323221037", "story_v_out_323221.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_323221", "323221037", "story_v_out_323221.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play323221038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 323221038
		arg_165_1.duration_ = 12.83

		local var_165_0 = {
			zh = 9.566,
			ja = 12.833
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play323221039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.05

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(323221038)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 42 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 42)

				if (42 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 42)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221038", "story_v_out_323221.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221038", "story_v_out_323221.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_323221", "323221038", "story_v_out_323221.awb")

						arg_165_1:RecordAudio("323221038", var_168_6)
						arg_165_1:RecordAudio("323221038", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_323221", "323221038", "story_v_out_323221.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_323221", "323221038", "story_v_out_323221.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play323221039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 323221039
		arg_169_1.duration_ = 12.37

		local var_169_0 = {
			zh = 6.9,
			ja = 12.366
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
				arg_169_0:Play323221040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.75

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(323221039)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 30 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 30)

				if (30 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 30)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221039", "story_v_out_323221.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_323221", "323221039", "story_v_out_323221.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_323221", "323221039", "story_v_out_323221.awb")

						arg_169_1:RecordAudio("323221039", var_172_6)
						arg_169_1:RecordAudio("323221039", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_323221", "323221039", "story_v_out_323221.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_323221", "323221039", "story_v_out_323221.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play323221040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 323221040
		arg_173_1.duration_ = 6.17

		local var_173_0 = {
			zh = 4.9,
			ja = 6.166
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
				arg_173_0:Play323221041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= 0 + 1.23333333333333 and arg_173_1.time_ < 0 + 1.23333333333333 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end

			local var_176_0 = 0
			local var_176_1 = 0.5

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(323221040)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 20 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 20)

				if (20 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 20)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221040", "story_v_out_323221.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_out_323221", "323221040", "story_v_out_323221.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_out_323221", "323221040", "story_v_out_323221.awb")

						arg_173_1:RecordAudio("323221040", var_176_7)
						arg_173_1:RecordAudio("323221040", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_323221", "323221040", "story_v_out_323221.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_323221", "323221040", "story_v_out_323221.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play323221041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 323221041
		arg_177_1.duration_ = 3.52

		local var_177_0 = {
			zh = 3.35,
			ja = 3.516
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
			arg_177_1.auto_ = false
		end

		function arg_177_1.playNext_(arg_179_0)
			arg_177_1.onStoryFinished_()
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_9000

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				if arg_177_1.var_.effect233 then
					Object.Destroy(arg_177_1.var_.effect233)

					arg_177_1.var_.effect233 = nil
				end
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_1 = arg_177_1.var_.effectwewe

				if not arg_177_1.var_.effectwewe then
					var_180_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_180_1.name = "wewe"
					arg_177_1.var_.effectwewe = var_180_1
				else
					var_180_1.transform:SetParent(var_180_9000)
				end

				var_180_1.transform.localPosition = Vector3.New(0, 0, -1.7)
				var_180_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_180_3 = arg_177_1.bgs_.MS2304.transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPosMS2304 = var_180_3.localPosition
			end

			local var_180_4 = 1.899999999999

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_3.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPosMS2304, Vector3.New(0, -1.02, -0.07), (arg_177_1.time_ - 0) / var_180_4)
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_3.localPosition = Vector3.New(0, -1.02, -0.07)
			end

			local var_180_5 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_5 + 2.13333333333333 and arg_177_1.time_ < var_180_5 + 2.13333333333333 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_6 = 1.75
			local var_180_7 = 0.15

			if 1.75 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_8 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_8:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(323221041)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 6 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_10) / 6)

				if (6 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_10) / 6)) > 0 and var_180_7 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12
					var_180_6 = var_180_6 + 0.3

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323221", "323221041", "story_v_out_323221.awb") ~= 0 then
					local var_180_13 = manager.audio:GetVoiceLength("story_v_out_323221", "323221041", "story_v_out_323221.awb") / 1000

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_out_323221", "323221041", "story_v_out_323221.awb")

						arg_177_1:RecordAudio("323221041", var_180_14)
						arg_177_1:RecordAudio("323221041", var_180_14)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_323221", "323221041", "story_v_out_323221.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_323221", "323221041", "story_v_out_323221.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = var_180_6 + 0.3
			local var_180_16 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_16 and arg_177_1.time_ < var_180_15 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.899999999999,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.73, -0.31),
					endPos = Vector3.New(0, -1.02, -0.07),
					easeType = LeanTweenType.animationCurve
				}
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J23h",
		"TextureConfig/Background/MS2304"
	},
	voices = {
		"story_v_out_323221.awb"
	}
}
