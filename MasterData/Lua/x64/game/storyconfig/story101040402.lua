return {
	Play104042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104042001
		arg_1_1.duration_ = 4.67

		local var_1_0 = {
			ja = 4.566,
			ko = 4.066,
			zh = 4.166,
			en = 4.666
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
				arg_1_0:Play104042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["1084ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_8 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_8 and not isNil(var_4_7) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_7) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_8 and arg_1_1.time_ < 2 + var_4_8 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_10 = "S0403"

			if arg_1_1.bgs_.S0403 == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.S0403:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueS0403 = var_4_12.color.a
					arg_1_1.var_.alphaMatValueS0403 = var_4_12
				end

				arg_1_1.var_.alphaOldValueS0403 = 0
			end

			local var_4_13 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				if arg_1_1.var_.alphaMatValueS0403 then
					arg_1_1.var_.alphaMatValueS0403.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0403, 1, (arg_1_1.time_ - 0) / var_4_13)
					arg_1_1.var_.alphaMatValueS0403.color = arg_1_1.var_.alphaMatValueS0403.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueS0403 then
				arg_1_1.var_.alphaMatValueS0403.color.a = 1
				arg_1_1.var_.alphaMatValueS0403.color = arg_1_1.var_.alphaMatValueS0403.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.S0403

				arg_1_1.bgs_.S0403.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0403" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_17 + 2 and arg_1_1.time_ < var_4_17 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_21 = arg_1_1:GetWordFromCfg(104042001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 7 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 7)

				if (7 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 7)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042001", "story_v_out_104042.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_104042", "104042001", "story_v_out_104042.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_104042", "104042001", "story_v_out_104042.awb")

						arg_1_1:RecordAudio("104042001", var_4_26)
						arg_1_1:RecordAudio("104042001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104042", "104042001", "story_v_out_104042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104042", "104042001", "story_v_out_104042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104042002
		arg_8_1.duration_ = 4.63

		local var_8_0 = {
			ja = 3.733,
			ko = 4.633,
			zh = 4.1,
			en = 3.7
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
				arg_8_0:Play104042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = arg_8_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(arg_8_1.actors_["1084ui_story"]) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.225

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(104042002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 9 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 9)

				if (9 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 9)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042002", "story_v_out_104042.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_104042", "104042002", "story_v_out_104042.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_104042", "104042002", "story_v_out_104042.awb")

						arg_8_1:RecordAudio("104042002", var_11_8)
						arg_8_1:RecordAudio("104042002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104042", "104042002", "story_v_out_104042.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104042", "104042002", "story_v_out_104042.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104042003
		arg_12_1.duration_ = 1.83

		local var_12_0 = {
			ja = 1.833,
			ko = 1.2,
			zh = 1,
			en = 1.233
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
				arg_12_0:Play104042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1019ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1019ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1019ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1019ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1019ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_15_6 = 0
			local var_15_7 = 0.1

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_8 = arg_12_1:GetWordFromCfg(104042003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 4 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 4)

				if (4 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 4)) > 0 and var_15_7 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042003", "story_v_out_104042.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_104042", "104042003", "story_v_out_104042.awb") / 1000

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_104042", "104042003", "story_v_out_104042.awb")

						arg_12_1:RecordAudio("104042003", var_15_13)
						arg_12_1:RecordAudio("104042003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104042", "104042003", "story_v_out_104042.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104042", "104042003", "story_v_out_104042.awb")
				end

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
	Play104042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104042004
		arg_16_1.duration_ = 4.93

		local var_16_0 = {
			ja = 4.466,
			ko = 3.466,
			zh = 4.1,
			en = 4.933
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
				arg_16_0:Play104042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1019ui_story"]) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = arg_16_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1019ui_story"]) then
				if arg_16_1.var_.characterEffect1019ui_story and not isNil(arg_16_1.actors_["1019ui_story"]) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1019ui_story"]) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.475

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(104042004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 19 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 19)

				if (19 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 19)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042004", "story_v_out_104042.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_104042", "104042004", "story_v_out_104042.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_104042", "104042004", "story_v_out_104042.awb")

						arg_16_1:RecordAudio("104042004", var_19_8)
						arg_16_1:RecordAudio("104042004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104042", "104042004", "story_v_out_104042.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104042", "104042004", "story_v_out_104042.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_9 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_9

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_9 and arg_16_1.time_ < var_19_1 + var_19_9 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play104042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104042005
		arg_20_1.duration_ = 4.63

		local var_20_0 = {
			ja = 2.233,
			ko = 3.1,
			zh = 3.233,
			en = 4.633
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
				arg_20_0:Play104042006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(104042005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 17)

				if (17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 17)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042005", "story_v_out_104042.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_104042", "104042005", "story_v_out_104042.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_104042", "104042005", "story_v_out_104042.awb")

						arg_20_1:RecordAudio("104042005", var_23_6)
						arg_20_1:RecordAudio("104042005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104042", "104042005", "story_v_out_104042.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104042", "104042005", "story_v_out_104042.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play104042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104042006
		arg_24_1.duration_ = 3.87

		local var_24_0 = {
			ja = 3.866,
			ko = 3.666,
			zh = 2.966,
			en = 3.333
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
				arg_24_0:Play104042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.2

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(104042006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 7 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 7)

				if (7 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 7)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042006", "story_v_out_104042.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_104042", "104042006", "story_v_out_104042.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_104042", "104042006", "story_v_out_104042.awb")

						arg_24_1:RecordAudio("104042006", var_27_6)
						arg_24_1:RecordAudio("104042006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104042", "104042006", "story_v_out_104042.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104042", "104042006", "story_v_out_104042.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play104042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104042007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.775

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(104042007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 31 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 31)

				if (31 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 31)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104042008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104042008
		arg_32_1.duration_ = 3.17

		local var_32_0 = {
			ja = 2.2,
			ko = 2.533,
			zh = 2.233,
			en = 3.166
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
				arg_32_0:Play104042009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(104042008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 9 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 9)

				if (9 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 9)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042008", "story_v_out_104042.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_104042", "104042008", "story_v_out_104042.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_104042", "104042008", "story_v_out_104042.awb")

						arg_32_1:RecordAudio("104042008", var_35_6)
						arg_32_1:RecordAudio("104042008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104042", "104042008", "story_v_out_104042.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104042", "104042008", "story_v_out_104042.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104042009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104042009
		arg_36_1.duration_ = 2.73

		local var_36_0 = {
			ja = 2.3,
			ko = 2.733,
			zh = 2.6,
			en = 2.566
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
				arg_36_0:Play104042010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.25

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(104042009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 10 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 10)

				if (10 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 10)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042009", "story_v_out_104042.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_104042", "104042009", "story_v_out_104042.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_104042", "104042009", "story_v_out_104042.awb")

						arg_36_1:RecordAudio("104042009", var_39_6)
						arg_36_1:RecordAudio("104042009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104042", "104042009", "story_v_out_104042.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104042", "104042009", "story_v_out_104042.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104042010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104042010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104042011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_4", "se_story_4_cutchain", "")
			end

			local var_43_1 = 0
			local var_43_2 = 0.575

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(104042010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 23 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 23)

				if (23 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 23)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104042011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104042011
		arg_44_1.duration_ = 3.73

		local var_44_0 = {
			ja = 3.566,
			ko = 3.733,
			zh = 3.666,
			en = 3.3
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
				arg_44_0:Play104042012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 2 < arg_44_1.time_ and arg_44_1.time_ <= 2 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = arg_44_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 2 <= arg_44_1.time_ and arg_44_1.time_ < 2 + var_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(arg_44_1.actors_["1084ui_story"]) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 2 + var_47_0 and arg_44_1.time_ < 2 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_2 = arg_44_1.bgs_.S0403:GetComponent("SpriteRenderer")

				if var_47_2 then
					arg_44_1.var_.alphaOldValueS0403 = var_47_2.color.a
					arg_44_1.var_.alphaMatValueS0403 = var_47_2
				end

				arg_44_1.var_.alphaOldValueS0403 = 1
			end

			local var_47_3 = 1.5

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 then
				if arg_44_1.var_.alphaMatValueS0403 then
					arg_44_1.var_.alphaMatValueS0403.color.a = Mathf.Lerp(arg_44_1.var_.alphaOldValueS0403, 0, (arg_44_1.time_ - 0) / var_47_3)
					arg_44_1.var_.alphaMatValueS0403.color = arg_44_1.var_.alphaMatValueS0403.color
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and arg_44_1.var_.alphaMatValueS0403 then
				arg_44_1.var_.alphaMatValueS0403.color.a = 0
				arg_44_1.var_.alphaMatValueS0403.color = arg_44_1.var_.alphaMatValueS0403.color
			end

			local var_47_4 = arg_44_1.bgs_.S0403.transform

			if 1.5 < arg_44_1.time_ and arg_44_1.time_ <= 1.5 + arg_47_0 then
				arg_44_1.var_.moveOldPosS0403 = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 1.5 <= arg_44_1.time_ and arg_44_1.time_ < 1.5 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPosS0403, Vector3.New(0, -100, 10), (arg_44_1.time_ - 1.5) / var_47_5)
			end

			if arg_44_1.time_ >= 1.5 + var_47_5 and arg_44_1.time_ < 1.5 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, -100, 10)
			end

			local var_47_6 = "B04b"

			if arg_44_1.bgs_.B04b == nil then
				local var_47_7 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_6)
				var_47_7.name = var_47_6
				var_47_7.transform.parent = arg_44_1.stage_.transform
				var_47_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_6] = var_47_7
			end

			if 1.5 < arg_44_1.time_ and arg_44_1.time_ <= 1.5 + arg_47_0 then
				local var_47_8 = arg_44_1.bgs_.B04b:GetComponent("SpriteRenderer")

				if var_47_8 then
					arg_44_1.var_.alphaOldValueB04b = var_47_8.color.a
					arg_44_1.var_.alphaMatValueB04b = var_47_8
				end

				arg_44_1.var_.alphaOldValueB04b = 0
			end

			local var_47_9 = 1.5

			if 1.5 <= arg_44_1.time_ and arg_44_1.time_ < 1.5 + var_47_9 then
				if arg_44_1.var_.alphaMatValueB04b then
					arg_44_1.var_.alphaMatValueB04b.color.a = Mathf.Lerp(arg_44_1.var_.alphaOldValueB04b, 1, (arg_44_1.time_ - 1.5) / var_47_9)
					arg_44_1.var_.alphaMatValueB04b.color = arg_44_1.var_.alphaMatValueB04b.color
				end
			end

			if arg_44_1.time_ >= 1.5 + var_47_9 and arg_44_1.time_ < 1.5 + var_47_9 + arg_47_0 and arg_44_1.var_.alphaMatValueB04b then
				arg_44_1.var_.alphaMatValueB04b.color.a = 1
				arg_44_1.var_.alphaMatValueB04b.color = arg_44_1.var_.alphaMatValueB04b.color
			end

			if 1.5 < arg_44_1.time_ and arg_44_1.time_ <= 1.5 + arg_47_0 then
				local var_47_10 = arg_44_1.bgs_.B04b

				arg_44_1.bgs_.B04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_11 = var_47_10:GetComponent("SpriteRenderer")

				if var_47_11 and var_47_11.sprite then
					local var_47_12 = 2 * (var_47_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_10.transform.localScale = Vector3.New(var_47_12 / var_47_11.sprite.bounds.size.y < var_47_12 * manager.ui.mainCameraCom_.aspect / var_47_11.sprite.bounds.size.x and var_47_12 * manager.ui.mainCameraCom_.aspect / var_47_11.sprite.bounds.size.x or var_47_12 / var_47_11.sprite.bounds.size.y, var_47_12 / var_47_11.sprite.bounds.size.y < var_47_12 * manager.ui.mainCameraCom_.aspect / var_47_11.sprite.bounds.size.x and var_47_12 * manager.ui.mainCameraCom_.aspect / var_47_11.sprite.bounds.size.x or var_47_12 / var_47_11.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "B04b" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_13 = arg_44_1.actors_["1084ui_story"].transform

			if 1.79999995231628 < arg_44_1.time_ and arg_44_1.time_ <= 1.79999995231628 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_13.localPosition
			end

			local var_47_14 = 0.001

			if 1.79999995231628 <= arg_44_1.time_ and arg_44_1.time_ < 1.79999995231628 + var_47_14 then
				var_47_13.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_44_1.time_ - 1.79999995231628) / var_47_14)
				var_47_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_13.position).x, (manager.ui.mainCamera.transform.position - var_47_13.position).y, (manager.ui.mainCamera.transform.position - var_47_13.position).z)
				var_47_13.localEulerAngles.z = 0
				var_47_13.localEulerAngles.x = 0
				var_47_13.localEulerAngles = var_47_13.localEulerAngles
			end

			if arg_44_1.time_ >= 1.79999995231628 + var_47_14 and arg_44_1.time_ < 1.79999995231628 + var_47_14 + arg_47_0 then
				var_47_13.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_47_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_13.position).x, (manager.ui.mainCamera.transform.position - var_47_13.position).y, (manager.ui.mainCamera.transform.position - var_47_13.position).z)
				var_47_13.localEulerAngles.z = 0
				var_47_13.localEulerAngles.x = 0
				var_47_13.localEulerAngles = var_47_13.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_47_15 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= var_47_15 + 2 and arg_44_1.time_ < var_47_15 + 2 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_16 = 2
			local var_47_17 = 0.175

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_18 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_18:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_19 = arg_44_1:GetWordFromCfg(104042011)
				local var_47_20 = arg_44_1:FormatText(var_47_19.content)

				arg_44_1.text_.text = var_47_20

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_22 = 7 <= 0 and var_47_17 or var_47_17 * (utf8.len(var_47_20) / 7)

				if (7 <= 0 and var_47_17 or var_47_17 * (utf8.len(var_47_20) / 7)) > 0 and var_47_17 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22
					var_47_16 = var_47_16 + 0.3

					if var_47_22 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_16
					end
				end

				arg_44_1.text_.text = var_47_20
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042011", "story_v_out_104042.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_104042", "104042011", "story_v_out_104042.awb") / 1000

					if var_47_23 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_16
					end

					if var_47_19.prefab_name ~= "" and arg_44_1.actors_[var_47_19.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_19.prefab_name].transform, "story_v_out_104042", "104042011", "story_v_out_104042.awb")

						arg_44_1:RecordAudio("104042011", var_47_24)
						arg_44_1:RecordAudio("104042011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104042", "104042011", "story_v_out_104042.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104042", "104042011", "story_v_out_104042.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = var_47_16 + 0.3
			local var_47_26 = math.max(var_47_17, arg_44_1.talkMaxDuration)

			if var_47_16 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_25 + var_47_26 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_25) / var_47_26

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_25 + var_47_26 and arg_44_1.time_ < var_47_25 + var_47_26 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0403",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play104042012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104042012
		arg_50_1.duration_ = 11.73

		local var_50_0 = {
			ja = 6.1,
			ko = 9.5,
			zh = 11.733,
			en = 7.366
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play104042013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_53_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_50_1.stage_.transform)

				var_53_0.name = "10001_tpose"
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["10001_tpose"] = var_53_0

				local var_53_1 = var_53_0:GetComponentInChildren(typeof(CharacterEffect))

				var_53_1.enabled = true

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end

				arg_50_1:ShowWeapon(var_53_1.transform, false)

				arg_50_1.var_["10001_tpose" .. "Animator"] = var_53_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_50_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_50_1.var_["10001_tpose" .. "LipSync"] = var_53_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_53_3 = arg_50_1.actors_["10001_tpose"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect10001_tpose == nil then
				arg_50_1.var_.characterEffect10001_tpose = var_53_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 and not isNil(var_53_3) then
				if arg_50_1.var_.characterEffect10001_tpose and not isNil(var_53_3) then
					arg_50_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect10001_tpose then
				arg_50_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_53_6 = arg_50_1.actors_["1084ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_6) and arg_50_1.var_.characterEffect1084ui_story == nil then
				arg_50_1.var_.characterEffect1084ui_story = var_53_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_7 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 and not isNil(var_53_6) then
				if arg_50_1.var_.characterEffect1084ui_story and not isNil(var_53_6) then
					arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_7)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 and not isNil(var_53_6) and arg_50_1.var_.characterEffect1084ui_story then
				arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_53_8 = arg_50_1.actors_["10001_tpose"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10001_tpose = var_53_8.localPosition

				local var_53_9 = GameObjectTools.GetOrAddComponent(var_53_8.gameObject, typeof(DynamicBoneHelper))

				if var_53_9 then
					var_53_9:EnableDynamicBone(false)
				end
			end

			local var_53_10 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_10 then
				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_50_1.time_ - 0) / var_53_10)
				var_53_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_8.position).x, (manager.ui.mainCamera.transform.position - var_53_8.position).y, (manager.ui.mainCamera.transform.position - var_53_8.position).z)
				var_53_8.localEulerAngles.z = 0
				var_53_8.localEulerAngles.x = 0
				var_53_8.localEulerAngles = var_53_8.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_10 and arg_50_1.time_ < 0 + var_53_10 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(0.7, -1.23, -5.8)
				var_53_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_8.position).x, (manager.ui.mainCamera.transform.position - var_53_8.position).y, (manager.ui.mainCamera.transform.position - var_53_8.position).z)
				var_53_8.localEulerAngles.z = 0
				var_53_8.localEulerAngles.x = 0
				var_53_8.localEulerAngles = var_53_8.localEulerAngles

				local var_53_11 = GameObjectTools.GetOrAddComponent(var_53_8.gameObject, typeof(DynamicBoneHelper))

				if var_53_11 then
					var_53_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_53_12 = 0
			local var_53_13 = 0.6

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_14 = arg_50_1:GetWordFromCfg(104042012)
				local var_53_15 = arg_50_1:FormatText(var_53_14.content)

				arg_50_1.text_.text = var_53_15

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_17 = 23 <= 0 and var_53_13 or var_53_13 * (utf8.len(var_53_15) / 23)

				if (23 <= 0 and var_53_13 or var_53_13 * (utf8.len(var_53_15) / 23)) > 0 and var_53_13 < var_53_17 then
					arg_50_1.talkMaxDuration = var_53_17

					if var_53_17 + var_53_12 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_17 + var_53_12
					end
				end

				arg_50_1.text_.text = var_53_15
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042012", "story_v_out_104042.awb") ~= 0 then
					local var_53_18 = manager.audio:GetVoiceLength("story_v_out_104042", "104042012", "story_v_out_104042.awb") / 1000

					if var_53_18 + var_53_12 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_18 + var_53_12
					end

					if var_53_14.prefab_name ~= "" and arg_50_1.actors_[var_53_14.prefab_name] ~= nil then
						local var_53_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_14.prefab_name].transform, "story_v_out_104042", "104042012", "story_v_out_104042.awb")

						arg_50_1:RecordAudio("104042012", var_53_19)
						arg_50_1:RecordAudio("104042012", var_53_19)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_104042", "104042012", "story_v_out_104042.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_104042", "104042012", "story_v_out_104042.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_20 = math.max(var_53_13, arg_50_1.talkMaxDuration)

			if var_53_12 <= arg_50_1.time_ and arg_50_1.time_ < var_53_12 + var_53_20 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_12) / var_53_20

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_12 + var_53_20 and arg_50_1.time_ < var_53_12 + var_53_20 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play104042013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104042013
		arg_54_1.duration_ = 5.1

		local var_54_0 = {
			ja = 4.033,
			ko = 3.833,
			zh = 5.1,
			en = 2.7
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104042014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_2")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_57_0 = 0
			local var_57_1 = 0.325

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(104042013)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 11 <= 0 and var_57_1 or var_57_1 * (utf8.len(var_57_3) / 11)

				if (11 <= 0 and var_57_1 or var_57_1 * (utf8.len(var_57_3) / 11)) > 0 and var_57_1 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042013", "story_v_out_104042.awb") ~= 0 then
					local var_57_6 = manager.audio:GetVoiceLength("story_v_out_104042", "104042013", "story_v_out_104042.awb") / 1000

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end

					if var_57_2.prefab_name ~= "" and arg_54_1.actors_[var_57_2.prefab_name] ~= nil then
						local var_57_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_2.prefab_name].transform, "story_v_out_104042", "104042013", "story_v_out_104042.awb")

						arg_54_1:RecordAudio("104042013", var_57_7)
						arg_54_1:RecordAudio("104042013", var_57_7)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104042", "104042013", "story_v_out_104042.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104042", "104042013", "story_v_out_104042.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_8 and arg_54_1.time_ < var_57_0 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play104042014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104042014
		arg_58_1.duration_ = 2.67

		local var_58_0 = {
			ja = 2.666,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play104042015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_61_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_58_1.stage_.transform)

				var_61_0.name = "1036ui_story"
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_["1036ui_story"] = var_61_0

				local var_61_1 = var_61_0:GetComponentInChildren(typeof(CharacterEffect))

				var_61_1.enabled = true

				local var_61_2 = GameObjectTools.GetOrAddComponent(var_61_0, typeof(DynamicBoneHelper))

				if var_61_2 then
					var_61_2:EnableDynamicBone(false)
				end

				arg_58_1:ShowWeapon(var_61_1.transform, false)

				arg_58_1.var_["1036ui_story" .. "Animator"] = var_61_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_58_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_58_1.var_["1036ui_story" .. "LipSync"] = var_61_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_61_3 = arg_58_1.actors_["1036ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_3) and arg_58_1.var_.characterEffect1036ui_story == nil then
				arg_58_1.var_.characterEffect1036ui_story = var_61_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_4 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 and not isNil(var_61_3) then
				if arg_58_1.var_.characterEffect1036ui_story and not isNil(var_61_3) then
					arg_58_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 and not isNil(var_61_3) and arg_58_1.var_.characterEffect1036ui_story then
				arg_58_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_61_6 = arg_58_1.actors_["10001_tpose"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_6) and arg_58_1.var_.characterEffect10001_tpose == nil then
				arg_58_1.var_.characterEffect10001_tpose = var_61_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_7 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 and not isNil(var_61_6) then
				if arg_58_1.var_.characterEffect10001_tpose and not isNil(var_61_6) then
					arg_58_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_58_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_7)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 and not isNil(var_61_6) and arg_58_1.var_.characterEffect10001_tpose then
				arg_58_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_58_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_61_8 = arg_58_1.actors_["1084ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1084ui_story = var_61_8.localPosition
			end

			local var_61_9 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_9 then
				var_61_8.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_9)
				var_61_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_8.position).x, (manager.ui.mainCamera.transform.position - var_61_8.position).y, (manager.ui.mainCamera.transform.position - var_61_8.position).z)
				var_61_8.localEulerAngles.z = 0
				var_61_8.localEulerAngles.x = 0
				var_61_8.localEulerAngles = var_61_8.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_9 and arg_58_1.time_ < 0 + var_61_9 + arg_61_0 then
				var_61_8.localPosition = Vector3.New(0, 100, 0)
				var_61_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_8.position).x, (manager.ui.mainCamera.transform.position - var_61_8.position).y, (manager.ui.mainCamera.transform.position - var_61_8.position).z)
				var_61_8.localEulerAngles.z = 0
				var_61_8.localEulerAngles.x = 0
				var_61_8.localEulerAngles = var_61_8.localEulerAngles
			end

			local var_61_10 = arg_58_1.actors_["1036ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1036ui_story = var_61_10.localPosition
			end

			local var_61_11 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_11 then
				var_61_10.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_58_1.time_ - 0) / var_61_11)
				var_61_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_10.position).x, (manager.ui.mainCamera.transform.position - var_61_10.position).y, (manager.ui.mainCamera.transform.position - var_61_10.position).z)
				var_61_10.localEulerAngles.z = 0
				var_61_10.localEulerAngles.x = 0
				var_61_10.localEulerAngles = var_61_10.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_11 and arg_58_1.time_ < 0 + var_61_11 + arg_61_0 then
				var_61_10.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_61_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_10.position).x, (manager.ui.mainCamera.transform.position - var_61_10.position).y, (manager.ui.mainCamera.transform.position - var_61_10.position).z)
				var_61_10.localEulerAngles.z = 0
				var_61_10.localEulerAngles.x = 0
				var_61_10.localEulerAngles = var_61_10.localEulerAngles
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_61_12 = 0
			local var_61_13 = 0.225

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_14 = arg_58_1:GetWordFromCfg(104042014)
				local var_61_15 = arg_58_1:FormatText(var_61_14.content)

				arg_58_1.text_.text = var_61_15

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_17 = 9 <= 0 and var_61_13 or var_61_13 * (utf8.len(var_61_15) / 9)

				if (9 <= 0 and var_61_13 or var_61_13 * (utf8.len(var_61_15) / 9)) > 0 and var_61_13 < var_61_17 then
					arg_58_1.talkMaxDuration = var_61_17

					if var_61_17 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_17 + var_61_12
					end
				end

				arg_58_1.text_.text = var_61_15
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042014", "story_v_out_104042.awb") ~= 0 then
					local var_61_18 = manager.audio:GetVoiceLength("story_v_out_104042", "104042014", "story_v_out_104042.awb") / 1000

					if var_61_18 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_18 + var_61_12
					end

					if var_61_14.prefab_name ~= "" and arg_58_1.actors_[var_61_14.prefab_name] ~= nil then
						local var_61_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_14.prefab_name].transform, "story_v_out_104042", "104042014", "story_v_out_104042.awb")

						arg_58_1:RecordAudio("104042014", var_61_19)
						arg_58_1:RecordAudio("104042014", var_61_19)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_104042", "104042014", "story_v_out_104042.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_104042", "104042014", "story_v_out_104042.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_20 = math.max(var_61_13, arg_58_1.talkMaxDuration)

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_20 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_12) / var_61_20

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_12 + var_61_20 and arg_58_1.time_ < var_61_12 + var_61_20 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play104042015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104042015
		arg_62_1.duration_ = 3.93

		local var_62_0 = {
			ja = 3.933,
			ko = 2.933,
			zh = 2.533,
			en = 2.766
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play104042016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) and arg_62_1.var_.characterEffect1019ui_story == nil then
				arg_62_1.var_.characterEffect1019ui_story = arg_62_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) then
				if arg_62_1.var_.characterEffect1019ui_story and not isNil(arg_62_1.actors_["1019ui_story"]) then
					arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) and arg_62_1.var_.characterEffect1019ui_story then
				arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["1036ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1036ui_story == nil then
				arg_62_1.var_.characterEffect1036ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect1036ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1036ui_story then
				arg_62_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_65_4 = arg_62_1.actors_["1036ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1036ui_story = var_65_4.localPosition
			end

			local var_65_5 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 then
				var_65_4.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_5)
				var_65_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_4.position).x, (manager.ui.mainCamera.transform.position - var_65_4.position).y, (manager.ui.mainCamera.transform.position - var_65_4.position).z)
				var_65_4.localEulerAngles.z = 0
				var_65_4.localEulerAngles.x = 0
				var_65_4.localEulerAngles = var_65_4.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 then
				var_65_4.localPosition = Vector3.New(0, 100, 0)
				var_65_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_4.position).x, (manager.ui.mainCamera.transform.position - var_65_4.position).y, (manager.ui.mainCamera.transform.position - var_65_4.position).z)
				var_65_4.localEulerAngles.z = 0
				var_65_4.localEulerAngles.x = 0
				var_65_4.localEulerAngles = var_65_4.localEulerAngles
			end

			local var_65_6 = arg_62_1.actors_["1019ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1019ui_story = var_65_6.localPosition
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_6.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_62_1.time_ - 0) / var_65_7)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_65_8 = 0
			local var_65_9 = 0.325

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(104042015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 13 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 13)

				if (13 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 13)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042015", "story_v_out_104042.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042015", "story_v_out_104042.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_104042", "104042015", "story_v_out_104042.awb")

						arg_62_1:RecordAudio("104042015", var_65_15)
						arg_62_1:RecordAudio("104042015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104042", "104042015", "story_v_out_104042.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104042", "104042015", "story_v_out_104042.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_62_1:InitPlayNodeList()
	end,
	Play104042016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104042016
		arg_66_1.duration_ = 5.67

		local var_66_0 = {
			ja = 3.866,
			ko = 3.633,
			zh = 5.666,
			en = 4.2
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play104042017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10001_tpose"]) and arg_66_1.var_.characterEffect10001_tpose == nil then
				arg_66_1.var_.characterEffect10001_tpose = arg_66_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10001_tpose"]) then
				if arg_66_1.var_.characterEffect10001_tpose and not isNil(arg_66_1.actors_["10001_tpose"]) then
					arg_66_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10001_tpose"]) and arg_66_1.var_.characterEffect10001_tpose then
				arg_66_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["1019ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_2) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_3)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_69_4 = 0
			local var_69_5 = 0.4

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(104042016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 16 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 16)

				if (16 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 16)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042016", "story_v_out_104042.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042016", "story_v_out_104042.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_104042", "104042016", "story_v_out_104042.awb")

						arg_66_1:RecordAudio("104042016", var_69_11)
						arg_66_1:RecordAudio("104042016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104042", "104042016", "story_v_out_104042.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104042", "104042016", "story_v_out_104042.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104042017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104042017
		arg_70_1.duration_ = 2.37

		local var_70_0 = {
			ja = 2.366,
			ko = 1.633,
			zh = 2,
			en = 1.9
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play104042018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10001_tpose"]) and arg_70_1.var_.characterEffect10001_tpose == nil then
				arg_70_1.var_.characterEffect10001_tpose = arg_70_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10001_tpose"]) then
				if arg_70_1.var_.characterEffect10001_tpose and not isNil(arg_70_1.actors_["10001_tpose"]) then
					arg_70_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_70_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10001_tpose"]) and arg_70_1.var_.characterEffect10001_tpose then
				arg_70_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_70_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.2

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(104042017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_6 = 8 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_4) / 8)

				if (8 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_4) / 8)) > 0 and var_73_2 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042017", "story_v_out_104042.awb") ~= 0 then
					local var_73_7 = manager.audio:GetVoiceLength("story_v_out_104042", "104042017", "story_v_out_104042.awb") / 1000

					if var_73_7 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_1
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_104042", "104042017", "story_v_out_104042.awb")

						arg_70_1:RecordAudio("104042017", var_73_8)
						arg_70_1:RecordAudio("104042017", var_73_8)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104042", "104042017", "story_v_out_104042.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104042", "104042017", "story_v_out_104042.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_9 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_9 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_9

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_9 and arg_70_1.time_ < var_73_1 + var_73_9 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104042018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104042018
		arg_74_1.duration_ = 7.17

		local var_74_0 = {
			ja = 4.7,
			ko = 5.766,
			zh = 7.166,
			en = 5.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play104042019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10001_tpose"]) and arg_74_1.var_.characterEffect10001_tpose == nil then
				arg_74_1.var_.characterEffect10001_tpose = arg_74_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10001_tpose"]) then
				if arg_74_1.var_.characterEffect10001_tpose and not isNil(arg_74_1.actors_["10001_tpose"]) then
					arg_74_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10001_tpose"]) and arg_74_1.var_.characterEffect10001_tpose then
				arg_74_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action445")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_77_2 = 0
			local var_77_3 = 0.75

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(104042018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 30 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 30)

				if (30 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 30)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042018", "story_v_out_104042.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_104042", "104042018", "story_v_out_104042.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_104042", "104042018", "story_v_out_104042.awb")

						arg_74_1:RecordAudio("104042018", var_77_9)
						arg_74_1:RecordAudio("104042018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104042", "104042018", "story_v_out_104042.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104042", "104042018", "story_v_out_104042.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104042019
		arg_78_1.duration_ = 6.47

		local var_78_0 = {
			ja = 6.466,
			ko = 3.8,
			zh = 4.166,
			en = 4.166
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
				arg_78_0:Play104042020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = arg_78_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) then
				if arg_78_1.var_.characterEffect1019ui_story and not isNil(arg_78_1.actors_["1019ui_story"]) then
					arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) and arg_78_1.var_.characterEffect1019ui_story then
				arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["10001_tpose"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect10001_tpose == nil then
				arg_78_1.var_.characterEffect10001_tpose = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect10001_tpose and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_78_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect10001_tpose then
				arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_78_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_81_4 = 0
			local var_81_5 = 0.625

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(104042019)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 25 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 25)

				if (25 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 25)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042019", "story_v_out_104042.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042019", "story_v_out_104042.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_104042", "104042019", "story_v_out_104042.awb")

						arg_78_1:RecordAudio("104042019", var_81_11)
						arg_78_1:RecordAudio("104042019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104042", "104042019", "story_v_out_104042.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104042", "104042019", "story_v_out_104042.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play104042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104042020
		arg_82_1.duration_ = 5.07

		local var_82_0 = {
			ja = 5.066,
			ko = 2.733,
			zh = 3.7,
			en = 2.4
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
				arg_82_0:Play104042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10001_tpose"]) and arg_82_1.var_.characterEffect10001_tpose == nil then
				arg_82_1.var_.characterEffect10001_tpose = arg_82_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10001_tpose"]) then
				if arg_82_1.var_.characterEffect10001_tpose and not isNil(arg_82_1.actors_["10001_tpose"]) then
					arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10001_tpose"]) and arg_82_1.var_.characterEffect10001_tpose then
				arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1019ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1019ui_story == nil then
				arg_82_1.var_.characterEffect1019ui_story = var_85_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_3 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.characterEffect1019ui_story and not isNil(var_85_2) then
					arg_82_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_3)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1019ui_story then
				arg_82_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_2")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_85_4 = 0
			local var_85_5 = 0.25

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(104042020)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 10 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 10)

				if (10 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 10)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042020", "story_v_out_104042.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042020", "story_v_out_104042.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_104042", "104042020", "story_v_out_104042.awb")

						arg_82_1:RecordAudio("104042020", var_85_11)
						arg_82_1:RecordAudio("104042020", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104042", "104042020", "story_v_out_104042.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104042", "104042020", "story_v_out_104042.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play104042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104042021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play104042022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10001_tpose"]) and arg_86_1.var_.characterEffect10001_tpose == nil then
				arg_86_1.var_.characterEffect10001_tpose = arg_86_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10001_tpose"]) then
				if arg_86_1.var_.characterEffect10001_tpose and not isNil(arg_86_1.actors_["10001_tpose"]) then
					arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_86_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10001_tpose"]) and arg_86_1.var_.characterEffect10001_tpose then
				arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_86_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_89_1 = arg_86_1.actors_["10001_tpose"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10001_tpose = var_89_1.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_1.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_3)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0, 100, 0)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles

				local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_1.gameObject, typeof(DynamicBoneHelper))

				if var_89_4 then
					var_89_4:EnableDynamicBone(true)
				end
			end

			local var_89_5 = arg_86_1.actors_["1019ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1019ui_story = var_89_5.localPosition
			end

			local var_89_6 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_6 then
				var_89_5.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_6)
				var_89_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_5.position).x, (manager.ui.mainCamera.transform.position - var_89_5.position).y, (manager.ui.mainCamera.transform.position - var_89_5.position).z)
				var_89_5.localEulerAngles.z = 0
				var_89_5.localEulerAngles.x = 0
				var_89_5.localEulerAngles = var_89_5.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_6 and arg_86_1.time_ < 0 + var_89_6 + arg_89_0 then
				var_89_5.localPosition = Vector3.New(0, 100, 0)
				var_89_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_5.position).x, (manager.ui.mainCamera.transform.position - var_89_5.position).y, (manager.ui.mainCamera.transform.position - var_89_5.position).z)
				var_89_5.localEulerAngles.z = 0
				var_89_5.localEulerAngles.x = 0
				var_89_5.localEulerAngles = var_89_5.localEulerAngles
			end

			local var_89_7 = 0
			local var_89_8 = 1.05

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_9 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(104042021).content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 42 <= 0 and var_89_8 or var_89_8 * (utf8.len(var_89_9) / 42)

				if (42 <= 0 and var_89_8 or var_89_8 * (utf8.len(var_89_9) / 42)) > 0 and var_89_8 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_7 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_7
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_8, arg_86_1.talkMaxDuration)

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_7) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_7 + var_89_12 and arg_86_1.time_ < var_89_7 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_86_1:InitPlayNodeList()
	end,
	Play104042022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104042022
		arg_90_1.duration_ = 8.4

		local var_90_0 = {
			ja = 8.4,
			ko = 6.833,
			zh = 5.4,
			en = 6.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play104042023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1036ui_story"]) and arg_90_1.var_.characterEffect1036ui_story == nil then
				arg_90_1.var_.characterEffect1036ui_story = arg_90_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1036ui_story"]) then
				if arg_90_1.var_.characterEffect1036ui_story and not isNil(arg_90_1.actors_["1036ui_story"]) then
					arg_90_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1036ui_story"]) and arg_90_1.var_.characterEffect1036ui_story then
				arg_90_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_93_2 = arg_90_1.actors_["1036ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1036ui_story = var_93_2.localPosition
			end

			local var_93_3 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_90_1.time_ - 0) / var_93_3)
				var_93_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_2.position).x, (manager.ui.mainCamera.transform.position - var_93_2.position).y, (manager.ui.mainCamera.transform.position - var_93_2.position).z)
				var_93_2.localEulerAngles.z = 0
				var_93_2.localEulerAngles.x = 0
				var_93_2.localEulerAngles = var_93_2.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_93_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_2.position).x, (manager.ui.mainCamera.transform.position - var_93_2.position).y, (manager.ui.mainCamera.transform.position - var_93_2.position).z)
				var_93_2.localEulerAngles.z = 0
				var_93_2.localEulerAngles.x = 0
				var_93_2.localEulerAngles = var_93_2.localEulerAngles
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_93_4 = 0
			local var_93_5 = 0.825

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(104042022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 32 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 32)

				if (32 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 32)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042022", "story_v_out_104042.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042022", "story_v_out_104042.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_104042", "104042022", "story_v_out_104042.awb")

						arg_90_1:RecordAudio("104042022", var_93_11)
						arg_90_1:RecordAudio("104042022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104042", "104042022", "story_v_out_104042.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104042", "104042022", "story_v_out_104042.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play104042023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 104042023
		arg_94_1.duration_ = 10.93

		local var_94_0 = {
			ja = 10.933,
			ko = 7.7,
			zh = 7.7,
			en = 6.3
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
				arg_94_0:Play104042024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10001_tpose"]) and arg_94_1.var_.characterEffect10001_tpose == nil then
				arg_94_1.var_.characterEffect10001_tpose = arg_94_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10001_tpose"]) then
				if arg_94_1.var_.characterEffect10001_tpose and not isNil(arg_94_1.actors_["10001_tpose"]) then
					arg_94_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10001_tpose"]) and arg_94_1.var_.characterEffect10001_tpose then
				arg_94_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["1036ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1036ui_story == nil then
				arg_94_1.var_.characterEffect1036ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect1036ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1036ui_story then
				arg_94_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_97_4 = arg_94_1.actors_["10001_tpose"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos10001_tpose = var_97_4.localPosition

				local var_97_5 = GameObjectTools.GetOrAddComponent(var_97_4.gameObject, typeof(DynamicBoneHelper))

				if var_97_5 then
					var_97_5:EnableDynamicBone(false)
				end
			end

			local var_97_6 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_6 then
				var_97_4.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_94_1.time_ - 0) / var_97_6)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_6 and arg_94_1.time_ < 0 + var_97_6 + arg_97_0 then
				var_97_4.localPosition = Vector3.New(0.7, -1.23, -5.8)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles

				local var_97_7 = GameObjectTools.GetOrAddComponent(var_97_4.gameObject, typeof(DynamicBoneHelper))

				if var_97_7 then
					var_97_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_97_8 = 0
			local var_97_9 = 0.925

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(104042023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 36 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 36)

				if (36 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 36)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042023", "story_v_out_104042.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042023", "story_v_out_104042.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_104042", "104042023", "story_v_out_104042.awb")

						arg_94_1:RecordAudio("104042023", var_97_15)
						arg_94_1:RecordAudio("104042023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_104042", "104042023", "story_v_out_104042.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_104042", "104042023", "story_v_out_104042.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play104042024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 104042024
		arg_98_1.duration_ = 3.2

		local var_98_0 = {
			ja = 3.2,
			ko = 2.566,
			zh = 2.433,
			en = 2
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play104042025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = arg_98_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) then
				if arg_98_1.var_.characterEffect1019ui_story and not isNil(arg_98_1.actors_["1019ui_story"]) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["10001_tpose"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10001_tpose == nil then
				arg_98_1.var_.characterEffect10001_tpose = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect10001_tpose and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_98_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10001_tpose then
				arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_98_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_101_4 = arg_98_1.actors_["1036ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1036ui_story = var_101_4.localPosition
			end

			local var_101_5 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_5 then
				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_5)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_5 and arg_98_1.time_ < 0 + var_101_5 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0, 100, 0)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			local var_101_6 = arg_98_1.actors_["1019ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1019ui_story = var_101_6.localPosition
			end

			local var_101_7 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_98_1.time_ - 0) / var_101_7)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_101_8 = 0
			local var_101_9 = 0.325

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(104042024)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 13 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 13)

				if (13 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 13)) > 0 and var_101_9 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042024", "story_v_out_104042.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042024", "story_v_out_104042.awb") / 1000

					if var_101_14 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_8
					end

					if var_101_10.prefab_name ~= "" and arg_98_1.actors_[var_101_10.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_10.prefab_name].transform, "story_v_out_104042", "104042024", "story_v_out_104042.awb")

						arg_98_1:RecordAudio("104042024", var_101_15)
						arg_98_1:RecordAudio("104042024", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_104042", "104042024", "story_v_out_104042.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_104042", "104042024", "story_v_out_104042.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_98_1:InitPlayNodeList()
	end,
	Play104042025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 104042025
		arg_102_1.duration_ = 12.87

		local var_102_0 = {
			ja = 12.866,
			ko = 10.933,
			zh = 9.4,
			en = 10.1
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play104042026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10001_tpose"]) and arg_102_1.var_.characterEffect10001_tpose == nil then
				arg_102_1.var_.characterEffect10001_tpose = arg_102_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10001_tpose"]) then
				if arg_102_1.var_.characterEffect10001_tpose and not isNil(arg_102_1.actors_["10001_tpose"]) then
					arg_102_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10001_tpose"]) and arg_102_1.var_.characterEffect10001_tpose then
				arg_102_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["1019ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect1019ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1019ui_story then
				arg_102_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action425")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_105_4 = 0
			local var_105_5 = 1.2

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(104042025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 48 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 48)

				if (48 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 48)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042025", "story_v_out_104042.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042025", "story_v_out_104042.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_104042", "104042025", "story_v_out_104042.awb")

						arg_102_1:RecordAudio("104042025", var_105_11)
						arg_102_1:RecordAudio("104042025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_104042", "104042025", "story_v_out_104042.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_104042", "104042025", "story_v_out_104042.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play104042026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 104042026
		arg_106_1.duration_ = 4.53

		local var_106_0 = {
			ja = 4.533,
			ko = 4.066,
			zh = 3.8,
			en = 2.9
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
				arg_106_0:Play104042027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action453")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_109_0 = 0
			local var_109_1 = 0.5

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(104042026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 20 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 20)

				if (20 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 20)) > 0 and var_109_1 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042026", "story_v_out_104042.awb") ~= 0 then
					local var_109_6 = manager.audio:GetVoiceLength("story_v_out_104042", "104042026", "story_v_out_104042.awb") / 1000

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end

					if var_109_2.prefab_name ~= "" and arg_106_1.actors_[var_109_2.prefab_name] ~= nil then
						local var_109_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_2.prefab_name].transform, "story_v_out_104042", "104042026", "story_v_out_104042.awb")

						arg_106_1:RecordAudio("104042026", var_109_7)
						arg_106_1:RecordAudio("104042026", var_109_7)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_104042", "104042026", "story_v_out_104042.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_104042", "104042026", "story_v_out_104042.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play104042027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 104042027
		arg_110_1.duration_ = 8.27

		local var_110_0 = {
			ja = 8.266,
			ko = 5.3,
			zh = 5.1,
			en = 6.766
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play104042028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = arg_110_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) then
				if arg_110_1.var_.characterEffect1019ui_story and not isNil(arg_110_1.actors_["1019ui_story"]) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["10001_tpose"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect10001_tpose == nil then
				arg_110_1.var_.characterEffect10001_tpose = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect10001_tpose and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_110_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect10001_tpose then
				arg_110_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_110_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_113_4 = 0
			local var_113_5 = 0.675

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(104042027)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 27 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 27)

				if (27 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 27)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042027", "story_v_out_104042.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042027", "story_v_out_104042.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_104042", "104042027", "story_v_out_104042.awb")

						arg_110_1:RecordAudio("104042027", var_113_11)
						arg_110_1:RecordAudio("104042027", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_104042", "104042027", "story_v_out_104042.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_104042", "104042027", "story_v_out_104042.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play104042028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 104042028
		arg_114_1.duration_ = 2

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play104042029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10001_tpose"]) and arg_114_1.var_.characterEffect10001_tpose == nil then
				arg_114_1.var_.characterEffect10001_tpose = arg_114_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10001_tpose"]) then
				if arg_114_1.var_.characterEffect10001_tpose and not isNil(arg_114_1.actors_["10001_tpose"]) then
					arg_114_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10001_tpose"]) and arg_114_1.var_.characterEffect10001_tpose then
				arg_114_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1019ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1019ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1019ui_story then
				arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action435")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_117_4 = 0
			local var_117_5 = 0.15

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(104042028)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 6 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 6)

				if (6 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 6)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042028", "story_v_out_104042.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042028", "story_v_out_104042.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_104042", "104042028", "story_v_out_104042.awb")

						arg_114_1:RecordAudio("104042028", var_117_11)
						arg_114_1:RecordAudio("104042028", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_104042", "104042028", "story_v_out_104042.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_104042", "104042028", "story_v_out_104042.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play104042029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 104042029
		arg_118_1.duration_ = 5.53

		local var_118_0 = {
			ja = 5.533,
			ko = 3.933,
			zh = 3.366,
			en = 2.3
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play104042030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = arg_118_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) then
				if arg_118_1.var_.characterEffect1019ui_story and not isNil(arg_118_1.actors_["1019ui_story"]) then
					arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) and arg_118_1.var_.characterEffect1019ui_story then
				arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["10001_tpose"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect10001_tpose == nil then
				arg_118_1.var_.characterEffect10001_tpose = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect10001_tpose and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_118_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect10001_tpose then
				arg_118_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_118_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.4

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(104042029)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 16 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 16)

				if (16 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 16)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042029", "story_v_out_104042.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042029", "story_v_out_104042.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_104042", "104042029", "story_v_out_104042.awb")

						arg_118_1:RecordAudio("104042029", var_121_11)
						arg_118_1:RecordAudio("104042029", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_104042", "104042029", "story_v_out_104042.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_104042", "104042029", "story_v_out_104042.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play104042030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 104042030
		arg_122_1.duration_ = 5.8

		local var_122_0 = {
			ja = 5.266,
			ko = 5.8,
			zh = 5.3,
			en = 3.5
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play104042031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["10001_tpose"]) and arg_122_1.var_.characterEffect10001_tpose == nil then
				arg_122_1.var_.characterEffect10001_tpose = arg_122_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["10001_tpose"]) then
				if arg_122_1.var_.characterEffect10001_tpose and not isNil(arg_122_1.actors_["10001_tpose"]) then
					arg_122_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["10001_tpose"]) and arg_122_1.var_.characterEffect10001_tpose then
				arg_122_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["1019ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1019ui_story == nil then
				arg_122_1.var_.characterEffect1019ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect1019ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1019ui_story then
				arg_122_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action453")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_125_4 = 0
			local var_125_5 = 0.45

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(104042030)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 18 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 18)

				if (18 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 18)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042030", "story_v_out_104042.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042030", "story_v_out_104042.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_104042", "104042030", "story_v_out_104042.awb")

						arg_122_1:RecordAudio("104042030", var_125_11)
						arg_122_1:RecordAudio("104042030", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_104042", "104042030", "story_v_out_104042.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_104042", "104042030", "story_v_out_104042.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play104042031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 104042031
		arg_126_1.duration_ = 6.2

		local var_126_0 = {
			ja = 6.2,
			ko = 4.2,
			zh = 2.833,
			en = 3.566
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play104042032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1036ui_story"]) and arg_126_1.var_.characterEffect1036ui_story == nil then
				arg_126_1.var_.characterEffect1036ui_story = arg_126_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1036ui_story"]) then
				if arg_126_1.var_.characterEffect1036ui_story and not isNil(arg_126_1.actors_["1036ui_story"]) then
					arg_126_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1036ui_story"]) and arg_126_1.var_.characterEffect1036ui_story then
				arg_126_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_129_2 = arg_126_1.actors_["10001_tpose"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect10001_tpose == nil then
				arg_126_1.var_.characterEffect10001_tpose = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.characterEffect10001_tpose and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_126_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_3)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect10001_tpose then
				arg_126_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_126_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_129_4 = arg_126_1.actors_["10001_tpose"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10001_tpose = var_129_4.localPosition

				local var_129_5 = GameObjectTools.GetOrAddComponent(var_129_4.gameObject, typeof(DynamicBoneHelper))

				if var_129_5 then
					var_129_5:EnableDynamicBone(false)
				end
			end

			local var_129_6 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 then
				var_129_4.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_6)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 then
				var_129_4.localPosition = Vector3.New(0, 100, 0)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles

				local var_129_7 = GameObjectTools.GetOrAddComponent(var_129_4.gameObject, typeof(DynamicBoneHelper))

				if var_129_7 then
					var_129_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_129_8 = arg_126_1.actors_["1036ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1036ui_story = var_129_8.localPosition
			end

			local var_129_9 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_9 then
				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_126_1.time_ - 0) / var_129_9)
				var_129_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_8.position).x, (manager.ui.mainCamera.transform.position - var_129_8.position).y, (manager.ui.mainCamera.transform.position - var_129_8.position).z)
				var_129_8.localEulerAngles.z = 0
				var_129_8.localEulerAngles.x = 0
				var_129_8.localEulerAngles = var_129_8.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_9 and arg_126_1.time_ < 0 + var_129_9 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_129_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_8.position).x, (manager.ui.mainCamera.transform.position - var_129_8.position).y, (manager.ui.mainCamera.transform.position - var_129_8.position).z)
				var_129_8.localEulerAngles.z = 0
				var_129_8.localEulerAngles.x = 0
				var_129_8.localEulerAngles = var_129_8.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_10 = 0
			local var_129_11 = 0.35

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_12 = arg_126_1:GetWordFromCfg(104042031)
				local var_129_13 = arg_126_1:FormatText(var_129_12.content)

				arg_126_1.text_.text = var_129_13

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_15 = 14 <= 0 and var_129_11 or var_129_11 * (utf8.len(var_129_13) / 14)

				if (14 <= 0 and var_129_11 or var_129_11 * (utf8.len(var_129_13) / 14)) > 0 and var_129_11 < var_129_15 then
					arg_126_1.talkMaxDuration = var_129_15

					if var_129_15 + var_129_10 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_15 + var_129_10
					end
				end

				arg_126_1.text_.text = var_129_13
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042031", "story_v_out_104042.awb") ~= 0 then
					local var_129_16 = manager.audio:GetVoiceLength("story_v_out_104042", "104042031", "story_v_out_104042.awb") / 1000

					if var_129_16 + var_129_10 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_16 + var_129_10
					end

					if var_129_12.prefab_name ~= "" and arg_126_1.actors_[var_129_12.prefab_name] ~= nil then
						local var_129_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_12.prefab_name].transform, "story_v_out_104042", "104042031", "story_v_out_104042.awb")

						arg_126_1:RecordAudio("104042031", var_129_17)
						arg_126_1:RecordAudio("104042031", var_129_17)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_104042", "104042031", "story_v_out_104042.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_104042", "104042031", "story_v_out_104042.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_18 = math.max(var_129_11, arg_126_1.talkMaxDuration)

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_18 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_10) / var_129_18

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_10 + var_129_18 and arg_126_1.time_ < var_129_10 + var_129_18 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play104042032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 104042032
		arg_130_1.duration_ = 11.77

		local var_130_0 = {
			ja = 11.766,
			ko = 8.566,
			zh = 9.133,
			en = 9.133
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play104042033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1019ui_story"]) and arg_130_1.var_.characterEffect1019ui_story == nil then
				arg_130_1.var_.characterEffect1019ui_story = arg_130_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1019ui_story"]) then
				if arg_130_1.var_.characterEffect1019ui_story and not isNil(arg_130_1.actors_["1019ui_story"]) then
					arg_130_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1019ui_story"]) and arg_130_1.var_.characterEffect1019ui_story then
				arg_130_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["1036ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1036ui_story == nil then
				arg_130_1.var_.characterEffect1036ui_story = var_133_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_3 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.characterEffect1036ui_story and not isNil(var_133_2) then
					arg_130_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_3)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1036ui_story then
				arg_130_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_133_4 = 0
			local var_133_5 = 1.075

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(104042032)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 43 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 43)

				if (43 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 43)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042032", "story_v_out_104042.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042032", "story_v_out_104042.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_out_104042", "104042032", "story_v_out_104042.awb")

						arg_130_1:RecordAudio("104042032", var_133_11)
						arg_130_1:RecordAudio("104042032", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_104042", "104042032", "story_v_out_104042.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_104042", "104042032", "story_v_out_104042.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play104042033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 104042033
		arg_134_1.duration_ = 4.27

		local var_134_0 = {
			ja = 4.266,
			ko = 2.6,
			zh = 4.266,
			en = 2.933
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play104042034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_137_0 = 0
			local var_137_1 = 0.55

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(104042033)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 22 <= 0 and var_137_1 or var_137_1 * (utf8.len(var_137_3) / 22)

				if (22 <= 0 and var_137_1 or var_137_1 * (utf8.len(var_137_3) / 22)) > 0 and var_137_1 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042033", "story_v_out_104042.awb") ~= 0 then
					local var_137_6 = manager.audio:GetVoiceLength("story_v_out_104042", "104042033", "story_v_out_104042.awb") / 1000

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end

					if var_137_2.prefab_name ~= "" and arg_134_1.actors_[var_137_2.prefab_name] ~= nil then
						local var_137_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_2.prefab_name].transform, "story_v_out_104042", "104042033", "story_v_out_104042.awb")

						arg_134_1:RecordAudio("104042033", var_137_7)
						arg_134_1:RecordAudio("104042033", var_137_7)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_104042", "104042033", "story_v_out_104042.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_104042", "104042033", "story_v_out_104042.awb")
				end

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
	Play104042034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 104042034
		arg_138_1.duration_ = 8.13

		local var_138_0 = {
			ja = 8.1,
			ko = 7.333,
			zh = 7.8,
			en = 8.133
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play104042035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10001_tpose"]) and arg_138_1.var_.characterEffect10001_tpose == nil then
				arg_138_1.var_.characterEffect10001_tpose = arg_138_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10001_tpose"]) then
				if arg_138_1.var_.characterEffect10001_tpose and not isNil(arg_138_1.actors_["10001_tpose"]) then
					arg_138_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10001_tpose"]) and arg_138_1.var_.characterEffect10001_tpose then
				arg_138_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_141_2 = arg_138_1.actors_["1019ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1019ui_story == nil then
				arg_138_1.var_.characterEffect1019ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.characterEffect1019ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_3)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1019ui_story then
				arg_138_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_141_4 = arg_138_1.actors_["1019ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1019ui_story = var_141_4.localPosition
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_4.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_5)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_4.localPosition = Vector3.New(0, 100, 0)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			local var_141_6 = arg_138_1.actors_["1036ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1036ui_story = var_141_6.localPosition
			end

			local var_141_7 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				var_141_6.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_7)
				var_141_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_6.position).x, (manager.ui.mainCamera.transform.position - var_141_6.position).y, (manager.ui.mainCamera.transform.position - var_141_6.position).z)
				var_141_6.localEulerAngles.z = 0
				var_141_6.localEulerAngles.x = 0
				var_141_6.localEulerAngles = var_141_6.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				var_141_6.localPosition = Vector3.New(0, 100, 0)
				var_141_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_6.position).x, (manager.ui.mainCamera.transform.position - var_141_6.position).y, (manager.ui.mainCamera.transform.position - var_141_6.position).z)
				var_141_6.localEulerAngles.z = 0
				var_141_6.localEulerAngles.x = 0
				var_141_6.localEulerAngles = var_141_6.localEulerAngles
			end

			local var_141_8 = arg_138_1.actors_["10001_tpose"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10001_tpose = var_141_8.localPosition

				local var_141_9 = GameObjectTools.GetOrAddComponent(var_141_8.gameObject, typeof(DynamicBoneHelper))

				if var_141_9 then
					var_141_9:EnableDynamicBone(false)
				end
			end

			local var_141_10 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_10 then
				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_138_1.time_ - 0) / var_141_10)
				var_141_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_8.position).x, (manager.ui.mainCamera.transform.position - var_141_8.position).y, (manager.ui.mainCamera.transform.position - var_141_8.position).z)
				var_141_8.localEulerAngles.z = 0
				var_141_8.localEulerAngles.x = 0
				var_141_8.localEulerAngles = var_141_8.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_10 and arg_138_1.time_ < 0 + var_141_10 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(0, -1.23, -5.8)
				var_141_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_8.position).x, (manager.ui.mainCamera.transform.position - var_141_8.position).y, (manager.ui.mainCamera.transform.position - var_141_8.position).z)
				var_141_8.localEulerAngles.z = 0
				var_141_8.localEulerAngles.x = 0
				var_141_8.localEulerAngles = var_141_8.localEulerAngles

				local var_141_11 = GameObjectTools.GetOrAddComponent(var_141_8.gameObject, typeof(DynamicBoneHelper))

				if var_141_11 then
					var_141_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_12 = 0
			local var_141_13 = 0.925

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_14 = arg_138_1:GetWordFromCfg(104042034)
				local var_141_15 = arg_138_1:FormatText(var_141_14.content)

				arg_138_1.text_.text = var_141_15

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 37 <= 0 and var_141_13 or var_141_13 * (utf8.len(var_141_15) / 37)

				if (37 <= 0 and var_141_13 or var_141_13 * (utf8.len(var_141_15) / 37)) > 0 and var_141_13 < var_141_17 then
					arg_138_1.talkMaxDuration = var_141_17

					if var_141_17 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_15
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042034", "story_v_out_104042.awb") ~= 0 then
					local var_141_18 = manager.audio:GetVoiceLength("story_v_out_104042", "104042034", "story_v_out_104042.awb") / 1000

					if var_141_18 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_18 + var_141_12
					end

					if var_141_14.prefab_name ~= "" and arg_138_1.actors_[var_141_14.prefab_name] ~= nil then
						local var_141_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_14.prefab_name].transform, "story_v_out_104042", "104042034", "story_v_out_104042.awb")

						arg_138_1:RecordAudio("104042034", var_141_19)
						arg_138_1:RecordAudio("104042034", var_141_19)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_104042", "104042034", "story_v_out_104042.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_104042", "104042034", "story_v_out_104042.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_20 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_20 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_20

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_20 and arg_138_1.time_ < var_141_12 + var_141_20 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play104042035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 104042035
		arg_142_1.duration_ = 2.63

		local var_142_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play104042036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1019ui_story"]) and arg_142_1.var_.characterEffect1019ui_story == nil then
				arg_142_1.var_.characterEffect1019ui_story = arg_142_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.1

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1019ui_story"]) then
				if arg_142_1.var_.characterEffect1019ui_story and not isNil(arg_142_1.actors_["1019ui_story"]) then
					arg_142_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1019ui_story"]) and arg_142_1.var_.characterEffect1019ui_story then
				arg_142_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_145_2 = arg_142_1.actors_["10001_tpose"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect10001_tpose == nil then
				arg_142_1.var_.characterEffect10001_tpose = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_3 = 0.1

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.characterEffect10001_tpose and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_142_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_3)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect10001_tpose then
				arg_142_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_142_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_145_4 = arg_142_1.actors_["10001_tpose"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10001_tpose = var_145_4.localPosition

				local var_145_5 = GameObjectTools.GetOrAddComponent(var_145_4.gameObject, typeof(DynamicBoneHelper))

				if var_145_5 then
					var_145_5:EnableDynamicBone(false)
				end
			end

			local var_145_6 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_6 then
				var_145_4.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_6)
				var_145_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_4.position).x, (manager.ui.mainCamera.transform.position - var_145_4.position).y, (manager.ui.mainCamera.transform.position - var_145_4.position).z)
				var_145_4.localEulerAngles.z = 0
				var_145_4.localEulerAngles.x = 0
				var_145_4.localEulerAngles = var_145_4.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_6 and arg_142_1.time_ < 0 + var_145_6 + arg_145_0 then
				var_145_4.localPosition = Vector3.New(0, 100, 0)
				var_145_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_4.position).x, (manager.ui.mainCamera.transform.position - var_145_4.position).y, (manager.ui.mainCamera.transform.position - var_145_4.position).z)
				var_145_4.localEulerAngles.z = 0
				var_145_4.localEulerAngles.x = 0
				var_145_4.localEulerAngles = var_145_4.localEulerAngles

				local var_145_7 = GameObjectTools.GetOrAddComponent(var_145_4.gameObject, typeof(DynamicBoneHelper))

				if var_145_7 then
					var_145_7:EnableDynamicBone(true)
				end
			end

			local var_145_8 = arg_142_1.actors_["1019ui_story"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1019ui_story = var_145_8.localPosition
			end

			local var_145_9 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_9 then
				var_145_8.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_142_1.time_ - 0) / var_145_9)
				var_145_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_8.position).x, (manager.ui.mainCamera.transform.position - var_145_8.position).y, (manager.ui.mainCamera.transform.position - var_145_8.position).z)
				var_145_8.localEulerAngles.z = 0
				var_145_8.localEulerAngles.x = 0
				var_145_8.localEulerAngles = var_145_8.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_9 and arg_142_1.time_ < 0 + var_145_9 + arg_145_0 then
				var_145_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_145_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_8.position).x, (manager.ui.mainCamera.transform.position - var_145_8.position).y, (manager.ui.mainCamera.transform.position - var_145_8.position).z)
				var_145_8.localEulerAngles.z = 0
				var_145_8.localEulerAngles.x = 0
				var_145_8.localEulerAngles = var_145_8.localEulerAngles
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_145_10 = 0
			local var_145_11 = 0.125

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_12 = arg_142_1:GetWordFromCfg(104042035)
				local var_145_13 = arg_142_1:FormatText(var_145_12.content)

				arg_142_1.text_.text = var_145_13

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_15 = 5 <= 0 and var_145_11 or var_145_11 * (utf8.len(var_145_13) / 5)

				if (5 <= 0 and var_145_11 or var_145_11 * (utf8.len(var_145_13) / 5)) > 0 and var_145_11 < var_145_15 then
					arg_142_1.talkMaxDuration = var_145_15

					if var_145_15 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_10
					end
				end

				arg_142_1.text_.text = var_145_13
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042035", "story_v_out_104042.awb") ~= 0 then
					local var_145_16 = manager.audio:GetVoiceLength("story_v_out_104042", "104042035", "story_v_out_104042.awb") / 1000

					if var_145_16 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_16 + var_145_10
					end

					if var_145_12.prefab_name ~= "" and arg_142_1.actors_[var_145_12.prefab_name] ~= nil then
						local var_145_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_12.prefab_name].transform, "story_v_out_104042", "104042035", "story_v_out_104042.awb")

						arg_142_1:RecordAudio("104042035", var_145_17)
						arg_142_1:RecordAudio("104042035", var_145_17)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_104042", "104042035", "story_v_out_104042.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_104042", "104042035", "story_v_out_104042.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_18 = math.max(var_145_11, arg_142_1.talkMaxDuration)

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_18 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_10) / var_145_18

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_10 + var_145_18 and arg_142_1.time_ < var_145_10 + var_145_18 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_142_1:InitPlayNodeList()
	end,
	Play104042036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 104042036
		arg_146_1.duration_ = 5.43

		local var_146_0 = {
			ja = 5.433,
			ko = 4.366,
			zh = 4.4,
			en = 4.233
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play104042037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = arg_146_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) then
				if arg_146_1.var_.characterEffect1084ui_story and not isNil(arg_146_1.actors_["1084ui_story"]) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["1019ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect1019ui_story == nil then
				arg_146_1.var_.characterEffect1019ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_3 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.characterEffect1019ui_story and not isNil(var_149_2) then
					arg_146_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_3)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect1019ui_story then
				arg_146_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_149_4 = arg_146_1.actors_["1084ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_4.localPosition
			end

			local var_149_5 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_5 then
				var_149_4.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_146_1.time_ - 0) / var_149_5)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_5 and arg_146_1.time_ < 0 + var_149_5 + arg_149_0 then
				var_149_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_149_6 = 0
			local var_149_7 = 0.475

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:GetWordFromCfg(104042036)
				local var_149_9 = arg_146_1:FormatText(var_149_8.content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 19 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 19)

				if (19 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 19)) > 0 and var_149_7 < var_149_11 then
					arg_146_1.talkMaxDuration = var_149_11

					if var_149_11 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042036", "story_v_out_104042.awb") ~= 0 then
					local var_149_12 = manager.audio:GetVoiceLength("story_v_out_104042", "104042036", "story_v_out_104042.awb") / 1000

					if var_149_12 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_6
					end

					if var_149_8.prefab_name ~= "" and arg_146_1.actors_[var_149_8.prefab_name] ~= nil then
						local var_149_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_8.prefab_name].transform, "story_v_out_104042", "104042036", "story_v_out_104042.awb")

						arg_146_1:RecordAudio("104042036", var_149_13)
						arg_146_1:RecordAudio("104042036", var_149_13)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_104042", "104042036", "story_v_out_104042.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_104042", "104042036", "story_v_out_104042.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play104042037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 104042037
		arg_150_1.duration_ = 4.4

		local var_150_0 = {
			ja = 4.4,
			ko = 3.033,
			zh = 3.8,
			en = 3.866
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play104042038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["10001_tpose"]) and arg_150_1.var_.characterEffect10001_tpose == nil then
				arg_150_1.var_.characterEffect10001_tpose = arg_150_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["10001_tpose"]) then
				if arg_150_1.var_.characterEffect10001_tpose and not isNil(arg_150_1.actors_["10001_tpose"]) then
					arg_150_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["10001_tpose"]) and arg_150_1.var_.characterEffect10001_tpose then
				arg_150_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_153_2 = arg_150_1.actors_["1084ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_2) then
					arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_3)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1084ui_story then
				arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_153_4 = arg_150_1.actors_["1084ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_4.localPosition
			end

			local var_153_5 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_5 then
				var_153_4.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_5)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_5 and arg_150_1.time_ < 0 + var_153_5 + arg_153_0 then
				var_153_4.localPosition = Vector3.New(0, 100, 0)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			local var_153_6 = arg_150_1.actors_["1019ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1019ui_story = var_153_6.localPosition
			end

			local var_153_7 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				var_153_6.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_7)
				var_153_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_6.position).x, (manager.ui.mainCamera.transform.position - var_153_6.position).y, (manager.ui.mainCamera.transform.position - var_153_6.position).z)
				var_153_6.localEulerAngles.z = 0
				var_153_6.localEulerAngles.x = 0
				var_153_6.localEulerAngles = var_153_6.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				var_153_6.localPosition = Vector3.New(0, 100, 0)
				var_153_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_6.position).x, (manager.ui.mainCamera.transform.position - var_153_6.position).y, (manager.ui.mainCamera.transform.position - var_153_6.position).z)
				var_153_6.localEulerAngles.z = 0
				var_153_6.localEulerAngles.x = 0
				var_153_6.localEulerAngles = var_153_6.localEulerAngles
			end

			local var_153_8 = arg_150_1.actors_["10001_tpose"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10001_tpose = var_153_8.localPosition

				local var_153_9 = GameObjectTools.GetOrAddComponent(var_153_8.gameObject, typeof(DynamicBoneHelper))

				if var_153_9 then
					var_153_9:EnableDynamicBone(false)
				end
			end

			local var_153_10 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_10 then
				var_153_8.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_150_1.time_ - 0) / var_153_10)
				var_153_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_8.position).x, (manager.ui.mainCamera.transform.position - var_153_8.position).y, (manager.ui.mainCamera.transform.position - var_153_8.position).z)
				var_153_8.localEulerAngles.z = 0
				var_153_8.localEulerAngles.x = 0
				var_153_8.localEulerAngles = var_153_8.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_10 and arg_150_1.time_ < 0 + var_153_10 + arg_153_0 then
				var_153_8.localPosition = Vector3.New(0, -1.23, -5.8)
				var_153_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_8.position).x, (manager.ui.mainCamera.transform.position - var_153_8.position).y, (manager.ui.mainCamera.transform.position - var_153_8.position).z)
				var_153_8.localEulerAngles.z = 0
				var_153_8.localEulerAngles.x = 0
				var_153_8.localEulerAngles = var_153_8.localEulerAngles

				local var_153_11 = GameObjectTools.GetOrAddComponent(var_153_8.gameObject, typeof(DynamicBoneHelper))

				if var_153_11 then
					var_153_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_153_12 = 0
			local var_153_13 = 0.35

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_14 = arg_150_1:GetWordFromCfg(104042037)
				local var_153_15 = arg_150_1:FormatText(var_153_14.content)

				arg_150_1.text_.text = var_153_15

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_17 = 14 <= 0 and var_153_13 or var_153_13 * (utf8.len(var_153_15) / 14)

				if (14 <= 0 and var_153_13 or var_153_13 * (utf8.len(var_153_15) / 14)) > 0 and var_153_13 < var_153_17 then
					arg_150_1.talkMaxDuration = var_153_17

					if var_153_17 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_17 + var_153_12
					end
				end

				arg_150_1.text_.text = var_153_15
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042037", "story_v_out_104042.awb") ~= 0 then
					local var_153_18 = manager.audio:GetVoiceLength("story_v_out_104042", "104042037", "story_v_out_104042.awb") / 1000

					if var_153_18 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_18 + var_153_12
					end

					if var_153_14.prefab_name ~= "" and arg_150_1.actors_[var_153_14.prefab_name] ~= nil then
						local var_153_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_14.prefab_name].transform, "story_v_out_104042", "104042037", "story_v_out_104042.awb")

						arg_150_1:RecordAudio("104042037", var_153_19)
						arg_150_1:RecordAudio("104042037", var_153_19)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_104042", "104042037", "story_v_out_104042.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_104042", "104042037", "story_v_out_104042.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_20 = math.max(var_153_13, arg_150_1.talkMaxDuration)

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_20 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_12) / var_153_20

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_12 + var_153_20 and arg_150_1.time_ < var_153_12 + var_153_20 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play104042038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 104042038
		arg_154_1.duration_ = 7.97

		local var_154_0 = {
			ja = 7.966,
			ko = 3.3,
			zh = 4.033,
			en = 4.766
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play104042039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if arg_154_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_157_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_154_1.stage_.transform)

				var_157_0.name = "1011ui_story"
				var_157_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["1011ui_story"] = var_157_0

				local var_157_1 = var_157_0:GetComponentInChildren(typeof(CharacterEffect))

				var_157_1.enabled = true

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_0, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end

				arg_154_1:ShowWeapon(var_157_1.transform, false)

				arg_154_1.var_["1011ui_story" .. "Animator"] = var_157_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_154_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_154_1.var_["1011ui_story" .. "LipSync"] = var_157_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_157_3 = arg_154_1.actors_["1011ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect1011ui_story == nil then
				arg_154_1.var_.characterEffect1011ui_story = var_157_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_4 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 and not isNil(var_157_3) then
				if arg_154_1.var_.characterEffect1011ui_story and not isNil(var_157_3) then
					arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect1011ui_story then
				arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_157_6 = arg_154_1.actors_["10001_tpose"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_6) and arg_154_1.var_.characterEffect10001_tpose == nil then
				arg_154_1.var_.characterEffect10001_tpose = var_157_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_7 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 and not isNil(var_157_6) then
				if arg_154_1.var_.characterEffect10001_tpose and not isNil(var_157_6) then
					arg_154_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_154_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_7)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 and not isNil(var_157_6) and arg_154_1.var_.characterEffect10001_tpose then
				arg_154_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_154_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_157_8 = arg_154_1.actors_["10001_tpose"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10001_tpose = var_157_8.localPosition

				local var_157_9 = GameObjectTools.GetOrAddComponent(var_157_8.gameObject, typeof(DynamicBoneHelper))

				if var_157_9 then
					var_157_9:EnableDynamicBone(false)
				end
			end

			local var_157_10 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_10 then
				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_10)
				var_157_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_8.position).x, (manager.ui.mainCamera.transform.position - var_157_8.position).y, (manager.ui.mainCamera.transform.position - var_157_8.position).z)
				var_157_8.localEulerAngles.z = 0
				var_157_8.localEulerAngles.x = 0
				var_157_8.localEulerAngles = var_157_8.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_10 and arg_154_1.time_ < 0 + var_157_10 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(0, 100, 0)
				var_157_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_8.position).x, (manager.ui.mainCamera.transform.position - var_157_8.position).y, (manager.ui.mainCamera.transform.position - var_157_8.position).z)
				var_157_8.localEulerAngles.z = 0
				var_157_8.localEulerAngles.x = 0
				var_157_8.localEulerAngles = var_157_8.localEulerAngles

				local var_157_11 = GameObjectTools.GetOrAddComponent(var_157_8.gameObject, typeof(DynamicBoneHelper))

				if var_157_11 then
					var_157_11:EnableDynamicBone(true)
				end
			end

			local var_157_12 = arg_154_1.actors_["1011ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1011ui_story = var_157_12.localPosition
			end

			local var_157_13 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_13 then
				var_157_12.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_154_1.time_ - 0) / var_157_13)
				var_157_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_12.position).x, (manager.ui.mainCamera.transform.position - var_157_12.position).y, (manager.ui.mainCamera.transform.position - var_157_12.position).z)
				var_157_12.localEulerAngles.z = 0
				var_157_12.localEulerAngles.x = 0
				var_157_12.localEulerAngles = var_157_12.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_13 and arg_154_1.time_ < 0 + var_157_13 + arg_157_0 then
				var_157_12.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_157_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_12.position).x, (manager.ui.mainCamera.transform.position - var_157_12.position).y, (manager.ui.mainCamera.transform.position - var_157_12.position).z)
				var_157_12.localEulerAngles.z = 0
				var_157_12.localEulerAngles.x = 0
				var_157_12.localEulerAngles = var_157_12.localEulerAngles
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_14 = 0
			local var_157_15 = 0.4

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_16 = arg_154_1:GetWordFromCfg(104042038)
				local var_157_17 = arg_154_1:FormatText(var_157_16.content)

				arg_154_1.text_.text = var_157_17

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_19 = 16 <= 0 and var_157_15 or var_157_15 * (utf8.len(var_157_17) / 16)

				if (16 <= 0 and var_157_15 or var_157_15 * (utf8.len(var_157_17) / 16)) > 0 and var_157_15 < var_157_19 then
					arg_154_1.talkMaxDuration = var_157_19

					if var_157_19 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_19 + var_157_14
					end
				end

				arg_154_1.text_.text = var_157_17
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042038", "story_v_out_104042.awb") ~= 0 then
					local var_157_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042038", "story_v_out_104042.awb") / 1000

					if var_157_20 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_20 + var_157_14
					end

					if var_157_16.prefab_name ~= "" and arg_154_1.actors_[var_157_16.prefab_name] ~= nil then
						local var_157_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_16.prefab_name].transform, "story_v_out_104042", "104042038", "story_v_out_104042.awb")

						arg_154_1:RecordAudio("104042038", var_157_21)
						arg_154_1:RecordAudio("104042038", var_157_21)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_104042", "104042038", "story_v_out_104042.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_104042", "104042038", "story_v_out_104042.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_15, arg_154_1.talkMaxDuration)

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_14) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_14 + var_157_22 and arg_154_1.time_ < var_157_14 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_154_1:InitPlayNodeList()
	end,
	Play104042039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 104042039
		arg_158_1.duration_ = 5.97

		local var_158_0 = {
			ja = 5.966,
			ko = 3.866,
			zh = 4.4,
			en = 4.666
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play104042040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1084ui_story"]) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = arg_158_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.1

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1084ui_story"]) then
				if arg_158_1.var_.characterEffect1084ui_story and not isNil(arg_158_1.actors_["1084ui_story"]) then
					arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1084ui_story"]) and arg_158_1.var_.characterEffect1084ui_story then
				arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_161_2 = arg_158_1.actors_["1011ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect1011ui_story == nil then
				arg_158_1.var_.characterEffect1011ui_story = var_161_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_3 = 0.1

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 and not isNil(var_161_2) then
				if arg_158_1.var_.characterEffect1011ui_story and not isNil(var_161_2) then
					arg_158_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_3)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect1011ui_story then
				arg_158_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_161_4 = arg_158_1.actors_["1084ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1084ui_story = var_161_4.localPosition
			end

			local var_161_5 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_5 then
				var_161_4.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_158_1.time_ - 0) / var_161_5)
				var_161_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_4.position).x, (manager.ui.mainCamera.transform.position - var_161_4.position).y, (manager.ui.mainCamera.transform.position - var_161_4.position).z)
				var_161_4.localEulerAngles.z = 0
				var_161_4.localEulerAngles.x = 0
				var_161_4.localEulerAngles = var_161_4.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_5 and arg_158_1.time_ < 0 + var_161_5 + arg_161_0 then
				var_161_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_161_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_4.position).x, (manager.ui.mainCamera.transform.position - var_161_4.position).y, (manager.ui.mainCamera.transform.position - var_161_4.position).z)
				var_161_4.localEulerAngles.z = 0
				var_161_4.localEulerAngles.x = 0
				var_161_4.localEulerAngles = var_161_4.localEulerAngles
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_161_6 = 0
			local var_161_7 = 0.575

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_8 = arg_158_1:GetWordFromCfg(104042039)
				local var_161_9 = arg_158_1:FormatText(var_161_8.content)

				arg_158_1.text_.text = var_161_9

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 23 <= 0 and var_161_7 or var_161_7 * (utf8.len(var_161_9) / 23)

				if (23 <= 0 and var_161_7 or var_161_7 * (utf8.len(var_161_9) / 23)) > 0 and var_161_7 < var_161_11 then
					arg_158_1.talkMaxDuration = var_161_11

					if var_161_11 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_11 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_9
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042039", "story_v_out_104042.awb") ~= 0 then
					local var_161_12 = manager.audio:GetVoiceLength("story_v_out_104042", "104042039", "story_v_out_104042.awb") / 1000

					if var_161_12 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_6
					end

					if var_161_8.prefab_name ~= "" and arg_158_1.actors_[var_161_8.prefab_name] ~= nil then
						local var_161_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_8.prefab_name].transform, "story_v_out_104042", "104042039", "story_v_out_104042.awb")

						arg_158_1:RecordAudio("104042039", var_161_13)
						arg_158_1:RecordAudio("104042039", var_161_13)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_104042", "104042039", "story_v_out_104042.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_104042", "104042039", "story_v_out_104042.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play104042040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 104042040
		arg_162_1.duration_ = 11.23

		local var_162_0 = {
			ja = 11.233,
			ko = 5.666,
			zh = 7.233,
			en = 5.7
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
			arg_162_1.auto_ = false
		end

		function arg_162_1.playNext_(arg_164_0)
			arg_162_1.onStoryFinished_()
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1011ui_story"]) and arg_162_1.var_.characterEffect1011ui_story == nil then
				arg_162_1.var_.characterEffect1011ui_story = arg_162_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.1

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1011ui_story"]) then
				if arg_162_1.var_.characterEffect1011ui_story and not isNil(arg_162_1.actors_["1011ui_story"]) then
					arg_162_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1011ui_story"]) and arg_162_1.var_.characterEffect1011ui_story then
				arg_162_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_165_2 = arg_162_1.actors_["1084ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.characterEffect1084ui_story == nil then
				arg_162_1.var_.characterEffect1084ui_story = var_165_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_3 = 0.1

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_3 and not isNil(var_165_2) then
				if arg_162_1.var_.characterEffect1084ui_story and not isNil(var_165_2) then
					arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_3)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_3 and arg_162_1.time_ < 0 + var_165_3 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.characterEffect1084ui_story then
				arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_165_4 = 0
			local var_165_5 = 0.55

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(104042040)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 22 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 22)

				if (22 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 22)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042040", "story_v_out_104042.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042040", "story_v_out_104042.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_104042", "104042040", "story_v_out_104042.awb")

						arg_162_1:RecordAudio("104042040", var_165_11)
						arg_162_1:RecordAudio("104042040", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_104042", "104042040", "story_v_out_104042.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_104042", "104042040", "story_v_out_104042.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0403",
		"TextureConfig/Background/B04b"
	},
	voices = {
		"story_v_out_104042.awb"
	}
}
