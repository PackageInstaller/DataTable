return {
	Play324771001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324771001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 4.233,
			ja = 4.833
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
				arg_1_0:Play324771002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2007 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_4_0.name = "ST2007"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2007 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2007

				arg_1_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2007" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1037ui_story"

			if arg_1_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1037ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1037ui_story == nil then
				arg_1_1.var_.characterEffect1037ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1037ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1037ui_story then
				arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

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

			local var_4_21 = 2
			local var_4_22 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(324771001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 10 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 10)

				if (10 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 10)) > 0 and var_4_22 < var_4_27 then
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

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771001", "story_v_out_324771.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_324771", "324771001", "story_v_out_324771.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_324771", "324771001", "story_v_out_324771.awb")

						arg_1_1:RecordAudio("324771001", var_4_29)
						arg_1_1:RecordAudio("324771001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324771", "324771001", "story_v_out_324771.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324771", "324771001", "story_v_out_324771.awb")
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
	Play324771002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324771002
		arg_8_1.duration_ = 4.87

		local var_8_0 = {
			zh = 3.633,
			ja = 4.866
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
				arg_8_0:Play324771003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1036ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1036ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1036ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1036ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1036ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1037ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1037ui_story == nil then
				arg_8_1.var_.characterEffect1037ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect1037ui_story and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1037ui_story then
				arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_11_8 = 0
			local var_11_9 = 0.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_10 = arg_8_1:GetWordFromCfg(324771002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 16 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 16)

				if (16 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 16)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771002", "story_v_out_324771.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_324771", "324771002", "story_v_out_324771.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_324771", "324771002", "story_v_out_324771.awb")

						arg_8_1:RecordAudio("324771002", var_11_15)
						arg_8_1:RecordAudio("324771002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324771", "324771002", "story_v_out_324771.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324771", "324771002", "story_v_out_324771.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324771003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324771003
		arg_12_1.duration_ = 5.9

		local var_12_0 = {
			zh = 2.5,
			ja = 5.9
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
				arg_12_0:Play324771004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1053ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1053ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1053ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1053ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1053ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1053ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1053ui_story then
				arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1036ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = var_15_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 and not isNil(var_15_6) then
				if arg_12_1.var_.characterEffect1036ui_story and not isNil(var_15_6) then
					arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_7)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1036ui_story then
				arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_15_8 = 0
			local var_15_9 = 0.275

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_10 = arg_12_1:GetWordFromCfg(324771003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 11 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 11)

				if (11 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 11)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771003", "story_v_out_324771.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_324771", "324771003", "story_v_out_324771.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_324771", "324771003", "story_v_out_324771.awb")

						arg_12_1:RecordAudio("324771003", var_15_15)
						arg_12_1:RecordAudio("324771003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324771", "324771003", "story_v_out_324771.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324771", "324771003", "story_v_out_324771.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324771004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324771004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324771005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1053ui_story"]) and arg_16_1.var_.characterEffect1053ui_story == nil then
				arg_16_1.var_.characterEffect1053ui_story = arg_16_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1053ui_story"]) then
				if arg_16_1.var_.characterEffect1053ui_story and not isNil(arg_16_1.actors_["1053ui_story"]) then
					arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1053ui_story"]) and arg_16_1.var_.characterEffect1053ui_story then
				arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 1.1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(324771004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 44 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 44)

				if (44 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 44)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324771005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324771005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324771006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.95

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(324771005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 38 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 38)

				if (38 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 38)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324771006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324771006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324771007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.4

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324771006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 16 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 16)

				if (16 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 16)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324771007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324771007
		arg_28_1.duration_ = 5.47

		local var_28_0 = {
			zh = 4,
			ja = 5.466
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
				arg_28_0:Play324771008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "6148ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["6148ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["6148ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["6148ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["6148ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos6148ui_story = var_31_3.localPosition

				local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_4 then
					var_31_4:EnableDynamicBone(false)
				end
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_28_1.time_ - 0) / var_31_5)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(true)
				end
			end

			local var_31_7 = arg_28_1.actors_["6148ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = var_31_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 and not isNil(var_31_7) then
				if arg_28_1.var_.characterEffect6148ui_story and not isNil(var_31_7) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_31_10 = 0
			local var_31_11 = 0.5

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(324771007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 20 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 20)

				if (20 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 20)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771007", "story_v_out_324771.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_324771", "324771007", "story_v_out_324771.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_324771", "324771007", "story_v_out_324771.awb")

						arg_28_1:RecordAudio("324771007", var_31_17)
						arg_28_1:RecordAudio("324771007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324771", "324771007", "story_v_out_324771.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324771", "324771007", "story_v_out_324771.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324771008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324771008
		arg_32_1.duration_ = 6.4

		local var_32_0 = {
			zh = 5.033,
			ja = 6.4
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
				arg_32_0:Play324771009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "1054ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1054ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["1054ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["1054ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["1054ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_3.localPosition

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(false)
				end
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_32_1.time_ - 0) / var_35_5)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(true)
				end
			end

			local var_35_7 = arg_32_1.actors_["1054ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect1054ui_story == nil then
				arg_32_1.var_.characterEffect1054ui_story = var_35_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 and not isNil(var_35_7) then
				if arg_32_1.var_.characterEffect1054ui_story and not isNil(var_35_7) then
					arg_32_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect1054ui_story then
				arg_32_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1", "EmotionTimelineAnimator")
			end

			local var_35_10 = arg_32_1.actors_["6148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect6148ui_story then
				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_35_12 = 0
			local var_35_13 = 0.5

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(324771008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 20 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 20)

				if (20 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 20)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771008", "story_v_out_324771.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_324771", "324771008", "story_v_out_324771.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_324771", "324771008", "story_v_out_324771.awb")

						arg_32_1:RecordAudio("324771008", var_35_19)
						arg_32_1:RecordAudio("324771008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324771", "324771008", "story_v_out_324771.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324771", "324771008", "story_v_out_324771.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324771009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324771009
		arg_36_1.duration_ = 5.1

		local var_36_0 = {
			zh = 4,
			ja = 5.1
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
				arg_36_0:Play324771010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1053ui_story = arg_36_1.actors_["1053ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1053ui_story"].transform.position).z)
				arg_36_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1053ui_story"].transform.localEulerAngles = arg_36_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_36_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1053ui_story"].transform.position).z)
				arg_36_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1053ui_story"].transform.localEulerAngles = arg_36_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["1054ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_3.localPosition

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, 100, 0)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(true)
				end
			end

			local var_39_7 = arg_36_1.actors_["1053ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1053ui_story == nil then
				arg_36_1.var_.characterEffect1053ui_story = var_39_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 and not isNil(var_39_7) then
				if arg_36_1.var_.characterEffect1053ui_story and not isNil(var_39_7) then
					arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1053ui_story then
				arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_39_10 = arg_36_1.actors_["1054ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_10) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_11 and not isNil(var_39_10) then
				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_10) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_11 and arg_36_1.time_ < 0 + var_39_11 + arg_39_0 and not isNil(var_39_10) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_39_13 = arg_36_1.actors_["6148ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos6148ui_story = var_39_13.localPosition

				local var_39_14 = GameObjectTools.GetOrAddComponent(var_39_13.gameObject, typeof(DynamicBoneHelper))

				if var_39_14 then
					var_39_14:EnableDynamicBone(false)
				end
			end

			local var_39_15 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_15 then
				var_39_13.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_15)
				var_39_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_13.position).x, (manager.ui.mainCamera.transform.position - var_39_13.position).y, (manager.ui.mainCamera.transform.position - var_39_13.position).z)
				var_39_13.localEulerAngles.z = 0
				var_39_13.localEulerAngles.x = 0
				var_39_13.localEulerAngles = var_39_13.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_15 and arg_36_1.time_ < 0 + var_39_15 + arg_39_0 then
				var_39_13.localPosition = Vector3.New(0, 100, 0)
				var_39_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_13.position).x, (manager.ui.mainCamera.transform.position - var_39_13.position).y, (manager.ui.mainCamera.transform.position - var_39_13.position).z)
				var_39_13.localEulerAngles.z = 0
				var_39_13.localEulerAngles.x = 0
				var_39_13.localEulerAngles = var_39_13.localEulerAngles

				local var_39_16 = GameObjectTools.GetOrAddComponent(var_39_13.gameObject, typeof(DynamicBoneHelper))

				if var_39_16 then
					var_39_16:EnableDynamicBone(true)
				end
			end

			local var_39_17 = 0
			local var_39_18 = 0.4

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(324771009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_22 = 16 <= 0 and var_39_18 or var_39_18 * (utf8.len(var_39_20) / 16)

				if (16 <= 0 and var_39_18 or var_39_18 * (utf8.len(var_39_20) / 16)) > 0 and var_39_18 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771009", "story_v_out_324771.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_out_324771", "324771009", "story_v_out_324771.awb") / 1000

					if var_39_23 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_17
					end

					if var_39_19.prefab_name ~= "" and arg_36_1.actors_[var_39_19.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_19.prefab_name].transform, "story_v_out_324771", "324771009", "story_v_out_324771.awb")

						arg_36_1:RecordAudio("324771009", var_39_24)
						arg_36_1:RecordAudio("324771009", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324771", "324771009", "story_v_out_324771.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324771", "324771009", "story_v_out_324771.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_25 and arg_36_1.time_ < var_39_17 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play324771010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324771010
		arg_40_1.duration_ = 3.73

		local var_40_0 = {
			zh = 2.266,
			ja = 3.733
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
				arg_40_0:Play324771011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1037ui_story"]) and arg_40_1.var_.characterEffect1037ui_story == nil then
				arg_40_1.var_.characterEffect1037ui_story = arg_40_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1037ui_story"]) then
				if arg_40_1.var_.characterEffect1037ui_story and not isNil(arg_40_1.actors_["1037ui_story"]) then
					arg_40_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1037ui_story"]) and arg_40_1.var_.characterEffect1037ui_story then
				arg_40_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1053ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1053ui_story then
				arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_43_4 = arg_40_1.actors_["6148ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect6148ui_story == nil then
				arg_40_1.var_.characterEffect6148ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_5 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 and not isNil(var_43_4) then
				if arg_40_1.var_.characterEffect6148ui_story and not isNil(var_43_4) then
					arg_40_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect6148ui_story then
				arg_40_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_43_7 = arg_40_1.actors_["6148ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = var_43_7.localPosition

				local var_43_8 = GameObjectTools.GetOrAddComponent(var_43_7.gameObject, typeof(DynamicBoneHelper))

				if var_43_8 then
					var_43_8:EnableDynamicBone(false)
				end
			end

			local var_43_9 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_9 then
				var_43_7.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_40_1.time_ - 0) / var_43_9)
				var_43_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_7.position).x, (manager.ui.mainCamera.transform.position - var_43_7.position).y, (manager.ui.mainCamera.transform.position - var_43_7.position).z)
				var_43_7.localEulerAngles.z = 0
				var_43_7.localEulerAngles.x = 0
				var_43_7.localEulerAngles = var_43_7.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_9 and arg_40_1.time_ < 0 + var_43_9 + arg_43_0 then
				var_43_7.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_43_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_7.position).x, (manager.ui.mainCamera.transform.position - var_43_7.position).y, (manager.ui.mainCamera.transform.position - var_43_7.position).z)
				var_43_7.localEulerAngles.z = 0
				var_43_7.localEulerAngles.x = 0
				var_43_7.localEulerAngles = var_43_7.localEulerAngles

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_7.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["1053ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1053ui_story = var_43_11.localPosition

				local var_43_12 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_12 then
					var_43_12:EnableDynamicBone(false)
				end
			end

			local var_43_13 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_13 then
				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_40_1.time_ - 0) / var_43_13)
				var_43_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_11.position).x, (manager.ui.mainCamera.transform.position - var_43_11.position).y, (manager.ui.mainCamera.transform.position - var_43_11.position).z)
				var_43_11.localEulerAngles.z = 0
				var_43_11.localEulerAngles.x = 0
				var_43_11.localEulerAngles = var_43_11.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_13 and arg_40_1.time_ < 0 + var_43_13 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0.7, -1.08, -6)
				var_43_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_11.position).x, (manager.ui.mainCamera.transform.position - var_43_11.position).y, (manager.ui.mainCamera.transform.position - var_43_11.position).z)
				var_43_11.localEulerAngles.z = 0
				var_43_11.localEulerAngles.x = 0
				var_43_11.localEulerAngles = var_43_11.localEulerAngles

				local var_43_14 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_14 then
					var_43_14:EnableDynamicBone(true)
				end
			end

			local var_43_15 = 0
			local var_43_16 = 0.325

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_17 = arg_40_1:GetWordFromCfg(324771010)
				local var_43_18 = arg_40_1:FormatText(var_43_17.content)

				arg_40_1.text_.text = var_43_18

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 13 <= 0 and var_43_16 or var_43_16 * (utf8.len(var_43_18) / 13)

				if (13 <= 0 and var_43_16 or var_43_16 * (utf8.len(var_43_18) / 13)) > 0 and var_43_16 < var_43_20 then
					arg_40_1.talkMaxDuration = var_43_20

					if var_43_20 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_18
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771010", "story_v_out_324771.awb") ~= 0 then
					local var_43_21 = manager.audio:GetVoiceLength("story_v_out_324771", "324771010", "story_v_out_324771.awb") / 1000

					if var_43_21 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_21 + var_43_15
					end

					if var_43_17.prefab_name ~= "" and arg_40_1.actors_[var_43_17.prefab_name] ~= nil then
						local var_43_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_17.prefab_name].transform, "story_v_out_324771", "324771010", "story_v_out_324771.awb")

						arg_40_1:RecordAudio("324771010", var_43_22)
						arg_40_1:RecordAudio("324771010", var_43_22)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324771", "324771010", "story_v_out_324771.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324771", "324771010", "story_v_out_324771.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_23 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_23

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_23 and arg_40_1.time_ < var_43_15 + var_43_23 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_40_1:InitPlayNodeList()
	end,
	Play324771011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324771011
		arg_44_1.duration_ = 4.33

		local var_44_0 = {
			zh = 1.999999999999,
			ja = 4.333
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
				arg_44_0:Play324771012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = arg_44_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) then
				if arg_44_1.var_.characterEffect1053ui_story and not isNil(arg_44_1.actors_["1053ui_story"]) then
					arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) and arg_44_1.var_.characterEffect1053ui_story then
				arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_47_2 = arg_44_1.actors_["6148ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect6148ui_story == nil then
				arg_44_1.var_.characterEffect6148ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect6148ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect6148ui_story then
				arg_44_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_47_4 = 0
			local var_47_5 = 0.25

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(324771011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 10 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 10)

				if (10 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 10)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771011", "story_v_out_324771.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_324771", "324771011", "story_v_out_324771.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_324771", "324771011", "story_v_out_324771.awb")

						arg_44_1:RecordAudio("324771011", var_47_11)
						arg_44_1:RecordAudio("324771011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324771", "324771011", "story_v_out_324771.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324771", "324771011", "story_v_out_324771.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324771012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324771012
		arg_48_1.duration_ = 6.2

		local var_48_0 = {
			zh = 5.166,
			ja = 6.2
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
				arg_48_0:Play324771013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1054ui_story"]) and arg_48_1.var_.characterEffect1054ui_story == nil then
				arg_48_1.var_.characterEffect1054ui_story = arg_48_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1054ui_story"]) then
				if arg_48_1.var_.characterEffect1054ui_story and not isNil(arg_48_1.actors_["1054ui_story"]) then
					arg_48_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1054ui_story"]) and arg_48_1.var_.characterEffect1054ui_story then
				arg_48_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1053ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1053ui_story then
				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_51_4 = arg_48_1.actors_["1037ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1037ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, 100, 0)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			local var_51_6 = arg_48_1.actors_["1054ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1054ui_story = var_51_6.localPosition

				local var_51_7 = GameObjectTools.GetOrAddComponent(var_51_6.gameObject, typeof(DynamicBoneHelper))

				if var_51_7 then
					var_51_7:EnableDynamicBone(false)
				end
			end

			local var_51_8 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_8 then
				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_48_1.time_ - 0) / var_51_8)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_8 and arg_48_1.time_ < 0 + var_51_8 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles

				local var_51_9 = GameObjectTools.GetOrAddComponent(var_51_6.gameObject, typeof(DynamicBoneHelper))

				if var_51_9 then
					var_51_9:EnableDynamicBone(true)
				end
			end

			local var_51_10 = arg_48_1.actors_["6148ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = var_51_10.localPosition

				local var_51_11 = GameObjectTools.GetOrAddComponent(var_51_10.gameObject, typeof(DynamicBoneHelper))

				if var_51_11 then
					var_51_11:EnableDynamicBone(false)
				end
			end

			local var_51_12 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_12 then
				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_12)
				var_51_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_10.position).x, (manager.ui.mainCamera.transform.position - var_51_10.position).y, (manager.ui.mainCamera.transform.position - var_51_10.position).z)
				var_51_10.localEulerAngles.z = 0
				var_51_10.localEulerAngles.x = 0
				var_51_10.localEulerAngles = var_51_10.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_12 and arg_48_1.time_ < 0 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)
				var_51_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_10.position).x, (manager.ui.mainCamera.transform.position - var_51_10.position).y, (manager.ui.mainCamera.transform.position - var_51_10.position).z)
				var_51_10.localEulerAngles.z = 0
				var_51_10.localEulerAngles.x = 0
				var_51_10.localEulerAngles = var_51_10.localEulerAngles

				local var_51_13 = GameObjectTools.GetOrAddComponent(var_51_10.gameObject, typeof(DynamicBoneHelper))

				if var_51_13 then
					var_51_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			local var_51_14 = 0
			local var_51_15 = 0.525

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_16 = arg_48_1:GetWordFromCfg(324771012)
				local var_51_17 = arg_48_1:FormatText(var_51_16.content)

				arg_48_1.text_.text = var_51_17

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 21 <= 0 and var_51_15 or var_51_15 * (utf8.len(var_51_17) / 21)

				if (21 <= 0 and var_51_15 or var_51_15 * (utf8.len(var_51_17) / 21)) > 0 and var_51_15 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_14 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_14
					end
				end

				arg_48_1.text_.text = var_51_17
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771012", "story_v_out_324771.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_324771", "324771012", "story_v_out_324771.awb") / 1000

					if var_51_20 + var_51_14 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_14
					end

					if var_51_16.prefab_name ~= "" and arg_48_1.actors_[var_51_16.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_16.prefab_name].transform, "story_v_out_324771", "324771012", "story_v_out_324771.awb")

						arg_48_1:RecordAudio("324771012", var_51_21)
						arg_48_1:RecordAudio("324771012", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324771", "324771012", "story_v_out_324771.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324771", "324771012", "story_v_out_324771.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_15, arg_48_1.talkMaxDuration)

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_14) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_14 + var_51_22 and arg_48_1.time_ < var_51_14 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play324771013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324771013
		arg_52_1.duration_ = 12.5

		local var_52_0 = {
			zh = 9.3,
			ja = 12.5
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
				arg_52_0:Play324771014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1053ui_story"]) and arg_52_1.var_.characterEffect1053ui_story == nil then
				arg_52_1.var_.characterEffect1053ui_story = arg_52_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1053ui_story"]) then
				if arg_52_1.var_.characterEffect1053ui_story and not isNil(arg_52_1.actors_["1053ui_story"]) then
					arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1053ui_story"]) and arg_52_1.var_.characterEffect1053ui_story then
				arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["1054ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1054ui_story == nil then
				arg_52_1.var_.characterEffect1054ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1054ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1054ui_story then
				arg_52_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(324771013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 40 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 40)

				if (40 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 40)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771013", "story_v_out_324771.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_324771", "324771013", "story_v_out_324771.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_324771", "324771013", "story_v_out_324771.awb")

						arg_52_1:RecordAudio("324771013", var_55_11)
						arg_52_1:RecordAudio("324771013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324771", "324771013", "story_v_out_324771.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324771", "324771013", "story_v_out_324771.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324771014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324771014
		arg_56_1.duration_ = 6.7

		local var_56_0 = {
			zh = 4.133,
			ja = 6.7
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
				arg_56_0:Play324771015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_59_0 = 0
			local var_59_1 = 0.425

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(324771014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 17 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 17)

				if (17 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 17)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771014", "story_v_out_324771.awb") ~= 0 then
					local var_59_6 = manager.audio:GetVoiceLength("story_v_out_324771", "324771014", "story_v_out_324771.awb") / 1000

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end

					if var_59_2.prefab_name ~= "" and arg_56_1.actors_[var_59_2.prefab_name] ~= nil then
						local var_59_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_2.prefab_name].transform, "story_v_out_324771", "324771014", "story_v_out_324771.awb")

						arg_56_1:RecordAudio("324771014", var_59_7)
						arg_56_1:RecordAudio("324771014", var_59_7)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324771", "324771014", "story_v_out_324771.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324771", "324771014", "story_v_out_324771.awb")
				end

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
	Play324771015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324771015
		arg_60_1.duration_ = 3.33

		local var_60_0 = {
			zh = 3.333,
			ja = 2.8
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
				arg_60_0:Play324771016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = arg_60_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) then
				if arg_60_1.var_.characterEffect1054ui_story and not isNil(arg_60_1.actors_["1054ui_story"]) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1053ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1053ui_story then
				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_2")
			end

			local var_63_4 = 0
			local var_63_5 = 0.25

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(324771015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 10 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 10)

				if (10 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 10)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771015", "story_v_out_324771.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_324771", "324771015", "story_v_out_324771.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_324771", "324771015", "story_v_out_324771.awb")

						arg_60_1:RecordAudio("324771015", var_63_11)
						arg_60_1:RecordAudio("324771015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324771", "324771015", "story_v_out_324771.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324771", "324771015", "story_v_out_324771.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324771016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324771016
		arg_64_1.duration_ = 4.3

		local var_64_0 = {
			zh = 2.533,
			ja = 4.3
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
				arg_64_0:Play324771017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = arg_64_1.actors_["6148ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).z)
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles = arg_64_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_64_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).z)
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles = arg_64_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = arg_64_1.actors_["1053ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1053ui_story = var_67_3.localPosition

				local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_4 then
					var_67_4:EnableDynamicBone(false)
				end
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_5)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0, 100, 0)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles

				local var_67_6 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_6 then
					var_67_6:EnableDynamicBone(true)
				end
			end

			local var_67_7 = arg_64_1.actors_["6148ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_8 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_8 and not isNil(var_67_7) then
				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_7) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_8 and arg_64_1.time_ < 0 + var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_67_10 = arg_64_1.actors_["1054ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_11 and not isNil(var_67_10) then
				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_10) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_11)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_11 and arg_64_1.time_ < 0 + var_67_11 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_67_12 = 0
			local var_67_13 = 0.325

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(324771016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 13 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 13)

				if (13 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 13)) > 0 and var_67_13 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771016", "story_v_out_324771.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_324771", "324771016", "story_v_out_324771.awb") / 1000

					if var_67_18 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_12
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_324771", "324771016", "story_v_out_324771.awb")

						arg_64_1:RecordAudio("324771016", var_67_19)
						arg_64_1:RecordAudio("324771016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324771", "324771016", "story_v_out_324771.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324771", "324771016", "story_v_out_324771.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_20 and arg_64_1.time_ < var_67_12 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_64_1:InitPlayNodeList()
	end,
	Play324771017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324771017
		arg_68_1.duration_ = 6.5

		local var_68_0 = {
			zh = 3.933,
			ja = 6.5
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
			arg_68_1.auto_ = false
		end

		function arg_68_1.playNext_(arg_70_0)
			arg_68_1.onStoryFinished_()
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1053ui_story = arg_68_1.actors_["1053ui_story"].transform.localPosition

				local var_71_0 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_0 then
					var_71_0:EnableDynamicBone(false)
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_68_1.time_ - 0) / var_71_1)
				arg_68_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).z)
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles = arg_68_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_68_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).z)
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles = arg_68_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(true)
				end
			end

			local var_71_3 = arg_68_1.actors_["6148ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos6148ui_story = var_71_3.localPosition

				local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_3.gameObject, typeof(DynamicBoneHelper))

				if var_71_4 then
					var_71_4:EnableDynamicBone(false)
				end
			end

			local var_71_5 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_5 then
				var_71_3.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_5)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_5 and arg_68_1.time_ < 0 + var_71_5 + arg_71_0 then
				var_71_3.localPosition = Vector3.New(0, 100, 0)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles

				local var_71_6 = GameObjectTools.GetOrAddComponent(var_71_3.gameObject, typeof(DynamicBoneHelper))

				if var_71_6 then
					var_71_6:EnableDynamicBone(true)
				end
			end

			local var_71_7 = arg_68_1.actors_["1054ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1054ui_story = var_71_7.localPosition

				local var_71_8 = GameObjectTools.GetOrAddComponent(var_71_7.gameObject, typeof(DynamicBoneHelper))

				if var_71_8 then
					var_71_8:EnableDynamicBone(false)
				end
			end

			local var_71_9 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_9 then
				var_71_7.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_9)
				var_71_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_7.position).x, (manager.ui.mainCamera.transform.position - var_71_7.position).y, (manager.ui.mainCamera.transform.position - var_71_7.position).z)
				var_71_7.localEulerAngles.z = 0
				var_71_7.localEulerAngles.x = 0
				var_71_7.localEulerAngles = var_71_7.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_9 and arg_68_1.time_ < 0 + var_71_9 + arg_71_0 then
				var_71_7.localPosition = Vector3.New(0, 100, 0)
				var_71_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_7.position).x, (manager.ui.mainCamera.transform.position - var_71_7.position).y, (manager.ui.mainCamera.transform.position - var_71_7.position).z)
				var_71_7.localEulerAngles.z = 0
				var_71_7.localEulerAngles.x = 0
				var_71_7.localEulerAngles = var_71_7.localEulerAngles

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_7.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["1053ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_12 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_12 and not isNil(var_71_11) then
				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_11) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_12 and arg_68_1.time_ < 0 + var_71_12 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_71_14 = arg_68_1.actors_["1037ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_14) and arg_68_1.var_.characterEffect1037ui_story == nil then
				arg_68_1.var_.characterEffect1037ui_story = var_71_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_15 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_15 and not isNil(var_71_14) then
				if arg_68_1.var_.characterEffect1037ui_story and not isNil(var_71_14) then
					arg_68_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_15)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_15 and arg_68_1.time_ < 0 + var_71_15 + arg_71_0 and not isNil(var_71_14) and arg_68_1.var_.characterEffect1037ui_story then
				arg_68_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action456")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_71_16 = 0
			local var_71_17 = 0.475

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(324771017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_21 = 19 <= 0 and var_71_17 or var_71_17 * (utf8.len(var_71_19) / 19)

				if (19 <= 0 and var_71_17 or var_71_17 * (utf8.len(var_71_19) / 19)) > 0 and var_71_17 < var_71_21 then
					arg_68_1.talkMaxDuration = var_71_21

					if var_71_21 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_21 + var_71_16
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771017", "story_v_out_324771.awb") ~= 0 then
					local var_71_22 = manager.audio:GetVoiceLength("story_v_out_324771", "324771017", "story_v_out_324771.awb") / 1000

					if var_71_22 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_16
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_324771", "324771017", "story_v_out_324771.awb")

						arg_68_1:RecordAudio("324771017", var_71_23)
						arg_68_1:RecordAudio("324771017", var_71_23)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324771", "324771017", "story_v_out_324771.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324771", "324771017", "story_v_out_324771.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_24 = math.max(var_71_17, arg_68_1.talkMaxDuration)

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_24 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_16) / var_71_24

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_16 + var_71_24 and arg_68_1.time_ < var_71_16 + var_71_24 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	assets = {
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324771.awb"
	}
}
