return {
	Play324502001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324502001
		arg_1_1.duration_ = 7.97

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324502002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J21h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_4_0.name = "J21h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J21h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J21h

				arg_1_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J21h" then
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

			local var_4_9 = "10170ui_story"

			if arg_1_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10170ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect10170ui_story == nil then
				arg_1_1.var_.characterEffect10170ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect10170ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect10170ui_story then
				arg_1_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			local var_4_21 = 1.73333333333333
			local var_4_22 = 0.675

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(324502001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 27 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 27)

				if (27 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 27)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502001", "story_v_out_324502.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_324502", "324502001", "story_v_out_324502.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_324502", "324502001", "story_v_out_324502.awb")

						arg_1_1:RecordAudio("324502001", var_4_29)
						arg_1_1:RecordAudio("324502001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324502", "324502001", "story_v_out_324502.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324502", "324502001", "story_v_out_324502.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324502002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324502002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324502003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["10170ui_story"]) and arg_8_1.var_.characterEffect10170ui_story == nil then
				arg_8_1.var_.characterEffect10170ui_story = arg_8_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["10170ui_story"]) then
				if arg_8_1.var_.characterEffect10170ui_story and not isNil(arg_8_1.actors_["10170ui_story"]) then
					arg_8_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["10170ui_story"]) and arg_8_1.var_.characterEffect10170ui_story then
				arg_8_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.875

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(324502002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 35 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 35)

				if (35 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 35)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324502003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324502003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324502004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.3

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324502003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 12 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 12)

				if (12 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 12)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324502004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324502004
		arg_16_1.duration_ = 3.17

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324502005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10170ui_story = arg_16_1.actors_["10170ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10170ui_story"].transform.position).z)
				arg_16_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10170ui_story"].transform.localEulerAngles = arg_16_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_16_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10170ui_story"].transform.position).z)
				arg_16_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10170ui_story"].transform.localEulerAngles = arg_16_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["10170ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect10170ui_story == nil then
				arg_16_1.var_.characterEffect10170ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect10170ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect10170ui_story then
				arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(324502004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 8 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 8)

				if (8 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 8)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502004", "story_v_out_324502.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502004", "story_v_out_324502.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_324502", "324502004", "story_v_out_324502.awb")

						arg_16_1:RecordAudio("324502004", var_19_13)
						arg_16_1:RecordAudio("324502004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324502", "324502004", "story_v_out_324502.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324502", "324502004", "story_v_out_324502.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play324502005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324502005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324502006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["10170ui_story"]) and arg_20_1.var_.characterEffect10170ui_story == nil then
				arg_20_1.var_.characterEffect10170ui_story = arg_20_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["10170ui_story"]) then
				if arg_20_1.var_.characterEffect10170ui_story and not isNil(arg_20_1.actors_["10170ui_story"]) then
					arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["10170ui_story"]) and arg_20_1.var_.characterEffect10170ui_story then
				arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.7

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(324502005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 28 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 28)

				if (28 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 28)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324502006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324502006
		arg_24_1.duration_ = 3.4

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324502007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10170ui_story"]) and arg_24_1.var_.characterEffect10170ui_story == nil then
				arg_24_1.var_.characterEffect10170ui_story = arg_24_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10170ui_story"]) then
				if arg_24_1.var_.characterEffect10170ui_story and not isNil(arg_24_1.actors_["10170ui_story"]) then
					arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10170ui_story"]) and arg_24_1.var_.characterEffect10170ui_story then
				arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_2 = 0
			local var_27_3 = 0.4

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(324502006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 16 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 16)

				if (16 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 16)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502006", "story_v_out_324502.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502006", "story_v_out_324502.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_324502", "324502006", "story_v_out_324502.awb")

						arg_24_1:RecordAudio("324502006", var_27_9)
						arg_24_1:RecordAudio("324502006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324502", "324502006", "story_v_out_324502.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324502", "324502006", "story_v_out_324502.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324502007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324502007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324502008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10170ui_story"]) and arg_28_1.var_.characterEffect10170ui_story == nil then
				arg_28_1.var_.characterEffect10170ui_story = arg_28_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10170ui_story"]) then
				if arg_28_1.var_.characterEffect10170ui_story and not isNil(arg_28_1.actors_["10170ui_story"]) then
					arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10170ui_story"]) and arg_28_1.var_.characterEffect10170ui_story then
				arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.225

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(324502007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 9 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 9)

				if (9 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 9)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324502008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324502008
		arg_32_1.duration_ = 1.33

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324502009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10170ui_story"]) and arg_32_1.var_.characterEffect10170ui_story == nil then
				arg_32_1.var_.characterEffect10170ui_story = arg_32_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10170ui_story"]) then
				if arg_32_1.var_.characterEffect10170ui_story and not isNil(arg_32_1.actors_["10170ui_story"]) then
					arg_32_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10170ui_story"]) and arg_32_1.var_.characterEffect10170ui_story then
				arg_32_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_35_2 = 0
			local var_35_3 = 0.1

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(324502008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 4 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 4)

				if (4 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 4)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502008", "story_v_out_324502.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502008", "story_v_out_324502.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_324502", "324502008", "story_v_out_324502.awb")

						arg_32_1:RecordAudio("324502008", var_35_9)
						arg_32_1:RecordAudio("324502008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324502", "324502008", "story_v_out_324502.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324502", "324502008", "story_v_out_324502.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324502009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324502009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324502010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10170ui_story"]) and arg_36_1.var_.characterEffect10170ui_story == nil then
				arg_36_1.var_.characterEffect10170ui_story = arg_36_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10170ui_story"]) then
				if arg_36_1.var_.characterEffect10170ui_story and not isNil(arg_36_1.actors_["10170ui_story"]) then
					arg_36_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10170ui_story"]) and arg_36_1.var_.characterEffect10170ui_story then
				arg_36_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(324502009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 15 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 15)

				if (15 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 15)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324502010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324502010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324502011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10170ui_story = arg_40_1.actors_["10170ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10170ui_story"].transform.position).z)
				arg_40_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10170ui_story"].transform.localEulerAngles = arg_40_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10170ui_story"].transform.position).z)
				arg_40_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10170ui_story"].transform.localEulerAngles = arg_40_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = 0
			local var_43_4 = 1.025

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(324502010).content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 41 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 41)

				if (41 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 41)) > 0 and var_43_4 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_8 and arg_40_1.time_ < var_43_3 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play324502011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324502011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324502012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.2

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(324502011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 48 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 48)

				if (48 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 48)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324502012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324502012
		arg_48_1.duration_ = 4.5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324502013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10170ui_story = arg_48_1.actors_["10170ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10170ui_story"].transform.position).z)
				arg_48_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10170ui_story"].transform.localEulerAngles = arg_48_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_48_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10170ui_story"].transform.position).z)
				arg_48_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10170ui_story"].transform.localEulerAngles = arg_48_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["10170ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect10170ui_story == nil then
				arg_48_1.var_.characterEffect10170ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect10170ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect10170ui_story then
				arg_48_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_6 = 0
			local var_51_7 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(324502012)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 19 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 19)

				if (19 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 19)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502012", "story_v_out_324502.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502012", "story_v_out_324502.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_324502", "324502012", "story_v_out_324502.awb")

						arg_48_1:RecordAudio("324502012", var_51_13)
						arg_48_1:RecordAudio("324502012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324502", "324502012", "story_v_out_324502.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324502", "324502012", "story_v_out_324502.awb")
				end

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

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play324502013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324502013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324502014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10170ui_story"]) and arg_52_1.var_.characterEffect10170ui_story == nil then
				arg_52_1.var_.characterEffect10170ui_story = arg_52_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10170ui_story"]) then
				if arg_52_1.var_.characterEffect10170ui_story and not isNil(arg_52_1.actors_["10170ui_story"]) then
					arg_52_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10170ui_story"]) and arg_52_1.var_.characterEffect10170ui_story then
				arg_52_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(324502013).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 12 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 12)

				if (12 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 12)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324502014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324502014
		arg_56_1.duration_ = 1.6

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324502015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10170ui_story"]) and arg_56_1.var_.characterEffect10170ui_story == nil then
				arg_56_1.var_.characterEffect10170ui_story = arg_56_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10170ui_story"]) then
				if arg_56_1.var_.characterEffect10170ui_story and not isNil(arg_56_1.actors_["10170ui_story"]) then
					arg_56_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10170ui_story"]) and arg_56_1.var_.characterEffect10170ui_story then
				arg_56_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_59_2 = 0
			local var_59_3 = 0.15

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(324502014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 6 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 6)

				if (6 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 6)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502014", "story_v_out_324502.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502014", "story_v_out_324502.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_324502", "324502014", "story_v_out_324502.awb")

						arg_56_1:RecordAudio("324502014", var_59_9)
						arg_56_1:RecordAudio("324502014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324502", "324502014", "story_v_out_324502.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324502", "324502014", "story_v_out_324502.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324502015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324502015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324502016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10170ui_story"]) and arg_60_1.var_.characterEffect10170ui_story == nil then
				arg_60_1.var_.characterEffect10170ui_story = arg_60_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10170ui_story"]) then
				if arg_60_1.var_.characterEffect10170ui_story and not isNil(arg_60_1.actors_["10170ui_story"]) then
					arg_60_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10170ui_story"]) and arg_60_1.var_.characterEffect10170ui_story then
				arg_60_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.075

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(324502015).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 3 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 3)

				if (3 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 3)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324502016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324502016
		arg_64_1.duration_ = 5.2

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324502017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10170ui_story"]) and arg_64_1.var_.characterEffect10170ui_story == nil then
				arg_64_1.var_.characterEffect10170ui_story = arg_64_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10170ui_story"]) then
				if arg_64_1.var_.characterEffect10170ui_story and not isNil(arg_64_1.actors_["10170ui_story"]) then
					arg_64_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10170ui_story"]) and arg_64_1.var_.characterEffect10170ui_story then
				arg_64_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_2")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_67_2 = 0
			local var_67_3 = 0.425

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(324502016)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 17 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 17)

				if (17 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 17)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502016", "story_v_out_324502.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502016", "story_v_out_324502.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_324502", "324502016", "story_v_out_324502.awb")

						arg_64_1:RecordAudio("324502016", var_67_9)
						arg_64_1:RecordAudio("324502016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324502", "324502016", "story_v_out_324502.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324502", "324502016", "story_v_out_324502.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324502017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324502017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324502018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10170ui_story = arg_68_1.actors_["10170ui_story"].transform.localPosition

				local var_71_0 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_0 then
					var_71_0:EnableDynamicBone(false)
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_1)
				arg_68_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10170ui_story"].transform.position).z)
				arg_68_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["10170ui_story"].transform.localEulerAngles = arg_68_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10170ui_story"].transform.position).z)
				arg_68_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["10170ui_story"].transform.localEulerAngles = arg_68_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(true)
				end
			end

			local var_71_3 = arg_68_1.actors_["10170ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect10170ui_story == nil then
				arg_68_1.var_.characterEffect10170ui_story = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect10170ui_story and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_4)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect10170ui_story then
				arg_68_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_71_5 = 0
			local var_71_6 = 1.5

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_7 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(324502017).content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 60 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_7) / 60)

				if (60 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_7) / 60)) > 0 and var_71_6 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_10 and arg_68_1.time_ < var_71_5 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play324502018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324502018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324502019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.275

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(324502018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 51 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 51)

				if (51 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 51)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324502019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324502019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324502020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.45

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(324502019).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 18 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 18)

				if (18 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 18)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324502020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324502020
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324502021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10170ui_story = arg_80_1.actors_["10170ui_story"].transform.localPosition

				local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_0 then
					var_83_0:EnableDynamicBone(false)
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_80_1.time_ - 0) / var_83_1)
				arg_80_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10170ui_story"].transform.position).z)
				arg_80_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10170ui_story"].transform.localEulerAngles = arg_80_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_80_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10170ui_story"].transform.position).z)
				arg_80_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10170ui_story"].transform.localEulerAngles = arg_80_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_83_2 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(true)
				end
			end

			local var_83_3 = arg_80_1.actors_["10170ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect10170ui_story == nil then
				arg_80_1.var_.characterEffect10170ui_story = var_83_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_4 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 and not isNil(var_83_3) then
				if arg_80_1.var_.characterEffect10170ui_story and not isNil(var_83_3) then
					arg_80_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect10170ui_story then
				arg_80_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_83_6 = 0
			local var_83_7 = 0.175

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:GetWordFromCfg(324502020)
				local var_83_9 = arg_80_1:FormatText(var_83_8.content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 7 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_9) / 7)

				if (7 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_9) / 7)) > 0 and var_83_7 < var_83_11 then
					arg_80_1.talkMaxDuration = var_83_11

					if var_83_11 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502020", "story_v_out_324502.awb") ~= 0 then
					local var_83_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502020", "story_v_out_324502.awb") / 1000

					if var_83_12 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_6
					end

					if var_83_8.prefab_name ~= "" and arg_80_1.actors_[var_83_8.prefab_name] ~= nil then
						local var_83_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_8.prefab_name].transform, "story_v_out_324502", "324502020", "story_v_out_324502.awb")

						arg_80_1:RecordAudio("324502020", var_83_13)
						arg_80_1:RecordAudio("324502020", var_83_13)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324502", "324502020", "story_v_out_324502.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324502", "324502020", "story_v_out_324502.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play324502021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324502021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324502022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10170ui_story"]) and arg_84_1.var_.characterEffect10170ui_story == nil then
				arg_84_1.var_.characterEffect10170ui_story = arg_84_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10170ui_story"]) then
				if arg_84_1.var_.characterEffect10170ui_story and not isNil(arg_84_1.actors_["10170ui_story"]) then
					arg_84_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10170ui_story"]) and arg_84_1.var_.characterEffect10170ui_story then
				arg_84_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.35

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(324502021).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 14 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 14)

				if (14 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 14)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324502022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324502022
		arg_88_1.duration_ = 2

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324502023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10170ui_story"]) and arg_88_1.var_.characterEffect10170ui_story == nil then
				arg_88_1.var_.characterEffect10170ui_story = arg_88_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10170ui_story"]) then
				if arg_88_1.var_.characterEffect10170ui_story and not isNil(arg_88_1.actors_["10170ui_story"]) then
					arg_88_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10170ui_story"]) and arg_88_1.var_.characterEffect10170ui_story then
				arg_88_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_2")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_91_2 = 0
			local var_91_3 = 0.2

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(324502022)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 8 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 8)

				if (8 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 8)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502022", "story_v_out_324502.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502022", "story_v_out_324502.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_324502", "324502022", "story_v_out_324502.awb")

						arg_88_1:RecordAudio("324502022", var_91_9)
						arg_88_1:RecordAudio("324502022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324502", "324502022", "story_v_out_324502.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324502", "324502022", "story_v_out_324502.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324502023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324502023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324502024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10170ui_story"]) and arg_92_1.var_.characterEffect10170ui_story == nil then
				arg_92_1.var_.characterEffect10170ui_story = arg_92_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10170ui_story"]) then
				if arg_92_1.var_.characterEffect10170ui_story and not isNil(arg_92_1.actors_["10170ui_story"]) then
					arg_92_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10170ui_story"]) and arg_92_1.var_.characterEffect10170ui_story then
				arg_92_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.5

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(324502023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 20 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 20)

				if (20 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 20)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play324502024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324502024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324502025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10170ui_story = arg_96_1.actors_["10170ui_story"].transform.localPosition

				local var_99_0 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_0 then
					var_99_0:EnableDynamicBone(false)
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_1)
				arg_96_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10170ui_story"].transform.position).z)
				arg_96_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10170ui_story"].transform.localEulerAngles = arg_96_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10170ui_story"].transform.position).z)
				arg_96_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10170ui_story"].transform.localEulerAngles = arg_96_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_99_2 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(true)
				end
			end

			local var_99_3 = 0
			local var_99_4 = 0.675

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_3 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_5 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(324502024).content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 27 <= 0 and var_99_4 or var_99_4 * (utf8.len(var_99_5) / 27)

				if (27 <= 0 and var_99_4 or var_99_4 * (utf8.len(var_99_5) / 27)) > 0 and var_99_4 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_3 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_3
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_4, arg_96_1.talkMaxDuration)

			if var_99_3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_3 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_3) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_3 + var_99_8 and arg_96_1.time_ < var_99_3 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play324502025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324502025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324502026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(324502025).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 4 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 4)

				if (4 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 4)) > 0 and var_103_0 < var_103_3 then
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
	Play324502026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324502026
		arg_104_1.duration_ = 2

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324502027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10170ui_story = arg_104_1.actors_["10170ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10170ui_story"].transform.position).z)
				arg_104_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["10170ui_story"].transform.localEulerAngles = arg_104_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_104_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10170ui_story"].transform.position).z)
				arg_104_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["10170ui_story"].transform.localEulerAngles = arg_104_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["10170ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect10170ui_story == nil then
				arg_104_1.var_.characterEffect10170ui_story = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect10170ui_story and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect10170ui_story then
				arg_104_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.075

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(324502026)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 3 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 3)

				if (3 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 3)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502026", "story_v_out_324502.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502026", "story_v_out_324502.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_324502", "324502026", "story_v_out_324502.awb")

						arg_104_1:RecordAudio("324502026", var_107_13)
						arg_104_1:RecordAudio("324502026", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_324502", "324502026", "story_v_out_324502.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_324502", "324502026", "story_v_out_324502.awb")
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
				actorName = "10170ui_story",
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
	Play324502027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324502027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324502028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10170ui_story"]) and arg_108_1.var_.characterEffect10170ui_story == nil then
				arg_108_1.var_.characterEffect10170ui_story = arg_108_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10170ui_story"]) then
				if arg_108_1.var_.characterEffect10170ui_story and not isNil(arg_108_1.actors_["10170ui_story"]) then
					arg_108_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10170ui_story"]) and arg_108_1.var_.characterEffect10170ui_story then
				arg_108_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.25

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(324502027).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 10 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 10)

				if (10 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 10)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324502028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324502028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324502029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10170ui_story = arg_112_1.actors_["10170ui_story"].transform.localPosition

				local var_115_0 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_0 then
					var_115_0:EnableDynamicBone(false)
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_1)
				arg_112_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10170ui_story"].transform.position).z)
				arg_112_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["10170ui_story"].transform.localEulerAngles = arg_112_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10170ui_story"].transform.position).z)
				arg_112_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["10170ui_story"].transform.localEulerAngles = arg_112_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_115_2 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(true)
				end
			end

			local var_115_3 = 0
			local var_115_4 = 1.3

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_5 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(324502028).content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 52 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 52)

				if (52 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 52)) > 0 and var_115_4 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_3) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_3 + var_115_8 and arg_112_1.time_ < var_115_3 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play324502029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324502029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324502030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.725

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(324502029).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 29 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 29)

				if (29 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 29)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play324502030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324502030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324502031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_123_1 = 0
			local var_123_2 = 0.15

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(324502030).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 6 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 6)

				if (6 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 6)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324502031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324502031
		arg_124_1.duration_ = 2

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324502032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10170ui_story = arg_124_1.actors_["10170ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10170ui_story"].transform.position).z)
				arg_124_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["10170ui_story"].transform.localEulerAngles = arg_124_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_124_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10170ui_story"].transform.position).z)
				arg_124_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["10170ui_story"].transform.localEulerAngles = arg_124_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = arg_124_1.actors_["10170ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect10170ui_story == nil then
				arg_124_1.var_.characterEffect10170ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect10170ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect10170ui_story then
				arg_124_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_2")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_127_6 = 0
			local var_127_7 = 0.0329999998211861

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(324502031)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 1 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 1)

				if (1 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 1)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502031", "story_v_out_324502.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502031", "story_v_out_324502.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_324502", "324502031", "story_v_out_324502.awb")

						arg_124_1:RecordAudio("324502031", var_127_13)
						arg_124_1:RecordAudio("324502031", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324502", "324502031", "story_v_out_324502.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324502", "324502031", "story_v_out_324502.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play324502032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324502032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324502033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10170ui_story = arg_128_1.actors_["10170ui_story"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10170ui_story"].transform.position).z)
				arg_128_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10170ui_story"].transform.localEulerAngles = arg_128_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10170ui_story"].transform.position).z)
				arg_128_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10170ui_story"].transform.localEulerAngles = arg_128_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["10170ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect10170ui_story == nil then
				arg_128_1.var_.characterEffect10170ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect10170ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_4)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect10170ui_story then
				arg_128_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			if 0.8 < arg_128_1.time_ and arg_128_1.time_ <= 0.8 + arg_131_0 then
				arg_128_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_131_6 = 0
			local var_131_7 = 0.9

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(324502032).content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 36 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_8) / 36)

				if (36 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_8) / 36)) > 0 and var_131_7 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_11 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_11

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_11 and arg_128_1.time_ < var_131_6 + var_131_11 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play324502033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324502033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324502034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 1.525

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(324502033).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 61 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 61)

				if (61 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 61)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324502034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324502034
		arg_136_1.duration_ = 7.23

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324502035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if arg_136_1.bgs_.STblack == nil then
				local var_139_0 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_139_0.name = "STblack"
				var_139_0.transform.parent = arg_136_1.stage_.transform
				var_139_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_.STblack = var_139_0
			end

			if 1 < arg_136_1.time_ and arg_136_1.time_ <= 1 + arg_139_0 then
				local var_139_1 = arg_136_1.bgs_.STblack

				arg_136_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_139_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_2 = var_139_1:GetComponent("SpriteRenderer")

				if var_139_2 and var_139_2.sprite then
					local var_139_3 = 2 * (var_139_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_139_1.transform.localScale = Vector3.New(var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "STblack" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_4 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			if arg_136_1.time_ >= var_139_4 + 0.3 and arg_136_1.time_ < var_139_4 + 0.3 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_5 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_6 = 1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 then
				local var_139_7 = Color.New(0, 0, 0)

				var_139_7.a = Mathf.Lerp(0, 1, (arg_136_1.time_ - var_139_5) / var_139_6)
				arg_136_1.mask_.color = var_139_7
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 then
				local var_139_8 = Color.New(0, 0, 0)

				var_139_8.a = 1
				arg_136_1.mask_.color = var_139_8
			end

			local var_139_9 = 1

			if 1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_10 = 1.43333333333333

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 then
				local var_139_11 = Color.New(0, 0, 0)

				var_139_11.a = Mathf.Lerp(1, 0, (arg_136_1.time_ - var_139_9) / var_139_10)
				arg_136_1.mask_.color = var_139_11
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 then
				local var_139_12 = Color.New(0, 0, 0)

				arg_136_1.mask_.enabled = false
				var_139_12.a = 0
				arg_136_1.mask_.color = var_139_12
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_13 = 2.23333333333333
			local var_139_14 = 0.9

			if 2.23333333333333 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_15 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_15:setOnUpdate(LuaHelper.FloatAction(function(arg_140_0)
					arg_136_1.dialogCg_.alpha = arg_140_0
				end))
				var_139_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_16 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(324502034).content)

				arg_136_1.text_.text = var_139_16

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_18 = 36 <= 0 and var_139_14 or var_139_14 * (utf8.len(var_139_16) / 36)

				if (36 <= 0 and var_139_14 or var_139_14 * (utf8.len(var_139_16) / 36)) > 0 and var_139_14 < var_139_18 then
					arg_136_1.talkMaxDuration = var_139_18
					var_139_13 = var_139_13 + 0.3

					if var_139_18 + var_139_13 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_13
					end
				end

				arg_136_1.text_.text = var_139_16
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_19 = var_139_13 + 0.3
			local var_139_20 = math.max(var_139_14, arg_136_1.talkMaxDuration)

			if var_139_13 + 0.3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_19 + var_139_20 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_19) / var_139_20

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_19 + var_139_20 and arg_136_1.time_ < var_139_19 + var_139_20 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324502035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324502035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play324502036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.4

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(324502035).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 16 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 16)

				if (16 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 16)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play324502036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324502036
		arg_146_1.duration_ = 6.9

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324502037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if arg_146_1.bgs_.ST32 == nil then
				local var_149_0 = Object.Instantiate(arg_146_1.paintGo_)

				var_149_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST32")
				var_149_0.name = "ST32"
				var_149_0.transform.parent = arg_146_1.stage_.transform
				var_149_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.bgs_.ST32 = var_149_0
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				local var_149_1 = arg_146_1.bgs_.ST32

				arg_146_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_149_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_2 = var_149_1:GetComponent("SpriteRenderer")

				if var_149_2 and var_149_2.sprite then
					local var_149_3 = 2 * (var_149_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_149_1.transform.localScale = Vector3.New(var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "ST32" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_149_4 = 0

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			if arg_146_1.time_ >= var_149_4 + 0.3 and arg_146_1.time_ < var_149_4 + 0.3 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_5 = 0

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_6 = 2

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 then
				local var_149_7 = Color.New(0, 0, 0)

				var_149_7.a = Mathf.Lerp(1, 0, (arg_146_1.time_ - var_149_5) / var_149_6)
				arg_146_1.mask_.color = var_149_7
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 then
				local var_149_8 = Color.New(0, 0, 0)

				arg_146_1.mask_.enabled = false
				var_149_8.a = 0
				arg_146_1.mask_.color = var_149_8
			end

			if 1.2 < arg_146_1.time_ and arg_146_1.time_ <= 1.2 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_146_1.time_ and arg_146_1.time_ <= 0.1 + arg_149_0 then
				arg_146_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:AudioAction("play", "music", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_149_13 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

				if "" ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_13 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_13

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_13
						arg_146_1.bgmTxt2_.text = var_149_13
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_14 = 1.9
			local var_149_15 = 1.375

			if 1.9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_16 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_16:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_146_1.dialogCg_.alpha = arg_151_0
				end))
				var_149_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_17 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(324502036).content)

				arg_146_1.text_.text = var_149_17

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_19 = 55 <= 0 and var_149_15 or var_149_15 * (utf8.len(var_149_17) / 55)

				if (55 <= 0 and var_149_15 or var_149_15 * (utf8.len(var_149_17) / 55)) > 0 and var_149_15 < var_149_19 then
					arg_146_1.talkMaxDuration = var_149_19
					var_149_14 = var_149_14 + 0.3

					if var_149_19 + var_149_14 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_14
					end
				end

				arg_146_1.text_.text = var_149_17
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_20 = var_149_14 + 0.3
			local var_149_21 = math.max(var_149_15, arg_146_1.talkMaxDuration)

			if var_149_14 + 0.3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_20 + var_149_21 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_20) / var_149_21

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_20 + var_149_21 and arg_146_1.time_ < var_149_20 + var_149_21 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324502037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 324502037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play324502038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.375

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(324502037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 15 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 15)

				if (15 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 15)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play324502038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 324502038
		arg_157_1.duration_ = 5.73

		local var_157_0 = {
			zh = 4.166,
			ja = 5.733
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
				arg_157_0:Play324502039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.actors_["10164ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10164ui_story"))) then
				local var_160_0 = Object.Instantiate(Asset.Load("Char/" .. "10164ui_story"), arg_157_1.stage_.transform)

				var_160_0.name = "10164ui_story"
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["10164ui_story"] = var_160_0

				local var_160_1 = var_160_0:GetComponentInChildren(typeof(CharacterEffect))

				var_160_1.enabled = true

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end

				arg_157_1:ShowWeapon(var_160_1.transform, false)

				arg_157_1.var_["10164ui_story" .. "Animator"] = var_160_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_157_1.var_["10164ui_story" .. "Animator"].applyRootMotion = true
				arg_157_1.var_["10164ui_story" .. "LipSync"] = var_160_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_160_3 = arg_157_1.actors_["10164ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10164ui_story = var_160_3.localPosition

				local var_160_4 = GameObjectTools.GetOrAddComponent(var_160_3.gameObject, typeof(DynamicBoneHelper))

				if var_160_4 then
					var_160_4:EnableDynamicBone(false)
				end
			end

			local var_160_5 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10164ui_story, Vector3.New(0, -1.08, -5.83), (arg_157_1.time_ - 0) / var_160_5)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, -1.08, -5.83)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles

				local var_160_6 = GameObjectTools.GetOrAddComponent(var_160_3.gameObject, typeof(DynamicBoneHelper))

				if var_160_6 then
					var_160_6:EnableDynamicBone(true)
				end
			end

			local var_160_7 = arg_157_1.actors_["10164ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.characterEffect10164ui_story == nil then
				arg_157_1.var_.characterEffect10164ui_story = var_160_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_8 and not isNil(var_160_7) then
				if arg_157_1.var_.characterEffect10164ui_story and not isNil(var_160_7) then
					arg_157_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_8 and arg_157_1.time_ < 0 + var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.characterEffect10164ui_story then
				arg_157_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_160_10 = 0
			local var_160_11 = 0.45

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_12 = arg_157_1:GetWordFromCfg(324502038)
				local var_160_13 = arg_157_1:FormatText(var_160_12.content)

				arg_157_1.text_.text = var_160_13

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_15 = 18 <= 0 and var_160_11 or var_160_11 * (utf8.len(var_160_13) / 18)

				if (18 <= 0 and var_160_11 or var_160_11 * (utf8.len(var_160_13) / 18)) > 0 and var_160_11 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15

					if var_160_15 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_13
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502038", "story_v_out_324502.awb") ~= 0 then
					local var_160_16 = manager.audio:GetVoiceLength("story_v_out_324502", "324502038", "story_v_out_324502.awb") / 1000

					if var_160_16 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_16 + var_160_10
					end

					if var_160_12.prefab_name ~= "" and arg_157_1.actors_[var_160_12.prefab_name] ~= nil then
						local var_160_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_12.prefab_name].transform, "story_v_out_324502", "324502038", "story_v_out_324502.awb")

						arg_157_1:RecordAudio("324502038", var_160_17)
						arg_157_1:RecordAudio("324502038", var_160_17)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_324502", "324502038", "story_v_out_324502.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_324502", "324502038", "story_v_out_324502.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_18 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_18 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_10) / var_160_18

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_10 + var_160_18 and arg_157_1.time_ < var_160_10 + var_160_18 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play324502039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 324502039
		arg_161_1.duration_ = 11.87

		local var_161_0 = {
			zh = 10.3,
			ja = 11.866
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
				arg_161_0:Play324502040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.95

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(324502039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 38)

				if (38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 38)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502039", "story_v_out_324502.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_324502", "324502039", "story_v_out_324502.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_324502", "324502039", "story_v_out_324502.awb")

						arg_161_1:RecordAudio("324502039", var_164_6)
						arg_161_1:RecordAudio("324502039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_324502", "324502039", "story_v_out_324502.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_324502", "324502039", "story_v_out_324502.awb")
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
	Play324502040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 324502040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play324502041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10164ui_story"]) and arg_165_1.var_.characterEffect10164ui_story == nil then
				arg_165_1.var_.characterEffect10164ui_story = arg_165_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10164ui_story"]) then
				if arg_165_1.var_.characterEffect10164ui_story and not isNil(arg_165_1.actors_["10164ui_story"]) then
					arg_165_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10164ui_story"]) and arg_165_1.var_.characterEffect10164ui_story then
				arg_165_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 1.275

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(324502040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 51 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 51)

				if (51 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 51)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play324502041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 324502041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play324502042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.025

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(324502041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 41 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 41)

				if (41 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 41)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play324502042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 324502042
		arg_173_1.duration_ = 9.93

		local var_173_0 = {
			zh = 9.933,
			ja = 9.166
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
				arg_173_0:Play324502043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10164ui_story"]) and arg_173_1.var_.characterEffect10164ui_story == nil then
				arg_173_1.var_.characterEffect10164ui_story = arg_173_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10164ui_story"]) then
				if arg_173_1.var_.characterEffect10164ui_story and not isNil(arg_173_1.actors_["10164ui_story"]) then
					arg_173_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10164ui_story"]) and arg_173_1.var_.characterEffect10164ui_story then
				arg_173_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_2")
			end

			local var_176_2 = 0
			local var_176_3 = 0.725

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:GetWordFromCfg(324502042)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 29 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 29)

				if (29 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 29)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502042", "story_v_out_324502.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502042", "story_v_out_324502.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_324502", "324502042", "story_v_out_324502.awb")

						arg_173_1:RecordAudio("324502042", var_176_9)
						arg_173_1:RecordAudio("324502042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_324502", "324502042", "story_v_out_324502.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_324502", "324502042", "story_v_out_324502.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play324502043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 324502043
		arg_177_1.duration_ = 7.57

		local var_177_0 = {
			zh = 6.2,
			ja = 7.566
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
				arg_177_0:Play324502044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_180_0 = 0
			local var_180_1 = 0.625

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(324502043)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 25 <= 0 and var_180_1 or var_180_1 * (utf8.len(var_180_3) / 25)

				if (25 <= 0 and var_180_1 or var_180_1 * (utf8.len(var_180_3) / 25)) > 0 and var_180_1 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502043", "story_v_out_324502.awb") ~= 0 then
					local var_180_6 = manager.audio:GetVoiceLength("story_v_out_324502", "324502043", "story_v_out_324502.awb") / 1000

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end

					if var_180_2.prefab_name ~= "" and arg_177_1.actors_[var_180_2.prefab_name] ~= nil then
						local var_180_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_2.prefab_name].transform, "story_v_out_324502", "324502043", "story_v_out_324502.awb")

						arg_177_1:RecordAudio("324502043", var_180_7)
						arg_177_1:RecordAudio("324502043", var_180_7)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_324502", "324502043", "story_v_out_324502.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_324502", "324502043", "story_v_out_324502.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_8 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_8 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_8

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_8 and arg_177_1.time_ < var_180_0 + var_180_8 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play324502044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 324502044
		arg_181_1.duration_ = 7.7

		local var_181_0 = {
			zh = 3.033,
			ja = 7.7
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
				arg_181_0:Play324502045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.275

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(324502044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 11 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 11)

				if (11 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 11)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502044", "story_v_out_324502.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_324502", "324502044", "story_v_out_324502.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_324502", "324502044", "story_v_out_324502.awb")

						arg_181_1:RecordAudio("324502044", var_184_6)
						arg_181_1:RecordAudio("324502044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_324502", "324502044", "story_v_out_324502.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_324502", "324502044", "story_v_out_324502.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play324502045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 324502045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play324502046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10164ui_story = arg_185_1.actors_["10164ui_story"].transform.localPosition

				local var_188_0 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_0 then
					var_188_0:EnableDynamicBone(false)
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_1)
				arg_185_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10164ui_story"].transform.position).z)
				arg_185_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10164ui_story"].transform.localEulerAngles = arg_185_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10164ui_story"].transform.position).z)
				arg_185_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10164ui_story"].transform.localEulerAngles = arg_185_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_188_2 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(true)
				end
			end

			local var_188_3 = arg_185_1.actors_["10164ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10164ui_story == nil then
				arg_185_1.var_.characterEffect10164ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect10164ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_4)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10164ui_story then
				arg_185_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_188_5 = 0
			local var_188_6 = 0.675

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(324502045).content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 27 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 27)

				if (27 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 27)) > 0 and var_188_6 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_10 and arg_185_1.time_ < var_188_5 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play324502046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 324502046
		arg_189_1.duration_ = 8.2

		local var_189_0 = {
			zh = 5.5,
			ja = 8.2
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play324502047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10164ui_story = arg_189_1.actors_["10164ui_story"].transform.localPosition

				local var_192_0 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_192_0 then
					var_192_0:EnableDynamicBone(false)
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10164ui_story, Vector3.New(0, -1.08, -5.83), (arg_189_1.time_ - 0) / var_192_1)
				arg_189_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10164ui_story"].transform.position).z)
				arg_189_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10164ui_story"].transform.localEulerAngles = arg_189_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_189_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10164ui_story"].transform.position).z)
				arg_189_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10164ui_story"].transform.localEulerAngles = arg_189_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_192_2 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(true)
				end
			end

			local var_192_3 = arg_189_1.actors_["10164ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_3) and arg_189_1.var_.characterEffect10164ui_story == nil then
				arg_189_1.var_.characterEffect10164ui_story = var_192_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_4 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 and not isNil(var_192_3) then
				if arg_189_1.var_.characterEffect10164ui_story and not isNil(var_192_3) then
					arg_189_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 and not isNil(var_192_3) and arg_189_1.var_.characterEffect10164ui_story then
				arg_189_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_192_6 = 0
			local var_192_7 = 0.7

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(324502046)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 28 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 28)

				if (28 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 28)) > 0 and var_192_7 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502046", "story_v_out_324502.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502046", "story_v_out_324502.awb") / 1000

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end

					if var_192_8.prefab_name ~= "" and arg_189_1.actors_[var_192_8.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_8.prefab_name].transform, "story_v_out_324502", "324502046", "story_v_out_324502.awb")

						arg_189_1:RecordAudio("324502046", var_192_13)
						arg_189_1:RecordAudio("324502046", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_324502", "324502046", "story_v_out_324502.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_324502", "324502046", "story_v_out_324502.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play324502047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 324502047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play324502048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10164ui_story"]) and arg_193_1.var_.characterEffect10164ui_story == nil then
				arg_193_1.var_.characterEffect10164ui_story = arg_193_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10164ui_story"]) then
				if arg_193_1.var_.characterEffect10164ui_story and not isNil(arg_193_1.actors_["10164ui_story"]) then
					arg_193_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10164ui_story"]) and arg_193_1.var_.characterEffect10164ui_story then
				arg_193_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.925

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(324502047).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 37 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 37)

				if (37 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 37)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play324502048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 324502048
		arg_197_1.duration_ = 10.73

		local var_197_0 = {
			zh = 10.466,
			ja = 10.733
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play324502049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10164ui_story"]) and arg_197_1.var_.characterEffect10164ui_story == nil then
				arg_197_1.var_.characterEffect10164ui_story = arg_197_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10164ui_story"]) then
				if arg_197_1.var_.characterEffect10164ui_story and not isNil(arg_197_1.actors_["10164ui_story"]) then
					arg_197_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10164ui_story"]) and arg_197_1.var_.characterEffect10164ui_story then
				arg_197_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_200_2 = 0
			local var_200_3 = 1.325

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(324502048)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 53 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 53)

				if (53 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 53)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502048", "story_v_out_324502.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502048", "story_v_out_324502.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_324502", "324502048", "story_v_out_324502.awb")

						arg_197_1:RecordAudio("324502048", var_200_9)
						arg_197_1:RecordAudio("324502048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_324502", "324502048", "story_v_out_324502.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_324502", "324502048", "story_v_out_324502.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play324502049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 324502049
		arg_201_1.duration_ = 11.03

		local var_201_0 = {
			zh = 10,
			ja = 11.033
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play324502050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_204_0 = 0
			local var_204_1 = 1.3

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(324502049)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 52 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 52)

				if (52 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 52)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502049", "story_v_out_324502.awb") ~= 0 then
					local var_204_6 = manager.audio:GetVoiceLength("story_v_out_324502", "324502049", "story_v_out_324502.awb") / 1000

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end

					if var_204_2.prefab_name ~= "" and arg_201_1.actors_[var_204_2.prefab_name] ~= nil then
						local var_204_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_2.prefab_name].transform, "story_v_out_324502", "324502049", "story_v_out_324502.awb")

						arg_201_1:RecordAudio("324502049", var_204_7)
						arg_201_1:RecordAudio("324502049", var_204_7)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_324502", "324502049", "story_v_out_324502.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_324502", "324502049", "story_v_out_324502.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play324502050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 324502050
		arg_205_1.duration_ = 3.73

		local var_205_0 = {
			zh = 2.6,
			ja = 3.733
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play324502051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.3

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(324502050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 12 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 12)

				if (12 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 12)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502050", "story_v_out_324502.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_324502", "324502050", "story_v_out_324502.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_324502", "324502050", "story_v_out_324502.awb")

						arg_205_1:RecordAudio("324502050", var_208_6)
						arg_205_1:RecordAudio("324502050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_324502", "324502050", "story_v_out_324502.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_324502", "324502050", "story_v_out_324502.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play324502051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 324502051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play324502052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10164ui_story"]) and arg_209_1.var_.characterEffect10164ui_story == nil then
				arg_209_1.var_.characterEffect10164ui_story = arg_209_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10164ui_story"]) then
				if arg_209_1.var_.characterEffect10164ui_story and not isNil(arg_209_1.actors_["10164ui_story"]) then
					arg_209_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10164ui_story"]) and arg_209_1.var_.characterEffect10164ui_story then
				arg_209_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.175

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(324502051).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 7 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 7)

				if (7 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 7)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play324502052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 324502052
		arg_213_1.duration_ = 13.9

		local var_213_0 = {
			zh = 10.8,
			ja = 13.9
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play324502053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10164ui_story"]) and arg_213_1.var_.characterEffect10164ui_story == nil then
				arg_213_1.var_.characterEffect10164ui_story = arg_213_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10164ui_story"]) then
				if arg_213_1.var_.characterEffect10164ui_story and not isNil(arg_213_1.actors_["10164ui_story"]) then
					arg_213_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10164ui_story"]) and arg_213_1.var_.characterEffect10164ui_story then
				arg_213_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_216_2 = 0
			local var_216_3 = 1.125

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(324502052)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 45 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 45)

				if (45 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 45)) > 0 and var_216_3 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502052", "story_v_out_324502.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502052", "story_v_out_324502.awb") / 1000

					if var_216_8 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_2
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_out_324502", "324502052", "story_v_out_324502.awb")

						arg_213_1:RecordAudio("324502052", var_216_9)
						arg_213_1:RecordAudio("324502052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_324502", "324502052", "story_v_out_324502.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_324502", "324502052", "story_v_out_324502.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_10 and arg_213_1.time_ < var_216_2 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play324502053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 324502053
		arg_217_1.duration_ = 5.63

		local var_217_0 = {
			zh = 3.733,
			ja = 5.633
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play324502054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(324502053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)

				if (21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502053", "story_v_out_324502.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_324502", "324502053", "story_v_out_324502.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_324502", "324502053", "story_v_out_324502.awb")

						arg_217_1:RecordAudio("324502053", var_220_6)
						arg_217_1:RecordAudio("324502053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_324502", "324502053", "story_v_out_324502.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_324502", "324502053", "story_v_out_324502.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play324502054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 324502054
		arg_221_1.duration_ = 5.6

		local var_221_0 = {
			zh = 1.966,
			ja = 5.6
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play324502055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.275

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(324502054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 11 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 11)

				if (11 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 11)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502054", "story_v_out_324502.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_324502", "324502054", "story_v_out_324502.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_324502", "324502054", "story_v_out_324502.awb")

						arg_221_1:RecordAudio("324502054", var_224_6)
						arg_221_1:RecordAudio("324502054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_324502", "324502054", "story_v_out_324502.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_324502", "324502054", "story_v_out_324502.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play324502055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 324502055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play324502056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10164ui_story"]) and arg_225_1.var_.characterEffect10164ui_story == nil then
				arg_225_1.var_.characterEffect10164ui_story = arg_225_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10164ui_story"]) then
				if arg_225_1.var_.characterEffect10164ui_story and not isNil(arg_225_1.actors_["10164ui_story"]) then
					arg_225_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10164ui_story"]) and arg_225_1.var_.characterEffect10164ui_story then
				arg_225_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 1.125

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(324502055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 45 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 45)

				if (45 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 45)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play324502056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 324502056
		arg_229_1.duration_ = 1

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play324502057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10164ui_story = arg_229_1.actors_["10164ui_story"].transform.localPosition

				local var_232_0 = GameObjectTools.GetOrAddComponent(arg_229_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_232_0 then
					var_232_0:EnableDynamicBone(false)
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_1)
				arg_229_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10164ui_story"].transform.position).z)
				arg_229_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10164ui_story"].transform.localEulerAngles = arg_229_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10164ui_story"].transform.position).z)
				arg_229_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10164ui_story"].transform.localEulerAngles = arg_229_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_232_2 = GameObjectTools.GetOrAddComponent(arg_229_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_232_2 then
					var_232_2:EnableDynamicBone(true)
				end
			end

			local var_232_3 = arg_229_1.actors_["10170ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect10170ui_story == nil then
				arg_229_1.var_.characterEffect10170ui_story = var_232_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_4 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 and not isNil(var_232_3) then
				if arg_229_1.var_.characterEffect10170ui_story and not isNil(var_232_3) then
					arg_229_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect10170ui_story then
				arg_229_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_232_6 = 0
			local var_232_7 = 0.075

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_8 = arg_229_1:GetWordFromCfg(324502056)
				local var_232_9 = arg_229_1:FormatText(var_232_8.content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 3 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_9) / 3)

				if (3 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_9) / 3)) > 0 and var_232_7 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11

					if var_232_11 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502056", "story_v_out_324502.awb") ~= 0 then
					local var_232_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502056", "story_v_out_324502.awb") / 1000

					if var_232_12 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_6
					end

					if var_232_8.prefab_name ~= "" and arg_229_1.actors_[var_232_8.prefab_name] ~= nil then
						local var_232_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_8.prefab_name].transform, "story_v_out_324502", "324502056", "story_v_out_324502.awb")

						arg_229_1:RecordAudio("324502056", var_232_13)
						arg_229_1:RecordAudio("324502056", var_232_13)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_324502", "324502056", "story_v_out_324502.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_324502", "324502056", "story_v_out_324502.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play324502057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 324502057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play324502058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10170ui_story"]) and arg_233_1.var_.characterEffect10170ui_story == nil then
				arg_233_1.var_.characterEffect10170ui_story = arg_233_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10170ui_story"]) then
				if arg_233_1.var_.characterEffect10170ui_story and not isNil(arg_233_1.actors_["10170ui_story"]) then
					arg_233_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10170ui_story"]) and arg_233_1.var_.characterEffect10170ui_story then
				arg_233_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.575

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(324502057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 23 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 23)

				if (23 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 23)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play324502058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 324502058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play324502059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.25

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(324502058).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 10 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 10)

				if (10 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 10)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play324502059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 324502059
		arg_241_1.duration_ = 3.87

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play324502060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10170ui_story = arg_241_1.actors_["10170ui_story"].transform.localPosition

				local var_244_0 = GameObjectTools.GetOrAddComponent(arg_241_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_244_0 then
					var_244_0:EnableDynamicBone(false)
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_241_1.time_ - 0) / var_244_1)
				arg_241_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10170ui_story"].transform.position).z)
				arg_241_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10170ui_story"].transform.localEulerAngles = arg_241_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_241_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10170ui_story"].transform.position).z)
				arg_241_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10170ui_story"].transform.localEulerAngles = arg_241_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_244_2 = GameObjectTools.GetOrAddComponent(arg_241_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(true)
				end
			end

			local var_244_3 = arg_241_1.actors_["10170ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect10170ui_story == nil then
				arg_241_1.var_.characterEffect10170ui_story = var_244_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_4 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 and not isNil(var_244_3) then
				if arg_241_1.var_.characterEffect10170ui_story and not isNil(var_244_3) then
					arg_241_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect10170ui_story then
				arg_241_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_6 = 0
			local var_244_7 = 0.425

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_8 = arg_241_1:GetWordFromCfg(324502059)
				local var_244_9 = arg_241_1:FormatText(var_244_8.content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 17 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_9) / 17)

				if (17 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_9) / 17)) > 0 and var_244_7 < var_244_11 then
					arg_241_1.talkMaxDuration = var_244_11

					if var_244_11 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_9
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502059", "story_v_out_324502.awb") ~= 0 then
					local var_244_12 = manager.audio:GetVoiceLength("story_v_out_324502", "324502059", "story_v_out_324502.awb") / 1000

					if var_244_12 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_6
					end

					if var_244_8.prefab_name ~= "" and arg_241_1.actors_[var_244_8.prefab_name] ~= nil then
						local var_244_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_8.prefab_name].transform, "story_v_out_324502", "324502059", "story_v_out_324502.awb")

						arg_241_1:RecordAudio("324502059", var_244_13)
						arg_241_1:RecordAudio("324502059", var_244_13)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_324502", "324502059", "story_v_out_324502.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_324502", "324502059", "story_v_out_324502.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play324502060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 324502060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play324502061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10170ui_story"]) and arg_245_1.var_.characterEffect10170ui_story == nil then
				arg_245_1.var_.characterEffect10170ui_story = arg_245_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10170ui_story"]) then
				if arg_245_1.var_.characterEffect10170ui_story and not isNil(arg_245_1.actors_["10170ui_story"]) then
					arg_245_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10170ui_story"]) and arg_245_1.var_.characterEffect10170ui_story then
				arg_245_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(324502060).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 5 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 5)

				if (5 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 5)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play324502061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 324502061
		arg_249_1.duration_ = 3.17

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play324502062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10170ui_story"]) and arg_249_1.var_.characterEffect10170ui_story == nil then
				arg_249_1.var_.characterEffect10170ui_story = arg_249_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10170ui_story"]) then
				if arg_249_1.var_.characterEffect10170ui_story and not isNil(arg_249_1.actors_["10170ui_story"]) then
					arg_249_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10170ui_story"]) and arg_249_1.var_.characterEffect10170ui_story then
				arg_249_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_252_2 = 0
			local var_252_3 = 0.3

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(324502061)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 12 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 12)

				if (12 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 12)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502061", "story_v_out_324502.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_324502", "324502061", "story_v_out_324502.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_out_324502", "324502061", "story_v_out_324502.awb")

						arg_249_1:RecordAudio("324502061", var_252_9)
						arg_249_1:RecordAudio("324502061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_324502", "324502061", "story_v_out_324502.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_324502", "324502061", "story_v_out_324502.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play324502062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 324502062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play324502063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10170ui_story"]) and arg_253_1.var_.characterEffect10170ui_story == nil then
				arg_253_1.var_.characterEffect10170ui_story = arg_253_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10170ui_story"]) then
				if arg_253_1.var_.characterEffect10170ui_story and not isNil(arg_253_1.actors_["10170ui_story"]) then
					arg_253_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10170ui_story"]) and arg_253_1.var_.characterEffect10170ui_story then
				arg_253_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(324502062).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 21 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 21)

				if (21 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 21)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play324502063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 324502063
		arg_257_1.duration_ = 3.33

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
			arg_257_1.auto_ = false
		end

		function arg_257_1.playNext_(arg_259_0)
			arg_257_1.onStoryFinished_()
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10170ui_story"]) and arg_257_1.var_.characterEffect10170ui_story == nil then
				arg_257_1.var_.characterEffect10170ui_story = arg_257_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10170ui_story"]) then
				if arg_257_1.var_.characterEffect10170ui_story and not isNil(arg_257_1.actors_["10170ui_story"]) then
					arg_257_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10170ui_story"]) and arg_257_1.var_.characterEffect10170ui_story then
				arg_257_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_2")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_2 = 0.533333333333333
			local var_260_3 = 0.225

			if 0.533333333333333 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_4 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_4:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_5 = arg_257_1:GetWordFromCfg(324502063)
				local var_260_6 = arg_257_1:FormatText(var_260_5.content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_8 = 9 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_6) / 9)

				if (9 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_6) / 9)) > 0 and var_260_3 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8
					var_260_2 = var_260_2 + 0.3

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324502", "324502063", "story_v_out_324502.awb") ~= 0 then
					local var_260_9 = manager.audio:GetVoiceLength("story_v_out_324502", "324502063", "story_v_out_324502.awb") / 1000

					if var_260_9 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_2
					end

					if var_260_5.prefab_name ~= "" and arg_257_1.actors_[var_260_5.prefab_name] ~= nil then
						local var_260_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_5.prefab_name].transform, "story_v_out_324502", "324502063", "story_v_out_324502.awb")

						arg_257_1:RecordAudio("324502063", var_260_10)
						arg_257_1:RecordAudio("324502063", var_260_10)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_324502", "324502063", "story_v_out_324502.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_324502", "324502063", "story_v_out_324502.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_11 = var_260_2 + 0.3
			local var_260_12 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_11) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_11 + var_260_12 and arg_257_1.time_ < var_260_11 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST32"
	},
	voices = {
		"story_v_out_324502.awb"
	}
}
