return {
	Play421061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0109 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0109")
				var_4_0.name = "ST0109"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0109 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0109

				arg_1_1.bgs_.ST0109.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0109" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.633333333334333 and arg_1_1.time_ < var_4_4 + 0.633333333334333 + arg_4_0 then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 1.999999999999
			local var_4_17 = 1.025

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(421061001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 41 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 41)

				if (41 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 41)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421061002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.1 < arg_9_1.time_ and arg_9_1.time_ <= 0.1 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_143", "se_story_143_doorhandle", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(421061002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)

				if (40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)) > 0 and var_12_2 < var_12_5 then
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
	Play421061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421061003
		arg_13_1.duration_ = 4.67

		local var_13_0 = {
			zh = 3.133,
			ja = 4.666
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play421061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1047ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1047ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1047ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1047ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1047ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1047ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1047ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1047ui_story == nil then
				arg_13_1.var_.characterEffect1047ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1047ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1047ui_story then
				arg_13_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(421061003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 12 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 12)

				if (12 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 12)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061003", "story_v_out_421061.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_421061", "421061003", "story_v_out_421061.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_421061", "421061003", "story_v_out_421061.awb")

						arg_13_1:RecordAudio("421061003", var_16_15)
						arg_13_1:RecordAudio("421061003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421061", "421061003", "story_v_out_421061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421061", "421061003", "story_v_out_421061.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play421061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421061004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1047ui_story = arg_17_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).z)
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles = arg_17_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).z)
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles = arg_17_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1047ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1047ui_story == nil then
				arg_17_1.var_.characterEffect1047ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1047ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1047ui_story then
				arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 1.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(421061004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 43 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 43)

				if (43 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 43)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play421061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421061005
		arg_21_1.duration_ = 6.4

		local var_21_0 = {
			zh = 3.833,
			ja = 6.4
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
				arg_21_0:Play421061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(421061005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 21 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 21)

				if (21 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 21)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061005", "story_v_out_421061.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061005", "story_v_out_421061.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_421061", "421061005", "story_v_out_421061.awb")

						arg_21_1:RecordAudio("421061005", var_24_6)
						arg_21_1:RecordAudio("421061005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421061", "421061005", "story_v_out_421061.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421061", "421061005", "story_v_out_421061.awb")
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
	Play421061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421061006
		arg_25_1.duration_ = 8.88

		local var_25_0 = {
			zh = 8.21666666666667,
			ja = 8.88266666666667
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
				arg_25_0:Play421061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_9000

			if arg_25_1.bgs_.SS2102 == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2102")
				var_28_0.name = "SS2102"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.SS2102 = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.SS2102

				arg_25_1.bgs_.SS2102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "SS2102" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 3.91666666666667

			if 3.91666666666667 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_4 + 0.3 and arg_25_1.time_ < var_28_4 + 0.3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_5 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_6 = 2

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_5) / var_28_6)
				arg_25_1.mask_.color = var_28_7
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 then
				local var_28_8 = Color.New(0, 0, 0)

				var_28_8.a = 1
				arg_25_1.mask_.color = var_28_8
			end

			local var_28_9 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_10 = 2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 then
				local var_28_11 = Color.New(0, 0, 0)

				var_28_11.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_9) / var_28_10)
				arg_25_1.mask_.color = var_28_11
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 then
				local var_28_12 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_12.a = 0
				arg_25_1.mask_.color = var_28_12
			end

			local var_28_13 = arg_25_1.bgs_.SS2102.transform

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS2102 = var_28_13.localPosition
			end

			local var_28_14 = 0.1

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_14 then
				var_28_13.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS2102, Vector3.New(0, 1, 10), (arg_25_1.time_ - 2) / var_28_14)
			end

			if arg_25_1.time_ >= 2 + var_28_14 and arg_25_1.time_ < 2 + var_28_14 + arg_28_0 then
				var_28_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_28_15 = arg_25_1.bgs_.SS2102.transform

			if 2.1 < arg_25_1.time_ and arg_25_1.time_ <= 2.1 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS2102 = var_28_15.localPosition
			end

			local var_28_16 = 1.63388343070013

			if 2.1 <= arg_25_1.time_ and arg_25_1.time_ < 2.1 + var_28_16 then
				var_28_15.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS2102, Vector3.New(0, 1, 9), (arg_25_1.time_ - 2.1) / var_28_16)
			end

			if arg_25_1.time_ >= 2.1 + var_28_16 and arg_25_1.time_ < 2.1 + var_28_16 + arg_28_0 then
				var_28_15.localPosition = Vector3.New(0, 1, 9)
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_17 = arg_25_1.var_.effect1006

				if not arg_25_1.var_.effect1006 then
					var_28_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_28_17.name = "1006"
					arg_25_1.var_.effect1006 = var_28_17
				else
					var_28_17.transform:SetParent(var_28_9000)
				end

				var_28_17.transform.localPosition = Vector3.New(0, 2, -10.21)
				var_28_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_19 = 3.91666666666667
			local var_28_20 = 0.55

			if 3.91666666666667 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_21 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_21:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_22 = arg_25_1:GetWordFromCfg(421061006)
				local var_28_23 = arg_25_1:FormatText(var_28_22.content)

				arg_25_1.text_.text = var_28_23

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 22 <= 0 and var_28_20 or var_28_20 * (utf8.len(var_28_23) / 22)

				if (22 <= 0 and var_28_20 or var_28_20 * (utf8.len(var_28_23) / 22)) > 0 and var_28_20 < var_28_25 then
					arg_25_1.talkMaxDuration = var_28_25
					var_28_19 = var_28_19 + 0.3

					if var_28_25 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_25 + var_28_19
					end
				end

				arg_25_1.text_.text = var_28_23
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061006", "story_v_out_421061.awb") ~= 0 then
					local var_28_26 = manager.audio:GetVoiceLength("story_v_out_421061", "421061006", "story_v_out_421061.awb") / 1000

					if var_28_26 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_26 + var_28_19
					end

					if var_28_22.prefab_name ~= "" and arg_25_1.actors_[var_28_22.prefab_name] ~= nil then
						local var_28_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_22.prefab_name].transform, "story_v_out_421061", "421061006", "story_v_out_421061.awb")

						arg_25_1:RecordAudio("421061006", var_28_27)
						arg_25_1:RecordAudio("421061006", var_28_27)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_421061", "421061006", "story_v_out_421061.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_421061", "421061006", "story_v_out_421061.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_28 = var_28_19 + 0.3
			local var_28_29 = math.max(var_28_20, arg_25_1.talkMaxDuration)

			if var_28_19 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_28 + var_28_29 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_28) / var_28_29

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_28 + var_28_29 and arg_25_1.time_ < var_28_28 + var_28_29 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.63388343070013,
				className = "StoryMoveNode",
				startTime = 2.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play421061007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 421061007
		arg_31_1.duration_ = 5

		local var_31_0 = {
			zh = 4.7,
			ja = 5
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
				arg_31_0:Play421061008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.45

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(421061007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 18 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 18)

				if (18 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 18)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061007", "story_v_out_421061.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061007", "story_v_out_421061.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_421061", "421061007", "story_v_out_421061.awb")

						arg_31_1:RecordAudio("421061007", var_34_6)
						arg_31_1:RecordAudio("421061007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_421061", "421061007", "story_v_out_421061.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_421061", "421061007", "story_v_out_421061.awb")
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
	Play421061008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 421061008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play421061009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0.1 < arg_35_1.time_ and arg_35_1.time_ <= 0.1 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_140", "se_story_140_surround", "")
			end

			local var_38_1 = 0
			local var_38_2 = 1.85

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(421061008).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 74 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 74)

				if (74 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 74)) > 0 and var_38_2 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_6 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_6 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_6

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_6 and arg_35_1.time_ < var_38_1 + var_38_6 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play421061009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 421061009
		arg_39_1.duration_ = 8.17

		local var_39_0 = {
			zh = 6.1,
			ja = 8.166
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
				arg_39_0:Play421061010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.95

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(421061009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 38 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 38)

				if (38 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 38)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061009", "story_v_out_421061.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061009", "story_v_out_421061.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_421061", "421061009", "story_v_out_421061.awb")

						arg_39_1:RecordAudio("421061009", var_42_6)
						arg_39_1:RecordAudio("421061009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_421061", "421061009", "story_v_out_421061.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_421061", "421061009", "story_v_out_421061.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play421061010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 421061010
		arg_43_1.duration_ = 7.8

		local var_43_0 = {
			zh = 4.2,
			ja = 7.8
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
				arg_43_0:Play421061011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.525

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(421061010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 21 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 21)

				if (21 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 21)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061010", "story_v_out_421061.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061010", "story_v_out_421061.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_421061", "421061010", "story_v_out_421061.awb")

						arg_43_1:RecordAudio("421061010", var_46_6)
						arg_43_1:RecordAudio("421061010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_421061", "421061010", "story_v_out_421061.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_421061", "421061010", "story_v_out_421061.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play421061011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 421061011
		arg_47_1.duration_ = 5.57

		local var_47_0 = {
			zh = 4.433,
			ja = 5.566
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
				arg_47_0:Play421061012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(421061011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 21 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 21)

				if (21 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 21)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061011", "story_v_out_421061.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061011", "story_v_out_421061.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_421061", "421061011", "story_v_out_421061.awb")

						arg_47_1:RecordAudio("421061011", var_50_6)
						arg_47_1:RecordAudio("421061011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_421061", "421061011", "story_v_out_421061.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_421061", "421061011", "story_v_out_421061.awb")
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
	Play421061012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 421061012
		arg_51_1.duration_ = 2.6

		local var_51_0 = {
			zh = 1.6,
			ja = 2.6
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
				arg_51_0:Play421061013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.125

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(421061012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 5 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 5)

				if (5 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 5)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061012", "story_v_out_421061.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061012", "story_v_out_421061.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_421061", "421061012", "story_v_out_421061.awb")

						arg_51_1:RecordAudio("421061012", var_54_6)
						arg_51_1:RecordAudio("421061012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_421061", "421061012", "story_v_out_421061.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_421061", "421061012", "story_v_out_421061.awb")
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
	Play421061013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 421061013
		arg_55_1.duration_ = 1.5

		local var_55_0 = {
			zh = 1.233,
			ja = 1.5
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
				arg_55_0:Play421061014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(421061013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 4 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 4)

				if (4 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 4)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061013", "story_v_out_421061.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061013", "story_v_out_421061.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_421061", "421061013", "story_v_out_421061.awb")

						arg_55_1:RecordAudio("421061013", var_58_6)
						arg_55_1:RecordAudio("421061013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_421061", "421061013", "story_v_out_421061.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_421061", "421061013", "story_v_out_421061.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play421061014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 421061014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play421061015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.075

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(421061014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 43 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 43)

				if (43 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 43)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play421061015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 421061015
		arg_63_1.duration_ = 9.57

		local var_63_0 = {
			zh = 7,
			ja = 9.566
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play421061016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.825

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(421061015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 33 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 33)

				if (33 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 33)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061015", "story_v_out_421061.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061015", "story_v_out_421061.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_421061", "421061015", "story_v_out_421061.awb")

						arg_63_1:RecordAudio("421061015", var_66_6)
						arg_63_1:RecordAudio("421061015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_421061", "421061015", "story_v_out_421061.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_421061", "421061015", "story_v_out_421061.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play421061016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 421061016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play421061017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.1

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(421061016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 44 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 44)

				if (44 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 44)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play421061017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 421061017
		arg_71_1.duration_ = 7.87

		local var_71_0 = {
			zh = 6.066,
			ja = 7.866
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
				arg_71_0:Play421061018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.55

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(421061017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 22 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 22)

				if (22 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 22)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061017", "story_v_out_421061.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061017", "story_v_out_421061.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_421061", "421061017", "story_v_out_421061.awb")

						arg_71_1:RecordAudio("421061017", var_74_6)
						arg_71_1:RecordAudio("421061017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_421061", "421061017", "story_v_out_421061.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_421061", "421061017", "story_v_out_421061.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play421061018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 421061018
		arg_75_1.duration_ = 4.6

		local var_75_0 = {
			zh = 4.6,
			ja = 4.366
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
				arg_75_0:Play421061019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.5

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(421061018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 20 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 20)

				if (20 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 20)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061018", "story_v_out_421061.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061018", "story_v_out_421061.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_421061", "421061018", "story_v_out_421061.awb")

						arg_75_1:RecordAudio("421061018", var_78_6)
						arg_75_1:RecordAudio("421061018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_421061", "421061018", "story_v_out_421061.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_421061", "421061018", "story_v_out_421061.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play421061019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 421061019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play421061020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0.833333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 0.833333333333333 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_clap01", "")
			end

			local var_82_1 = 0
			local var_82_2 = 1.475

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(421061019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 59 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 59)

				if (59 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 59)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play421061020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 421061020
		arg_83_1.duration_ = 9.2

		local var_83_0 = {
			zh = 8.266,
			ja = 9.2
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play421061021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.825

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(421061020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 33 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 33)

				if (33 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 33)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061020", "story_v_out_421061.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061020", "story_v_out_421061.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_421061", "421061020", "story_v_out_421061.awb")

						arg_83_1:RecordAudio("421061020", var_86_6)
						arg_83_1:RecordAudio("421061020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_421061", "421061020", "story_v_out_421061.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_421061", "421061020", "story_v_out_421061.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play421061021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 421061021
		arg_87_1.duration_ = 3.4

		local var_87_0 = {
			zh = 2.466,
			ja = 3.4
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play421061022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.175

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:GetWordFromCfg(421061021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 7 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 7)

				if (7 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 7)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061021", "story_v_out_421061.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061021", "story_v_out_421061.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_421061", "421061021", "story_v_out_421061.awb")

						arg_87_1:RecordAudio("421061021", var_90_6)
						arg_87_1:RecordAudio("421061021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_421061", "421061021", "story_v_out_421061.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_421061", "421061021", "story_v_out_421061.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play421061022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 421061022
		arg_91_1.duration_ = 4

		local var_91_0 = {
			zh = 3.8,
			ja = 4
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play421061023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(421061022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 12 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 12)

				if (12 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 12)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061022", "story_v_out_421061.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061022", "story_v_out_421061.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_421061", "421061022", "story_v_out_421061.awb")

						arg_91_1:RecordAudio("421061022", var_94_6)
						arg_91_1:RecordAudio("421061022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_421061", "421061022", "story_v_out_421061.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_421061", "421061022", "story_v_out_421061.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play421061023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 421061023
		arg_95_1.duration_ = 3.97

		local var_95_0 = {
			zh = 2.166,
			ja = 3.966
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play421061024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.175

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(421061023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 7 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 7)

				if (7 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 7)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061023", "story_v_out_421061.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061023", "story_v_out_421061.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_421061", "421061023", "story_v_out_421061.awb")

						arg_95_1:RecordAudio("421061023", var_98_6)
						arg_95_1:RecordAudio("421061023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_421061", "421061023", "story_v_out_421061.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_421061", "421061023", "story_v_out_421061.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play421061024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 421061024
		arg_99_1.duration_ = 10.4

		local var_99_0 = {
			zh = 5.233,
			ja = 10.4
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play421061025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.625

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(421061024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 25 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 25)

				if (25 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 25)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061024", "story_v_out_421061.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061024", "story_v_out_421061.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_421061", "421061024", "story_v_out_421061.awb")

						arg_99_1:RecordAudio("421061024", var_102_6)
						arg_99_1:RecordAudio("421061024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_421061", "421061024", "story_v_out_421061.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_421061", "421061024", "story_v_out_421061.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play421061025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 421061025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play421061026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0.1 < arg_103_1.time_ and arg_103_1.time_ <= 0.1 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep09", "")
			end

			local var_106_1 = 0
			local var_106_2 = 0.7

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(421061025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 28 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 28)

				if (28 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 28)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play421061026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 421061026
		arg_107_1.duration_ = 5.3

		local var_107_0 = {
			zh = 5.29966666666667,
			ja = 4.76666666666667
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
				arg_107_0:Play421061027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_9001
			local var_110_9000

			if 1.06666666666667 < arg_107_1.time_ and arg_107_1.time_ <= 1.06666666666667 + arg_110_0 then
				arg_107_1.var_.moveOldPosSS2102 = arg_107_1.bgs_.SS2102.transform.localPosition
			end

			local var_110_0 = 0.001

			if 1.06666666666667 <= arg_107_1.time_ and arg_107_1.time_ < 1.06666666666667 + var_110_0 then
				arg_107_1.bgs_.SS2102.transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosSS2102, Vector3.New(-0.84, -0.3, 4), (arg_107_1.time_ - 1.06666666666667) / var_110_0)
			end

			if arg_107_1.time_ >= 1.06666666666667 + var_110_0 and arg_107_1.time_ < 1.06666666666667 + var_110_0 + arg_110_0 then
				arg_107_1.bgs_.SS2102.transform.localPosition = Vector3.New(-0.84, -0.3, 4)
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_1 = arg_107_1.var_.effect1026

				if not arg_107_1.var_.effect1026 then
					var_110_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_110_1.name = "1026"
					arg_107_1.var_.effect1026 = var_110_1
				else
					var_110_1.transform:SetParent(var_110_9001)
				end

				var_110_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_110_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.06666666666667 < arg_107_1.time_ and arg_107_1.time_ <= 1.06666666666667 + arg_110_0 then
				if arg_107_1.var_.effect1026 then
					Object.Destroy(arg_107_1.var_.effect1026)

					arg_107_1.var_.effect1026 = nil
				end
			end

			if 1.06666666666667 < arg_107_1.time_ and arg_107_1.time_ <= 1.06666666666667 + arg_110_0 then
				local var_110_4 = arg_107_1.var_.effect1027

				if not arg_107_1.var_.effect1027 then
					var_110_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_110_4.name = "1027"
					arg_107_1.var_.effect1027 = var_110_4
				else
					var_110_4.transform:SetParent(var_110_9000)
				end

				var_110_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_110_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.43333333333333 < arg_107_1.time_ and arg_107_1.time_ <= 2.43333333333333 + arg_110_0 then
				if arg_107_1.var_.effect1027 then
					Object.Destroy(arg_107_1.var_.effect1027)

					arg_107_1.var_.effect1027 = nil
				end
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_7 = 1.96666666666667
			local var_110_8 = 0.35

			if 1.96666666666667 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_9 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_9:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(421061026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 14 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_11) / 14)

				if (14 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_11) / 14)) > 0 and var_110_8 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13
					var_110_7 = var_110_7 + 0.3

					if var_110_13 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061026", "story_v_out_421061.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_421061", "421061026", "story_v_out_421061.awb") / 1000

					if var_110_14 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_7
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_421061", "421061026", "story_v_out_421061.awb")

						arg_107_1:RecordAudio("421061026", var_110_15)
						arg_107_1:RecordAudio("421061026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_421061", "421061026", "story_v_out_421061.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_421061", "421061026", "story_v_out_421061.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = var_110_7 + 0.3
			local var_110_17 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 + 0.3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_16) / var_110_17

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play421061027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421061027
		arg_113_1.duration_ = 4.6

		local var_113_0 = {
			zh = 1.933,
			ja = 4.6
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play421061028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.25

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(421061027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 10 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 10)

				if (10 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 10)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061027", "story_v_out_421061.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061027", "story_v_out_421061.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_421061", "421061027", "story_v_out_421061.awb")

						arg_113_1:RecordAudio("421061027", var_116_6)
						arg_113_1:RecordAudio("421061027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421061", "421061027", "story_v_out_421061.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421061", "421061027", "story_v_out_421061.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play421061028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421061028
		arg_117_1.duration_ = 11.97

		local var_117_0 = {
			zh = 8.533,
			ja = 11.966
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
				arg_117_0:Play421061029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.75

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(421061028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 30 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 30)

				if (30 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 30)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061028", "story_v_out_421061.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061028", "story_v_out_421061.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_421061", "421061028", "story_v_out_421061.awb")

						arg_117_1:RecordAudio("421061028", var_120_6)
						arg_117_1:RecordAudio("421061028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_421061", "421061028", "story_v_out_421061.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_421061", "421061028", "story_v_out_421061.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play421061029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421061029
		arg_121_1.duration_ = 10.17

		local var_121_0 = {
			zh = 7.6,
			ja = 10.166
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play421061030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.925

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(421061029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 37 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 37)

				if (37 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 37)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061029", "story_v_out_421061.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061029", "story_v_out_421061.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_421061", "421061029", "story_v_out_421061.awb")

						arg_121_1:RecordAudio("421061029", var_124_6)
						arg_121_1:RecordAudio("421061029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421061", "421061029", "story_v_out_421061.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421061", "421061029", "story_v_out_421061.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play421061030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421061030
		arg_125_1.duration_ = 6.07

		local var_125_0 = {
			zh = 5.1,
			ja = 6.066
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play421061031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(421061030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 21 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 21)

				if (21 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 21)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061030", "story_v_out_421061.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061030", "story_v_out_421061.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_421061", "421061030", "story_v_out_421061.awb")

						arg_125_1:RecordAudio("421061030", var_128_6)
						arg_125_1:RecordAudio("421061030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_421061", "421061030", "story_v_out_421061.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_421061", "421061030", "story_v_out_421061.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play421061031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421061031
		arg_129_1.duration_ = 6.53

		local var_129_0 = {
			zh = 6.166,
			ja = 6.533
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
				arg_129_0:Play421061032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				local var_132_0 = arg_129_1.bgs_.ST0109

				arg_129_1.bgs_.ST0109.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_132_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_1 = var_132_0:GetComponent("SpriteRenderer")

				if var_132_1 and var_132_1.sprite then
					local var_132_2 = 2 * (var_132_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_132_0.transform.localScale = Vector3.New(var_132_2 / var_132_1.sprite.bounds.size.y < var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x and var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x or var_132_2 / var_132_1.sprite.bounds.size.y, var_132_2 / var_132_1.sprite.bounds.size.y < var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x and var_132_2 * manager.ui.mainCameraCom_.aspect / var_132_1.sprite.bounds.size.x or var_132_2 / var_132_1.sprite.bounds.size.y, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "ST0109" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_3 = 4

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= var_132_3 + 0.0999999999999996 and arg_129_1.time_ < var_132_3 + 0.0999999999999996 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_4 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_5 = 2

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_5 then
				local var_132_6 = Color.New(0, 0, 0)

				var_132_6.a = Mathf.Lerp(0, 1, (arg_129_1.time_ - var_132_4) / var_132_5)
				arg_129_1.mask_.color = var_132_6
			end

			if arg_129_1.time_ >= var_132_4 + var_132_5 and arg_129_1.time_ < var_132_4 + var_132_5 + arg_132_0 then
				local var_132_7 = Color.New(0, 0, 0)

				var_132_7.a = 1
				arg_129_1.mask_.color = var_132_7
			end

			local var_132_8 = 2

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_9 = 2

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 then
				local var_132_10 = Color.New(0, 0, 0)

				var_132_10.a = Mathf.Lerp(1, 0, (arg_129_1.time_ - var_132_8) / var_132_9)
				arg_129_1.mask_.color = var_132_10
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 then
				local var_132_11 = Color.New(0, 0, 0)

				arg_129_1.mask_.enabled = false
				var_132_11.a = 0
				arg_129_1.mask_.color = var_132_11
			end

			local var_132_12 = "10102ui_story"

			if arg_129_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_132_13 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_129_1.stage_.transform)

				var_132_13.name = var_132_12
				var_132_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_[var_132_12] = var_132_13

				local var_132_14 = var_132_13:GetComponentInChildren(typeof(CharacterEffect))

				var_132_14.enabled = true

				local var_132_15 = GameObjectTools.GetOrAddComponent(var_132_13, typeof(DynamicBoneHelper))

				if var_132_15 then
					var_132_15:EnableDynamicBone(false)
				end

				arg_129_1:ShowWeapon(var_132_14.transform, false)

				arg_129_1.var_[var_132_12 .. "Animator"] = var_132_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_129_1.var_[var_132_12 .. "Animator"].applyRootMotion = true
				arg_129_1.var_[var_132_12 .. "LipSync"] = var_132_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_132_16 = arg_129_1.actors_["10102ui_story"].transform

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 then
				arg_129_1.var_.moveOldPos10102ui_story = var_132_16.localPosition
			end

			local var_132_17 = 0.001

			if 4 <= arg_129_1.time_ and arg_129_1.time_ < 4 + var_132_17 then
				var_132_16.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_129_1.time_ - 4) / var_132_17)
				var_132_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_16.position).x, (manager.ui.mainCamera.transform.position - var_132_16.position).y, (manager.ui.mainCamera.transform.position - var_132_16.position).z)
				var_132_16.localEulerAngles.z = 0
				var_132_16.localEulerAngles.x = 0
				var_132_16.localEulerAngles = var_132_16.localEulerAngles
			end

			if arg_129_1.time_ >= 4 + var_132_17 and arg_129_1.time_ < 4 + var_132_17 + arg_132_0 then
				var_132_16.localPosition = Vector3.New(0, -0.985, -6.275)
				var_132_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_16.position).x, (manager.ui.mainCamera.transform.position - var_132_16.position).y, (manager.ui.mainCamera.transform.position - var_132_16.position).z)
				var_132_16.localEulerAngles.z = 0
				var_132_16.localEulerAngles.x = 0
				var_132_16.localEulerAngles = var_132_16.localEulerAngles
			end

			local var_132_18 = arg_129_1.actors_["10102ui_story"]

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect10102ui_story == nil then
				arg_129_1.var_.characterEffect10102ui_story = var_132_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_19 = 0.200000002980232

			if 4 <= arg_129_1.time_ and arg_129_1.time_ < 4 + var_132_19 and not isNil(var_132_18) then
				if arg_129_1.var_.characterEffect10102ui_story and not isNil(var_132_18) then
					arg_129_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 4 + var_132_19 and arg_129_1.time_ < 4 + var_132_19 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect10102ui_story then
				arg_129_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 then
				arg_129_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 then
				arg_129_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.9 < arg_129_1.time_ and arg_129_1.time_ <= 1.9 + arg_132_0 then
				if arg_129_1.var_.effect1006 then
					Object.Destroy(arg_129_1.var_.effect1006)

					arg_129_1.var_.effect1006 = nil
				end
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_22 = 4
			local var_132_23 = 0.2

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_22 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_24 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_24:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_25 = arg_129_1:GetWordFromCfg(421061031)
				local var_132_26 = arg_129_1:FormatText(var_132_25.content)

				arg_129_1.text_.text = var_132_26

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_28 = 8 <= 0 and var_132_23 or var_132_23 * (utf8.len(var_132_26) / 8)

				if (8 <= 0 and var_132_23 or var_132_23 * (utf8.len(var_132_26) / 8)) > 0 and var_132_23 < var_132_28 then
					arg_129_1.talkMaxDuration = var_132_28
					var_132_22 = var_132_22 + 0.3

					if var_132_28 + var_132_22 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_28 + var_132_22
					end
				end

				arg_129_1.text_.text = var_132_26
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061031", "story_v_out_421061.awb") ~= 0 then
					local var_132_29 = manager.audio:GetVoiceLength("story_v_out_421061", "421061031", "story_v_out_421061.awb") / 1000

					if var_132_29 + var_132_22 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_29 + var_132_22
					end

					if var_132_25.prefab_name ~= "" and arg_129_1.actors_[var_132_25.prefab_name] ~= nil then
						local var_132_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_25.prefab_name].transform, "story_v_out_421061", "421061031", "story_v_out_421061.awb")

						arg_129_1:RecordAudio("421061031", var_132_30)
						arg_129_1:RecordAudio("421061031", var_132_30)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421061", "421061031", "story_v_out_421061.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421061", "421061031", "story_v_out_421061.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_31 = var_132_22 + 0.3
			local var_132_32 = math.max(var_132_23, arg_129_1.talkMaxDuration)

			if var_132_22 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_31 + var_132_32 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_31) / var_132_32

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_31 + var_132_32 and arg_129_1.time_ < var_132_31 + var_132_32 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play421061032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 421061032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play421061033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10102ui_story = arg_135_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).z)
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles = arg_135_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).z)
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles = arg_135_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["10102ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10102ui_story == nil then
				arg_135_1.var_.characterEffect10102ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10102ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_2)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10102ui_story then
				arg_135_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_138_3 = 0
			local var_138_4 = 0.425

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_5 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(421061032).content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 17 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 17)

				if (17 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 17)) > 0 and var_138_4 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_8 and arg_135_1.time_ < var_138_3 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play421061033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 421061033
		arg_139_1.duration_ = 4.53

		local var_139_0 = {
			zh = 3.866,
			ja = 4.533
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play421061034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_142_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_139_1.stage_.transform)

				var_142_0.name = "10145ui_story"
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["10145ui_story"] = var_142_0

				local var_142_1 = var_142_0:GetComponentInChildren(typeof(CharacterEffect))

				var_142_1.enabled = true

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end

				arg_139_1:ShowWeapon(var_142_1.transform, false)

				arg_139_1.var_["10145ui_story" .. "Animator"] = var_142_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_139_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_139_1.var_["10145ui_story" .. "LipSync"] = var_142_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_142_3 = arg_139_1.actors_["10145ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10145ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(0, -1, -6.2)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["10145ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect10145ui_story == nil then
				arg_139_1.var_.characterEffect10145ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect10145ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect10145ui_story then
				arg_139_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_142_8 = 0
			local var_142_9 = 0.525

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(421061033)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 21 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 21)

				if (21 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 21)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061033", "story_v_out_421061.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_421061", "421061033", "story_v_out_421061.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_421061", "421061033", "story_v_out_421061.awb")

						arg_139_1:RecordAudio("421061033", var_142_15)
						arg_139_1:RecordAudio("421061033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_421061", "421061033", "story_v_out_421061.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_421061", "421061033", "story_v_out_421061.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play421061034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 421061034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play421061035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10145ui_story = arg_143_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).z)
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles = arg_143_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).z)
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles = arg_143_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["10145ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10145ui_story == nil then
				arg_143_1.var_.characterEffect10145ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10145ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10145ui_story then
				arg_143_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_146_3 = 0
			local var_146_4 = 1.175

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(421061034).content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 47 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 47)

				if (47 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 47)) > 0 and var_146_4 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_8 and arg_143_1.time_ < var_146_3 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play421061035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421061035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play421061036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.35

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(421061035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 54 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 54)

				if (54 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 54)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play421061036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421061036
		arg_151_1.duration_ = 3.83

		local var_151_0 = {
			zh = 2.9,
			ja = 3.833
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play421061037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10145ui_story = arg_151_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).z)
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles = arg_151_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_151_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).z)
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles = arg_151_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10145ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10145ui_story == nil then
				arg_151_1.var_.characterEffect10145ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10145ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10145ui_story then
				arg_151_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_154_4 = 0
			local var_154_5 = 0.525

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(421061036)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 21 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 21)

				if (21 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 21)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061036", "story_v_out_421061.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061036", "story_v_out_421061.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_421061", "421061036", "story_v_out_421061.awb")

						arg_151_1:RecordAudio("421061036", var_154_11)
						arg_151_1:RecordAudio("421061036", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_421061", "421061036", "story_v_out_421061.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_421061", "421061036", "story_v_out_421061.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play421061037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421061037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421061038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10145ui_story = arg_155_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10145ui_story"].transform.position).z)
				arg_155_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10145ui_story"].transform.localEulerAngles = arg_155_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10145ui_story"].transform.position).z)
				arg_155_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10145ui_story"].transform.localEulerAngles = arg_155_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_158_1 = 0
			local var_158_2 = 0.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(421061037).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 13 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 13)

				if (13 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 13)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play421061038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421061038
		arg_159_1.duration_ = 6.03

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play421061039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if arg_159_1.bgs_.ST21 == nil then
				local var_162_0 = Object.Instantiate(arg_159_1.paintGo_)

				var_162_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21")
				var_162_0.name = "ST21"
				var_162_0.transform.parent = arg_159_1.stage_.transform
				var_162_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.bgs_.ST21 = var_162_0
			end

			if 2 < arg_159_1.time_ and arg_159_1.time_ <= 2 + arg_162_0 then
				local var_162_1 = arg_159_1.bgs_.ST21

				arg_159_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_162_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_2 = var_162_1:GetComponent("SpriteRenderer")

				if var_162_2 and var_162_2.sprite then
					local var_162_3 = 2 * (var_162_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_162_1.transform.localScale = Vector3.New(var_162_3 / var_162_2.sprite.bounds.size.y < var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x and var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x or var_162_3 / var_162_2.sprite.bounds.size.y, var_162_3 / var_162_2.sprite.bounds.size.y < var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x and var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x or var_162_3 / var_162_2.sprite.bounds.size.y, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "ST21" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_4 = 4

			if 4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_4 + 0.0999999999999996 and arg_159_1.time_ < var_162_4 + 0.0999999999999996 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_5 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_6 = 2

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 then
				local var_162_7 = Color.New(0, 0, 0)

				var_162_7.a = Mathf.Lerp(0, 1, (arg_159_1.time_ - var_162_5) / var_162_6)
				arg_159_1.mask_.color = var_162_7
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 then
				local var_162_8 = Color.New(0, 0, 0)

				var_162_8.a = 1
				arg_159_1.mask_.color = var_162_8
			end

			local var_162_9 = 2

			if 2 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_10 = 2

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_10 then
				local var_162_11 = Color.New(0, 0, 0)

				var_162_11.a = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_9) / var_162_10)
				arg_159_1.mask_.color = var_162_11
			end

			if arg_159_1.time_ >= var_162_9 + var_162_10 and arg_159_1.time_ < var_162_9 + var_162_10 + arg_162_0 then
				local var_162_12 = Color.New(0, 0, 0)

				arg_159_1.mask_.enabled = false
				var_162_12.a = 0
				arg_159_1.mask_.color = var_162_12
			end

			local var_162_13 = arg_159_1.actors_["10145ui_story"].transform

			if 2 < arg_159_1.time_ and arg_159_1.time_ <= 2 + arg_162_0 then
				arg_159_1.var_.moveOldPos10145ui_story = var_162_13.localPosition
			end

			local var_162_14 = 0.001

			if 2 <= arg_159_1.time_ and arg_159_1.time_ < 2 + var_162_14 then
				var_162_13.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 2) / var_162_14)
				var_162_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_13.position).x, (manager.ui.mainCamera.transform.position - var_162_13.position).y, (manager.ui.mainCamera.transform.position - var_162_13.position).z)
				var_162_13.localEulerAngles.z = 0
				var_162_13.localEulerAngles.x = 0
				var_162_13.localEulerAngles = var_162_13.localEulerAngles
			end

			if arg_159_1.time_ >= 2 + var_162_14 and arg_159_1.time_ < 2 + var_162_14 + arg_162_0 then
				var_162_13.localPosition = Vector3.New(0, 100, 0)
				var_162_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_13.position).x, (manager.ui.mainCamera.transform.position - var_162_13.position).y, (manager.ui.mainCamera.transform.position - var_162_13.position).z)
				var_162_13.localEulerAngles.z = 0
				var_162_13.localEulerAngles.x = 0
				var_162_13.localEulerAngles = var_162_13.localEulerAngles
			end

			if 0.1 < arg_159_1.time_ and arg_159_1.time_ <= 0.1 + arg_162_0 then
				arg_159_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if 1.6 < arg_159_1.time_ and arg_159_1.time_ <= 1.6 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_17 = 4
			local var_162_18 = 0.1

			if 4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_19 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_19:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_20 = arg_159_1:GetWordFromCfg(421061038)
				local var_162_21 = arg_159_1:FormatText(var_162_20.content)

				arg_159_1.text_.text = var_162_21

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_23 = 4 <= 0 and var_162_18 or var_162_18 * (utf8.len(var_162_21) / 4)

				if (4 <= 0 and var_162_18 or var_162_18 * (utf8.len(var_162_21) / 4)) > 0 and var_162_18 < var_162_23 then
					arg_159_1.talkMaxDuration = var_162_23
					var_162_17 = var_162_17 + 0.3

					if var_162_23 + var_162_17 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_17
					end
				end

				arg_159_1.text_.text = var_162_21
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061038", "story_v_out_421061.awb") ~= 0 then
					local var_162_24 = manager.audio:GetVoiceLength("story_v_out_421061", "421061038", "story_v_out_421061.awb") / 1000

					if var_162_24 + var_162_17 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_24 + var_162_17
					end

					if var_162_20.prefab_name ~= "" and arg_159_1.actors_[var_162_20.prefab_name] ~= nil then
						local var_162_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_20.prefab_name].transform, "story_v_out_421061", "421061038", "story_v_out_421061.awb")

						arg_159_1:RecordAudio("421061038", var_162_25)
						arg_159_1:RecordAudio("421061038", var_162_25)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_421061", "421061038", "story_v_out_421061.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_421061", "421061038", "story_v_out_421061.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_26 = var_162_17 + 0.3
			local var_162_27 = math.max(var_162_18, arg_159_1.talkMaxDuration)

			if var_162_17 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_26 + var_162_27 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_26) / var_162_27

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_26 + var_162_27 and arg_159_1.time_ < var_162_26 + var_162_27 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play421061039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421061039
		arg_165_1.duration_ = 3.53

		local var_165_0 = {
			zh = 2.766,
			ja = 3.533
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
				arg_165_0:Play421061040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1047ui_story = arg_165_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).z)
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles = arg_165_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_165_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).z)
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles = arg_165_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1047ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1047ui_story == nil then
				arg_165_1.var_.characterEffect1047ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1047ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1047ui_story then
				arg_165_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_168_4 = 0
			local var_168_5 = 0.3

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(421061039)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 12 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 12)

				if (12 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 12)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061039", "story_v_out_421061.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061039", "story_v_out_421061.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_421061", "421061039", "story_v_out_421061.awb")

						arg_165_1:RecordAudio("421061039", var_168_11)
						arg_165_1:RecordAudio("421061039", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_421061", "421061039", "story_v_out_421061.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_421061", "421061039", "story_v_out_421061.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play421061040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421061040
		arg_169_1.duration_ = 6.37

		local var_169_0 = {
			zh = 5.9,
			ja = 6.366
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
				arg_169_0:Play421061041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1047ui_story"]) and arg_169_1.var_.characterEffect1047ui_story == nil then
				arg_169_1.var_.characterEffect1047ui_story = arg_169_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1047ui_story"]) then
				if arg_169_1.var_.characterEffect1047ui_story and not isNil(arg_169_1.actors_["1047ui_story"]) then
					arg_169_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1047ui_story"]) and arg_169_1.var_.characterEffect1047ui_story then
				arg_169_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 0.475

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(421061040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_6 = 19 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_4) / 19)

				if (19 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_4) / 19)) > 0 and var_172_2 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061040", "story_v_out_421061.awb") ~= 0 then
					local var_172_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061040", "story_v_out_421061.awb") / 1000

					if var_172_7 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_1
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_421061", "421061040", "story_v_out_421061.awb")

						arg_169_1:RecordAudio("421061040", var_172_8)
						arg_169_1:RecordAudio("421061040", var_172_8)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_421061", "421061040", "story_v_out_421061.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_421061", "421061040", "story_v_out_421061.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_9 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_9 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_9

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_9 and arg_169_1.time_ < var_172_1 + var_172_9 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play421061041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421061041
		arg_173_1.duration_ = 12

		local var_173_0 = {
			zh = 12,
			ja = 11.066
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
				arg_173_0:Play421061042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047ui_story = arg_173_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1047ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story then
				arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 1.275

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(421061041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 51 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 51)

				if (51 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 51)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061041", "story_v_out_421061.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061041", "story_v_out_421061.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_421061", "421061041", "story_v_out_421061.awb")

						arg_173_1:RecordAudio("421061041", var_176_11)
						arg_173_1:RecordAudio("421061041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421061", "421061041", "story_v_out_421061.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421061", "421061041", "story_v_out_421061.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play421061042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421061042
		arg_177_1.duration_ = 11.97

		local var_177_0 = {
			zh = 4.7,
			ja = 11.966
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
				arg_177_0:Play421061043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047ui_story = arg_177_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_180_1 = 0
			local var_180_2 = 1.05

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(421061042)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 21 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 21)

				if (21 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 21)) > 0 and var_180_2 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061042", "story_v_out_421061.awb") ~= 0 then
					local var_180_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061042", "story_v_out_421061.awb") / 1000

					if var_180_7 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_1
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_421061", "421061042", "story_v_out_421061.awb")

						arg_177_1:RecordAudio("421061042", var_180_8)
						arg_177_1:RecordAudio("421061042", var_180_8)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_421061", "421061042", "story_v_out_421061.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_421061", "421061042", "story_v_out_421061.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_9 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_9 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_9

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_9 and arg_177_1.time_ < var_180_1 + var_180_9 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play421061043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421061043
		arg_181_1.duration_ = 11.4

		local var_181_0 = {
			zh = 9.8,
			ja = 11.4
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
				arg_181_0:Play421061044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1047ui_story"]) and arg_181_1.var_.characterEffect1047ui_story == nil then
				arg_181_1.var_.characterEffect1047ui_story = arg_181_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1047ui_story"]) then
				if arg_181_1.var_.characterEffect1047ui_story and not isNil(arg_181_1.actors_["1047ui_story"]) then
					arg_181_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1047ui_story"]) and arg_181_1.var_.characterEffect1047ui_story then
				arg_181_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.975

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(421061043)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 39 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_4) / 39)

				if (39 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_4) / 39)) > 0 and var_184_2 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061043", "story_v_out_421061.awb") ~= 0 then
					local var_184_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061043", "story_v_out_421061.awb") / 1000

					if var_184_7 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_1
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_421061", "421061043", "story_v_out_421061.awb")

						arg_181_1:RecordAudio("421061043", var_184_8)
						arg_181_1:RecordAudio("421061043", var_184_8)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_421061", "421061043", "story_v_out_421061.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_421061", "421061043", "story_v_out_421061.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_9 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_9 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_9

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_9 and arg_181_1.time_ < var_184_1 + var_184_9 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play421061044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421061044
		arg_185_1.duration_ = 18.4

		local var_185_0 = {
			zh = 8.433,
			ja = 18.4
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
				arg_185_0:Play421061045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047ui_story = arg_185_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1047ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1047ui_story == nil then
				arg_185_1.var_.characterEffect1047ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1047ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1047ui_story then
				arg_185_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_4 = 0
			local var_188_5 = 0.95

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(421061044)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 38 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 38)

				if (38 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 38)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061044", "story_v_out_421061.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061044", "story_v_out_421061.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_421061", "421061044", "story_v_out_421061.awb")

						arg_185_1:RecordAudio("421061044", var_188_11)
						arg_185_1:RecordAudio("421061044", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421061", "421061044", "story_v_out_421061.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421061", "421061044", "story_v_out_421061.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421061045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421061045
		arg_189_1.duration_ = 13.87

		local var_189_0 = {
			zh = 10.666,
			ja = 13.866
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
				arg_189_0:Play421061046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1047ui_story"]) and arg_189_1.var_.characterEffect1047ui_story == nil then
				arg_189_1.var_.characterEffect1047ui_story = arg_189_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1047ui_story"]) then
				if arg_189_1.var_.characterEffect1047ui_story and not isNil(arg_189_1.actors_["1047ui_story"]) then
					arg_189_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1047ui_story"]) and arg_189_1.var_.characterEffect1047ui_story then
				arg_189_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 1.05

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(421061045)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 42 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 42)

				if (42 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 42)) > 0 and var_192_2 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061045", "story_v_out_421061.awb") ~= 0 then
					local var_192_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061045", "story_v_out_421061.awb") / 1000

					if var_192_7 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_1
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_421061", "421061045", "story_v_out_421061.awb")

						arg_189_1:RecordAudio("421061045", var_192_8)
						arg_189_1:RecordAudio("421061045", var_192_8)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_421061", "421061045", "story_v_out_421061.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_421061", "421061045", "story_v_out_421061.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_9 and arg_189_1.time_ < var_192_1 + var_192_9 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play421061046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421061046
		arg_193_1.duration_ = 12.93

		local var_193_0 = {
			zh = 9.666,
			ja = 12.933
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421061047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1047ui_story = arg_193_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).z)
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles = arg_193_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_193_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).z)
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles = arg_193_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1047ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1047ui_story == nil then
				arg_193_1.var_.characterEffect1047ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1047ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1047ui_story then
				arg_193_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_196_4 = 0
			local var_196_5 = 0.975

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(421061046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 39 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 39)

				if (39 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 39)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061046", "story_v_out_421061.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061046", "story_v_out_421061.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_421061", "421061046", "story_v_out_421061.awb")

						arg_193_1:RecordAudio("421061046", var_196_11)
						arg_193_1:RecordAudio("421061046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_421061", "421061046", "story_v_out_421061.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_421061", "421061046", "story_v_out_421061.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play421061047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421061047
		arg_197_1.duration_ = 3

		local var_197_0 = {
			zh = 3,
			ja = 2.8
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
				arg_197_0:Play421061048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1047ui_story"]) and arg_197_1.var_.characterEffect1047ui_story == nil then
				arg_197_1.var_.characterEffect1047ui_story = arg_197_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1047ui_story"]) then
				if arg_197_1.var_.characterEffect1047ui_story and not isNil(arg_197_1.actors_["1047ui_story"]) then
					arg_197_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1047ui_story"]) and arg_197_1.var_.characterEffect1047ui_story then
				arg_197_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.275

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(421061047)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 11 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 11)

				if (11 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 11)) > 0 and var_200_2 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061047", "story_v_out_421061.awb") ~= 0 then
					local var_200_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061047", "story_v_out_421061.awb") / 1000

					if var_200_7 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_1
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_421061", "421061047", "story_v_out_421061.awb")

						arg_197_1:RecordAudio("421061047", var_200_8)
						arg_197_1:RecordAudio("421061047", var_200_8)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421061", "421061047", "story_v_out_421061.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421061", "421061047", "story_v_out_421061.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_9 and arg_197_1.time_ < var_200_1 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play421061048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421061048
		arg_201_1.duration_ = 8.33

		local var_201_0 = {
			zh = 4.8,
			ja = 8.333
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
				arg_201_0:Play421061049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1047ui_story = arg_201_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).z)
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles = arg_201_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_201_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).z)
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles = arg_201_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1047ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1047ui_story == nil then
				arg_201_1.var_.characterEffect1047ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1047ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1047ui_story then
				arg_201_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_204_4 = 0
			local var_204_5 = 0.55

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(421061048)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 22 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 22)

				if (22 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 22)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061048", "story_v_out_421061.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061048", "story_v_out_421061.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_421061", "421061048", "story_v_out_421061.awb")

						arg_201_1:RecordAudio("421061048", var_204_11)
						arg_201_1:RecordAudio("421061048", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_421061", "421061048", "story_v_out_421061.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_421061", "421061048", "story_v_out_421061.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play421061049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421061049
		arg_205_1.duration_ = 10.7

		local var_205_0 = {
			zh = 8.9,
			ja = 10.7
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
				arg_205_0:Play421061050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1047ui_story"]) and arg_205_1.var_.characterEffect1047ui_story == nil then
				arg_205_1.var_.characterEffect1047ui_story = arg_205_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1047ui_story"]) then
				if arg_205_1.var_.characterEffect1047ui_story and not isNil(arg_205_1.actors_["1047ui_story"]) then
					arg_205_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1047ui_story"]) and arg_205_1.var_.characterEffect1047ui_story then
				arg_205_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.9

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(421061049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 36 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_4) / 36)

				if (36 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_4) / 36)) > 0 and var_208_2 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061049", "story_v_out_421061.awb") ~= 0 then
					local var_208_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061049", "story_v_out_421061.awb") / 1000

					if var_208_7 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_1
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_421061", "421061049", "story_v_out_421061.awb")

						arg_205_1:RecordAudio("421061049", var_208_8)
						arg_205_1:RecordAudio("421061049", var_208_8)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_421061", "421061049", "story_v_out_421061.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_421061", "421061049", "story_v_out_421061.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_9 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_9

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_9 and arg_205_1.time_ < var_208_1 + var_208_9 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play421061050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421061050
		arg_209_1.duration_ = 5.13

		local var_209_0 = {
			zh = 3.666,
			ja = 5.133
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play421061051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = arg_209_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1047ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1047ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_4 = 0
			local var_212_5 = 0.4

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(421061050)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 16 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 16)

				if (16 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 16)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061050", "story_v_out_421061.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061050", "story_v_out_421061.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_421061", "421061050", "story_v_out_421061.awb")

						arg_209_1:RecordAudio("421061050", var_212_11)
						arg_209_1:RecordAudio("421061050", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421061", "421061050", "story_v_out_421061.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421061", "421061050", "story_v_out_421061.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play421061051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421061051
		arg_213_1.duration_ = 12.9

		local var_213_0 = {
			zh = 10.333,
			ja = 12.9
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
				arg_213_0:Play421061052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047ui_story = arg_213_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).z)
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles = arg_213_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).z)
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles = arg_213_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_216_1 = 0
			local var_216_2 = 0.975

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(421061051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 39 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 39)

				if (39 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 39)) > 0 and var_216_2 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061051", "story_v_out_421061.awb") ~= 0 then
					local var_216_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061051", "story_v_out_421061.awb") / 1000

					if var_216_7 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_1
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_421061", "421061051", "story_v_out_421061.awb")

						arg_213_1:RecordAudio("421061051", var_216_8)
						arg_213_1:RecordAudio("421061051", var_216_8)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421061", "421061051", "story_v_out_421061.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421061", "421061051", "story_v_out_421061.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_9 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_9

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_9 and arg_213_1.time_ < var_216_1 + var_216_9 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play421061052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421061052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421061053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0.5 < arg_217_1.time_ and arg_217_1.time_ <= 0.5 + arg_220_0 then
				arg_217_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ui", "")
			end

			local var_220_1 = 0
			local var_220_2 = 0.85

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(421061052).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 34 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 34)

				if (34 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 34)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play421061053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421061053
		arg_221_1.duration_ = 9

		local var_221_0 = {
			zh = 5.533,
			ja = 9
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
				arg_221_0:Play421061054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1047ui_story = arg_221_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).z)
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles = arg_221_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_221_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).z)
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles = arg_221_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1047ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1047ui_story == nil then
				arg_221_1.var_.characterEffect1047ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1047ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1047ui_story then
				arg_221_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_224_4 = 0
			local var_224_5 = 0.55

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(421061053)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 22 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 22)

				if (22 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 22)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061053", "story_v_out_421061.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061053", "story_v_out_421061.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_421061", "421061053", "story_v_out_421061.awb")

						arg_221_1:RecordAudio("421061053", var_224_11)
						arg_221_1:RecordAudio("421061053", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_421061", "421061053", "story_v_out_421061.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_421061", "421061053", "story_v_out_421061.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play421061054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421061054
		arg_225_1.duration_ = 4.13

		local var_225_0 = {
			zh = 3.566,
			ja = 4.133
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play421061055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1047ui_story"]) and arg_225_1.var_.characterEffect1047ui_story == nil then
				arg_225_1.var_.characterEffect1047ui_story = arg_225_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1047ui_story"]) then
				if arg_225_1.var_.characterEffect1047ui_story and not isNil(arg_225_1.actors_["1047ui_story"]) then
					arg_225_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1047ui_story"]) and arg_225_1.var_.characterEffect1047ui_story then
				arg_225_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(421061054)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 13 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 13)

				if (13 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 13)) > 0 and var_228_2 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061054", "story_v_out_421061.awb") ~= 0 then
					local var_228_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061054", "story_v_out_421061.awb") / 1000

					if var_228_7 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_1
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_421061", "421061054", "story_v_out_421061.awb")

						arg_225_1:RecordAudio("421061054", var_228_8)
						arg_225_1:RecordAudio("421061054", var_228_8)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_421061", "421061054", "story_v_out_421061.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_421061", "421061054", "story_v_out_421061.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_9 and arg_225_1.time_ < var_228_1 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play421061055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421061055
		arg_229_1.duration_ = 10.7

		local var_229_0 = {
			zh = 6.266,
			ja = 10.7
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421061056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1047ui_story = arg_229_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).z)
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles = arg_229_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_229_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).z)
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles = arg_229_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1047ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1047ui_story == nil then
				arg_229_1.var_.characterEffect1047ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1047ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1047ui_story then
				arg_229_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_232_4 = 0
			local var_232_5 = 0.7

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(421061055)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 28 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 28)

				if (28 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 28)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061055", "story_v_out_421061.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061055", "story_v_out_421061.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_421061", "421061055", "story_v_out_421061.awb")

						arg_229_1:RecordAudio("421061055", var_232_11)
						arg_229_1:RecordAudio("421061055", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_421061", "421061055", "story_v_out_421061.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_421061", "421061055", "story_v_out_421061.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421061056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 421061056
		arg_233_1.duration_ = 14.57

		local var_233_0 = {
			zh = 11.433,
			ja = 14.566
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play421061057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1047ui_story"]) and arg_233_1.var_.characterEffect1047ui_story == nil then
				arg_233_1.var_.characterEffect1047ui_story = arg_233_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1047ui_story"]) then
				if arg_233_1.var_.characterEffect1047ui_story and not isNil(arg_233_1.actors_["1047ui_story"]) then
					arg_233_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1047ui_story"]) and arg_233_1.var_.characterEffect1047ui_story then
				arg_233_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 1.2

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(421061056)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_6 = 48 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_4) / 48)

				if (48 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_4) / 48)) > 0 and var_236_2 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061056", "story_v_out_421061.awb") ~= 0 then
					local var_236_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061056", "story_v_out_421061.awb") / 1000

					if var_236_7 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_1
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_421061", "421061056", "story_v_out_421061.awb")

						arg_233_1:RecordAudio("421061056", var_236_8)
						arg_233_1:RecordAudio("421061056", var_236_8)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_421061", "421061056", "story_v_out_421061.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_421061", "421061056", "story_v_out_421061.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_9 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_9 and arg_233_1.time_ < var_236_1 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play421061057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 421061057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play421061058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1047ui_story = arg_237_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1047ui_story"].transform.position).z)
				arg_237_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1047ui_story"].transform.localEulerAngles = arg_237_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1047ui_story"].transform.position).z)
				arg_237_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1047ui_story"].transform.localEulerAngles = arg_237_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_237_1.time_ and arg_237_1.time_ <= 0.1 + arg_240_0 then
				arg_237_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword01", "")
			end

			if 0.833333333333333 < arg_237_1.time_ and arg_237_1.time_ <= 0.833333333333333 + arg_240_0 then
				arg_237_1:AudioAction("play", "effect", "se_story", "se_story_explosion", "")
			end

			local var_240_3 = manager.ui.mainCamera.transform

			if 0.1 < arg_237_1.time_ and arg_237_1.time_ <= 0.1 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_3.localPosition
			end

			local var_240_4 = 1

			if 0.1 <= arg_237_1.time_ and arg_237_1.time_ < 0.1 + var_240_4 then
				local var_240_5, var_240_6 = math.modf((arg_237_1.time_ - 0.1) / 0.066)

				var_240_3.localPosition = Vector3.New(var_240_6 * 0.13, var_240_6 * 0.13, var_240_6 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= 0.1 + var_240_4 and arg_237_1.time_ < 0.1 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_7 = 0
			local var_240_8 = 1.175

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_9 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(421061057).content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 47 <= 0 and var_240_8 or var_240_8 * (utf8.len(var_240_9) / 47)

				if (47 <= 0 and var_240_8 or var_240_8 * (utf8.len(var_240_9) / 47)) > 0 and var_240_8 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_7 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_7
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_8, arg_237_1.talkMaxDuration)

			if var_240_7 <= arg_237_1.time_ and arg_237_1.time_ < var_240_7 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_7) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_7 + var_240_12 and arg_237_1.time_ < var_240_7 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play421061058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 421061058
		arg_241_1.duration_ = 3

		local var_241_0 = {
			zh = 2.5,
			ja = 3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play421061059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.25

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:GetWordFromCfg(421061058)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 10 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 10)

				if (10 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 10)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061058", "story_v_out_421061.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061058", "story_v_out_421061.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_421061", "421061058", "story_v_out_421061.awb")

						arg_241_1:RecordAudio("421061058", var_244_6)
						arg_241_1:RecordAudio("421061058", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_421061", "421061058", "story_v_out_421061.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_421061", "421061058", "story_v_out_421061.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play421061059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 421061059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play421061060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0.1 < arg_245_1.time_ and arg_245_1.time_ <= 0.1 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_143", "se_story_143_foley_pinch_paper", "")
			end

			local var_248_1 = 0
			local var_248_2 = 1.6

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(421061059).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 64 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 64)

				if (64 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 64)) > 0 and var_248_2 < var_248_5 then
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
	Play421061060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 421061060
		arg_249_1.duration_ = 4.4

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play421061061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if arg_249_1.bgs_.STblack == nil then
				local var_252_0 = Object.Instantiate(arg_249_1.paintGo_)

				var_252_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_252_0.name = "STblack"
				var_252_0.transform.parent = arg_249_1.stage_.transform
				var_252_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.bgs_.STblack = var_252_0
			end

			if 2 < arg_249_1.time_ and arg_249_1.time_ <= 2 + arg_252_0 then
				local var_252_1 = arg_249_1.bgs_.STblack

				arg_249_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_252_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_252_2 = var_252_1:GetComponent("SpriteRenderer")

				if var_252_2 and var_252_2.sprite then
					local var_252_3 = 2 * (var_252_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_252_1.transform.localScale = Vector3.New(var_252_3 / var_252_2.sprite.bounds.size.y < var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x and var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x or var_252_3 / var_252_2.sprite.bounds.size.y, var_252_3 / var_252_2.sprite.bounds.size.y < var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x and var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x or var_252_3 / var_252_2.sprite.bounds.size.y, 0)
				end

				for iter_252_0, iter_252_1 in pairs(arg_249_1.bgs_) do
					if iter_252_0 ~= "STblack" then
						iter_252_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_252_4 = 4

			if 4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.allBtn_.enabled = false
			end

			if arg_249_1.time_ >= var_252_4 + 0.166666666666667 and arg_249_1.time_ < var_252_4 + 0.166666666666667 + arg_252_0 then
				arg_249_1.allBtn_.enabled = true
			end

			local var_252_5 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_6 = 2

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_6 then
				local var_252_7 = Color.New(0, 0, 0)

				var_252_7.a = Mathf.Lerp(0, 1, (arg_249_1.time_ - var_252_5) / var_252_6)
				arg_249_1.mask_.color = var_252_7
			end

			if arg_249_1.time_ >= var_252_5 + var_252_6 and arg_249_1.time_ < var_252_5 + var_252_6 + arg_252_0 then
				local var_252_8 = Color.New(0, 0, 0)

				var_252_8.a = 1
				arg_249_1.mask_.color = var_252_8
			end

			local var_252_9 = 2

			if 2 < arg_249_1.time_ and arg_249_1.time_ <= var_252_9 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_10 = 2

			if var_252_9 <= arg_249_1.time_ and arg_249_1.time_ < var_252_9 + var_252_10 then
				local var_252_11 = Color.New(0, 0, 0)

				var_252_11.a = Mathf.Lerp(1, 0, (arg_249_1.time_ - var_252_9) / var_252_10)
				arg_249_1.mask_.color = var_252_11
			end

			if arg_249_1.time_ >= var_252_9 + var_252_10 and arg_249_1.time_ < var_252_9 + var_252_10 + arg_252_0 then
				local var_252_12 = Color.New(0, 0, 0)

				arg_249_1.mask_.enabled = false
				var_252_12.a = 0
				arg_249_1.mask_.color = var_252_12
			end

			if 2 < arg_249_1.time_ and arg_249_1.time_ <= 2 + arg_252_0 then
				arg_249_1.fswbg_:SetActive(true)
				arg_249_1.dialog_:SetActive(false)

				arg_249_1.fswtw_.percent = 0
				arg_249_1.fswt_.text = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(421061060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.fswt_)

				arg_249_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_249_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_249_1.fswtw_:SetDirty()

				arg_249_1.typewritterCharCountI18N = 0

				SetActive(arg_249_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_249_1:ShowNextGo(false)
			end

			local var_252_13 = 3.33333333333333

			if 3.33333333333333 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1.var_.oldValueTypewriter = arg_249_1.fswtw_.percent
				arg_249_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_249_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_249_1:ShowNextGo(false)
			end

			local var_252_14 = 25
			local var_252_15 = 0.666666666666667
			local var_252_16, var_252_17 = arg_249_1:GetPercentByPara(arg_249_1:FormatText(arg_249_1:GetWordFromCfg(421061060).content), 1)

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0

				local var_252_18 = var_252_14 <= 0 and var_252_15 or var_252_15 * ((var_252_17 - arg_249_1.typewritterCharCountI18N) / var_252_14)

				if (var_252_14 <= 0 and var_252_15 or var_252_15 * ((var_252_17 - arg_249_1.typewritterCharCountI18N) / var_252_14)) > 0 and var_252_15 < var_252_18 then
					arg_249_1.talkMaxDuration = var_252_18

					if var_252_18 + var_252_13 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_18 + var_252_13
					end
				end
			end

			local var_252_19 = math.max(0.666666666666667, arg_249_1.talkMaxDuration)

			if var_252_13 <= arg_249_1.time_ and arg_249_1.time_ < var_252_13 + var_252_19 then
				arg_249_1.fswtw_.percent = Mathf.Lerp(arg_249_1.var_.oldValueTypewriter, var_252_16, (arg_249_1.time_ - var_252_13) / var_252_19)
				arg_249_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_249_1.fswtw_:SetDirty()
			end

			if arg_249_1.time_ >= var_252_13 + var_252_19 and arg_249_1.time_ < var_252_13 + var_252_19 + arg_252_0 then
				arg_249_1.fswtw_.percent = var_252_16

				arg_249_1.fswtw_:SetDirty()
				arg_249_1:ShowNextGo(true)

				arg_249_1.typewritterCharCountI18N = var_252_17
			end

			if 2 < arg_249_1.time_ and arg_249_1.time_ <= 2 + arg_252_0 then
				local var_252_20 = arg_249_1.fswbg_.transform:Find("textbox/adapt/content") or arg_249_1.fswbg_.transform:Find("textbox/content")
				local var_252_21 = arg_249_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_252_22 = var_252_20:GetComponent("RectTransform")

				var_252_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_252_22.offsetMin = Vector2.New(0, 0)
				var_252_22.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play421061061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 421061061
		arg_253_1.duration_ = 6.3

		local var_253_0 = {
			zh = 5.766666666666,
			ja = 6.3
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play421061062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if arg_253_1.bgs_.D10_1 == nil then
				local var_256_0 = Object.Instantiate(arg_253_1.paintGo_)

				var_256_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10_1")
				var_256_0.name = "D10_1"
				var_256_0.transform.parent = arg_253_1.stage_.transform
				var_256_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.bgs_.D10_1 = var_256_0
			end

			if 2 < arg_253_1.time_ and arg_253_1.time_ <= 2 + arg_256_0 then
				local var_256_1 = arg_253_1.bgs_.D10_1

				arg_253_1.bgs_.D10_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_256_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_2 = var_256_1:GetComponent("SpriteRenderer")

				if var_256_2 and var_256_2.sprite then
					local var_256_3 = 2 * (var_256_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_256_1.transform.localScale = Vector3.New(var_256_3 / var_256_2.sprite.bounds.size.y < var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x and var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x or var_256_3 / var_256_2.sprite.bounds.size.y, var_256_3 / var_256_2.sprite.bounds.size.y < var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x and var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x or var_256_3 / var_256_2.sprite.bounds.size.y, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "D10_1" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_4 = 4

			if 4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			if arg_253_1.time_ >= var_256_4 + 0.133333333333334 and arg_253_1.time_ < var_256_4 + 0.133333333333334 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_5 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_6 = 2

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 then
				local var_256_7 = Color.New(0, 0, 0)

				var_256_7.a = Mathf.Lerp(0, 1, (arg_253_1.time_ - var_256_5) / var_256_6)
				arg_253_1.mask_.color = var_256_7
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 then
				local var_256_8 = Color.New(0, 0, 0)

				var_256_8.a = 1
				arg_253_1.mask_.color = var_256_8
			end

			local var_256_9 = 2

			if 2 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_10 = 2

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 then
				local var_256_11 = Color.New(0, 0, 0)

				var_256_11.a = Mathf.Lerp(1, 0, (arg_253_1.time_ - var_256_9) / var_256_10)
				arg_253_1.mask_.color = var_256_11
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 then
				local var_256_12 = Color.New(0, 0, 0)

				arg_253_1.mask_.enabled = false
				var_256_12.a = 0
				arg_253_1.mask_.color = var_256_12
			end

			if 1.9 < arg_253_1.time_ and arg_253_1.time_ <= 1.9 + arg_256_0 then
				arg_253_1.fswbg_:SetActive(false)
				arg_253_1.dialog_:SetActive(false)
				SetActive(arg_253_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_253_1:ShowNextGo(false)
			end

			if 0.1 < arg_253_1.time_ and arg_253_1.time_ <= 0.1 + arg_256_0 then
				arg_253_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.6 < arg_253_1.time_ and arg_253_1.time_ <= 1.6 + arg_256_0 then
				arg_253_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_15 = 4
			local var_256_16 = 0.2

			if 4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_17 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_17:setOnUpdate(LuaHelper.FloatAction(function(arg_257_0)
					arg_253_1.dialogCg_.alpha = arg_257_0
				end))
				var_256_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10100")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_18 = arg_253_1:GetWordFromCfg(421061061)
				local var_256_19 = arg_253_1:FormatText(var_256_18.content)

				arg_253_1.text_.text = var_256_19

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_21 = 8 <= 0 and var_256_16 or var_256_16 * (utf8.len(var_256_19) / 8)

				if (8 <= 0 and var_256_16 or var_256_16 * (utf8.len(var_256_19) / 8)) > 0 and var_256_16 < var_256_21 then
					arg_253_1.talkMaxDuration = var_256_21
					var_256_15 = var_256_15 + 0.3

					if var_256_21 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_21 + var_256_15
					end
				end

				arg_253_1.text_.text = var_256_19
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061061", "story_v_out_421061.awb") ~= 0 then
					local var_256_22 = manager.audio:GetVoiceLength("story_v_out_421061", "421061061", "story_v_out_421061.awb") / 1000

					if var_256_22 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_22 + var_256_15
					end

					if var_256_18.prefab_name ~= "" and arg_253_1.actors_[var_256_18.prefab_name] ~= nil then
						local var_256_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_18.prefab_name].transform, "story_v_out_421061", "421061061", "story_v_out_421061.awb")

						arg_253_1:RecordAudio("421061061", var_256_23)
						arg_253_1:RecordAudio("421061061", var_256_23)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_421061", "421061061", "story_v_out_421061.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_421061", "421061061", "story_v_out_421061.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_24 = var_256_15 + 0.3
			local var_256_25 = math.max(var_256_16, arg_253_1.talkMaxDuration)

			if var_256_15 + 0.3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_24 + var_256_25 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_24) / var_256_25

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_24 + var_256_25 and arg_253_1.time_ < var_256_24 + var_256_25 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play421061062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 421061062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play421061063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.275

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(421061062).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 11 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 11)

				if (11 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 11)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play421061063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 421061063
		arg_263_1.duration_ = 5.53

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play421061064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_266_0 = 0.533333333333333

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				local var_266_1, var_266_2 = math.modf((arg_263_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_266_2 * 0.13, var_266_2 * 0.13, var_266_2 * 0.13) + arg_263_1.var_.shakeOldPos
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				manager.ui.mainCamera.transform.localPosition = arg_263_1.var_.shakeOldPos
			end

			if 0.166666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 0.166666666666667 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hit02", "")
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_4 = 0.533333333333333
			local var_266_5 = 1

			if 0.533333333333333 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_6 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_6:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(421061063).content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 40 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 40)

				if (40 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 40)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9
					var_266_4 = var_266_4 + 0.3

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = var_266_4 + 0.3
			local var_266_11 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_10) / var_266_11

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play421061064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 421061064
		arg_269_1.duration_ = 4.37

		local var_269_0 = {
			zh = 2.966,
			ja = 4.366
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play421061065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10102ui_story = arg_269_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10102ui_story"].transform.position).z)
				arg_269_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10102ui_story"].transform.localEulerAngles = arg_269_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_269_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10102ui_story"].transform.position).z)
				arg_269_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10102ui_story"].transform.localEulerAngles = arg_269_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["10102ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10102ui_story == nil then
				arg_269_1.var_.characterEffect10102ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect10102ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10102ui_story then
				arg_269_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.375

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(421061064)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 15 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 15)

				if (15 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 15)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061064", "story_v_out_421061.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061064", "story_v_out_421061.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_421061", "421061064", "story_v_out_421061.awb")

						arg_269_1:RecordAudio("421061064", var_272_11)
						arg_269_1:RecordAudio("421061064", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_421061", "421061064", "story_v_out_421061.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_421061", "421061064", "story_v_out_421061.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play421061065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421061065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421061066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10102ui_story"]) and arg_273_1.var_.characterEffect10102ui_story == nil then
				arg_273_1.var_.characterEffect10102ui_story = arg_273_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10102ui_story"]) then
				if arg_273_1.var_.characterEffect10102ui_story and not isNil(arg_273_1.actors_["10102ui_story"]) then
					arg_273_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10102ui_story"]) and arg_273_1.var_.characterEffect10102ui_story then
				arg_273_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.475

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(421061065).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 19 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 19)

				if (19 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 19)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play421061066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421061066
		arg_277_1.duration_ = 10.7

		local var_277_0 = {
			zh = 5.766,
			ja = 10.7
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play421061067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10102ui_story = arg_277_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10102ui_story"].transform.position).z)
				arg_277_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10102ui_story"].transform.localEulerAngles = arg_277_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10102ui_story"].transform.position).z)
				arg_277_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10102ui_story"].transform.localEulerAngles = arg_277_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["10145ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10145ui_story = var_280_1.localPosition
			end

			local var_280_2 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 then
				var_280_1.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_277_1.time_ - 0) / var_280_2)
				var_280_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_1.position).x, (manager.ui.mainCamera.transform.position - var_280_1.position).y, (manager.ui.mainCamera.transform.position - var_280_1.position).z)
				var_280_1.localEulerAngles.z = 0
				var_280_1.localEulerAngles.x = 0
				var_280_1.localEulerAngles = var_280_1.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 then
				var_280_1.localPosition = Vector3.New(0, -1, -6.2)
				var_280_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_1.position).x, (manager.ui.mainCamera.transform.position - var_280_1.position).y, (manager.ui.mainCamera.transform.position - var_280_1.position).z)
				var_280_1.localEulerAngles.z = 0
				var_280_1.localEulerAngles.x = 0
				var_280_1.localEulerAngles = var_280_1.localEulerAngles
			end

			local var_280_3 = arg_277_1.actors_["10145ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect10145ui_story == nil then
				arg_277_1.var_.characterEffect10145ui_story = var_280_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_4 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 and not isNil(var_280_3) then
				if arg_277_1.var_.characterEffect10145ui_story and not isNil(var_280_3) then
					arg_277_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect10145ui_story then
				arg_277_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.85

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(421061066)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 34 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 34)

				if (34 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 34)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061066", "story_v_out_421061.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061066", "story_v_out_421061.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_421061", "421061066", "story_v_out_421061.awb")

						arg_277_1:RecordAudio("421061066", var_280_13)
						arg_277_1:RecordAudio("421061066", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_421061", "421061066", "story_v_out_421061.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_421061", "421061066", "story_v_out_421061.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play421061067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 421061067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play421061068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_9000

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10145ui_story = arg_281_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10145ui_story"].transform.position).z)
				arg_281_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10145ui_story"].transform.localEulerAngles = arg_281_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10145ui_story"].transform.position).z)
				arg_281_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10145ui_story"].transform.localEulerAngles = arg_281_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0.633333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 0.633333333333333 + arg_284_0 then
				local var_284_1 = arg_281_1.var_.effect1061

				if not arg_281_1.var_.effect1061 then
					var_284_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_284_1.name = "1061"
					arg_281_1.var_.effect1061 = var_284_1
				else
					var_284_1.transform:SetParent(var_284_9000)
				end

				var_284_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_284_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.43333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 2.43333333333333 + arg_284_0 then
				if arg_281_1.var_.effect1061 then
					Object.Destroy(arg_281_1.var_.effect1061)

					arg_281_1.var_.effect1061 = nil
				end
			end

			local var_284_4 = manager.ui.mainCamera.transform

			if 0.633333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 0.633333333333333 + arg_284_0 then
				arg_281_1.var_.shakeOldPos = var_284_4.localPosition
			end

			local var_284_5 = 0.666666666666667

			if 0.633333333333333 <= arg_281_1.time_ and arg_281_1.time_ < 0.633333333333333 + var_284_5 then
				local var_284_6, var_284_7 = math.modf((arg_281_1.time_ - 0.633333333333333) / 0.066)

				var_284_4.localPosition = Vector3.New(var_284_7 * 0.13, var_284_7 * 0.13, var_284_7 * 0.13) + arg_281_1.var_.shakeOldPos
			end

			if arg_281_1.time_ >= 0.633333333333333 + var_284_5 and arg_281_1.time_ < 0.633333333333333 + var_284_5 + arg_284_0 then
				var_284_4.localPosition = arg_281_1.var_.shakeOldPos
			end

			if 0.633333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 0.633333333333333 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			local var_284_9 = 0
			local var_284_10 = 1.2

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_11 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(421061067).content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 48 <= 0 and var_284_10 or var_284_10 * (utf8.len(var_284_11) / 48)

				if (48 <= 0 and var_284_10 or var_284_10 * (utf8.len(var_284_11) / 48)) > 0 and var_284_10 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_9 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_9
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_10, arg_281_1.talkMaxDuration)

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_9) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_9 + var_284_14 and arg_281_1.time_ < var_284_9 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play421061068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421061068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play421061069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.525

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(421061068).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 21 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 21)

				if (21 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 21)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play421061069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421061069
		arg_289_1.duration_ = 7.13

		local var_289_0 = {
			zh = 4.8,
			ja = 7.133
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play421061070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10102ui_story = arg_289_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).z)
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles = arg_289_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_289_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).z)
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles = arg_289_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["10102ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10102ui_story == nil then
				arg_289_1.var_.characterEffect10102ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect10102ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10102ui_story then
				arg_289_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.7

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(421061069)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 28 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 28)

				if (28 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 28)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061069", "story_v_out_421061.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061069", "story_v_out_421061.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_421061", "421061069", "story_v_out_421061.awb")

						arg_289_1:RecordAudio("421061069", var_292_11)
						arg_289_1:RecordAudio("421061069", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421061", "421061069", "story_v_out_421061.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421061", "421061069", "story_v_out_421061.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play421061070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421061070
		arg_293_1.duration_ = 3.8

		local var_293_0 = {
			zh = 3.366,
			ja = 3.8
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play421061071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10145ui_story = arg_293_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).z)
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles = arg_293_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_293_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).z)
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles = arg_293_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["10145ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10145ui_story == nil then
				arg_293_1.var_.characterEffect10145ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect10145ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10145ui_story then
				arg_293_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["10102ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect10102ui_story == nil then
				arg_293_1.var_.characterEffect10102ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_5 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 and not isNil(var_296_4) then
				if arg_293_1.var_.characterEffect10102ui_story and not isNil(var_296_4) then
					arg_293_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_5)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect10102ui_story then
				arg_293_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_296_6 = 0
			local var_296_7 = 0.425

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(421061070)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 17 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 17)

				if (17 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 17)) > 0 and var_296_7 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061070", "story_v_out_421061.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061070", "story_v_out_421061.awb") / 1000

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end

					if var_296_8.prefab_name ~= "" and arg_293_1.actors_[var_296_8.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_8.prefab_name].transform, "story_v_out_421061", "421061070", "story_v_out_421061.awb")

						arg_293_1:RecordAudio("421061070", var_296_13)
						arg_293_1:RecordAudio("421061070", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_421061", "421061070", "story_v_out_421061.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_421061", "421061070", "story_v_out_421061.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play421061071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421061071
		arg_297_1.duration_ = 15.23

		local var_297_0 = {
			zh = 8.233,
			ja = 15.233
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421061072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10102ui_story = arg_297_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10102ui_story"].transform.position).z)
				arg_297_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10102ui_story"].transform.localEulerAngles = arg_297_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_297_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10102ui_story"].transform.position).z)
				arg_297_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10102ui_story"].transform.localEulerAngles = arg_297_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["10102ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect10102ui_story == nil then
				arg_297_1.var_.characterEffect10102ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect10102ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect10102ui_story then
				arg_297_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["10145ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10145ui_story == nil then
				arg_297_1.var_.characterEffect10145ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_5 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 and not isNil(var_300_4) then
				if arg_297_1.var_.characterEffect10145ui_story and not isNil(var_300_4) then
					arg_297_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_5)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10145ui_story then
				arg_297_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_300_6 = 0
			local var_300_7 = 0.925

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(421061071)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 37 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 37)

				if (37 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 37)) > 0 and var_300_7 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061071", "story_v_out_421061.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061071", "story_v_out_421061.awb") / 1000

					if var_300_12 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_6
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_421061", "421061071", "story_v_out_421061.awb")

						arg_297_1:RecordAudio("421061071", var_300_13)
						arg_297_1:RecordAudio("421061071", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_421061", "421061071", "story_v_out_421061.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_421061", "421061071", "story_v_out_421061.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play421061072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 421061072
		arg_301_1.duration_ = 3.5

		local var_301_0 = {
			zh = 2.633,
			ja = 3.5
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play421061073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10145ui_story = arg_301_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10145ui_story"].transform.position).z)
				arg_301_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["10145ui_story"].transform.localEulerAngles = arg_301_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_301_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10145ui_story"].transform.position).z)
				arg_301_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["10145ui_story"].transform.localEulerAngles = arg_301_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["10145ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect10145ui_story == nil then
				arg_301_1.var_.characterEffect10145ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect10145ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect10145ui_story then
				arg_301_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_304_4 = arg_301_1.actors_["10102ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10102ui_story == nil then
				arg_301_1.var_.characterEffect10102ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_5 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_5 and not isNil(var_304_4) then
				if arg_301_1.var_.characterEffect10102ui_story and not isNil(var_304_4) then
					arg_301_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_5)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_5 and arg_301_1.time_ < 0 + var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10102ui_story then
				arg_301_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_304_6 = 0
			local var_304_7 = 0.325

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_8 = arg_301_1:GetWordFromCfg(421061072)
				local var_304_9 = arg_301_1:FormatText(var_304_8.content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 13 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 13)

				if (13 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 13)) > 0 and var_304_7 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061072", "story_v_out_421061.awb") ~= 0 then
					local var_304_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061072", "story_v_out_421061.awb") / 1000

					if var_304_12 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_6
					end

					if var_304_8.prefab_name ~= "" and arg_301_1.actors_[var_304_8.prefab_name] ~= nil then
						local var_304_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_8.prefab_name].transform, "story_v_out_421061", "421061072", "story_v_out_421061.awb")

						arg_301_1:RecordAudio("421061072", var_304_13)
						arg_301_1:RecordAudio("421061072", var_304_13)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_421061", "421061072", "story_v_out_421061.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_421061", "421061072", "story_v_out_421061.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play421061073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 421061073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play421061074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["10145ui_story"]) and arg_305_1.var_.characterEffect10145ui_story == nil then
				arg_305_1.var_.characterEffect10145ui_story = arg_305_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["10145ui_story"]) then
				if arg_305_1.var_.characterEffect10145ui_story and not isNil(arg_305_1.actors_["10145ui_story"]) then
					arg_305_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["10145ui_story"]) and arg_305_1.var_.characterEffect10145ui_story then
				arg_305_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.175

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(421061073).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 7 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 7)

				if (7 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 7)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play421061074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 421061074
		arg_309_1.duration_ = 6.03

		local var_309_0 = {
			zh = 5.833333333332,
			ja = 6.033
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play421061075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 2 < arg_309_1.time_ and arg_309_1.time_ <= 2 + arg_312_0 then
				local var_312_0 = arg_309_1.bgs_.ST21

				arg_309_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_312_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_312_1 = var_312_0:GetComponent("SpriteRenderer")

				if var_312_1 and var_312_1.sprite then
					local var_312_2 = 2 * (var_312_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_312_0.transform.localScale = Vector3.New(var_312_2 / var_312_1.sprite.bounds.size.y < var_312_2 * manager.ui.mainCameraCom_.aspect / var_312_1.sprite.bounds.size.x and var_312_2 * manager.ui.mainCameraCom_.aspect / var_312_1.sprite.bounds.size.x or var_312_2 / var_312_1.sprite.bounds.size.y, var_312_2 / var_312_1.sprite.bounds.size.y < var_312_2 * manager.ui.mainCameraCom_.aspect / var_312_1.sprite.bounds.size.x and var_312_2 * manager.ui.mainCameraCom_.aspect / var_312_1.sprite.bounds.size.x or var_312_2 / var_312_1.sprite.bounds.size.y, 0)
				end

				for iter_312_0, iter_312_1 in pairs(arg_309_1.bgs_) do
					if iter_312_0 ~= "ST21" then
						iter_312_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_312_3 = 4

			if 4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			if arg_309_1.time_ >= var_312_3 + 0.0999999999999996 and arg_309_1.time_ < var_312_3 + 0.0999999999999996 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end

			local var_312_4 = 0

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_5 = 2

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_5 then
				local var_312_6 = Color.New(0, 0, 0)

				var_312_6.a = Mathf.Lerp(0, 1, (arg_309_1.time_ - var_312_4) / var_312_5)
				arg_309_1.mask_.color = var_312_6
			end

			if arg_309_1.time_ >= var_312_4 + var_312_5 and arg_309_1.time_ < var_312_4 + var_312_5 + arg_312_0 then
				local var_312_7 = Color.New(0, 0, 0)

				var_312_7.a = 1
				arg_309_1.mask_.color = var_312_7
			end

			local var_312_8 = 2

			if 2 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_9 = 2

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_9 then
				local var_312_10 = Color.New(0, 0, 0)

				var_312_10.a = Mathf.Lerp(1, 0, (arg_309_1.time_ - var_312_8) / var_312_9)
				arg_309_1.mask_.color = var_312_10
			end

			if arg_309_1.time_ >= var_312_8 + var_312_9 and arg_309_1.time_ < var_312_8 + var_312_9 + arg_312_0 then
				local var_312_11 = Color.New(0, 0, 0)

				arg_309_1.mask_.enabled = false
				var_312_11.a = 0
				arg_309_1.mask_.color = var_312_11
			end

			local var_312_12 = arg_309_1.actors_["10102ui_story"].transform

			if 2 < arg_309_1.time_ and arg_309_1.time_ <= 2 + arg_312_0 then
				arg_309_1.var_.moveOldPos10102ui_story = var_312_12.localPosition
			end

			local var_312_13 = 0.001

			if 2 <= arg_309_1.time_ and arg_309_1.time_ < 2 + var_312_13 then
				var_312_12.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 2) / var_312_13)
				var_312_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_12.position).x, (manager.ui.mainCamera.transform.position - var_312_12.position).y, (manager.ui.mainCamera.transform.position - var_312_12.position).z)
				var_312_12.localEulerAngles.z = 0
				var_312_12.localEulerAngles.x = 0
				var_312_12.localEulerAngles = var_312_12.localEulerAngles
			end

			if arg_309_1.time_ >= 2 + var_312_13 and arg_309_1.time_ < 2 + var_312_13 + arg_312_0 then
				var_312_12.localPosition = Vector3.New(0, 100, 0)
				var_312_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_12.position).x, (manager.ui.mainCamera.transform.position - var_312_12.position).y, (manager.ui.mainCamera.transform.position - var_312_12.position).z)
				var_312_12.localEulerAngles.z = 0
				var_312_12.localEulerAngles.x = 0
				var_312_12.localEulerAngles = var_312_12.localEulerAngles
			end

			local var_312_14 = arg_309_1.actors_["10145ui_story"].transform

			if 2 < arg_309_1.time_ and arg_309_1.time_ <= 2 + arg_312_0 then
				arg_309_1.var_.moveOldPos10145ui_story = var_312_14.localPosition
			end

			local var_312_15 = 0.001

			if 2 <= arg_309_1.time_ and arg_309_1.time_ < 2 + var_312_15 then
				var_312_14.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 2) / var_312_15)
				var_312_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_14.position).x, (manager.ui.mainCamera.transform.position - var_312_14.position).y, (manager.ui.mainCamera.transform.position - var_312_14.position).z)
				var_312_14.localEulerAngles.z = 0
				var_312_14.localEulerAngles.x = 0
				var_312_14.localEulerAngles = var_312_14.localEulerAngles
			end

			if arg_309_1.time_ >= 2 + var_312_15 and arg_309_1.time_ < 2 + var_312_15 + arg_312_0 then
				var_312_14.localPosition = Vector3.New(0, 100, 0)
				var_312_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_14.position).x, (manager.ui.mainCamera.transform.position - var_312_14.position).y, (manager.ui.mainCamera.transform.position - var_312_14.position).z)
				var_312_14.localEulerAngles.z = 0
				var_312_14.localEulerAngles.x = 0
				var_312_14.localEulerAngles = var_312_14.localEulerAngles
			end

			local var_312_16 = arg_309_1.actors_["1047ui_story"].transform

			if 3.83333333333333 < arg_309_1.time_ and arg_309_1.time_ <= 3.83333333333333 + arg_312_0 then
				arg_309_1.var_.moveOldPos1047ui_story = var_312_16.localPosition
			end

			local var_312_17 = 0.001

			if 3.83333333333333 <= arg_309_1.time_ and arg_309_1.time_ < 3.83333333333333 + var_312_17 then
				var_312_16.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_309_1.time_ - 3.83333333333333) / var_312_17)
				var_312_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_16.position).x, (manager.ui.mainCamera.transform.position - var_312_16.position).y, (manager.ui.mainCamera.transform.position - var_312_16.position).z)
				var_312_16.localEulerAngles.z = 0
				var_312_16.localEulerAngles.x = 0
				var_312_16.localEulerAngles = var_312_16.localEulerAngles
			end

			if arg_309_1.time_ >= 3.83333333333333 + var_312_17 and arg_309_1.time_ < 3.83333333333333 + var_312_17 + arg_312_0 then
				var_312_16.localPosition = Vector3.New(0, -1.13, -6.2)
				var_312_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_16.position).x, (manager.ui.mainCamera.transform.position - var_312_16.position).y, (manager.ui.mainCamera.transform.position - var_312_16.position).z)
				var_312_16.localEulerAngles.z = 0
				var_312_16.localEulerAngles.x = 0
				var_312_16.localEulerAngles = var_312_16.localEulerAngles
			end

			local var_312_18 = arg_309_1.actors_["1047ui_story"]

			if 3.83333333333333 < arg_309_1.time_ and arg_309_1.time_ <= 3.83333333333333 + arg_312_0 and not isNil(var_312_18) and arg_309_1.var_.characterEffect1047ui_story == nil then
				arg_309_1.var_.characterEffect1047ui_story = var_312_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_19 = 0.200000002980232

			if 3.83333333333333 <= arg_309_1.time_ and arg_309_1.time_ < 3.83333333333333 + var_312_19 and not isNil(var_312_18) then
				if arg_309_1.var_.characterEffect1047ui_story and not isNil(var_312_18) then
					arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 3.83333333333333 + var_312_19 and arg_309_1.time_ < 3.83333333333333 + var_312_19 + arg_312_0 and not isNil(var_312_18) and arg_309_1.var_.characterEffect1047ui_story then
				arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_309_1.time_ and arg_309_1.time_ <= 3.83333333333333 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 3.83333333333333 < arg_309_1.time_ and arg_309_1.time_ <= 3.83333333333333 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_309_1.time_ and arg_309_1.time_ <= 0.1 + arg_312_0 then
				arg_309_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.5 < arg_309_1.time_ and arg_309_1.time_ <= 1.5 + arg_312_0 then
				arg_309_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_309_1.frameCnt_ <= 1 then
				arg_309_1.dialog_:SetActive(false)
			end

			local var_312_23 = 4
			local var_312_24 = 0.175

			if 4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0

				arg_309_1.dialog_:SetActive(true)

				arg_309_1.dialogCg_.alpha = 0

				local var_312_25 = LeanTween.value(arg_309_1.dialog_, 0, 1, 0.3)

				var_312_25:setOnUpdate(LuaHelper.FloatAction(function(arg_313_0)
					arg_309_1.dialogCg_.alpha = arg_313_0
				end))
				var_312_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_309_1.dialog_)
					var_312_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_309_1.duration_ = arg_309_1.duration_ + 0.3

				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_26 = arg_309_1:GetWordFromCfg(421061074)
				local var_312_27 = arg_309_1:FormatText(var_312_26.content)

				arg_309_1.text_.text = var_312_27

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_29 = 7 <= 0 and var_312_24 or var_312_24 * (utf8.len(var_312_27) / 7)

				if (7 <= 0 and var_312_24 or var_312_24 * (utf8.len(var_312_27) / 7)) > 0 and var_312_24 < var_312_29 then
					arg_309_1.talkMaxDuration = var_312_29
					var_312_23 = var_312_23 + 0.3

					if var_312_29 + var_312_23 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_29 + var_312_23
					end
				end

				arg_309_1.text_.text = var_312_27
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061074", "story_v_out_421061.awb") ~= 0 then
					local var_312_30 = manager.audio:GetVoiceLength("story_v_out_421061", "421061074", "story_v_out_421061.awb") / 1000

					if var_312_30 + var_312_23 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_30 + var_312_23
					end

					if var_312_26.prefab_name ~= "" and arg_309_1.actors_[var_312_26.prefab_name] ~= nil then
						local var_312_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_26.prefab_name].transform, "story_v_out_421061", "421061074", "story_v_out_421061.awb")

						arg_309_1:RecordAudio("421061074", var_312_31)
						arg_309_1:RecordAudio("421061074", var_312_31)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_421061", "421061074", "story_v_out_421061.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_421061", "421061074", "story_v_out_421061.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_32 = var_312_23 + 0.3
			local var_312_33 = math.max(var_312_24, arg_309_1.talkMaxDuration)

			if var_312_23 + 0.3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_32 + var_312_33 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_32) / var_312_33

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_32 + var_312_33 and arg_309_1.time_ < var_312_32 + var_312_33 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play421061075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 421061075
		arg_315_1.duration_ = 1.7

		local var_315_0 = {
			zh = 1.533,
			ja = 1.7
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play421061076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1047ui_story"]) and arg_315_1.var_.characterEffect1047ui_story == nil then
				arg_315_1.var_.characterEffect1047ui_story = arg_315_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1047ui_story"]) then
				if arg_315_1.var_.characterEffect1047ui_story and not isNil(arg_315_1.actors_["1047ui_story"]) then
					arg_315_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1047ui_story"]) and arg_315_1.var_.characterEffect1047ui_story then
				arg_315_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.175

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:GetWordFromCfg(421061075)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_6 = 7 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_4) / 7)

				if (7 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_4) / 7)) > 0 and var_318_2 < var_318_6 then
					arg_315_1.talkMaxDuration = var_318_6

					if var_318_6 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_6 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061075", "story_v_out_421061.awb") ~= 0 then
					local var_318_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061075", "story_v_out_421061.awb") / 1000

					if var_318_7 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_1
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_421061", "421061075", "story_v_out_421061.awb")

						arg_315_1:RecordAudio("421061075", var_318_8)
						arg_315_1:RecordAudio("421061075", var_318_8)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_421061", "421061075", "story_v_out_421061.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_421061", "421061075", "story_v_out_421061.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_9 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_9 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_9

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_9 and arg_315_1.time_ < var_318_1 + var_318_9 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play421061076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 421061076
		arg_319_1.duration_ = 8.8

		local var_319_0 = {
			zh = 8.533,
			ja = 8.8
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play421061077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1047ui_story = arg_319_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1047ui_story"].transform.position).z)
				arg_319_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1047ui_story"].transform.localEulerAngles = arg_319_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_319_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1047ui_story"].transform.position).z)
				arg_319_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1047ui_story"].transform.localEulerAngles = arg_319_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1047ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1047ui_story == nil then
				arg_319_1.var_.characterEffect1047ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1047ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1047ui_story then
				arg_319_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_322_4 = 0
			local var_322_5 = 0.925

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(421061076)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 37 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 37)

				if (37 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 37)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061076", "story_v_out_421061.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061076", "story_v_out_421061.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_421061", "421061076", "story_v_out_421061.awb")

						arg_319_1:RecordAudio("421061076", var_322_11)
						arg_319_1:RecordAudio("421061076", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_421061", "421061076", "story_v_out_421061.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_421061", "421061076", "story_v_out_421061.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play421061077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 421061077
		arg_323_1.duration_ = 7.67

		local var_323_0 = {
			zh = 7.666,
			ja = 7.633
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play421061078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1047ui_story"]) and arg_323_1.var_.characterEffect1047ui_story == nil then
				arg_323_1.var_.characterEffect1047ui_story = arg_323_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1047ui_story"]) then
				if arg_323_1.var_.characterEffect1047ui_story and not isNil(arg_323_1.actors_["1047ui_story"]) then
					arg_323_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1047ui_story"]) and arg_323_1.var_.characterEffect1047ui_story then
				arg_323_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.675

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:GetWordFromCfg(421061077)
				local var_326_4 = arg_323_1:FormatText(var_326_3.content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_6 = 27 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_4) / 27)

				if (27 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_4) / 27)) > 0 and var_326_2 < var_326_6 then
					arg_323_1.talkMaxDuration = var_326_6

					if var_326_6 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_6 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_4
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061077", "story_v_out_421061.awb") ~= 0 then
					local var_326_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061077", "story_v_out_421061.awb") / 1000

					if var_326_7 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_1
					end

					if var_326_3.prefab_name ~= "" and arg_323_1.actors_[var_326_3.prefab_name] ~= nil then
						local var_326_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_3.prefab_name].transform, "story_v_out_421061", "421061077", "story_v_out_421061.awb")

						arg_323_1:RecordAudio("421061077", var_326_8)
						arg_323_1:RecordAudio("421061077", var_326_8)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_421061", "421061077", "story_v_out_421061.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_421061", "421061077", "story_v_out_421061.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_9 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_9 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_9

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_9 and arg_323_1.time_ < var_326_1 + var_326_9 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play421061078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 421061078
		arg_327_1.duration_ = 5.1

		local var_327_0 = {
			zh = 3.166,
			ja = 5.1
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play421061079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1047ui_story = arg_327_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1047ui_story"].transform.position).z)
				arg_327_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1047ui_story"].transform.localEulerAngles = arg_327_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_327_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1047ui_story"].transform.position).z)
				arg_327_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1047ui_story"].transform.localEulerAngles = arg_327_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["1047ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1047ui_story == nil then
				arg_327_1.var_.characterEffect1047ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect1047ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1047ui_story then
				arg_327_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_330_4 = 0
			local var_330_5 = 0.525

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(421061078)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 11 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 11)

				if (11 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 11)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061078", "story_v_out_421061.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061078", "story_v_out_421061.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_421061", "421061078", "story_v_out_421061.awb")

						arg_327_1:RecordAudio("421061078", var_330_11)
						arg_327_1:RecordAudio("421061078", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_421061", "421061078", "story_v_out_421061.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_421061", "421061078", "story_v_out_421061.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play421061079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 421061079
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play421061080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1047ui_story = arg_331_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).z)
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles = arg_331_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).z)
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles = arg_331_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.6 < arg_331_1.time_ and arg_331_1.time_ <= 0.6 + arg_334_0 then
				arg_331_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_toy_hit", "")
			end

			local var_334_2 = 0
			local var_334_3 = 1.425

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(421061079).content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_6 = 57 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_4) / 57)

				if (57 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_4) / 57)) > 0 and var_334_3 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_2
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_3, arg_331_1.talkMaxDuration)

			if var_334_2 <= arg_331_1.time_ and arg_331_1.time_ < var_334_2 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_2) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_2 + var_334_7 and arg_331_1.time_ < var_334_2 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play421061080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 421061080
		arg_335_1.duration_ = 6.53

		local var_335_0 = {
			zh = 3.9,
			ja = 6.533
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play421061081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.35

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:GetWordFromCfg(421061080)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 14 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 14)

				if (14 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 14)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061080", "story_v_out_421061.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061080", "story_v_out_421061.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_421061", "421061080", "story_v_out_421061.awb")

						arg_335_1:RecordAudio("421061080", var_338_6)
						arg_335_1:RecordAudio("421061080", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_421061", "421061080", "story_v_out_421061.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_421061", "421061080", "story_v_out_421061.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play421061081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 421061081
		arg_339_1.duration_ = 7.63

		local var_339_0 = {
			zh = 4.766,
			ja = 7.633
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play421061082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1047ui_story = arg_339_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).z)
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles = arg_339_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_339_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).z)
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles = arg_339_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1047ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1047ui_story == nil then
				arg_339_1.var_.characterEffect1047ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1047ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1047ui_story then
				arg_339_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_342_4 = 0
			local var_342_5 = 0.525

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(421061081)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 21 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 21)

				if (21 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 21)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061081", "story_v_out_421061.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061081", "story_v_out_421061.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_421061", "421061081", "story_v_out_421061.awb")

						arg_339_1:RecordAudio("421061081", var_342_11)
						arg_339_1:RecordAudio("421061081", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_421061", "421061081", "story_v_out_421061.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_421061", "421061081", "story_v_out_421061.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play421061082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 421061082
		arg_343_1.duration_ = 9.03

		local var_343_0 = {
			zh = 7.2,
			ja = 9.033
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play421061083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.875

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(421061082)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 35 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 35)

				if (35 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 35)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061082", "story_v_out_421061.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061082", "story_v_out_421061.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_421061", "421061082", "story_v_out_421061.awb")

						arg_343_1:RecordAudio("421061082", var_346_6)
						arg_343_1:RecordAudio("421061082", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_421061", "421061082", "story_v_out_421061.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_421061", "421061082", "story_v_out_421061.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play421061083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 421061083
		arg_347_1.duration_ = 6.57

		local var_347_0 = {
			zh = 3.466,
			ja = 6.566
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play421061084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1047ui_story = arg_347_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1047ui_story"].transform.position).z)
				arg_347_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1047ui_story"].transform.localEulerAngles = arg_347_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_347_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1047ui_story"].transform.position).z)
				arg_347_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1047ui_story"].transform.localEulerAngles = arg_347_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_350_1 = 0
			local var_350_2 = 0.325

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:GetWordFromCfg(421061083)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_6 = 13 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_4) / 13)

				if (13 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_4) / 13)) > 0 and var_350_2 < var_350_6 then
					arg_347_1.talkMaxDuration = var_350_6

					if var_350_6 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_6 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061083", "story_v_out_421061.awb") ~= 0 then
					local var_350_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061083", "story_v_out_421061.awb") / 1000

					if var_350_7 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_1
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_421061", "421061083", "story_v_out_421061.awb")

						arg_347_1:RecordAudio("421061083", var_350_8)
						arg_347_1:RecordAudio("421061083", var_350_8)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_421061", "421061083", "story_v_out_421061.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_421061", "421061083", "story_v_out_421061.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_9 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_9 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_9

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_9 and arg_347_1.time_ < var_350_1 + var_350_9 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play421061084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 421061084
		arg_351_1.duration_ = 3.23

		local var_351_0 = {
			zh = 3.033,
			ja = 3.233
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play421061085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1047ui_story"]) and arg_351_1.var_.characterEffect1047ui_story == nil then
				arg_351_1.var_.characterEffect1047ui_story = arg_351_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1047ui_story"]) then
				if arg_351_1.var_.characterEffect1047ui_story and not isNil(arg_351_1.actors_["1047ui_story"]) then
					arg_351_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1047ui_story"]) and arg_351_1.var_.characterEffect1047ui_story then
				arg_351_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.25

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(421061084)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 10 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 10)

				if (10 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 10)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061084", "story_v_out_421061.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061084", "story_v_out_421061.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_421061", "421061084", "story_v_out_421061.awb")

						arg_351_1:RecordAudio("421061084", var_354_8)
						arg_351_1:RecordAudio("421061084", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_421061", "421061084", "story_v_out_421061.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_421061", "421061084", "story_v_out_421061.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play421061085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 421061085
		arg_355_1.duration_ = 13.53

		local var_355_0 = {
			zh = 7.9,
			ja = 13.533
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play421061086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1047ui_story = arg_355_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1047ui_story"].transform.position).z)
				arg_355_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1047ui_story"].transform.localEulerAngles = arg_355_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_355_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1047ui_story"].transform.position).z)
				arg_355_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1047ui_story"].transform.localEulerAngles = arg_355_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["1047ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1047ui_story == nil then
				arg_355_1.var_.characterEffect1047ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1047ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1047ui_story then
				arg_355_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_358_4 = 0
			local var_358_5 = 0.95

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(421061085)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 38 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 38)

				if (38 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 38)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061085", "story_v_out_421061.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061085", "story_v_out_421061.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_421061", "421061085", "story_v_out_421061.awb")

						arg_355_1:RecordAudio("421061085", var_358_11)
						arg_355_1:RecordAudio("421061085", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_421061", "421061085", "story_v_out_421061.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_421061", "421061085", "story_v_out_421061.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play421061086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 421061086
		arg_359_1.duration_ = 3.6

		local var_359_0 = {
			zh = 3.6,
			ja = 3.466
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play421061087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1047ui_story"]) and arg_359_1.var_.characterEffect1047ui_story == nil then
				arg_359_1.var_.characterEffect1047ui_story = arg_359_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1047ui_story"]) then
				if arg_359_1.var_.characterEffect1047ui_story and not isNil(arg_359_1.actors_["1047ui_story"]) then
					arg_359_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1047ui_story"]) and arg_359_1.var_.characterEffect1047ui_story then
				arg_359_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_362_1 = 0
			local var_362_2 = 0.3

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:GetWordFromCfg(421061086)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_6 = 12 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_4) / 12)

				if (12 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_4) / 12)) > 0 and var_362_2 < var_362_6 then
					arg_359_1.talkMaxDuration = var_362_6

					if var_362_6 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061086", "story_v_out_421061.awb") ~= 0 then
					local var_362_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061086", "story_v_out_421061.awb") / 1000

					if var_362_7 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_1
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_421061", "421061086", "story_v_out_421061.awb")

						arg_359_1:RecordAudio("421061086", var_362_8)
						arg_359_1:RecordAudio("421061086", var_362_8)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_421061", "421061086", "story_v_out_421061.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_421061", "421061086", "story_v_out_421061.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_9 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_9 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_9

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_9 and arg_359_1.time_ < var_362_1 + var_362_9 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play421061087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 421061087
		arg_363_1.duration_ = 2

		local var_363_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play421061088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1047ui_story = arg_363_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).z)
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles = arg_363_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_363_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).z)
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles = arg_363_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["1047ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1047ui_story == nil then
				arg_363_1.var_.characterEffect1047ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect1047ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1047ui_story then
				arg_363_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_366_4 = 0
			local var_366_5 = 0.2

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(421061087)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 8 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 8)

				if (8 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 8)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061087", "story_v_out_421061.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061087", "story_v_out_421061.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_421061", "421061087", "story_v_out_421061.awb")

						arg_363_1:RecordAudio("421061087", var_366_11)
						arg_363_1:RecordAudio("421061087", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_421061", "421061087", "story_v_out_421061.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_421061", "421061087", "story_v_out_421061.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play421061088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 421061088
		arg_367_1.duration_ = 7.13

		local var_367_0 = {
			zh = 6.366,
			ja = 7.133
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play421061089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1047ui_story"]) and arg_367_1.var_.characterEffect1047ui_story == nil then
				arg_367_1.var_.characterEffect1047ui_story = arg_367_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1047ui_story"]) then
				if arg_367_1.var_.characterEffect1047ui_story and not isNil(arg_367_1.actors_["1047ui_story"]) then
					arg_367_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1047ui_story"]) and arg_367_1.var_.characterEffect1047ui_story then
				arg_367_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.6

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(421061088)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_6 = 24 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 24)

				if (24 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 24)) > 0 and var_370_2 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061088", "story_v_out_421061.awb") ~= 0 then
					local var_370_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061088", "story_v_out_421061.awb") / 1000

					if var_370_7 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_1
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_out_421061", "421061088", "story_v_out_421061.awb")

						arg_367_1:RecordAudio("421061088", var_370_8)
						arg_367_1:RecordAudio("421061088", var_370_8)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_421061", "421061088", "story_v_out_421061.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_421061", "421061088", "story_v_out_421061.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_9 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_9 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_9

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_9 and arg_367_1.time_ < var_370_1 + var_370_9 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play421061089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 421061089
		arg_371_1.duration_ = 7.37

		local var_371_0 = {
			zh = 5.066,
			ja = 7.366
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play421061090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1047ui_story = arg_371_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).z)
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles = arg_371_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_371_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).z)
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles = arg_371_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1047ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1047ui_story == nil then
				arg_371_1.var_.characterEffect1047ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1047ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1047ui_story then
				arg_371_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_374_4 = 0
			local var_374_5 = 0.525

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(421061089)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 21 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 21)

				if (21 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 21)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061089", "story_v_out_421061.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061089", "story_v_out_421061.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_421061", "421061089", "story_v_out_421061.awb")

						arg_371_1:RecordAudio("421061089", var_374_11)
						arg_371_1:RecordAudio("421061089", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_421061", "421061089", "story_v_out_421061.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_421061", "421061089", "story_v_out_421061.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play421061090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 421061090
		arg_375_1.duration_ = 11.3

		local var_375_0 = {
			zh = 11.3,
			ja = 8.4
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play421061091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1047ui_story"]) and arg_375_1.var_.characterEffect1047ui_story == nil then
				arg_375_1.var_.characterEffect1047ui_story = arg_375_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1047ui_story"]) then
				if arg_375_1.var_.characterEffect1047ui_story and not isNil(arg_375_1.actors_["1047ui_story"]) then
					arg_375_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_0)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1047ui_story"]) and arg_375_1.var_.characterEffect1047ui_story then
				arg_375_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_378_1 = 0
			local var_378_2 = 1.225

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:GetWordFromCfg(421061090)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_6 = 49 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_4) / 49)

				if (49 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_4) / 49)) > 0 and var_378_2 < var_378_6 then
					arg_375_1.talkMaxDuration = var_378_6

					if var_378_6 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061090", "story_v_out_421061.awb") ~= 0 then
					local var_378_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061090", "story_v_out_421061.awb") / 1000

					if var_378_7 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_1
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_out_421061", "421061090", "story_v_out_421061.awb")

						arg_375_1:RecordAudio("421061090", var_378_8)
						arg_375_1:RecordAudio("421061090", var_378_8)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_421061", "421061090", "story_v_out_421061.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_421061", "421061090", "story_v_out_421061.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_9 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_9 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_9

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_9 and arg_375_1.time_ < var_378_1 + var_378_9 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play421061091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 421061091
		arg_379_1.duration_ = 5.9

		local var_379_0 = {
			zh = 4.933,
			ja = 5.9
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play421061092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.45

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:GetWordFromCfg(421061091)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 18 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 18)

				if (18 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 18)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061091", "story_v_out_421061.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_out_421061", "421061091", "story_v_out_421061.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_out_421061", "421061091", "story_v_out_421061.awb")

						arg_379_1:RecordAudio("421061091", var_382_6)
						arg_379_1:RecordAudio("421061091", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_421061", "421061091", "story_v_out_421061.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_421061", "421061091", "story_v_out_421061.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play421061092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 421061092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play421061093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1047ui_story = arg_383_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1047ui_story"].transform.position).z)
				arg_383_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1047ui_story"].transform.localEulerAngles = arg_383_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1047ui_story"].transform.position).z)
				arg_383_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1047ui_story"].transform.localEulerAngles = arg_383_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_386_1 = 0
			local var_386_2 = 1.375

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(421061092).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 55 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 55)

				if (55 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 55)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play421061093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 421061093
		arg_387_1.duration_ = 6.23

		local var_387_0 = {
			zh = 5.233,
			ja = 6.233
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play421061094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1047ui_story = arg_387_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).z)
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles = arg_387_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_387_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).z)
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles = arg_387_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["1047ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1047ui_story == nil then
				arg_387_1.var_.characterEffect1047ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1047ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1047ui_story then
				arg_387_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_390_4 = 0
			local var_390_5 = 0.6

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_6 = arg_387_1:GetWordFromCfg(421061093)
				local var_390_7 = arg_387_1:FormatText(var_390_6.content)

				arg_387_1.text_.text = var_390_7

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 24 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 24)

				if (24 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 24)) > 0 and var_390_5 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_7
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061093", "story_v_out_421061.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_out_421061", "421061093", "story_v_out_421061.awb") / 1000

					if var_390_10 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_4
					end

					if var_390_6.prefab_name ~= "" and arg_387_1.actors_[var_390_6.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_6.prefab_name].transform, "story_v_out_421061", "421061093", "story_v_out_421061.awb")

						arg_387_1:RecordAudio("421061093", var_390_11)
						arg_387_1:RecordAudio("421061093", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_421061", "421061093", "story_v_out_421061.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_421061", "421061093", "story_v_out_421061.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_5, arg_387_1.talkMaxDuration)

			if var_390_4 <= arg_387_1.time_ and arg_387_1.time_ < var_390_4 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_4) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_4 + var_390_12 and arg_387_1.time_ < var_390_4 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play421061094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 421061094
		arg_391_1.duration_ = 2.77

		local var_391_0 = {
			zh = 1.999999999999,
			ja = 2.766
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play421061095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1047ui_story = arg_391_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).z)
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles = arg_391_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_391_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).z)
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles = arg_391_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_394_1 = 0
			local var_394_2 = 0.2

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:GetWordFromCfg(421061094)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_6 = 8 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_4) / 8)

				if (8 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_4) / 8)) > 0 and var_394_2 < var_394_6 then
					arg_391_1.talkMaxDuration = var_394_6

					if var_394_6 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_6 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061094", "story_v_out_421061.awb") ~= 0 then
					local var_394_7 = manager.audio:GetVoiceLength("story_v_out_421061", "421061094", "story_v_out_421061.awb") / 1000

					if var_394_7 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_1
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_421061", "421061094", "story_v_out_421061.awb")

						arg_391_1:RecordAudio("421061094", var_394_8)
						arg_391_1:RecordAudio("421061094", var_394_8)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_421061", "421061094", "story_v_out_421061.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_421061", "421061094", "story_v_out_421061.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_9 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_9 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_9

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_9 and arg_391_1.time_ < var_394_1 + var_394_9 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play421061095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 421061095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play421061096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1047ui_story = arg_395_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1047ui_story"].transform.position).z)
				arg_395_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1047ui_story"].transform.localEulerAngles = arg_395_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1047ui_story"].transform.position).z)
				arg_395_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1047ui_story"].transform.localEulerAngles = arg_395_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1047ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1047ui_story == nil then
				arg_395_1.var_.characterEffect1047ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1047ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_2)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1047ui_story then
				arg_395_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_398_3 = 0
			local var_398_4 = 1.5

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_3 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_5 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(421061095).content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 60 <= 0 and var_398_4 or var_398_4 * (utf8.len(var_398_5) / 60)

				if (60 <= 0 and var_398_4 or var_398_4 * (utf8.len(var_398_5) / 60)) > 0 and var_398_4 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_3 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_3
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_8 = math.max(var_398_4, arg_395_1.talkMaxDuration)

			if var_398_3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_3 + var_398_8 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_3) / var_398_8

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_3 + var_398_8 and arg_395_1.time_ < var_398_3 + var_398_8 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play421061096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 421061096
		arg_399_1.duration_ = 7.17

		local var_399_0 = {
			zh = 6.2,
			ja = 7.166
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play421061097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if arg_399_1.bgs_.L06g == nil then
				local var_402_0 = Object.Instantiate(arg_399_1.paintGo_)

				var_402_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L06g")
				var_402_0.name = "L06g"
				var_402_0.transform.parent = arg_399_1.stage_.transform
				var_402_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.bgs_.L06g = var_402_0
			end

			if 2 < arg_399_1.time_ and arg_399_1.time_ <= 2 + arg_402_0 then
				local var_402_1 = arg_399_1.bgs_.L06g

				arg_399_1.bgs_.L06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_402_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_402_2 = var_402_1:GetComponent("SpriteRenderer")

				if var_402_2 and var_402_2.sprite then
					local var_402_3 = 2 * (var_402_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_402_1.transform.localScale = Vector3.New(var_402_3 / var_402_2.sprite.bounds.size.y < var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x and var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x or var_402_3 / var_402_2.sprite.bounds.size.y, var_402_3 / var_402_2.sprite.bounds.size.y < var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x and var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x or var_402_3 / var_402_2.sprite.bounds.size.y, 0)
				end

				for iter_402_0, iter_402_1 in pairs(arg_399_1.bgs_) do
					if iter_402_0 ~= "L06g" then
						iter_402_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_402_4 = 4

			if 4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.allBtn_.enabled = false
			end

			if arg_399_1.time_ >= var_402_4 + 0.0666666666666664 and arg_399_1.time_ < var_402_4 + 0.0666666666666664 + arg_402_0 then
				arg_399_1.allBtn_.enabled = true
			end

			local var_402_5 = 0

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_6 = 2

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_6 then
				local var_402_7 = Color.New(0, 0, 0)

				var_402_7.a = Mathf.Lerp(0, 1, (arg_399_1.time_ - var_402_5) / var_402_6)
				arg_399_1.mask_.color = var_402_7
			end

			if arg_399_1.time_ >= var_402_5 + var_402_6 and arg_399_1.time_ < var_402_5 + var_402_6 + arg_402_0 then
				local var_402_8 = Color.New(0, 0, 0)

				var_402_8.a = 1
				arg_399_1.mask_.color = var_402_8
			end

			local var_402_9 = 2

			if 2 < arg_399_1.time_ and arg_399_1.time_ <= var_402_9 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_10 = 2

			if var_402_9 <= arg_399_1.time_ and arg_399_1.time_ < var_402_9 + var_402_10 then
				local var_402_11 = Color.New(0, 0, 0)

				var_402_11.a = Mathf.Lerp(1, 0, (arg_399_1.time_ - var_402_9) / var_402_10)
				arg_399_1.mask_.color = var_402_11
			end

			if arg_399_1.time_ >= var_402_9 + var_402_10 and arg_399_1.time_ < var_402_9 + var_402_10 + arg_402_0 then
				local var_402_12 = Color.New(0, 0, 0)

				arg_399_1.mask_.enabled = false
				var_402_12.a = 0
				arg_399_1.mask_.color = var_402_12
			end

			local var_402_13 = arg_399_1.actors_["1047ui_story"].transform

			if 3.76666666666667 < arg_399_1.time_ and arg_399_1.time_ <= 3.76666666666667 + arg_402_0 then
				arg_399_1.var_.moveOldPos1047ui_story = var_402_13.localPosition
			end

			local var_402_14 = 0.001

			if 3.76666666666667 <= arg_399_1.time_ and arg_399_1.time_ < 3.76666666666667 + var_402_14 then
				var_402_13.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_399_1.time_ - 3.76666666666667) / var_402_14)
				var_402_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_13.position).x, (manager.ui.mainCamera.transform.position - var_402_13.position).y, (manager.ui.mainCamera.transform.position - var_402_13.position).z)
				var_402_13.localEulerAngles.z = 0
				var_402_13.localEulerAngles.x = 0
				var_402_13.localEulerAngles = var_402_13.localEulerAngles
			end

			if arg_399_1.time_ >= 3.76666666666667 + var_402_14 and arg_399_1.time_ < 3.76666666666667 + var_402_14 + arg_402_0 then
				var_402_13.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_402_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_13.position).x, (manager.ui.mainCamera.transform.position - var_402_13.position).y, (manager.ui.mainCamera.transform.position - var_402_13.position).z)
				var_402_13.localEulerAngles.z = 0
				var_402_13.localEulerAngles.x = 0
				var_402_13.localEulerAngles = var_402_13.localEulerAngles
			end

			local var_402_15 = arg_399_1.actors_["1047ui_story"]

			if 3.76666666666667 < arg_399_1.time_ and arg_399_1.time_ <= 3.76666666666667 + arg_402_0 and not isNil(var_402_15) and arg_399_1.var_.characterEffect1047ui_story == nil then
				arg_399_1.var_.characterEffect1047ui_story = var_402_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_16 = 0.200000002980232

			if 3.76666666666667 <= arg_399_1.time_ and arg_399_1.time_ < 3.76666666666667 + var_402_16 and not isNil(var_402_15) then
				if arg_399_1.var_.characterEffect1047ui_story and not isNil(var_402_15) then
					arg_399_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 3.76666666666667 + var_402_16 and arg_399_1.time_ < 3.76666666666667 + var_402_16 + arg_402_0 and not isNil(var_402_15) and arg_399_1.var_.characterEffect1047ui_story then
				arg_399_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.76666666666667 < arg_399_1.time_ and arg_399_1.time_ <= 3.76666666666667 + arg_402_0 then
				arg_399_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 3.76666666666667 < arg_399_1.time_ and arg_399_1.time_ <= 3.76666666666667 + arg_402_0 then
				arg_399_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_399_1.time_ and arg_399_1.time_ <= 0.1 + arg_402_0 then
				arg_399_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.56666666666667 < arg_399_1.time_ and arg_399_1.time_ <= 1.56666666666667 + arg_402_0 then
				arg_399_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_399_1.frameCnt_ <= 1 then
				arg_399_1.dialog_:SetActive(false)
			end

			local var_402_20 = 4
			local var_402_21 = 0.2

			if 4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_20 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0

				arg_399_1.dialog_:SetActive(true)

				arg_399_1.dialogCg_.alpha = 0

				local var_402_22 = LeanTween.value(arg_399_1.dialog_, 0, 1, 0.3)

				var_402_22:setOnUpdate(LuaHelper.FloatAction(function(arg_403_0)
					arg_399_1.dialogCg_.alpha = arg_403_0
				end))
				var_402_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_399_1.dialog_)
					var_402_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_399_1.duration_ = arg_399_1.duration_ + 0.3

				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_23 = arg_399_1:GetWordFromCfg(421061096)
				local var_402_24 = arg_399_1:FormatText(var_402_23.content)

				arg_399_1.text_.text = var_402_24

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_26 = 8 <= 0 and var_402_21 or var_402_21 * (utf8.len(var_402_24) / 8)

				if (8 <= 0 and var_402_21 or var_402_21 * (utf8.len(var_402_24) / 8)) > 0 and var_402_21 < var_402_26 then
					arg_399_1.talkMaxDuration = var_402_26
					var_402_20 = var_402_20 + 0.3

					if var_402_26 + var_402_20 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_26 + var_402_20
					end
				end

				arg_399_1.text_.text = var_402_24
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061096", "story_v_out_421061.awb") ~= 0 then
					local var_402_27 = manager.audio:GetVoiceLength("story_v_out_421061", "421061096", "story_v_out_421061.awb") / 1000

					if var_402_27 + var_402_20 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_27 + var_402_20
					end

					if var_402_23.prefab_name ~= "" and arg_399_1.actors_[var_402_23.prefab_name] ~= nil then
						local var_402_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_23.prefab_name].transform, "story_v_out_421061", "421061096", "story_v_out_421061.awb")

						arg_399_1:RecordAudio("421061096", var_402_28)
						arg_399_1:RecordAudio("421061096", var_402_28)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_421061", "421061096", "story_v_out_421061.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_421061", "421061096", "story_v_out_421061.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_29 = var_402_20 + 0.3
			local var_402_30 = math.max(var_402_21, arg_399_1.talkMaxDuration)

			if var_402_20 + 0.3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_29 + var_402_30 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_29) / var_402_30

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_29 + var_402_30 and arg_399_1.time_ < var_402_29 + var_402_30 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play421061097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 421061097
		arg_405_1.duration_ = 6.4

		local var_405_0 = {
			zh = 3.8,
			ja = 6.4
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play421061098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if arg_405_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_408_0 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_405_1.stage_.transform)

				var_408_0.name = "10143ui_story"
				var_408_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.actors_["10143ui_story"] = var_408_0

				local var_408_1 = var_408_0:GetComponentInChildren(typeof(CharacterEffect))

				var_408_1.enabled = true

				local var_408_2 = GameObjectTools.GetOrAddComponent(var_408_0, typeof(DynamicBoneHelper))

				if var_408_2 then
					var_408_2:EnableDynamicBone(false)
				end

				arg_405_1:ShowWeapon(var_408_1.transform, false)

				arg_405_1.var_["10143ui_story" .. "Animator"] = var_408_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_405_1.var_["10143ui_story" .. "Animator"].applyRootMotion = true
				arg_405_1.var_["10143ui_story" .. "LipSync"] = var_408_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_408_3 = arg_405_1.actors_["10143ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10143ui_story = var_408_3.localPosition
			end

			local var_408_4 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				var_408_3.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_405_1.time_ - 0) / var_408_4)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				var_408_3.localPosition = Vector3.New(0.78, -1.06, -6)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			local var_408_5 = arg_405_1.actors_["10143ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.characterEffect10143ui_story == nil then
				arg_405_1.var_.characterEffect10143ui_story = var_408_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_6 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_6 and not isNil(var_408_5) then
				if arg_405_1.var_.characterEffect10143ui_story and not isNil(var_408_5) then
					arg_405_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_6 and arg_405_1.time_ < 0 + var_408_6 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.characterEffect10143ui_story then
				arg_405_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_408_8 = arg_405_1.actors_["1047ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_8) and arg_405_1.var_.characterEffect1047ui_story == nil then
				arg_405_1.var_.characterEffect1047ui_story = var_408_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_9 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_9 and not isNil(var_408_8) then
				if arg_405_1.var_.characterEffect1047ui_story and not isNil(var_408_8) then
					arg_405_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_9)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_9 and arg_405_1.time_ < 0 + var_408_9 + arg_408_0 and not isNil(var_408_8) and arg_405_1.var_.characterEffect1047ui_story then
				arg_405_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action5_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_408_10 = 0
			local var_408_11 = 0.5

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_12 = arg_405_1:GetWordFromCfg(421061097)
				local var_408_13 = arg_405_1:FormatText(var_408_12.content)

				arg_405_1.text_.text = var_408_13

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_15 = 20 <= 0 and var_408_11 or var_408_11 * (utf8.len(var_408_13) / 20)

				if (20 <= 0 and var_408_11 or var_408_11 * (utf8.len(var_408_13) / 20)) > 0 and var_408_11 < var_408_15 then
					arg_405_1.talkMaxDuration = var_408_15

					if var_408_15 + var_408_10 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_15 + var_408_10
					end
				end

				arg_405_1.text_.text = var_408_13
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061097", "story_v_out_421061.awb") ~= 0 then
					local var_408_16 = manager.audio:GetVoiceLength("story_v_out_421061", "421061097", "story_v_out_421061.awb") / 1000

					if var_408_16 + var_408_10 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_16 + var_408_10
					end

					if var_408_12.prefab_name ~= "" and arg_405_1.actors_[var_408_12.prefab_name] ~= nil then
						local var_408_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_12.prefab_name].transform, "story_v_out_421061", "421061097", "story_v_out_421061.awb")

						arg_405_1:RecordAudio("421061097", var_408_17)
						arg_405_1:RecordAudio("421061097", var_408_17)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_421061", "421061097", "story_v_out_421061.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_421061", "421061097", "story_v_out_421061.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_18 = math.max(var_408_11, arg_405_1.talkMaxDuration)

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_18 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_10) / var_408_18

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_10 + var_408_18 and arg_405_1.time_ < var_408_10 + var_408_18 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play421061098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 421061098
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play421061099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10143ui_story = arg_409_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).z)
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles = arg_409_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).z)
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles = arg_409_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1047ui_story"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1047ui_story = var_412_1.localPosition
			end

			local var_412_2 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 then
				var_412_1.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_2)
				var_412_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_1.position).x, (manager.ui.mainCamera.transform.position - var_412_1.position).y, (manager.ui.mainCamera.transform.position - var_412_1.position).z)
				var_412_1.localEulerAngles.z = 0
				var_412_1.localEulerAngles.x = 0
				var_412_1.localEulerAngles = var_412_1.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 then
				var_412_1.localPosition = Vector3.New(0, 100, 0)
				var_412_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_1.position).x, (manager.ui.mainCamera.transform.position - var_412_1.position).y, (manager.ui.mainCamera.transform.position - var_412_1.position).z)
				var_412_1.localEulerAngles.z = 0
				var_412_1.localEulerAngles.x = 0
				var_412_1.localEulerAngles = var_412_1.localEulerAngles
			end

			local var_412_3 = arg_409_1.actors_["10143ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_3) and arg_409_1.var_.characterEffect10143ui_story == nil then
				arg_409_1.var_.characterEffect10143ui_story = var_412_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_4 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 and not isNil(var_412_3) then
				if arg_409_1.var_.characterEffect10143ui_story and not isNil(var_412_3) then
					arg_409_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_4)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 and not isNil(var_412_3) and arg_409_1.var_.characterEffect10143ui_story then
				arg_409_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_412_5 = 0
			local var_412_6 = 1.125

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_7 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(421061098).content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 45 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_7) / 45)

				if (45 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_7) / 45)) > 0 and var_412_6 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_5
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_6, arg_409_1.talkMaxDuration)

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_5) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_5 + var_412_10 and arg_409_1.time_ < var_412_5 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play421061099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 421061099
		arg_413_1.duration_ = 15.7

		local var_413_0 = {
			zh = 15.066,
			ja = 15.7
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play421061100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1047ui_story = arg_413_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1047ui_story"].transform.position).z)
				arg_413_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1047ui_story"].transform.localEulerAngles = arg_413_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_413_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1047ui_story"].transform.position).z)
				arg_413_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1047ui_story"].transform.localEulerAngles = arg_413_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["10143ui_story"].transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos10143ui_story = var_416_1.localPosition
			end

			local var_416_2 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 then
				var_416_1.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_413_1.time_ - 0) / var_416_2)
				var_416_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_1.position).x, (manager.ui.mainCamera.transform.position - var_416_1.position).y, (manager.ui.mainCamera.transform.position - var_416_1.position).z)
				var_416_1.localEulerAngles.z = 0
				var_416_1.localEulerAngles.x = 0
				var_416_1.localEulerAngles = var_416_1.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 then
				var_416_1.localPosition = Vector3.New(0.78, -1.06, -6)
				var_416_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_1.position).x, (manager.ui.mainCamera.transform.position - var_416_1.position).y, (manager.ui.mainCamera.transform.position - var_416_1.position).z)
				var_416_1.localEulerAngles.z = 0
				var_416_1.localEulerAngles.x = 0
				var_416_1.localEulerAngles = var_416_1.localEulerAngles
			end

			local var_416_3 = arg_413_1.actors_["1047ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_3) and arg_413_1.var_.characterEffect1047ui_story == nil then
				arg_413_1.var_.characterEffect1047ui_story = var_416_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_4 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 and not isNil(var_416_3) then
				if arg_413_1.var_.characterEffect1047ui_story and not isNil(var_416_3) then
					arg_413_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 and not isNil(var_416_3) and arg_413_1.var_.characterEffect1047ui_story then
				arg_413_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:AudioAction("play", "effect", "se_story_143", "se_story_143_communication", "")
			end

			local var_416_7 = 0
			local var_416_8 = 1.55

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_7 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_9 = arg_413_1:GetWordFromCfg(421061099)
				local var_416_10 = arg_413_1:FormatText(var_416_9.content)

				arg_413_1.text_.text = var_416_10

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_12 = 62 <= 0 and var_416_8 or var_416_8 * (utf8.len(var_416_10) / 62)

				if (62 <= 0 and var_416_8 or var_416_8 * (utf8.len(var_416_10) / 62)) > 0 and var_416_8 < var_416_12 then
					arg_413_1.talkMaxDuration = var_416_12

					if var_416_12 + var_416_7 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_7
					end
				end

				arg_413_1.text_.text = var_416_10
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061099", "story_v_out_421061.awb") ~= 0 then
					local var_416_13 = manager.audio:GetVoiceLength("story_v_out_421061", "421061099", "story_v_out_421061.awb") / 1000

					if var_416_13 + var_416_7 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_7
					end

					if var_416_9.prefab_name ~= "" and arg_413_1.actors_[var_416_9.prefab_name] ~= nil then
						local var_416_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_9.prefab_name].transform, "story_v_out_421061", "421061099", "story_v_out_421061.awb")

						arg_413_1:RecordAudio("421061099", var_416_14)
						arg_413_1:RecordAudio("421061099", var_416_14)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_421061", "421061099", "story_v_out_421061.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_421061", "421061099", "story_v_out_421061.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_15 = math.max(var_416_8, arg_413_1.talkMaxDuration)

			if var_416_7 <= arg_413_1.time_ and arg_413_1.time_ < var_416_7 + var_416_15 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_7) / var_416_15

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_7 + var_416_15 and arg_413_1.time_ < var_416_7 + var_416_15 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play421061100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 421061100
		arg_417_1.duration_ = 3.7

		local var_417_0 = {
			zh = 3.066,
			ja = 3.7
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play421061101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10143ui_story = arg_417_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).z)
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles = arg_417_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_417_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).z)
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles = arg_417_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["10143ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10143ui_story == nil then
				arg_417_1.var_.characterEffect10143ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect10143ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10143ui_story then
				arg_417_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_420_4 = arg_417_1.actors_["1047ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect1047ui_story == nil then
				arg_417_1.var_.characterEffect1047ui_story = var_420_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_5 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_5 and not isNil(var_420_4) then
				if arg_417_1.var_.characterEffect1047ui_story and not isNil(var_420_4) then
					arg_417_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_5)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_5 and arg_417_1.time_ < 0 + var_420_5 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect1047ui_story then
				arg_417_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action5_2")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_420_6 = 0
			local var_420_7 = 0.3

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_8 = arg_417_1:GetWordFromCfg(421061100)
				local var_420_9 = arg_417_1:FormatText(var_420_8.content)

				arg_417_1.text_.text = var_420_9

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 12 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_9) / 12)

				if (12 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_9) / 12)) > 0 and var_420_7 < var_420_11 then
					arg_417_1.talkMaxDuration = var_420_11

					if var_420_11 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_9
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061100", "story_v_out_421061.awb") ~= 0 then
					local var_420_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061100", "story_v_out_421061.awb") / 1000

					if var_420_12 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_12 + var_420_6
					end

					if var_420_8.prefab_name ~= "" and arg_417_1.actors_[var_420_8.prefab_name] ~= nil then
						local var_420_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_8.prefab_name].transform, "story_v_out_421061", "421061100", "story_v_out_421061.awb")

						arg_417_1:RecordAudio("421061100", var_420_13)
						arg_417_1:RecordAudio("421061100", var_420_13)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_421061", "421061100", "story_v_out_421061.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_421061", "421061100", "story_v_out_421061.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_14 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_14

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_14 and arg_417_1.time_ < var_420_6 + var_420_14 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play421061101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 421061101
		arg_421_1.duration_ = 6.3

		local var_421_0 = {
			zh = 5.566,
			ja = 6.3
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play421061102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1047ui_story = arg_421_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1047ui_story"].transform.position).z)
				arg_421_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1047ui_story"].transform.localEulerAngles = arg_421_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_421_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1047ui_story"].transform.position).z)
				arg_421_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1047ui_story"].transform.localEulerAngles = arg_421_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1047ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1047ui_story == nil then
				arg_421_1.var_.characterEffect1047ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1047ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1047ui_story then
				arg_421_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_424_4 = arg_421_1.actors_["10143ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect10143ui_story == nil then
				arg_421_1.var_.characterEffect10143ui_story = var_424_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_5 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_5 and not isNil(var_424_4) then
				if arg_421_1.var_.characterEffect10143ui_story and not isNil(var_424_4) then
					arg_421_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_421_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_5)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_5 and arg_421_1.time_ < 0 + var_424_5 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect10143ui_story then
				arg_421_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_421_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_424_6 = 0
			local var_424_7 = 0.55

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_8 = arg_421_1:GetWordFromCfg(421061101)
				local var_424_9 = arg_421_1:FormatText(var_424_8.content)

				arg_421_1.text_.text = var_424_9

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 22 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_9) / 22)

				if (22 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_9) / 22)) > 0 and var_424_7 < var_424_11 then
					arg_421_1.talkMaxDuration = var_424_11

					if var_424_11 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_11 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_9
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061101", "story_v_out_421061.awb") ~= 0 then
					local var_424_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061101", "story_v_out_421061.awb") / 1000

					if var_424_12 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_12 + var_424_6
					end

					if var_424_8.prefab_name ~= "" and arg_421_1.actors_[var_424_8.prefab_name] ~= nil then
						local var_424_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_8.prefab_name].transform, "story_v_out_421061", "421061101", "story_v_out_421061.awb")

						arg_421_1:RecordAudio("421061101", var_424_13)
						arg_421_1:RecordAudio("421061101", var_424_13)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_421061", "421061101", "story_v_out_421061.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_421061", "421061101", "story_v_out_421061.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_14 = math.max(var_424_7, arg_421_1.talkMaxDuration)

			if var_424_6 <= arg_421_1.time_ and arg_421_1.time_ < var_424_6 + var_424_14 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_6) / var_424_14

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_6 + var_424_14 and arg_421_1.time_ < var_424_6 + var_424_14 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play421061102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 421061102
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play421061103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos10143ui_story = arg_425_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10143ui_story"].transform.position).z)
				arg_425_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["10143ui_story"].transform.localEulerAngles = arg_425_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_425_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10143ui_story"].transform.position).z)
				arg_425_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["10143ui_story"].transform.localEulerAngles = arg_425_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1047ui_story"].transform

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1047ui_story = var_428_1.localPosition
			end

			local var_428_2 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 then
				var_428_1.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_2)
				var_428_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_428_1.position).x, (manager.ui.mainCamera.transform.position - var_428_1.position).y, (manager.ui.mainCamera.transform.position - var_428_1.position).z)
				var_428_1.localEulerAngles.z = 0
				var_428_1.localEulerAngles.x = 0
				var_428_1.localEulerAngles = var_428_1.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 then
				var_428_1.localPosition = Vector3.New(0, 100, 0)
				var_428_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_428_1.position).x, (manager.ui.mainCamera.transform.position - var_428_1.position).y, (manager.ui.mainCamera.transform.position - var_428_1.position).z)
				var_428_1.localEulerAngles.z = 0
				var_428_1.localEulerAngles.x = 0
				var_428_1.localEulerAngles = var_428_1.localEulerAngles
			end

			if 0.166666666666667 < arg_425_1.time_ and arg_425_1.time_ <= 0.166666666666667 + arg_428_0 then
				arg_425_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_428_4 = 0
			local var_428_5 = 1.5

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_6 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(421061102).content)

				arg_425_1.text_.text = var_428_6

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_8 = 60 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_6) / 60)

				if (60 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_6) / 60)) > 0 and var_428_5 < var_428_8 then
					arg_425_1.talkMaxDuration = var_428_8

					if var_428_8 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_8 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_6
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_9 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_9 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_9

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_9 and arg_425_1.time_ < var_428_4 + var_428_9 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play421061103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 421061103
		arg_429_1.duration_ = 11.2

		local var_429_0 = {
			zh = 7.733,
			ja = 11.2
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play421061104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1047ui_story = arg_429_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1047ui_story"].transform.position).z)
				arg_429_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1047ui_story"].transform.localEulerAngles = arg_429_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_429_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1047ui_story"].transform.position).z)
				arg_429_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1047ui_story"].transform.localEulerAngles = arg_429_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["10143ui_story"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10143ui_story = var_432_1.localPosition
			end

			local var_432_2 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 then
				var_432_1.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_429_1.time_ - 0) / var_432_2)
				var_432_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_1.position).x, (manager.ui.mainCamera.transform.position - var_432_1.position).y, (manager.ui.mainCamera.transform.position - var_432_1.position).z)
				var_432_1.localEulerAngles.z = 0
				var_432_1.localEulerAngles.x = 0
				var_432_1.localEulerAngles = var_432_1.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 then
				var_432_1.localPosition = Vector3.New(0.78, -1.06, -6)
				var_432_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_1.position).x, (manager.ui.mainCamera.transform.position - var_432_1.position).y, (manager.ui.mainCamera.transform.position - var_432_1.position).z)
				var_432_1.localEulerAngles.z = 0
				var_432_1.localEulerAngles.x = 0
				var_432_1.localEulerAngles = var_432_1.localEulerAngles
			end

			local var_432_3 = arg_429_1.actors_["1047ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_3) and arg_429_1.var_.characterEffect1047ui_story == nil then
				arg_429_1.var_.characterEffect1047ui_story = var_432_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_4 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 and not isNil(var_432_3) then
				if arg_429_1.var_.characterEffect1047ui_story and not isNil(var_432_3) then
					arg_429_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 and not isNil(var_432_3) and arg_429_1.var_.characterEffect1047ui_story then
				arg_429_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_432_6 = 0
			local var_432_7 = 0.825

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_8 = arg_429_1:GetWordFromCfg(421061103)
				local var_432_9 = arg_429_1:FormatText(var_432_8.content)

				arg_429_1.text_.text = var_432_9

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 33 <= 0 and var_432_7 or var_432_7 * (utf8.len(var_432_9) / 33)

				if (33 <= 0 and var_432_7 or var_432_7 * (utf8.len(var_432_9) / 33)) > 0 and var_432_7 < var_432_11 then
					arg_429_1.talkMaxDuration = var_432_11

					if var_432_11 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_11 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_9
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061103", "story_v_out_421061.awb") ~= 0 then
					local var_432_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061103", "story_v_out_421061.awb") / 1000

					if var_432_12 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_12 + var_432_6
					end

					if var_432_8.prefab_name ~= "" and arg_429_1.actors_[var_432_8.prefab_name] ~= nil then
						local var_432_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_8.prefab_name].transform, "story_v_out_421061", "421061103", "story_v_out_421061.awb")

						arg_429_1:RecordAudio("421061103", var_432_13)
						arg_429_1:RecordAudio("421061103", var_432_13)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_421061", "421061103", "story_v_out_421061.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_421061", "421061103", "story_v_out_421061.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_14 = math.max(var_432_7, arg_429_1.talkMaxDuration)

			if var_432_6 <= arg_429_1.time_ and arg_429_1.time_ < var_432_6 + var_432_14 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_6) / var_432_14

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_6 + var_432_14 and arg_429_1.time_ < var_432_6 + var_432_14 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play421061104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 421061104
		arg_433_1.duration_ = 2.63

		local var_433_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play421061105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10143ui_story = arg_433_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10143ui_story"].transform.position).z)
				arg_433_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["10143ui_story"].transform.localEulerAngles = arg_433_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_433_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10143ui_story"].transform.position).z)
				arg_433_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["10143ui_story"].transform.localEulerAngles = arg_433_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["10143ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect10143ui_story == nil then
				arg_433_1.var_.characterEffect10143ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect10143ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect10143ui_story then
				arg_433_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_436_4 = arg_433_1.actors_["1047ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect1047ui_story == nil then
				arg_433_1.var_.characterEffect1047ui_story = var_436_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_5 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_5 and not isNil(var_436_4) then
				if arg_433_1.var_.characterEffect1047ui_story and not isNil(var_436_4) then
					arg_433_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_5)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_5 and arg_433_1.time_ < 0 + var_436_5 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect1047ui_story then
				arg_433_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_436_6 = 0
			local var_436_7 = 0.2

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(421061104)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 8 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 8)

				if (8 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 8)) > 0 and var_436_7 < var_436_11 then
					arg_433_1.talkMaxDuration = var_436_11

					if var_436_11 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061104", "story_v_out_421061.awb") ~= 0 then
					local var_436_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061104", "story_v_out_421061.awb") / 1000

					if var_436_12 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_6
					end

					if var_436_8.prefab_name ~= "" and arg_433_1.actors_[var_436_8.prefab_name] ~= nil then
						local var_436_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_8.prefab_name].transform, "story_v_out_421061", "421061104", "story_v_out_421061.awb")

						arg_433_1:RecordAudio("421061104", var_436_13)
						arg_433_1:RecordAudio("421061104", var_436_13)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_421061", "421061104", "story_v_out_421061.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_421061", "421061104", "story_v_out_421061.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_14 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_14 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_14

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_14 and arg_433_1.time_ < var_436_6 + var_436_14 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play421061105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 421061105
		arg_437_1.duration_ = 7.6

		local var_437_0 = {
			zh = 5.1,
			ja = 7.6
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
			arg_437_1.auto_ = false
		end

		function arg_437_1.playNext_(arg_439_0)
			arg_437_1.onStoryFinished_()
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1047ui_story = arg_437_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).z)
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles = arg_437_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_437_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).z)
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles = arg_437_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1047ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1047ui_story == nil then
				arg_437_1.var_.characterEffect1047ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1047ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1047ui_story then
				arg_437_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_440_4 = arg_437_1.actors_["10143ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_4) and arg_437_1.var_.characterEffect10143ui_story == nil then
				arg_437_1.var_.characterEffect10143ui_story = var_440_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_5 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_5 and not isNil(var_440_4) then
				if arg_437_1.var_.characterEffect10143ui_story and not isNil(var_440_4) then
					arg_437_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_437_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_5)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_5 and arg_437_1.time_ < 0 + var_440_5 + arg_440_0 and not isNil(var_440_4) and arg_437_1.var_.characterEffect10143ui_story then
				arg_437_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_437_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_440_6 = 0
			local var_440_7 = 0.5

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_8 = arg_437_1:GetWordFromCfg(421061105)
				local var_440_9 = arg_437_1:FormatText(var_440_8.content)

				arg_437_1.text_.text = var_440_9

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 20 <= 0 and var_440_7 or var_440_7 * (utf8.len(var_440_9) / 20)

				if (20 <= 0 and var_440_7 or var_440_7 * (utf8.len(var_440_9) / 20)) > 0 and var_440_7 < var_440_11 then
					arg_437_1.talkMaxDuration = var_440_11

					if var_440_11 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_11 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_9
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421061", "421061105", "story_v_out_421061.awb") ~= 0 then
					local var_440_12 = manager.audio:GetVoiceLength("story_v_out_421061", "421061105", "story_v_out_421061.awb") / 1000

					if var_440_12 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_12 + var_440_6
					end

					if var_440_8.prefab_name ~= "" and arg_437_1.actors_[var_440_8.prefab_name] ~= nil then
						local var_440_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_8.prefab_name].transform, "story_v_out_421061", "421061105", "story_v_out_421061.awb")

						arg_437_1:RecordAudio("421061105", var_440_13)
						arg_437_1:RecordAudio("421061105", var_440_13)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_421061", "421061105", "story_v_out_421061.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_421061", "421061105", "story_v_out_421061.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_14 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_14 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_14

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_14 and arg_437_1.time_ < var_440_6 + var_440_14 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0109",
		"TextureConfig/Background/SS2102",
		"TextureConfig/Background/ST21",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D10_1",
		"TextureConfig/Background/L06g"
	},
	voices = {
		"story_v_out_421061.awb"
	}
}
