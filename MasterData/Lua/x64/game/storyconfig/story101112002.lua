return {
	Play111202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111202001
		arg_1_1.duration_ = 11.9

		local var_1_0 = {
			ja = 6.633,
			ko = 11.9,
			zh = 8.6,
			en = 8.733
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
				arg_1_0:Play111202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D07 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D07")
				var_4_0.name = "D07"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D07 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D07

				arg_1_1.bgs_.D07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D07" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D07:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD07 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD07 = var_4_4
				end

				arg_1_1.var_.alphaOldValueD07 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD07 then
					arg_1_1.var_.alphaMatValueD07.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD07, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD07.color = arg_1_1.var_.alphaMatValueD07.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD07 then
				arg_1_1.var_.alphaMatValueD07.color.a = 1
				arg_1_1.var_.alphaMatValueD07.color = arg_1_1.var_.alphaMatValueD07.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			local var_4_10 = 2
			local var_4_11 = 0.95

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_13 = arg_1_1:GetWordFromCfg(111202001)
				local var_4_14 = arg_1_1:FormatText(var_4_13.content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 38 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 38)

				if (38 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 38)) > 0 and var_4_11 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_10 = var_4_10 + 0.3

					if var_4_16 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202001", "story_v_out_111202.awb") ~= 0 then
					local var_4_17 = manager.audio:GetVoiceLength("story_v_out_111202", "111202001", "story_v_out_111202.awb") / 1000

					if var_4_17 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_10
					end

					if var_4_13.prefab_name ~= "" and arg_1_1.actors_[var_4_13.prefab_name] ~= nil then
						local var_4_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_13.prefab_name].transform, "story_v_out_111202", "111202001", "story_v_out_111202.awb")

						arg_1_1:RecordAudio("111202001", var_4_18)
						arg_1_1:RecordAudio("111202001", var_4_18)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_111202", "111202001", "story_v_out_111202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_111202", "111202001", "story_v_out_111202.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_10 + 0.3
			local var_4_20 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111202002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111202002
		arg_8_1.duration_ = 4.5

		local var_8_0 = {
			ja = 2.466,
			ko = 4.5,
			zh = 3.833,
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
				arg_8_0:Play111202003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.575

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(111202002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 23 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 23)

				if (23 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 23)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202002", "story_v_out_111202.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_111202", "111202002", "story_v_out_111202.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_111202", "111202002", "story_v_out_111202.awb")

						arg_8_1:RecordAudio("111202002", var_11_6)
						arg_8_1:RecordAudio("111202002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_111202", "111202002", "story_v_out_111202.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_111202", "111202002", "story_v_out_111202.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111202003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111202003
		arg_12_1.duration_ = 6.2

		local var_12_0 = {
			ja = 6.2,
			ko = 3.466,
			zh = 3.866,
			en = 3.6
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
				arg_12_0:Play111202004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1096ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1096ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1096ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1096ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1096ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1096ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1096ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1096ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1096ui_story == nil then
				arg_12_1.var_.characterEffect1096ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1096ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1096ui_story then
				arg_12_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_6 = arg_12_1.actors_["1096ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1096ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, -1.13, -5.6)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			local var_15_8 = 0
			local var_15_9 = 0.475

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(111202003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 19 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 19)

				if (19 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 19)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202003", "story_v_out_111202.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_111202", "111202003", "story_v_out_111202.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_111202", "111202003", "story_v_out_111202.awb")

						arg_12_1:RecordAudio("111202003", var_15_15)
						arg_12_1:RecordAudio("111202003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111202", "111202003", "story_v_out_111202.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111202", "111202003", "story_v_out_111202.awb")
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

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play111202004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111202004
		arg_16_1.duration_ = 3.77

		local var_16_0 = {
			ja = 2.4,
			ko = 2.1,
			zh = 2.1,
			en = 3.766
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
				arg_16_0:Play111202005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_19_0 = 0
			local var_19_1 = 0.275

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(111202004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 7 <= 0 and var_19_1 or var_19_1 * (utf8.len(var_19_3) / 7)

				if (7 <= 0 and var_19_1 or var_19_1 * (utf8.len(var_19_3) / 7)) > 0 and var_19_1 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202004", "story_v_out_111202.awb") ~= 0 then
					local var_19_6 = manager.audio:GetVoiceLength("story_v_out_111202", "111202004", "story_v_out_111202.awb") / 1000

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end

					if var_19_2.prefab_name ~= "" and arg_16_1.actors_[var_19_2.prefab_name] ~= nil then
						local var_19_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_2.prefab_name].transform, "story_v_out_111202", "111202004", "story_v_out_111202.awb")

						arg_16_1:RecordAudio("111202004", var_19_7)
						arg_16_1:RecordAudio("111202004", var_19_7)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111202", "111202004", "story_v_out_111202.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111202", "111202004", "story_v_out_111202.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111202005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111202005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111202006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1096ui_story"]) and arg_20_1.var_.characterEffect1096ui_story == nil then
				arg_20_1.var_.characterEffect1096ui_story = arg_20_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1096ui_story"]) then
				if arg_20_1.var_.characterEffect1096ui_story and not isNil(arg_20_1.actors_["1096ui_story"]) then
					arg_20_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1096ui_story"]) and arg_20_1.var_.characterEffect1096ui_story then
				arg_20_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_23_1 = arg_20_1.actors_["1096ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1096ui_story = var_23_1.localPosition
			end

			local var_23_2 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 then
				var_23_1.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_2)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_2 and arg_20_1.time_ < 0 + var_23_2 + arg_23_0 then
				var_23_1.localPosition = Vector3.New(0, 100, 0)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			local var_23_3 = 0
			local var_23_4 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(111202005).content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 31 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_5) / 31)

				if (31 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_5) / 31)) > 0 and var_23_4 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_3 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_3
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_4, arg_20_1.talkMaxDuration)

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_3) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_3 + var_23_8 and arg_20_1.time_ < var_23_3 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
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
	Play111202006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111202006
		arg_24_1.duration_ = 4.43

		local var_24_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 2.366,
			en = 4.433
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
				arg_24_0:Play111202007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_0 = arg_24_1.actors_["1096ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1096ui_story == nil then
				arg_24_1.var_.characterEffect1096ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_1 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 and not isNil(var_27_0) then
				if arg_24_1.var_.characterEffect1096ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1096ui_story then
				arg_24_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_27_3 = arg_24_1.actors_["1096ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1096ui_story = var_27_3.localPosition
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_24_1.time_ - 0) / var_27_4)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, -1.13, -5.6)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			local var_27_5 = 0
			local var_27_6 = 0.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(111202006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 9 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_8) / 9)

				if (9 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_8) / 9)) > 0 and var_27_6 < var_27_10 then
					arg_24_1.talkMaxDuration = var_27_10

					if var_27_10 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202006", "story_v_out_111202.awb") ~= 0 then
					local var_27_11 = manager.audio:GetVoiceLength("story_v_out_111202", "111202006", "story_v_out_111202.awb") / 1000

					if var_27_11 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_5
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_out_111202", "111202006", "story_v_out_111202.awb")

						arg_24_1:RecordAudio("111202006", var_27_12)
						arg_24_1:RecordAudio("111202006", var_27_12)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111202", "111202006", "story_v_out_111202.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111202", "111202006", "story_v_out_111202.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_6, arg_24_1.talkMaxDuration)

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_5) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_5 + var_27_13 and arg_24_1.time_ < var_27_5 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
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
	Play111202007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111202007
		arg_28_1.duration_ = 2.03

		local var_28_0 = {
			ja = 1.3,
			ko = 1.4,
			zh = 2.033,
			en = 1.4
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
				arg_28_0:Play111202008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1096ui_story"]) and arg_28_1.var_.characterEffect1096ui_story == nil then
				arg_28_1.var_.characterEffect1096ui_story = arg_28_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1096ui_story"]) then
				if arg_28_1.var_.characterEffect1096ui_story and not isNil(arg_28_1.actors_["1096ui_story"]) then
					arg_28_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1096ui_story"]) and arg_28_1.var_.characterEffect1096ui_story then
				arg_28_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.175

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(111202007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 7 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 7)

				if (7 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 7)) > 0 and var_31_2 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202007", "story_v_out_111202.awb") ~= 0 then
					local var_31_7 = manager.audio:GetVoiceLength("story_v_out_111202", "111202007", "story_v_out_111202.awb") / 1000

					if var_31_7 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_1
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_111202", "111202007", "story_v_out_111202.awb")

						arg_28_1:RecordAudio("111202007", var_31_8)
						arg_28_1:RecordAudio("111202007", var_31_8)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111202", "111202007", "story_v_out_111202.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111202", "111202007", "story_v_out_111202.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_9 and arg_28_1.time_ < var_31_1 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111202008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111202008
		arg_32_1.duration_ = 5.53

		local var_32_0 = {
			ja = 5.533,
			ko = 3.5,
			zh = 3.6,
			en = 4.066
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
				arg_32_0:Play111202009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_35_0 = arg_32_1.actors_["1096ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1096ui_story == nil then
				arg_32_1.var_.characterEffect1096ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_1 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 and not isNil(var_35_0) then
				if arg_32_1.var_.characterEffect1096ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1096ui_story then
				arg_32_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_35_3 = 0
			local var_35_4 = 0.45

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(111202008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 18 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 18)

				if (18 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 18)) > 0 and var_35_4 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202008", "story_v_out_111202.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_111202", "111202008", "story_v_out_111202.awb") / 1000

					if var_35_9 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_3
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_111202", "111202008", "story_v_out_111202.awb")

						arg_32_1:RecordAudio("111202008", var_35_10)
						arg_32_1:RecordAudio("111202008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111202", "111202008", "story_v_out_111202.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111202", "111202008", "story_v_out_111202.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_11 and arg_32_1.time_ < var_35_3 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111202009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111202009
		arg_36_1.duration_ = 6.77

		local var_36_0 = {
			ja = 6.033,
			ko = 6.766,
			zh = 6.1,
			en = 5
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
				arg_36_0:Play111202010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1096ui_story"]) and arg_36_1.var_.characterEffect1096ui_story == nil then
				arg_36_1.var_.characterEffect1096ui_story = arg_36_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1096ui_story"]) then
				if arg_36_1.var_.characterEffect1096ui_story and not isNil(arg_36_1.actors_["1096ui_story"]) then
					arg_36_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1096ui_story"]) and arg_36_1.var_.characterEffect1096ui_story then
				arg_36_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(111202009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 34 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 34)

				if (34 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 34)) > 0 and var_39_2 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202009", "story_v_out_111202.awb") ~= 0 then
					local var_39_7 = manager.audio:GetVoiceLength("story_v_out_111202", "111202009", "story_v_out_111202.awb") / 1000

					if var_39_7 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_1
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_111202", "111202009", "story_v_out_111202.awb")

						arg_36_1:RecordAudio("111202009", var_39_8)
						arg_36_1:RecordAudio("111202009", var_39_8)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111202", "111202009", "story_v_out_111202.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111202", "111202009", "story_v_out_111202.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_9 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_9 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_9

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_9 and arg_36_1.time_ < var_39_1 + var_39_9 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111202010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111202010
		arg_40_1.duration_ = 7.07

		local var_40_0 = {
			ja = 7.066,
			ko = 4.933,
			zh = 4.633,
			en = 4
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
				arg_40_0:Play111202011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(111202010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 22 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 22)

				if (22 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 22)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202010", "story_v_out_111202.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_111202", "111202010", "story_v_out_111202.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_111202", "111202010", "story_v_out_111202.awb")

						arg_40_1:RecordAudio("111202010", var_43_6)
						arg_40_1:RecordAudio("111202010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111202", "111202010", "story_v_out_111202.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111202", "111202010", "story_v_out_111202.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111202011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111202011
		arg_44_1.duration_ = 7.63

		local var_44_0 = {
			ja = 5.6,
			ko = 7.633,
			zh = 7.2,
			en = 6.833
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
				arg_44_0:Play111202012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_47_0 = arg_44_1.actors_["1096ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1096ui_story == nil then
				arg_44_1.var_.characterEffect1096ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_1 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 and not isNil(var_47_0) then
				if arg_44_1.var_.characterEffect1096ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1096ui_story then
				arg_44_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_47_3 = 0
			local var_47_4 = 0.9

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:GetWordFromCfg(111202011)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 36 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_6) / 36)

				if (36 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_6) / 36)) > 0 and var_47_4 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_3
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202011", "story_v_out_111202.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_out_111202", "111202011", "story_v_out_111202.awb") / 1000

					if var_47_9 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_3
					end

					if var_47_5.prefab_name ~= "" and arg_44_1.actors_[var_47_5.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_5.prefab_name].transform, "story_v_out_111202", "111202011", "story_v_out_111202.awb")

						arg_44_1:RecordAudio("111202011", var_47_10)
						arg_44_1:RecordAudio("111202011", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111202", "111202011", "story_v_out_111202.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111202", "111202011", "story_v_out_111202.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_4, arg_44_1.talkMaxDuration)

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_3) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_3 + var_47_11 and arg_44_1.time_ < var_47_3 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111202012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111202012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111202013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1096ui_story = arg_48_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1096ui_story"].transform.position).z)
				arg_48_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1096ui_story"].transform.localEulerAngles = arg_48_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1096ui_story"].transform.position).z)
				arg_48_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1096ui_story"].transform.localEulerAngles = arg_48_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_51_1 = 0
			local var_51_2 = 0.625

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(111202012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 25 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 25)

				if (25 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 25)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play111202013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111202013
		arg_52_1.duration_ = 6.1

		local var_52_0 = {
			ja = 3.8,
			ko = 6.1,
			zh = 3.766,
			en = 3.566
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
				arg_52_0:Play111202014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.5

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:GetWordFromCfg(111202013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 20 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 20)

				if (20 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 20)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202013", "story_v_out_111202.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_111202", "111202013", "story_v_out_111202.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_111202", "111202013", "story_v_out_111202.awb")

						arg_52_1:RecordAudio("111202013", var_55_6)
						arg_52_1:RecordAudio("111202013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111202", "111202013", "story_v_out_111202.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111202", "111202013", "story_v_out_111202.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111202014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111202014
		arg_56_1.duration_ = 4.27

		local var_56_0 = {
			ja = 4.266,
			ko = 3.533,
			zh = 3.866,
			en = 3.866
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
				arg_56_0:Play111202015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_59_0 = arg_56_1.actors_["1096ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1096ui_story = var_59_0.localPosition
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_56_1.time_ - 0) / var_59_1)
				var_59_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_0.position).x, (manager.ui.mainCamera.transform.position - var_59_0.position).y, (manager.ui.mainCamera.transform.position - var_59_0.position).z)
				var_59_0.localEulerAngles.z = 0
				var_59_0.localEulerAngles.x = 0
				var_59_0.localEulerAngles = var_59_0.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -1.13, -5.6)
				var_59_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_0.position).x, (manager.ui.mainCamera.transform.position - var_59_0.position).y, (manager.ui.mainCamera.transform.position - var_59_0.position).z)
				var_59_0.localEulerAngles.z = 0
				var_59_0.localEulerAngles.x = 0
				var_59_0.localEulerAngles = var_59_0.localEulerAngles
			end

			local var_59_2 = 0
			local var_59_3 = 0.4

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(111202014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 16 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 16)

				if (16 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 16)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202014", "story_v_out_111202.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_111202", "111202014", "story_v_out_111202.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_111202", "111202014", "story_v_out_111202.awb")

						arg_56_1:RecordAudio("111202014", var_59_9)
						arg_56_1:RecordAudio("111202014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111202", "111202014", "story_v_out_111202.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111202", "111202014", "story_v_out_111202.awb")
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

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play111202015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111202015
		arg_60_1.duration_ = 7.03

		local var_60_0 = {
			ja = 5.633,
			ko = 7.033,
			zh = 5.6,
			en = 5.366
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
				arg_60_0:Play111202016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1096ui_story"]) and arg_60_1.var_.characterEffect1096ui_story == nil then
				arg_60_1.var_.characterEffect1096ui_story = arg_60_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1096ui_story"]) then
				if arg_60_1.var_.characterEffect1096ui_story and not isNil(arg_60_1.actors_["1096ui_story"]) then
					arg_60_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1096ui_story"]) and arg_60_1.var_.characterEffect1096ui_story then
				arg_60_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.8

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(111202015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 30 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 30)

				if (30 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 30)) > 0 and var_63_2 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202015", "story_v_out_111202.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_111202", "111202015", "story_v_out_111202.awb") / 1000

					if var_63_7 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_1
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_111202", "111202015", "story_v_out_111202.awb")

						arg_60_1:RecordAudio("111202015", var_63_8)
						arg_60_1:RecordAudio("111202015", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_111202", "111202015", "story_v_out_111202.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_111202", "111202015", "story_v_out_111202.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_9 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_9

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_9 and arg_60_1.time_ < var_63_1 + var_63_9 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111202016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111202016
		arg_64_1.duration_ = 4.77

		local var_64_0 = {
			ja = 4.766,
			ko = 2.633,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_64_0:Play111202017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_0 = arg_64_1.actors_["1096ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1096ui_story == nil then
				arg_64_1.var_.characterEffect1096ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_1 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 and not isNil(var_67_0) then
				if arg_64_1.var_.characterEffect1096ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1096ui_story then
				arg_64_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_67_3 = 0
			local var_67_4 = 0.275

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:GetWordFromCfg(111202016)
				local var_67_6 = arg_64_1:FormatText(var_67_5.content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 11 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_6) / 11)

				if (11 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_6) / 11)) > 0 and var_67_4 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202016", "story_v_out_111202.awb") ~= 0 then
					local var_67_9 = manager.audio:GetVoiceLength("story_v_out_111202", "111202016", "story_v_out_111202.awb") / 1000

					if var_67_9 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_3
					end

					if var_67_5.prefab_name ~= "" and arg_64_1.actors_[var_67_5.prefab_name] ~= nil then
						local var_67_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_5.prefab_name].transform, "story_v_out_111202", "111202016", "story_v_out_111202.awb")

						arg_64_1:RecordAudio("111202016", var_67_10)
						arg_64_1:RecordAudio("111202016", var_67_10)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_111202", "111202016", "story_v_out_111202.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_111202", "111202016", "story_v_out_111202.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_11 and arg_64_1.time_ < var_67_3 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111202017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111202017
		arg_68_1.duration_ = 3.03

		local var_68_0 = {
			ja = 1.933,
			ko = 3.033,
			zh = 2.166,
			en = 2.433
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
				arg_68_0:Play111202018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1096ui_story"]) and arg_68_1.var_.characterEffect1096ui_story == nil then
				arg_68_1.var_.characterEffect1096ui_story = arg_68_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1096ui_story"]) then
				if arg_68_1.var_.characterEffect1096ui_story and not isNil(arg_68_1.actors_["1096ui_story"]) then
					arg_68_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1096ui_story"]) and arg_68_1.var_.characterEffect1096ui_story then
				arg_68_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.3

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(111202017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 12 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_4) / 12)

				if (12 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_4) / 12)) > 0 and var_71_2 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202017", "story_v_out_111202.awb") ~= 0 then
					local var_71_7 = manager.audio:GetVoiceLength("story_v_out_111202", "111202017", "story_v_out_111202.awb") / 1000

					if var_71_7 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_1
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_111202", "111202017", "story_v_out_111202.awb")

						arg_68_1:RecordAudio("111202017", var_71_8)
						arg_68_1:RecordAudio("111202017", var_71_8)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111202", "111202017", "story_v_out_111202.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111202", "111202017", "story_v_out_111202.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_9 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_9 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_9

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_9 and arg_68_1.time_ < var_71_1 + var_71_9 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111202018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111202018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play111202019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1096ui_story = arg_72_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1096ui_story"].transform.position).z)
				arg_72_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1096ui_story"].transform.localEulerAngles = arg_72_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1096ui_story"].transform.position).z)
				arg_72_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1096ui_story"].transform.localEulerAngles = arg_72_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_75_1 = 0
			local var_75_2 = 0.675

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(111202018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 27 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 27)

				if (27 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 27)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
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
	Play111202019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111202019
		arg_76_1.duration_ = 9

		local var_76_0 = {
			ja = 9,
			ko = 4.433,
			zh = 2.966,
			en = 2.966
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
				arg_76_0:Play111202020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.325

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:GetWordFromCfg(111202019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 13 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 13)

				if (13 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 13)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202019", "story_v_out_111202.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_111202", "111202019", "story_v_out_111202.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_111202", "111202019", "story_v_out_111202.awb")

						arg_76_1:RecordAudio("111202019", var_79_6)
						arg_76_1:RecordAudio("111202019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_111202", "111202019", "story_v_out_111202.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_111202", "111202019", "story_v_out_111202.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play111202020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 111202020
		arg_80_1.duration_ = 1.93

		local var_80_0 = {
			ja = 1.833,
			ko = 1.566,
			zh = 1.933,
			en = 1.466666666666
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
			arg_80_1.auto_ = false
		end

		function arg_80_1.playNext_(arg_82_0)
			arg_80_1.onStoryFinished_()
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_83_0 = 0.6

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				local var_83_1, var_83_2 = math.modf((arg_80_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_83_2 * 0.13, var_83_2 * 0.13, var_83_2 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				manager.ui.mainCamera.transform.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_3 = manager.ui.mainCamera.transform

			if 0.15 < arg_80_1.time_ and arg_80_1.time_ <= 0.15 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = var_83_3.localPosition
			end

			local var_83_4 = 1.21666666666667

			if 0.15 <= arg_80_1.time_ and arg_80_1.time_ < 0.15 + var_83_4 then
				local var_83_5, var_83_6 = math.modf((arg_80_1.time_ - 0.15) / 0.099)

				var_83_3.localPosition = Vector3.New(var_83_6 * 0.13, var_83_6 * 0.13, var_83_6 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= 0.15 + var_83_4 and arg_80_1.time_ < 0.15 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_7 = 0
			local var_83_8 = 0.15

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(111202020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_12 = 6 <= 0 and var_83_8 or var_83_8 * (utf8.len(var_83_10) / 6)

				if (6 <= 0 and var_83_8 or var_83_8 * (utf8.len(var_83_10) / 6)) > 0 and var_83_8 < var_83_12 then
					arg_80_1.talkMaxDuration = var_83_12

					if var_83_12 + var_83_7 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_7
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111202", "111202020", "story_v_out_111202.awb") ~= 0 then
					local var_83_13 = manager.audio:GetVoiceLength("story_v_out_111202", "111202020", "story_v_out_111202.awb") / 1000

					if var_83_13 + var_83_7 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_7
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_111202", "111202020", "story_v_out_111202.awb")

						arg_80_1:RecordAudio("111202020", var_83_14)
						arg_80_1:RecordAudio("111202020", var_83_14)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_111202", "111202020", "story_v_out_111202.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_111202", "111202020", "story_v_out_111202.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_15 = math.max(var_83_8, arg_80_1.talkMaxDuration)

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_15 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_7) / var_83_15

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_7 + var_83_15 and arg_80_1.time_ < var_83_7 + var_83_15 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D07"
	},
	voices = {
		"story_v_out_111202.awb"
	}
}
