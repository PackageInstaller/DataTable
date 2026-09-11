return {
	Play421052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421052001
		arg_1_1.duration_ = 4.7

		local var_1_0 = {
			zh = 3.233,
			ja = 4.7
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
				arg_1_0:Play421052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B10a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10a")
				var_4_0.name = "B10a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B10a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B10a

				arg_1_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.075

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(421052001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 3 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 3)

				if (3 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 3)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052001", "story_v_out_421052.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_421052", "421052001", "story_v_out_421052.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_421052", "421052001", "story_v_out_421052.awb")

						arg_1_1:RecordAudio("421052001", var_4_23)
						arg_1_1:RecordAudio("421052001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421052", "421052001", "story_v_out_421052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421052", "421052001", "story_v_out_421052.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421052002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.1 < arg_9_1.time_ and arg_9_1.time_ <= 0.1 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_gunreadygroup", "")
			end

			local var_12_1 = 0
			local var_12_2 = 0.9

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(421052002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)

				if (36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)) > 0 and var_12_2 < var_12_5 then
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
	Play421052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421052003
		arg_13_1.duration_ = 11.8

		local var_13_0 = {
			zh = 8.233,
			ja = 11.8
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
				arg_13_0:Play421052004(arg_13_1)
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

				arg_13_1:ShowWeapon(arg_13_1.var_["1047ui_story" .. "Animator"].transform, false)
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
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.925

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

				local var_16_10 = arg_13_1:GetWordFromCfg(421052003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 37 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 37)

				if (37 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 37)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052003", "story_v_out_421052.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052003", "story_v_out_421052.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_421052", "421052003", "story_v_out_421052.awb")

						arg_13_1:RecordAudio("421052003", var_16_15)
						arg_13_1:RecordAudio("421052003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421052", "421052003", "story_v_out_421052.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421052", "421052003", "story_v_out_421052.awb")
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
	Play421052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421052004
		arg_17_1.duration_ = 9.5

		local var_17_0 = {
			zh = 5.066,
			ja = 9.5
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
				arg_17_0:Play421052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1047ui_story"]) and arg_17_1.var_.characterEffect1047ui_story == nil then
				arg_17_1.var_.characterEffect1047ui_story = arg_17_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1047ui_story"]) then
				if arg_17_1.var_.characterEffect1047ui_story and not isNil(arg_17_1.actors_["1047ui_story"]) then
					arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1047ui_story"]) and arg_17_1.var_.characterEffect1047ui_story then
				arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(421052004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 18 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 18)

				if (18 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 18)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052004", "story_v_out_421052.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052004", "story_v_out_421052.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_421052", "421052004", "story_v_out_421052.awb")

						arg_17_1:RecordAudio("421052004", var_20_8)
						arg_17_1:RecordAudio("421052004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421052", "421052004", "story_v_out_421052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421052", "421052004", "story_v_out_421052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play421052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421052005
		arg_21_1.duration_ = 10.17

		local var_21_0 = {
			zh = 7.866,
			ja = 10.166
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
				arg_21_0:Play421052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = arg_21_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).z)
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles = arg_21_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_21_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).z)
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles = arg_21_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1047ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_4 = 0
			local var_24_5 = 0.8

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(421052005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 32 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 32)

				if (32 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 32)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052005", "story_v_out_421052.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052005", "story_v_out_421052.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_421052", "421052005", "story_v_out_421052.awb")

						arg_21_1:RecordAudio("421052005", var_24_11)
						arg_21_1:RecordAudio("421052005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421052", "421052005", "story_v_out_421052.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421052", "421052005", "story_v_out_421052.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play421052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421052006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = arg_25_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 1.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(421052006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)

				if (23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play421052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421052007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			zh = 1.833,
			ja = 3.366
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
				arg_29_0:Play421052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(421052007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 8 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 8)

				if (8 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 8)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052007", "story_v_out_421052.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052007", "story_v_out_421052.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_421052", "421052007", "story_v_out_421052.awb")

						arg_29_1:RecordAudio("421052007", var_32_6)
						arg_29_1:RecordAudio("421052007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421052", "421052007", "story_v_out_421052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421052", "421052007", "story_v_out_421052.awb")
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
	Play421052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421052008
		arg_33_1.duration_ = 6.27

		local var_33_0 = {
			zh = 5.633,
			ja = 6.266
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
				arg_33_0:Play421052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "10102ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10102ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["10102ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["10102ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["10102ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10102ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["10102ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect10102ui_story == nil then
				arg_33_1.var_.characterEffect10102ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect10102ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect10102ui_story then
				arg_33_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_8 = 0
			local var_36_9 = 0.725

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(421052008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 29 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 29)

				if (29 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 29)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052008", "story_v_out_421052.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052008", "story_v_out_421052.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_421052", "421052008", "story_v_out_421052.awb")

						arg_33_1:RecordAudio("421052008", var_36_15)
						arg_33_1:RecordAudio("421052008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421052", "421052008", "story_v_out_421052.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421052", "421052008", "story_v_out_421052.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play421052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421052009
		arg_37_1.duration_ = 16.23

		local var_37_0 = {
			zh = 9.9,
			ja = 16.233
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play421052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047ui_story = arg_37_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1047ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1047ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["10102ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10102ui_story == nil then
				arg_37_1.var_.characterEffect10102ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect10102ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10102ui_story then
				arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_6 = 0
			local var_40_7 = 1.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(421052009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 48 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 48)

				if (48 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 48)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052009", "story_v_out_421052.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052009", "story_v_out_421052.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_421052", "421052009", "story_v_out_421052.awb")

						arg_37_1:RecordAudio("421052009", var_40_13)
						arg_37_1:RecordAudio("421052009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421052", "421052009", "story_v_out_421052.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421052", "421052009", "story_v_out_421052.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play421052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421052010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1047ui_story"]) and arg_41_1.var_.characterEffect1047ui_story == nil then
				arg_41_1.var_.characterEffect1047ui_story = arg_41_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1047ui_story"]) then
				if arg_41_1.var_.characterEffect1047ui_story and not isNil(arg_41_1.actors_["1047ui_story"]) then
					arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1047ui_story"]) and arg_41_1.var_.characterEffect1047ui_story then
				arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(421052010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 10 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 10)

				if (10 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 10)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play421052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421052011
		arg_45_1.duration_ = 5.97

		local var_45_0 = {
			zh = 5.166,
			ja = 5.966
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
				arg_45_0:Play421052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1047ui_story = arg_45_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).z)
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles = arg_45_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_45_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).z)
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles = arg_45_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1047ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1047ui_story == nil then
				arg_45_1.var_.characterEffect1047ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1047ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1047ui_story then
				arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_4 = 0
			local var_48_5 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(421052011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 20 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 20)

				if (20 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 20)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052011", "story_v_out_421052.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052011", "story_v_out_421052.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_421052", "421052011", "story_v_out_421052.awb")

						arg_45_1:RecordAudio("421052011", var_48_11)
						arg_45_1:RecordAudio("421052011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421052", "421052011", "story_v_out_421052.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421052", "421052011", "story_v_out_421052.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play421052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421052012
		arg_49_1.duration_ = 12.83

		local var_49_0 = {
			zh = 8.633,
			ja = 12.833
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
				arg_49_0:Play421052013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.bgs_.B07b == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B07b")
				var_52_0.name = "B07b"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.B07b = var_52_0
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.B07b

				arg_49_1.bgs_.B07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "B07b" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 4

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_4 + 0.3 and arg_49_1.time_ < var_52_4 + 0.3 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_5 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_6 = 2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_5) / var_52_6)
				arg_49_1.mask_.color = var_52_7
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 then
				local var_52_8 = Color.New(0, 0, 0)

				var_52_8.a = 1
				arg_49_1.mask_.color = var_52_8
			end

			local var_52_9 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_10 = 2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 then
				local var_52_11 = Color.New(0, 0, 0)

				var_52_11.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_9) / var_52_10)
				arg_49_1.mask_.color = var_52_11
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 then
				local var_52_12 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_12.a = 0
				arg_49_1.mask_.color = var_52_12
			end

			local var_52_13 = arg_49_1.actors_["1047ui_story"].transform

			if 3.66666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 3.66666666666667 + arg_52_0 then
				arg_49_1.var_.moveOldPos1047ui_story = var_52_13.localPosition
			end

			local var_52_14 = 0.001

			if 3.66666666666667 <= arg_49_1.time_ and arg_49_1.time_ < 3.66666666666667 + var_52_14 then
				var_52_13.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_49_1.time_ - 3.66666666666667) / var_52_14)
				var_52_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_13.position).x, (manager.ui.mainCamera.transform.position - var_52_13.position).y, (manager.ui.mainCamera.transform.position - var_52_13.position).z)
				var_52_13.localEulerAngles.z = 0
				var_52_13.localEulerAngles.x = 0
				var_52_13.localEulerAngles = var_52_13.localEulerAngles
			end

			if arg_49_1.time_ >= 3.66666666666667 + var_52_14 and arg_49_1.time_ < 3.66666666666667 + var_52_14 + arg_52_0 then
				var_52_13.localPosition = Vector3.New(0, -1.13, -6.2)
				var_52_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_13.position).x, (manager.ui.mainCamera.transform.position - var_52_13.position).y, (manager.ui.mainCamera.transform.position - var_52_13.position).z)
				var_52_13.localEulerAngles.z = 0
				var_52_13.localEulerAngles.x = 0
				var_52_13.localEulerAngles = var_52_13.localEulerAngles
			end

			local var_52_15 = arg_49_1.actors_["1047ui_story"]

			if 3.66666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 3.66666666666667 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect1047ui_story == nil then
				arg_49_1.var_.characterEffect1047ui_story = var_52_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_16 = 0.200000002980232

			if 3.66666666666667 <= arg_49_1.time_ and arg_49_1.time_ < 3.66666666666667 + var_52_16 and not isNil(var_52_15) then
				if arg_49_1.var_.characterEffect1047ui_story and not isNil(var_52_15) then
					arg_49_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 3.66666666666667 + var_52_16 and arg_49_1.time_ < 3.66666666666667 + var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect1047ui_story then
				arg_49_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.66666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 3.66666666666667 + arg_52_0 then
				arg_49_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 3.66666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 3.66666666666667 + arg_52_0 then
				arg_49_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_52_18 = arg_49_1.actors_["1047ui_story"].transform

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				arg_49_1.var_.moveOldPos1047ui_story = var_52_18.localPosition
			end

			local var_52_19 = 0.001

			if 2 <= arg_49_1.time_ and arg_49_1.time_ < 2 + var_52_19 then
				var_52_18.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 2) / var_52_19)
				var_52_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_18.position).x, (manager.ui.mainCamera.transform.position - var_52_18.position).y, (manager.ui.mainCamera.transform.position - var_52_18.position).z)
				var_52_18.localEulerAngles.z = 0
				var_52_18.localEulerAngles.x = 0
				var_52_18.localEulerAngles = var_52_18.localEulerAngles
			end

			if arg_49_1.time_ >= 2 + var_52_19 and arg_49_1.time_ < 2 + var_52_19 + arg_52_0 then
				var_52_18.localPosition = Vector3.New(0, 100, 0)
				var_52_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_18.position).x, (manager.ui.mainCamera.transform.position - var_52_18.position).y, (manager.ui.mainCamera.transform.position - var_52_18.position).z)
				var_52_18.localEulerAngles.z = 0
				var_52_18.localEulerAngles.x = 0
				var_52_18.localEulerAngles = var_52_18.localEulerAngles
			end

			local var_52_20 = arg_49_1.actors_["10102ui_story"].transform

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102ui_story = var_52_20.localPosition
			end

			local var_52_21 = 0.001

			if 2 <= arg_49_1.time_ and arg_49_1.time_ < 2 + var_52_21 then
				var_52_20.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 2) / var_52_21)
				var_52_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_20.position).x, (manager.ui.mainCamera.transform.position - var_52_20.position).y, (manager.ui.mainCamera.transform.position - var_52_20.position).z)
				var_52_20.localEulerAngles.z = 0
				var_52_20.localEulerAngles.x = 0
				var_52_20.localEulerAngles = var_52_20.localEulerAngles
			end

			if arg_49_1.time_ >= 2 + var_52_21 and arg_49_1.time_ < 2 + var_52_21 + arg_52_0 then
				var_52_20.localPosition = Vector3.New(0, 100, 0)
				var_52_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_20.position).x, (manager.ui.mainCamera.transform.position - var_52_20.position).y, (manager.ui.mainCamera.transform.position - var_52_20.position).z)
				var_52_20.localEulerAngles.z = 0
				var_52_20.localEulerAngles.x = 0
				var_52_20.localEulerAngles = var_52_20.localEulerAngles
			end

			if 0.1 < arg_49_1.time_ and arg_49_1.time_ <= 0.1 + arg_52_0 then
				arg_49_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 1.63333333333333 < arg_49_1.time_ and arg_49_1.time_ <= 1.63333333333333 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_24 = 4
			local var_52_25 = 0.6

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_26 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_26:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_27 = arg_49_1:GetWordFromCfg(421052012)
				local var_52_28 = arg_49_1:FormatText(var_52_27.content)

				arg_49_1.text_.text = var_52_28

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_30 = 24 <= 0 and var_52_25 or var_52_25 * (utf8.len(var_52_28) / 24)

				if (24 <= 0 and var_52_25 or var_52_25 * (utf8.len(var_52_28) / 24)) > 0 and var_52_25 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30
					var_52_24 = var_52_24 + 0.3

					if var_52_30 + var_52_24 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_24
					end
				end

				arg_49_1.text_.text = var_52_28
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052012", "story_v_out_421052.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_421052", "421052012", "story_v_out_421052.awb") / 1000

					if var_52_31 + var_52_24 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_24
					end

					if var_52_27.prefab_name ~= "" and arg_49_1.actors_[var_52_27.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_27.prefab_name].transform, "story_v_out_421052", "421052012", "story_v_out_421052.awb")

						arg_49_1:RecordAudio("421052012", var_52_32)
						arg_49_1:RecordAudio("421052012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421052", "421052012", "story_v_out_421052.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421052", "421052012", "story_v_out_421052.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = var_52_24 + 0.3
			local var_52_34 = math.max(var_52_25, arg_49_1.talkMaxDuration)

			if var_52_24 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_33 + var_52_34 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_33) / var_52_34

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_33 + var_52_34 and arg_49_1.time_ < var_52_33 + var_52_34 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play421052013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 421052013
		arg_55_1.duration_ = 8

		local var_55_0 = {
			zh = 5.3,
			ja = 8
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
				arg_55_0:Play421052014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1047ui_story"]) and arg_55_1.var_.characterEffect1047ui_story == nil then
				arg_55_1.var_.characterEffect1047ui_story = arg_55_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1047ui_story"]) then
				if arg_55_1.var_.characterEffect1047ui_story and not isNil(arg_55_1.actors_["1047ui_story"]) then
					arg_55_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1047ui_story"]) and arg_55_1.var_.characterEffect1047ui_story then
				arg_55_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.55

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(421052013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_6 = 22 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_4) / 22)

				if (22 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_4) / 22)) > 0 and var_58_2 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052013", "story_v_out_421052.awb") ~= 0 then
					local var_58_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052013", "story_v_out_421052.awb") / 1000

					if var_58_7 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_1
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_421052", "421052013", "story_v_out_421052.awb")

						arg_55_1:RecordAudio("421052013", var_58_8)
						arg_55_1:RecordAudio("421052013", var_58_8)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_421052", "421052013", "story_v_out_421052.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_421052", "421052013", "story_v_out_421052.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_9 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_9 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_9

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_9 and arg_55_1.time_ < var_58_1 + var_58_9 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play421052014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 421052014
		arg_59_1.duration_ = 6.17

		local var_59_0 = {
			zh = 4.1,
			ja = 6.166
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play421052015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1047ui_story"]) and arg_59_1.var_.characterEffect1047ui_story == nil then
				arg_59_1.var_.characterEffect1047ui_story = arg_59_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1047ui_story"]) then
				if arg_59_1.var_.characterEffect1047ui_story and not isNil(arg_59_1.actors_["1047ui_story"]) then
					arg_59_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1047ui_story"]) and arg_59_1.var_.characterEffect1047ui_story then
				arg_59_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_62_2 = 0
			local var_62_3 = 0.7

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(421052014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 28 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 28)

				if (28 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 28)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052014", "story_v_out_421052.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052014", "story_v_out_421052.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_421052", "421052014", "story_v_out_421052.awb")

						arg_59_1:RecordAudio("421052014", var_62_9)
						arg_59_1:RecordAudio("421052014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_421052", "421052014", "story_v_out_421052.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_421052", "421052014", "story_v_out_421052.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play421052015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 421052015
		arg_63_1.duration_ = 4.43

		local var_63_0 = {
			zh = 2.866,
			ja = 4.433
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
				arg_63_0:Play421052016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1047ui_story"]) and arg_63_1.var_.characterEffect1047ui_story == nil then
				arg_63_1.var_.characterEffect1047ui_story = arg_63_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1047ui_story"]) then
				if arg_63_1.var_.characterEffect1047ui_story and not isNil(arg_63_1.actors_["1047ui_story"]) then
					arg_63_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1047ui_story"]) and arg_63_1.var_.characterEffect1047ui_story then
				arg_63_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.15

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(421052015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 6 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 6)

				if (6 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 6)) > 0 and var_66_2 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052015", "story_v_out_421052.awb") ~= 0 then
					local var_66_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052015", "story_v_out_421052.awb") / 1000

					if var_66_7 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_1
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_421052", "421052015", "story_v_out_421052.awb")

						arg_63_1:RecordAudio("421052015", var_66_8)
						arg_63_1:RecordAudio("421052015", var_66_8)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_421052", "421052015", "story_v_out_421052.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_421052", "421052015", "story_v_out_421052.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_9 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_9 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_9

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_9 and arg_63_1.time_ < var_66_1 + var_66_9 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play421052016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 421052016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play421052017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1047ui_story = arg_67_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).z)
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles = arg_67_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).z)
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles = arg_67_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_70_1 = 0
			local var_70_2 = 0.775

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(421052016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 31 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 31)

				if (31 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 31)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play421052017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 421052017
		arg_71_1.duration_ = 4.47

		local var_71_0 = {
			zh = 3.1,
			ja = 4.466
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
				arg_71_0:Play421052018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1047ui_story = arg_71_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1047ui_story"].transform.position).z)
				arg_71_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1047ui_story"].transform.localEulerAngles = arg_71_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_71_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1047ui_story"].transform.position).z)
				arg_71_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1047ui_story"].transform.localEulerAngles = arg_71_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1047ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1047ui_story == nil then
				arg_71_1.var_.characterEffect1047ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1047ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1047ui_story then
				arg_71_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_74_4 = 0
			local var_74_5 = 0.3

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(421052017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 12 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 12)

				if (12 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 12)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052017", "story_v_out_421052.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052017", "story_v_out_421052.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_421052", "421052017", "story_v_out_421052.awb")

						arg_71_1:RecordAudio("421052017", var_74_11)
						arg_71_1:RecordAudio("421052017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_421052", "421052017", "story_v_out_421052.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_421052", "421052017", "story_v_out_421052.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play421052018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 421052018
		arg_75_1.duration_ = 16.57

		local var_75_0 = {
			zh = 12.8,
			ja = 16.566
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
				arg_75_0:Play421052019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1047ui_story"]) and arg_75_1.var_.characterEffect1047ui_story == nil then
				arg_75_1.var_.characterEffect1047ui_story = arg_75_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1047ui_story"]) then
				if arg_75_1.var_.characterEffect1047ui_story and not isNil(arg_75_1.actors_["1047ui_story"]) then
					arg_75_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1047ui_story"]) and arg_75_1.var_.characterEffect1047ui_story then
				arg_75_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1.2

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(421052018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 48 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 48)

				if (48 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 48)) > 0 and var_78_2 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052018", "story_v_out_421052.awb") ~= 0 then
					local var_78_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052018", "story_v_out_421052.awb") / 1000

					if var_78_7 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_1
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_421052", "421052018", "story_v_out_421052.awb")

						arg_75_1:RecordAudio("421052018", var_78_8)
						arg_75_1:RecordAudio("421052018", var_78_8)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_421052", "421052018", "story_v_out_421052.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_421052", "421052018", "story_v_out_421052.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_9 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_9 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_9

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_9 and arg_75_1.time_ < var_78_1 + var_78_9 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play421052019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 421052019
		arg_79_1.duration_ = 11.1

		local var_79_0 = {
			zh = 7.733,
			ja = 11.1
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play421052020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1047ui_story = arg_79_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1047ui_story"].transform.position).z)
				arg_79_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1047ui_story"].transform.localEulerAngles = arg_79_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_79_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1047ui_story"].transform.position).z)
				arg_79_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1047ui_story"].transform.localEulerAngles = arg_79_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1047ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1047ui_story == nil then
				arg_79_1.var_.characterEffect1047ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1047ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1047ui_story then
				arg_79_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_82_4 = 0
			local var_82_5 = 0.825

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(421052019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 33 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 33)

				if (33 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 33)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052019", "story_v_out_421052.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052019", "story_v_out_421052.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_421052", "421052019", "story_v_out_421052.awb")

						arg_79_1:RecordAudio("421052019", var_82_11)
						arg_79_1:RecordAudio("421052019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_421052", "421052019", "story_v_out_421052.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_421052", "421052019", "story_v_out_421052.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play421052020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 421052020
		arg_83_1.duration_ = 9.47

		local var_83_0 = {
			zh = 9.466,
			ja = 8.4
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
				arg_83_0:Play421052021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1047ui_story"]) and arg_83_1.var_.characterEffect1047ui_story == nil then
				arg_83_1.var_.characterEffect1047ui_story = arg_83_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1047ui_story"]) then
				if arg_83_1.var_.characterEffect1047ui_story and not isNil(arg_83_1.actors_["1047ui_story"]) then
					arg_83_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1047ui_story"]) and arg_83_1.var_.characterEffect1047ui_story then
				arg_83_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.775

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(421052020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 31 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 31)

				if (31 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 31)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052020", "story_v_out_421052.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052020", "story_v_out_421052.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_421052", "421052020", "story_v_out_421052.awb")

						arg_83_1:RecordAudio("421052020", var_86_8)
						arg_83_1:RecordAudio("421052020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_421052", "421052020", "story_v_out_421052.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_421052", "421052020", "story_v_out_421052.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play421052021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 421052021
		arg_87_1.duration_ = 16.13

		local var_87_0 = {
			zh = 11.733,
			ja = 16.133
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
				arg_87_0:Play421052022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1047ui_story = arg_87_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1047ui_story"].transform.position).z)
				arg_87_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1047ui_story"].transform.localEulerAngles = arg_87_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_87_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1047ui_story"].transform.position).z)
				arg_87_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1047ui_story"].transform.localEulerAngles = arg_87_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1047ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1047ui_story == nil then
				arg_87_1.var_.characterEffect1047ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1047ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1047ui_story then
				arg_87_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_90_4 = 0
			local var_90_5 = 1.2

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(421052021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 48 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 48)

				if (48 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 48)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052021", "story_v_out_421052.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052021", "story_v_out_421052.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_421052", "421052021", "story_v_out_421052.awb")

						arg_87_1:RecordAudio("421052021", var_90_11)
						arg_87_1:RecordAudio("421052021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_421052", "421052021", "story_v_out_421052.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_421052", "421052021", "story_v_out_421052.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play421052022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 421052022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play421052023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1047ui_story = arg_91_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1047ui_story"].transform.position).z)
				arg_91_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1047ui_story"].transform.localEulerAngles = arg_91_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1047ui_story"].transform.position).z)
				arg_91_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1047ui_story"].transform.localEulerAngles = arg_91_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_94_1 = 0
			local var_94_2 = 1.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(421052022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 52 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 52)

				if (52 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 52)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play421052023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 421052023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play421052024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.85

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(421052023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 34 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 34)

				if (34 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 34)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play421052024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 421052024
		arg_99_1.duration_ = 10.4

		local var_99_0 = {
			zh = 6.833,
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
				arg_99_0:Play421052025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.675

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(421052024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 27 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 27)

				if (27 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 27)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052024", "story_v_out_421052.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052024", "story_v_out_421052.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_421052", "421052024", "story_v_out_421052.awb")

						arg_99_1:RecordAudio("421052024", var_102_6)
						arg_99_1:RecordAudio("421052024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_421052", "421052024", "story_v_out_421052.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_421052", "421052024", "story_v_out_421052.awb")
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
	Play421052025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 421052025
		arg_103_1.duration_ = 5.77

		local var_103_0 = {
			zh = 4.233,
			ja = 5.766
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
				arg_103_0:Play421052026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1047ui_story = arg_103_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1047ui_story"].transform.position).z)
				arg_103_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1047ui_story"].transform.localEulerAngles = arg_103_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_103_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1047ui_story"].transform.position).z)
				arg_103_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1047ui_story"].transform.localEulerAngles = arg_103_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1047ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1047ui_story == nil then
				arg_103_1.var_.characterEffect1047ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1047ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1047ui_story then
				arg_103_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_106_4 = 0
			local var_106_5 = 0.525

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(421052025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 21 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 21)

				if (21 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 21)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052025", "story_v_out_421052.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052025", "story_v_out_421052.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_421052", "421052025", "story_v_out_421052.awb")

						arg_103_1:RecordAudio("421052025", var_106_11)
						arg_103_1:RecordAudio("421052025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_421052", "421052025", "story_v_out_421052.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_421052", "421052025", "story_v_out_421052.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play421052026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 421052026
		arg_107_1.duration_ = 13.1

		local var_107_0 = {
			zh = 9.933,
			ja = 13.1
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
				arg_107_0:Play421052027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1047ui_story"]) and arg_107_1.var_.characterEffect1047ui_story == nil then
				arg_107_1.var_.characterEffect1047ui_story = arg_107_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1047ui_story"]) then
				if arg_107_1.var_.characterEffect1047ui_story and not isNil(arg_107_1.actors_["1047ui_story"]) then
					arg_107_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1047ui_story"]) and arg_107_1.var_.characterEffect1047ui_story then
				arg_107_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(421052026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 38 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_4) / 38)

				if (38 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_4) / 38)) > 0 and var_110_2 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052026", "story_v_out_421052.awb") ~= 0 then
					local var_110_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052026", "story_v_out_421052.awb") / 1000

					if var_110_7 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_1
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_421052", "421052026", "story_v_out_421052.awb")

						arg_107_1:RecordAudio("421052026", var_110_8)
						arg_107_1:RecordAudio("421052026", var_110_8)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_421052", "421052026", "story_v_out_421052.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_421052", "421052026", "story_v_out_421052.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_9 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_9 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_9

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_9 and arg_107_1.time_ < var_110_1 + var_110_9 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play421052027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 421052027
		arg_111_1.duration_ = 10.6

		local var_111_0 = {
			zh = 9.366,
			ja = 10.6
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play421052028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.85

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(421052027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 34 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 34)

				if (34 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 34)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052027", "story_v_out_421052.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052027", "story_v_out_421052.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_421052", "421052027", "story_v_out_421052.awb")

						arg_111_1:RecordAudio("421052027", var_114_6)
						arg_111_1:RecordAudio("421052027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_421052", "421052027", "story_v_out_421052.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_421052", "421052027", "story_v_out_421052.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play421052028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 421052028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play421052029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.1

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(421052028).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 4 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 4)

				if (4 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 4)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play421052029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 421052029
		arg_119_1.duration_ = 9.3

		local var_119_0 = {
			zh = 8.233,
			ja = 9.3
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play421052030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.825

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(421052029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 32 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 32)

				if (32 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 32)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052029", "story_v_out_421052.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052029", "story_v_out_421052.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_421052", "421052029", "story_v_out_421052.awb")

						arg_119_1:RecordAudio("421052029", var_122_6)
						arg_119_1:RecordAudio("421052029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_421052", "421052029", "story_v_out_421052.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_421052", "421052029", "story_v_out_421052.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play421052030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 421052030
		arg_123_1.duration_ = 9.07

		local var_123_0 = {
			zh = 5.766,
			ja = 9.066
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
				arg_123_0:Play421052031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1047ui_story = arg_123_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).z)
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles = arg_123_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_123_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).z)
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles = arg_123_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1047ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1047ui_story == nil then
				arg_123_1.var_.characterEffect1047ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1047ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1047ui_story then
				arg_123_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_126_4 = 0
			local var_126_5 = 0.75

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(421052030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 30 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 30)

				if (30 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 30)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052030", "story_v_out_421052.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052030", "story_v_out_421052.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_421052", "421052030", "story_v_out_421052.awb")

						arg_123_1:RecordAudio("421052030", var_126_11)
						arg_123_1:RecordAudio("421052030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_421052", "421052030", "story_v_out_421052.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_421052", "421052030", "story_v_out_421052.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play421052031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 421052031
		arg_127_1.duration_ = 21.03

		local var_127_0 = {
			zh = 18.066,
			ja = 21.033
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
				arg_127_0:Play421052032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1047ui_story"]) and arg_127_1.var_.characterEffect1047ui_story == nil then
				arg_127_1.var_.characterEffect1047ui_story = arg_127_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1047ui_story"]) then
				if arg_127_1.var_.characterEffect1047ui_story and not isNil(arg_127_1.actors_["1047ui_story"]) then
					arg_127_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1047ui_story"]) and arg_127_1.var_.characterEffect1047ui_story then
				arg_127_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 1.5

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(421052031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 60 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 60)

				if (60 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 60)) > 0 and var_130_2 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052031", "story_v_out_421052.awb") ~= 0 then
					local var_130_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052031", "story_v_out_421052.awb") / 1000

					if var_130_7 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_1
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_421052", "421052031", "story_v_out_421052.awb")

						arg_127_1:RecordAudio("421052031", var_130_8)
						arg_127_1:RecordAudio("421052031", var_130_8)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_421052", "421052031", "story_v_out_421052.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_421052", "421052031", "story_v_out_421052.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_9 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_9 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_9

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_9 and arg_127_1.time_ < var_130_1 + var_130_9 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play421052032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 421052032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play421052033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.3

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(421052032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 12 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 12)

				if (12 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 12)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play421052033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 421052033
		arg_135_1.duration_ = 7.37

		local var_135_0 = {
			zh = 6,
			ja = 7.366
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play421052034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(421052033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 22 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 22)

				if (22 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 22)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052033", "story_v_out_421052.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052033", "story_v_out_421052.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_421052", "421052033", "story_v_out_421052.awb")

						arg_135_1:RecordAudio("421052033", var_138_6)
						arg_135_1:RecordAudio("421052033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_421052", "421052033", "story_v_out_421052.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_421052", "421052033", "story_v_out_421052.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play421052034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 421052034
		arg_139_1.duration_ = 8.13

		local var_139_0 = {
			zh = 6.466,
			ja = 8.133
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
				arg_139_0:Play421052035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1047ui_story = arg_139_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1047ui_story"].transform.position).z)
				arg_139_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1047ui_story"].transform.localEulerAngles = arg_139_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_139_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1047ui_story"].transform.position).z)
				arg_139_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1047ui_story"].transform.localEulerAngles = arg_139_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1047ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1047ui_story == nil then
				arg_139_1.var_.characterEffect1047ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1047ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1047ui_story then
				arg_139_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_142_4 = 0
			local var_142_5 = 0.775

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(421052034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 31 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 31)

				if (31 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 31)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052034", "story_v_out_421052.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052034", "story_v_out_421052.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_421052", "421052034", "story_v_out_421052.awb")

						arg_139_1:RecordAudio("421052034", var_142_11)
						arg_139_1:RecordAudio("421052034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_421052", "421052034", "story_v_out_421052.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_421052", "421052034", "story_v_out_421052.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play421052035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 421052035
		arg_143_1.duration_ = 14.97

		local var_143_0 = {
			zh = 10.1,
			ja = 14.966
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play421052036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) and arg_143_1.var_.characterEffect1047ui_story == nil then
				arg_143_1.var_.characterEffect1047ui_story = arg_143_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) then
				if arg_143_1.var_.characterEffect1047ui_story and not isNil(arg_143_1.actors_["1047ui_story"]) then
					arg_143_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) and arg_143_1.var_.characterEffect1047ui_story then
				arg_143_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 1.075

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(421052035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 43 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 43)

				if (43 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 43)) > 0 and var_146_2 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052035", "story_v_out_421052.awb") ~= 0 then
					local var_146_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052035", "story_v_out_421052.awb") / 1000

					if var_146_7 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_1
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_421052", "421052035", "story_v_out_421052.awb")

						arg_143_1:RecordAudio("421052035", var_146_8)
						arg_143_1:RecordAudio("421052035", var_146_8)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_421052", "421052035", "story_v_out_421052.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_421052", "421052035", "story_v_out_421052.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_9 and arg_143_1.time_ < var_146_1 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play421052036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421052036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play421052037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047ui_story = arg_147_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_150_1 = 0
			local var_150_2 = 0.625

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(421052036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 25 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 25)

				if (25 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 25)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play421052037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421052037
		arg_151_1.duration_ = 6

		local var_151_0 = {
			zh = 4.133,
			ja = 6
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
				arg_151_0:Play421052038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.4

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(421052037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 16 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 16)

				if (16 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 16)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052037", "story_v_out_421052.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052037", "story_v_out_421052.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_421052", "421052037", "story_v_out_421052.awb")

						arg_151_1:RecordAudio("421052037", var_154_6)
						arg_151_1:RecordAudio("421052037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_421052", "421052037", "story_v_out_421052.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_421052", "421052037", "story_v_out_421052.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play421052038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421052038
		arg_155_1.duration_ = 24.77

		local var_155_0 = {
			zh = 22.9,
			ja = 24.766
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421052039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.925

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(421052038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 77 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 77)

				if (77 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 77)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052038", "story_v_out_421052.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052038", "story_v_out_421052.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_421052", "421052038", "story_v_out_421052.awb")

						arg_155_1:RecordAudio("421052038", var_158_6)
						arg_155_1:RecordAudio("421052038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_421052", "421052038", "story_v_out_421052.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_421052", "421052038", "story_v_out_421052.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play421052039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421052039
		arg_159_1.duration_ = 14

		local var_159_0 = {
			zh = 14,
			ja = 12.433
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play421052040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.3

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(421052039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 52 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 52)

				if (52 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 52)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052039", "story_v_out_421052.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052039", "story_v_out_421052.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_421052", "421052039", "story_v_out_421052.awb")

						arg_159_1:RecordAudio("421052039", var_162_6)
						arg_159_1:RecordAudio("421052039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_421052", "421052039", "story_v_out_421052.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_421052", "421052039", "story_v_out_421052.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play421052040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 421052040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play421052041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.5

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(421052040).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 20 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 20)

				if (20 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 20)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play421052041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 421052041
		arg_167_1.duration_ = 19.57

		local var_167_0 = {
			zh = 16.333,
			ja = 19.566
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play421052042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(421052041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 59 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 59)

				if (59 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 59)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052041", "story_v_out_421052.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052041", "story_v_out_421052.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_421052", "421052041", "story_v_out_421052.awb")

						arg_167_1:RecordAudio("421052041", var_170_6)
						arg_167_1:RecordAudio("421052041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_421052", "421052041", "story_v_out_421052.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_421052", "421052041", "story_v_out_421052.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play421052042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 421052042
		arg_171_1.duration_ = 11.6

		local var_171_0 = {
			zh = 8.633,
			ja = 11.6
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play421052043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.825

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(421052042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 33 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 33)

				if (33 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 33)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052042", "story_v_out_421052.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052042", "story_v_out_421052.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_421052", "421052042", "story_v_out_421052.awb")

						arg_171_1:RecordAudio("421052042", var_174_6)
						arg_171_1:RecordAudio("421052042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_421052", "421052042", "story_v_out_421052.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_421052", "421052042", "story_v_out_421052.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play421052043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 421052043
		arg_175_1.duration_ = 7.33

		local var_175_0 = {
			zh = 6.633,
			ja = 7.333
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play421052044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1047ui_story = arg_175_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1047ui_story"].transform.position).z)
				arg_175_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1047ui_story"].transform.localEulerAngles = arg_175_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_175_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1047ui_story"].transform.position).z)
				arg_175_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1047ui_story"].transform.localEulerAngles = arg_175_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1047ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1047ui_story == nil then
				arg_175_1.var_.characterEffect1047ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1047ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1047ui_story then
				arg_175_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_178_4 = 0
			local var_178_5 = 1.4

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(421052043)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 28 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 28)

				if (28 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 28)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052043", "story_v_out_421052.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052043", "story_v_out_421052.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_421052", "421052043", "story_v_out_421052.awb")

						arg_175_1:RecordAudio("421052043", var_178_11)
						arg_175_1:RecordAudio("421052043", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_421052", "421052043", "story_v_out_421052.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_421052", "421052043", "story_v_out_421052.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play421052044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 421052044
		arg_179_1.duration_ = 8.57

		local var_179_0 = {
			zh = 5.2,
			ja = 8.566
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play421052045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1047ui_story = arg_179_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1047ui_story"].transform.position).z)
				arg_179_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1047ui_story"].transform.localEulerAngles = arg_179_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_179_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1047ui_story"].transform.position).z)
				arg_179_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1047ui_story"].transform.localEulerAngles = arg_179_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_182_1 = 0
			local var_182_2 = 1.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(421052044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 28 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_4) / 28)

				if (28 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_4) / 28)) > 0 and var_182_2 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052044", "story_v_out_421052.awb") ~= 0 then
					local var_182_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052044", "story_v_out_421052.awb") / 1000

					if var_182_7 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_1
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_421052", "421052044", "story_v_out_421052.awb")

						arg_179_1:RecordAudio("421052044", var_182_8)
						arg_179_1:RecordAudio("421052044", var_182_8)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_421052", "421052044", "story_v_out_421052.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_421052", "421052044", "story_v_out_421052.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_9 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_9 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_9

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_9 and arg_179_1.time_ < var_182_1 + var_182_9 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play421052045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 421052045
		arg_183_1.duration_ = 9.33

		local var_183_0 = {
			zh = 6.566,
			ja = 9.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play421052046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1047ui_story"]) and arg_183_1.var_.characterEffect1047ui_story == nil then
				arg_183_1.var_.characterEffect1047ui_story = arg_183_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1047ui_story"]) then
				if arg_183_1.var_.characterEffect1047ui_story and not isNil(arg_183_1.actors_["1047ui_story"]) then
					arg_183_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1047ui_story"]) and arg_183_1.var_.characterEffect1047ui_story then
				arg_183_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.65

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(421052045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 26 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_4) / 26)

				if (26 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_4) / 26)) > 0 and var_186_2 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052045", "story_v_out_421052.awb") ~= 0 then
					local var_186_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052045", "story_v_out_421052.awb") / 1000

					if var_186_7 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_1
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_421052", "421052045", "story_v_out_421052.awb")

						arg_183_1:RecordAudio("421052045", var_186_8)
						arg_183_1:RecordAudio("421052045", var_186_8)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_421052", "421052045", "story_v_out_421052.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_421052", "421052045", "story_v_out_421052.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_9 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_9 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_9

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_9 and arg_183_1.time_ < var_186_1 + var_186_9 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play421052046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 421052046
		arg_187_1.duration_ = 4.37

		local var_187_0 = {
			zh = 3.6,
			ja = 4.366
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play421052047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1047ui_story = arg_187_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1047ui_story"].transform.position).z)
				arg_187_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1047ui_story"].transform.localEulerAngles = arg_187_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_187_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1047ui_story"].transform.position).z)
				arg_187_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1047ui_story"].transform.localEulerAngles = arg_187_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1047ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1047ui_story == nil then
				arg_187_1.var_.characterEffect1047ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1047ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1047ui_story then
				arg_187_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_190_4 = 0
			local var_190_5 = 0.325

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(421052046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 13 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 13)

				if (13 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 13)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052046", "story_v_out_421052.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052046", "story_v_out_421052.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_421052", "421052046", "story_v_out_421052.awb")

						arg_187_1:RecordAudio("421052046", var_190_11)
						arg_187_1:RecordAudio("421052046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_421052", "421052046", "story_v_out_421052.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_421052", "421052046", "story_v_out_421052.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play421052047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 421052047
		arg_191_1.duration_ = 13.53

		local var_191_0 = {
			zh = 9.7,
			ja = 13.533
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play421052048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1047ui_story"]) and arg_191_1.var_.characterEffect1047ui_story == nil then
				arg_191_1.var_.characterEffect1047ui_story = arg_191_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1047ui_story"]) then
				if arg_191_1.var_.characterEffect1047ui_story and not isNil(arg_191_1.actors_["1047ui_story"]) then
					arg_191_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1047ui_story"]) and arg_191_1.var_.characterEffect1047ui_story then
				arg_191_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 1

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(421052047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 40 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 40)

				if (40 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 40)) > 0 and var_194_2 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052047", "story_v_out_421052.awb") ~= 0 then
					local var_194_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052047", "story_v_out_421052.awb") / 1000

					if var_194_7 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_1
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_421052", "421052047", "story_v_out_421052.awb")

						arg_191_1:RecordAudio("421052047", var_194_8)
						arg_191_1:RecordAudio("421052047", var_194_8)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_421052", "421052047", "story_v_out_421052.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_421052", "421052047", "story_v_out_421052.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_9 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_9 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_9

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_9 and arg_191_1.time_ < var_194_1 + var_194_9 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play421052048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 421052048
		arg_195_1.duration_ = 6.5

		local var_195_0 = {
			zh = 4.266,
			ja = 6.5
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play421052049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1047ui_story = arg_195_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).z)
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles = arg_195_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_195_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).z)
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles = arg_195_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1047ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1047ui_story == nil then
				arg_195_1.var_.characterEffect1047ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1047ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1047ui_story then
				arg_195_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_198_4 = 0
			local var_198_5 = 0.5

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(421052048)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 20 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 20)

				if (20 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 20)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052048", "story_v_out_421052.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052048", "story_v_out_421052.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_421052", "421052048", "story_v_out_421052.awb")

						arg_195_1:RecordAudio("421052048", var_198_11)
						arg_195_1:RecordAudio("421052048", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_421052", "421052048", "story_v_out_421052.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_421052", "421052048", "story_v_out_421052.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play421052049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 421052049
		arg_199_1.duration_ = 10.33

		local var_199_0 = {
			zh = 6.4,
			ja = 10.333
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play421052050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1047ui_story"]) and arg_199_1.var_.characterEffect1047ui_story == nil then
				arg_199_1.var_.characterEffect1047ui_story = arg_199_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1047ui_story"]) then
				if arg_199_1.var_.characterEffect1047ui_story and not isNil(arg_199_1.actors_["1047ui_story"]) then
					arg_199_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1047ui_story"]) and arg_199_1.var_.characterEffect1047ui_story then
				arg_199_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.575

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(421052049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 23 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 23)

				if (23 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 23)) > 0 and var_202_2 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052049", "story_v_out_421052.awb") ~= 0 then
					local var_202_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052049", "story_v_out_421052.awb") / 1000

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_421052", "421052049", "story_v_out_421052.awb")

						arg_199_1:RecordAudio("421052049", var_202_8)
						arg_199_1:RecordAudio("421052049", var_202_8)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_421052", "421052049", "story_v_out_421052.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_421052", "421052049", "story_v_out_421052.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_9 and arg_199_1.time_ < var_202_1 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play421052050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 421052050
		arg_203_1.duration_ = 8

		local var_203_0 = {
			zh = 7.033,
			ja = 8
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play421052051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1047ui_story = arg_203_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1047ui_story"].transform.position).z)
				arg_203_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1047ui_story"].transform.localEulerAngles = arg_203_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_203_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1047ui_story"].transform.position).z)
				arg_203_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1047ui_story"].transform.localEulerAngles = arg_203_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1047ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1047ui_story == nil then
				arg_203_1.var_.characterEffect1047ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1047ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1047ui_story then
				arg_203_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_206_4 = 0
			local var_206_5 = 0.775

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(421052050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 31 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 31)

				if (31 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 31)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052050", "story_v_out_421052.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052050", "story_v_out_421052.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_421052", "421052050", "story_v_out_421052.awb")

						arg_203_1:RecordAudio("421052050", var_206_11)
						arg_203_1:RecordAudio("421052050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_421052", "421052050", "story_v_out_421052.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_421052", "421052050", "story_v_out_421052.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play421052051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 421052051
		arg_207_1.duration_ = 1.83

		local var_207_0 = {
			zh = 1.466,
			ja = 1.833
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play421052052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1047ui_story"]) and arg_207_1.var_.characterEffect1047ui_story == nil then
				arg_207_1.var_.characterEffect1047ui_story = arg_207_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1047ui_story"]) then
				if arg_207_1.var_.characterEffect1047ui_story and not isNil(arg_207_1.actors_["1047ui_story"]) then
					arg_207_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1047ui_story"]) and arg_207_1.var_.characterEffect1047ui_story then
				arg_207_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.125

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(421052051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 5 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_4) / 5)

				if (5 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_4) / 5)) > 0 and var_210_2 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052051", "story_v_out_421052.awb") ~= 0 then
					local var_210_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052051", "story_v_out_421052.awb") / 1000

					if var_210_7 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_1
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_421052", "421052051", "story_v_out_421052.awb")

						arg_207_1:RecordAudio("421052051", var_210_8)
						arg_207_1:RecordAudio("421052051", var_210_8)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_421052", "421052051", "story_v_out_421052.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_421052", "421052051", "story_v_out_421052.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_9 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_9 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_9

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_9 and arg_207_1.time_ < var_210_1 + var_210_9 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play421052052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 421052052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play421052053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(421052052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 19 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 19)

				if (19 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 19)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play421052053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 421052053
		arg_215_1.duration_ = 8.6

		local var_215_0 = {
			zh = 6.7,
			ja = 8.6
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play421052054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.7

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(421052053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 28 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 28)

				if (28 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 28)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052053", "story_v_out_421052.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052053", "story_v_out_421052.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_421052", "421052053", "story_v_out_421052.awb")

						arg_215_1:RecordAudio("421052053", var_218_6)
						arg_215_1:RecordAudio("421052053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_421052", "421052053", "story_v_out_421052.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_421052", "421052053", "story_v_out_421052.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play421052054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 421052054
		arg_219_1.duration_ = 7.8

		local var_219_0 = {
			zh = 6.3,
			ja = 7.8
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play421052055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1047ui_story = arg_219_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).z)
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles = arg_219_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_219_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).z)
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles = arg_219_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1047ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1047ui_story == nil then
				arg_219_1.var_.characterEffect1047ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1047ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1047ui_story then
				arg_219_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_222_4 = 0
			local var_222_5 = 0.7

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(421052054)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 28 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 28)

				if (28 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 28)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052054", "story_v_out_421052.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052054", "story_v_out_421052.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_421052", "421052054", "story_v_out_421052.awb")

						arg_219_1:RecordAudio("421052054", var_222_11)
						arg_219_1:RecordAudio("421052054", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_421052", "421052054", "story_v_out_421052.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_421052", "421052054", "story_v_out_421052.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play421052055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 421052055
		arg_223_1.duration_ = 17.5

		local var_223_0 = {
			zh = 10,
			ja = 17.5
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play421052056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1047ui_story"]) and arg_223_1.var_.characterEffect1047ui_story == nil then
				arg_223_1.var_.characterEffect1047ui_story = arg_223_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1047ui_story"]) then
				if arg_223_1.var_.characterEffect1047ui_story and not isNil(arg_223_1.actors_["1047ui_story"]) then
					arg_223_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1047ui_story"]) and arg_223_1.var_.characterEffect1047ui_story then
				arg_223_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.825

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(421052055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 33 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_4) / 33)

				if (33 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_4) / 33)) > 0 and var_226_2 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052055", "story_v_out_421052.awb") ~= 0 then
					local var_226_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052055", "story_v_out_421052.awb") / 1000

					if var_226_7 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_1
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_421052", "421052055", "story_v_out_421052.awb")

						arg_223_1:RecordAudio("421052055", var_226_8)
						arg_223_1:RecordAudio("421052055", var_226_8)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_421052", "421052055", "story_v_out_421052.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_421052", "421052055", "story_v_out_421052.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_9 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_9 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_9

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_9 and arg_223_1.time_ < var_226_1 + var_226_9 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play421052056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 421052056
		arg_227_1.duration_ = 20.1

		local var_227_0 = {
			zh = 14.7,
			ja = 20.1
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play421052057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1047ui_story = arg_227_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).z)
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles = arg_227_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_227_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).z)
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles = arg_227_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1047ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1047ui_story == nil then
				arg_227_1.var_.characterEffect1047ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1047ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1047ui_story then
				arg_227_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_230_4 = 0
			local var_230_5 = 1.6

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(421052056)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 64 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 64)

				if (64 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 64)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052056", "story_v_out_421052.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052056", "story_v_out_421052.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_421052", "421052056", "story_v_out_421052.awb")

						arg_227_1:RecordAudio("421052056", var_230_11)
						arg_227_1:RecordAudio("421052056", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_421052", "421052056", "story_v_out_421052.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_421052", "421052056", "story_v_out_421052.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play421052057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 421052057
		arg_231_1.duration_ = 16.6

		local var_231_0 = {
			zh = 7.9,
			ja = 16.6
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play421052058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.925

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:GetWordFromCfg(421052057)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 37 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 37)

				if (37 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 37)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052057", "story_v_out_421052.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052057", "story_v_out_421052.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_421052", "421052057", "story_v_out_421052.awb")

						arg_231_1:RecordAudio("421052057", var_234_6)
						arg_231_1:RecordAudio("421052057", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_421052", "421052057", "story_v_out_421052.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_421052", "421052057", "story_v_out_421052.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play421052058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421052058
		arg_235_1.duration_ = 12.67

		local var_235_0 = {
			zh = 5.7,
			ja = 12.666
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play421052059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1047ui_story"]) and arg_235_1.var_.characterEffect1047ui_story == nil then
				arg_235_1.var_.characterEffect1047ui_story = arg_235_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1047ui_story"]) then
				if arg_235_1.var_.characterEffect1047ui_story and not isNil(arg_235_1.actors_["1047ui_story"]) then
					arg_235_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1047ui_story"]) and arg_235_1.var_.characterEffect1047ui_story then
				arg_235_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(421052058)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_6 = 22 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_4) / 22)

				if (22 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_4) / 22)) > 0 and var_238_2 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052058", "story_v_out_421052.awb") ~= 0 then
					local var_238_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052058", "story_v_out_421052.awb") / 1000

					if var_238_7 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_1
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_421052", "421052058", "story_v_out_421052.awb")

						arg_235_1:RecordAudio("421052058", var_238_8)
						arg_235_1:RecordAudio("421052058", var_238_8)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_421052", "421052058", "story_v_out_421052.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_421052", "421052058", "story_v_out_421052.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_9 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_9 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_9

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_9 and arg_235_1.time_ < var_238_1 + var_238_9 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play421052059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421052059
		arg_239_1.duration_ = 13.17

		local var_239_0 = {
			zh = 9.5,
			ja = 13.166
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play421052060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1047ui_story = arg_239_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).z)
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles = arg_239_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_239_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).z)
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles = arg_239_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1047ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1047ui_story == nil then
				arg_239_1.var_.characterEffect1047ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1047ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1047ui_story then
				arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_242_4 = 0
			local var_242_5 = 0.925

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(421052059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 37 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 37)

				if (37 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 37)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052059", "story_v_out_421052.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052059", "story_v_out_421052.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_421052", "421052059", "story_v_out_421052.awb")

						arg_239_1:RecordAudio("421052059", var_242_11)
						arg_239_1:RecordAudio("421052059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_421052", "421052059", "story_v_out_421052.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_421052", "421052059", "story_v_out_421052.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play421052060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 421052060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play421052061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1047ui_story"]) and arg_243_1.var_.characterEffect1047ui_story == nil then
				arg_243_1.var_.characterEffect1047ui_story = arg_243_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1047ui_story"]) then
				if arg_243_1.var_.characterEffect1047ui_story and not isNil(arg_243_1.actors_["1047ui_story"]) then
					arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1047ui_story"]) and arg_243_1.var_.characterEffect1047ui_story then
				arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 1.3

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(421052060).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 52 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 52)

				if (52 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 52)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play421052061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 421052061
		arg_247_1.duration_ = 19.07

		local var_247_0 = {
			zh = 13.133,
			ja = 19.066
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play421052062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(421052061)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)

				if (44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052061", "story_v_out_421052.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052061", "story_v_out_421052.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_421052", "421052061", "story_v_out_421052.awb")

						arg_247_1:RecordAudio("421052061", var_250_6)
						arg_247_1:RecordAudio("421052061", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_421052", "421052061", "story_v_out_421052.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_421052", "421052061", "story_v_out_421052.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play421052062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 421052062
		arg_251_1.duration_ = 5.7

		local var_251_0 = {
			zh = 4.4,
			ja = 5.7
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play421052063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1047ui_story = arg_251_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).z)
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles = arg_251_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_251_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).z)
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles = arg_251_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1047ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1047ui_story == nil then
				arg_251_1.var_.characterEffect1047ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1047ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1047ui_story then
				arg_251_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_254_4 = 0
			local var_254_5 = 0.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(421052062)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 15 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 15)

				if (15 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 15)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052062", "story_v_out_421052.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052062", "story_v_out_421052.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_out_421052", "421052062", "story_v_out_421052.awb")

						arg_251_1:RecordAudio("421052062", var_254_11)
						arg_251_1:RecordAudio("421052062", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_421052", "421052062", "story_v_out_421052.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_421052", "421052062", "story_v_out_421052.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play421052063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 421052063
		arg_255_1.duration_ = 9

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play421052064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if arg_255_1.bgs_.B08b == nil then
				local var_258_0 = Object.Instantiate(arg_255_1.paintGo_)

				var_258_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B08b")
				var_258_0.name = "B08b"
				var_258_0.transform.parent = arg_255_1.stage_.transform
				var_258_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.bgs_.B08b = var_258_0
			end

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				local var_258_1 = arg_255_1.bgs_.B08b

				arg_255_1.bgs_.B08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_258_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_2 = var_258_1:GetComponent("SpriteRenderer")

				if var_258_2 and var_258_2.sprite then
					local var_258_3 = 2 * (var_258_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_258_1.transform.localScale = Vector3.New(var_258_3 / var_258_2.sprite.bounds.size.y < var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x and var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x or var_258_3 / var_258_2.sprite.bounds.size.y, var_258_3 / var_258_2.sprite.bounds.size.y < var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x and var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x or var_258_3 / var_258_2.sprite.bounds.size.y, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "B08b" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_4 = 4

			if 4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			if arg_255_1.time_ >= var_258_4 + 0.3 and arg_255_1.time_ < var_258_4 + 0.3 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end

			local var_258_5 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_6 = 2

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 then
				local var_258_7 = Color.New(0, 0, 0)

				var_258_7.a = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_5) / var_258_6)
				arg_255_1.mask_.color = var_258_7
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 then
				local var_258_8 = Color.New(0, 0, 0)

				var_258_8.a = 1
				arg_255_1.mask_.color = var_258_8
			end

			local var_258_9 = 2

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_10 = 2

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 then
				local var_258_11 = Color.New(0, 0, 0)

				var_258_11.a = Mathf.Lerp(1, 0, (arg_255_1.time_ - var_258_9) / var_258_10)
				arg_255_1.mask_.color = var_258_11
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 then
				local var_258_12 = Color.New(0, 0, 0)

				arg_255_1.mask_.enabled = false
				var_258_12.a = 0
				arg_255_1.mask_.color = var_258_12
			end

			local var_258_13 = arg_255_1.actors_["1047ui_story"].transform

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				arg_255_1.var_.moveOldPos1047ui_story = var_258_13.localPosition
			end

			local var_258_14 = 0.001

			if 2 <= arg_255_1.time_ and arg_255_1.time_ < 2 + var_258_14 then
				var_258_13.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 2) / var_258_14)
				var_258_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_13.position).x, (manager.ui.mainCamera.transform.position - var_258_13.position).y, (manager.ui.mainCamera.transform.position - var_258_13.position).z)
				var_258_13.localEulerAngles.z = 0
				var_258_13.localEulerAngles.x = 0
				var_258_13.localEulerAngles = var_258_13.localEulerAngles
			end

			if arg_255_1.time_ >= 2 + var_258_14 and arg_255_1.time_ < 2 + var_258_14 + arg_258_0 then
				var_258_13.localPosition = Vector3.New(0, 100, 0)
				var_258_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_13.position).x, (manager.ui.mainCamera.transform.position - var_258_13.position).y, (manager.ui.mainCamera.transform.position - var_258_13.position).z)
				var_258_13.localEulerAngles.z = 0
				var_258_13.localEulerAngles.x = 0
				var_258_13.localEulerAngles = var_258_13.localEulerAngles
			end

			if 0.1 < arg_255_1.time_ and arg_255_1.time_ <= 0.1 + arg_258_0 then
				arg_255_1:AudioAction("stop", "effect", "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if 1.66666666666667 < arg_255_1.time_ and arg_255_1.time_ <= 1.66666666666667 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_17 = 4
			local var_258_18 = 0.85

			if 4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_17 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_19 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_19:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_20 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(421052063).content)

				arg_255_1.text_.text = var_258_20

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_22 = 34 <= 0 and var_258_18 or var_258_18 * (utf8.len(var_258_20) / 34)

				if (34 <= 0 and var_258_18 or var_258_18 * (utf8.len(var_258_20) / 34)) > 0 and var_258_18 < var_258_22 then
					arg_255_1.talkMaxDuration = var_258_22
					var_258_17 = var_258_17 + 0.3

					if var_258_22 + var_258_17 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_22 + var_258_17
					end
				end

				arg_255_1.text_.text = var_258_20
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_23 = var_258_17 + 0.3
			local var_258_24 = math.max(var_258_18, arg_255_1.talkMaxDuration)

			if var_258_17 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_23 + var_258_24 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_23) / var_258_24

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_23 + var_258_24 and arg_255_1.time_ < var_258_23 + var_258_24 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play421052064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 421052064
		arg_261_1.duration_ = 7.1

		local var_261_0 = {
			zh = 6.266,
			ja = 7.1
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play421052065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10102ui_story = arg_261_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).z)
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles = arg_261_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_261_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).z)
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles = arg_261_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["10102ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect10102ui_story == nil then
				arg_261_1.var_.characterEffect10102ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect10102ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect10102ui_story then
				arg_261_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_4 = 0
			local var_264_5 = 0.55

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(421052064)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 22 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 22)

				if (22 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 22)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052064", "story_v_out_421052.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052064", "story_v_out_421052.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_421052", "421052064", "story_v_out_421052.awb")

						arg_261_1:RecordAudio("421052064", var_264_11)
						arg_261_1:RecordAudio("421052064", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_421052", "421052064", "story_v_out_421052.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_421052", "421052064", "story_v_out_421052.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play421052065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 421052065
		arg_265_1.duration_ = 6.13

		local var_265_0 = {
			zh = 4.433,
			ja = 6.133
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play421052066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10102ui_story = arg_265_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10102ui_story"].transform.position).z)
				arg_265_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10102ui_story"].transform.localEulerAngles = arg_265_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10102ui_story"].transform.position).z)
				arg_265_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10102ui_story"].transform.localEulerAngles = arg_265_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_268_1 = "10143ui_story"

			if arg_265_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_268_2 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_265_1.stage_.transform)

				var_268_2.name = var_268_1
				var_268_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_[var_268_1] = var_268_2

				local var_268_3 = var_268_2:GetComponentInChildren(typeof(CharacterEffect))

				var_268_3.enabled = true

				local var_268_4 = GameObjectTools.GetOrAddComponent(var_268_2, typeof(DynamicBoneHelper))

				if var_268_4 then
					var_268_4:EnableDynamicBone(false)
				end

				arg_265_1:ShowWeapon(var_268_3.transform, false)

				arg_265_1.var_[var_268_1 .. "Animator"] = var_268_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_265_1.var_[var_268_1 .. "Animator"].applyRootMotion = true
				arg_265_1.var_[var_268_1 .. "LipSync"] = var_268_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_268_5 = arg_265_1.actors_["10143ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10143ui_story = var_268_5.localPosition
			end

			local var_268_6 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 then
				var_268_5.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_265_1.time_ - 0) / var_268_6)
				var_268_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_5.position).x, (manager.ui.mainCamera.transform.position - var_268_5.position).y, (manager.ui.mainCamera.transform.position - var_268_5.position).z)
				var_268_5.localEulerAngles.z = 0
				var_268_5.localEulerAngles.x = 0
				var_268_5.localEulerAngles = var_268_5.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 then
				var_268_5.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_268_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_5.position).x, (manager.ui.mainCamera.transform.position - var_268_5.position).y, (manager.ui.mainCamera.transform.position - var_268_5.position).z)
				var_268_5.localEulerAngles.z = 0
				var_268_5.localEulerAngles.x = 0
				var_268_5.localEulerAngles = var_268_5.localEulerAngles
			end

			local var_268_7 = arg_265_1.actors_["10143ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.characterEffect10143ui_story == nil then
				arg_265_1.var_.characterEffect10143ui_story = var_268_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_8 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_8 and not isNil(var_268_7) then
				if arg_265_1.var_.characterEffect10143ui_story and not isNil(var_268_7) then
					arg_265_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_8 and arg_265_1.time_ < 0 + var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.characterEffect10143ui_story then
				arg_265_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_268_10 = arg_265_1.actors_["10102ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_10) and arg_265_1.var_.characterEffect10102ui_story == nil then
				arg_265_1.var_.characterEffect10102ui_story = var_268_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_11 and not isNil(var_268_10) then
				if arg_265_1.var_.characterEffect10102ui_story and not isNil(var_268_10) then
					arg_265_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_11)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_11 and arg_265_1.time_ < 0 + var_268_11 + arg_268_0 and not isNil(var_268_10) and arg_265_1.var_.characterEffect10102ui_story then
				arg_265_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_268_12 = 0
			local var_268_13 = 0.55

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_14 = arg_265_1:GetWordFromCfg(421052065)
				local var_268_15 = arg_265_1:FormatText(var_268_14.content)

				arg_265_1.text_.text = var_268_15

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 22 <= 0 and var_268_13 or var_268_13 * (utf8.len(var_268_15) / 22)

				if (22 <= 0 and var_268_13 or var_268_13 * (utf8.len(var_268_15) / 22)) > 0 and var_268_13 < var_268_17 then
					arg_265_1.talkMaxDuration = var_268_17

					if var_268_17 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_17 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_15
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052065", "story_v_out_421052.awb") ~= 0 then
					local var_268_18 = manager.audio:GetVoiceLength("story_v_out_421052", "421052065", "story_v_out_421052.awb") / 1000

					if var_268_18 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_12
					end

					if var_268_14.prefab_name ~= "" and arg_265_1.actors_[var_268_14.prefab_name] ~= nil then
						local var_268_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_14.prefab_name].transform, "story_v_out_421052", "421052065", "story_v_out_421052.awb")

						arg_265_1:RecordAudio("421052065", var_268_19)
						arg_265_1:RecordAudio("421052065", var_268_19)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_421052", "421052065", "story_v_out_421052.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_421052", "421052065", "story_v_out_421052.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_20 and arg_265_1.time_ < var_268_12 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play421052066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 421052066
		arg_269_1.duration_ = 6.23

		local var_269_0 = {
			zh = 3.433,
			ja = 6.233
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
				arg_269_0:Play421052067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if arg_269_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_272_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_269_1.stage_.transform)

				var_272_0.name = "10145ui_story"
				var_272_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["10145ui_story"] = var_272_0

				local var_272_1 = var_272_0:GetComponentInChildren(typeof(CharacterEffect))

				var_272_1.enabled = true

				local var_272_2 = GameObjectTools.GetOrAddComponent(var_272_0, typeof(DynamicBoneHelper))

				if var_272_2 then
					var_272_2:EnableDynamicBone(false)
				end

				arg_269_1:ShowWeapon(var_272_1.transform, false)

				arg_269_1.var_["10145ui_story" .. "Animator"] = var_272_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_269_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_269_1.var_["10145ui_story" .. "LipSync"] = var_272_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_272_3 = arg_269_1.actors_["10145ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10145ui_story = var_272_3.localPosition
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_3.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_269_1.time_ - 0) / var_272_4)
				var_272_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_3.position).x, (manager.ui.mainCamera.transform.position - var_272_3.position).y, (manager.ui.mainCamera.transform.position - var_272_3.position).z)
				var_272_3.localEulerAngles.z = 0
				var_272_3.localEulerAngles.x = 0
				var_272_3.localEulerAngles = var_272_3.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_3.localPosition = Vector3.New(0.78, -1, -6.2)
				var_272_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_3.position).x, (manager.ui.mainCamera.transform.position - var_272_3.position).y, (manager.ui.mainCamera.transform.position - var_272_3.position).z)
				var_272_3.localEulerAngles.z = 0
				var_272_3.localEulerAngles.x = 0
				var_272_3.localEulerAngles = var_272_3.localEulerAngles
			end

			local var_272_5 = arg_269_1.actors_["10145ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect10145ui_story == nil then
				arg_269_1.var_.characterEffect10145ui_story = var_272_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_6 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.characterEffect10145ui_story and not isNil(var_272_5) then
					arg_269_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect10145ui_story then
				arg_269_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_272_8 = arg_269_1.actors_["10143ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.characterEffect10143ui_story == nil then
				arg_269_1.var_.characterEffect10143ui_story = var_272_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_9 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_9 and not isNil(var_272_8) then
				if arg_269_1.var_.characterEffect10143ui_story and not isNil(var_272_8) then
					arg_269_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_9)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_9 and arg_269_1.time_ < 0 + var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.characterEffect10143ui_story then
				arg_269_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_272_10 = 0
			local var_272_11 = 0.4

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_12 = arg_269_1:GetWordFromCfg(421052066)
				local var_272_13 = arg_269_1:FormatText(var_272_12.content)

				arg_269_1.text_.text = var_272_13

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_15 = 16 <= 0 and var_272_11 or var_272_11 * (utf8.len(var_272_13) / 16)

				if (16 <= 0 and var_272_11 or var_272_11 * (utf8.len(var_272_13) / 16)) > 0 and var_272_11 < var_272_15 then
					arg_269_1.talkMaxDuration = var_272_15

					if var_272_15 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_10
					end
				end

				arg_269_1.text_.text = var_272_13
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052066", "story_v_out_421052.awb") ~= 0 then
					local var_272_16 = manager.audio:GetVoiceLength("story_v_out_421052", "421052066", "story_v_out_421052.awb") / 1000

					if var_272_16 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_16 + var_272_10
					end

					if var_272_12.prefab_name ~= "" and arg_269_1.actors_[var_272_12.prefab_name] ~= nil then
						local var_272_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_12.prefab_name].transform, "story_v_out_421052", "421052066", "story_v_out_421052.awb")

						arg_269_1:RecordAudio("421052066", var_272_17)
						arg_269_1:RecordAudio("421052066", var_272_17)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_421052", "421052066", "story_v_out_421052.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_421052", "421052066", "story_v_out_421052.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_18 = math.max(var_272_11, arg_269_1.talkMaxDuration)

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_18 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_10) / var_272_18

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_10 + var_272_18 and arg_269_1.time_ < var_272_10 + var_272_18 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play421052067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421052067
		arg_273_1.duration_ = 2

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421052068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10143ui_story = arg_273_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10143ui_story"].transform.position).z)
				arg_273_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10143ui_story"].transform.localEulerAngles = arg_273_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_273_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10143ui_story"].transform.position).z)
				arg_273_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10143ui_story"].transform.localEulerAngles = arg_273_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10143ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10143ui_story == nil then
				arg_273_1.var_.characterEffect10143ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10143ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10143ui_story then
				arg_273_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["10145ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect10145ui_story == nil then
				arg_273_1.var_.characterEffect10145ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_5 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 and not isNil(var_276_4) then
				if arg_273_1.var_.characterEffect10145ui_story and not isNil(var_276_4) then
					arg_273_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_5)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect10145ui_story then
				arg_273_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_276_6 = 0
			local var_276_7 = 0.075

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(421052067)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 3 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 3)

				if (3 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 3)) > 0 and var_276_7 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052067", "story_v_out_421052.awb") ~= 0 then
					local var_276_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052067", "story_v_out_421052.awb") / 1000

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_out_421052", "421052067", "story_v_out_421052.awb")

						arg_273_1:RecordAudio("421052067", var_276_13)
						arg_273_1:RecordAudio("421052067", var_276_13)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_421052", "421052067", "story_v_out_421052.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_421052", "421052067", "story_v_out_421052.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play421052068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421052068
		arg_277_1.duration_ = 2.63

		local var_277_0 = {
			zh = 2.633,
			ja = 2.2
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
				arg_277_0:Play421052069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10145ui_story = arg_277_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10145ui_story"].transform.position).z)
				arg_277_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10145ui_story"].transform.localEulerAngles = arg_277_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_277_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10145ui_story"].transform.position).z)
				arg_277_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10145ui_story"].transform.localEulerAngles = arg_277_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["10145ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10145ui_story == nil then
				arg_277_1.var_.characterEffect10145ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect10145ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10145ui_story then
				arg_277_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["10143ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10143ui_story == nil then
				arg_277_1.var_.characterEffect10143ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_5 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 and not isNil(var_280_4) then
				if arg_277_1.var_.characterEffect10143ui_story and not isNil(var_280_4) then
					arg_277_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_5)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10143ui_story then
				arg_277_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.35

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

				local var_280_8 = arg_277_1:GetWordFromCfg(421052068)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 14 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 14)

				if (14 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 14)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052068", "story_v_out_421052.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052068", "story_v_out_421052.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_421052", "421052068", "story_v_out_421052.awb")

						arg_277_1:RecordAudio("421052068", var_280_13)
						arg_277_1:RecordAudio("421052068", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_421052", "421052068", "story_v_out_421052.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_421052", "421052068", "story_v_out_421052.awb")
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
	Play421052069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 421052069
		arg_281_1.duration_ = 9.3

		local var_281_0 = {
			zh = 5.1,
			ja = 9.3
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play421052070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10143ui_story = arg_281_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10143ui_story"].transform.position).z)
				arg_281_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10143ui_story"].transform.localEulerAngles = arg_281_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_281_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10143ui_story"].transform.position).z)
				arg_281_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10143ui_story"].transform.localEulerAngles = arg_281_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["10143ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10143ui_story == nil then
				arg_281_1.var_.characterEffect10143ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect10143ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10143ui_story then
				arg_281_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_284_4 = arg_281_1.actors_["10145ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect10145ui_story == nil then
				arg_281_1.var_.characterEffect10145ui_story = var_284_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_5 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_5 and not isNil(var_284_4) then
				if arg_281_1.var_.characterEffect10145ui_story and not isNil(var_284_4) then
					arg_281_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_5)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_5 and arg_281_1.time_ < 0 + var_284_5 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect10145ui_story then
				arg_281_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_284_6 = 0
			local var_284_7 = 0.625

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:GetWordFromCfg(421052069)
				local var_284_9 = arg_281_1:FormatText(var_284_8.content)

				arg_281_1.text_.text = var_284_9

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 25 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_9) / 25)

				if (25 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_9) / 25)) > 0 and var_284_7 < var_284_11 then
					arg_281_1.talkMaxDuration = var_284_11

					if var_284_11 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_9
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052069", "story_v_out_421052.awb") ~= 0 then
					local var_284_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052069", "story_v_out_421052.awb") / 1000

					if var_284_12 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_6
					end

					if var_284_8.prefab_name ~= "" and arg_281_1.actors_[var_284_8.prefab_name] ~= nil then
						local var_284_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_8.prefab_name].transform, "story_v_out_421052", "421052069", "story_v_out_421052.awb")

						arg_281_1:RecordAudio("421052069", var_284_13)
						arg_281_1:RecordAudio("421052069", var_284_13)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_421052", "421052069", "story_v_out_421052.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_421052", "421052069", "story_v_out_421052.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play421052070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421052070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play421052071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10143ui_story"]) and arg_285_1.var_.characterEffect10143ui_story == nil then
				arg_285_1.var_.characterEffect10143ui_story = arg_285_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10143ui_story"]) then
				if arg_285_1.var_.characterEffect10143ui_story and not isNil(arg_285_1.actors_["10143ui_story"]) then
					arg_285_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10143ui_story"]) and arg_285_1.var_.characterEffect10143ui_story then
				arg_285_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.35

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
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

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(421052070).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 14 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 14)

				if (14 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 14)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play421052071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421052071
		arg_289_1.duration_ = 3.3

		local var_289_0 = {
			zh = 2.066,
			ja = 3.3
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
				arg_289_0:Play421052072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10145ui_story = arg_289_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10145ui_story"].transform.position).z)
				arg_289_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10145ui_story"].transform.localEulerAngles = arg_289_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_289_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10145ui_story"].transform.position).z)
				arg_289_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10145ui_story"].transform.localEulerAngles = arg_289_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["10145ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10145ui_story == nil then
				arg_289_1.var_.characterEffect10145ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect10145ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10145ui_story then
				arg_289_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.225

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(421052071)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 9 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 9)

				if (9 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 9)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052071", "story_v_out_421052.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052071", "story_v_out_421052.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_421052", "421052071", "story_v_out_421052.awb")

						arg_289_1:RecordAudio("421052071", var_292_11)
						arg_289_1:RecordAudio("421052071", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421052", "421052071", "story_v_out_421052.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421052", "421052071", "story_v_out_421052.awb")
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
				actorName = "10145ui_story",
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
	Play421052072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421052072
		arg_293_1.duration_ = 5

		local var_293_0 = {
			zh = 3.1,
			ja = 5
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
				arg_293_0:Play421052073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10145ui_story = arg_293_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).z)
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles = arg_293_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10145ui_story"].transform.position).z)
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10145ui_story"].transform.localEulerAngles = arg_293_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["10143ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10143ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(0, 100, 0)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			local var_296_3 = arg_293_1.actors_["1047ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1047ui_story = var_296_3.localPosition
			end

			local var_296_4 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				var_296_3.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_293_1.time_ - 0) / var_296_4)
				var_296_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_3.position).x, (manager.ui.mainCamera.transform.position - var_296_3.position).y, (manager.ui.mainCamera.transform.position - var_296_3.position).z)
				var_296_3.localEulerAngles.z = 0
				var_296_3.localEulerAngles.x = 0
				var_296_3.localEulerAngles = var_296_3.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				var_296_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_296_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_3.position).x, (manager.ui.mainCamera.transform.position - var_296_3.position).y, (manager.ui.mainCamera.transform.position - var_296_3.position).z)
				var_296_3.localEulerAngles.z = 0
				var_296_3.localEulerAngles.x = 0
				var_296_3.localEulerAngles = var_296_3.localEulerAngles
			end

			local var_296_5 = arg_293_1.actors_["1047ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.characterEffect1047ui_story == nil then
				arg_293_1.var_.characterEffect1047ui_story = var_296_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_6 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_6 and not isNil(var_296_5) then
				if arg_293_1.var_.characterEffect1047ui_story and not isNil(var_296_5) then
					arg_293_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_6 and arg_293_1.time_ < 0 + var_296_6 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.characterEffect1047ui_story then
				arg_293_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_296_8 = arg_293_1.actors_["10145ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.characterEffect10145ui_story == nil then
				arg_293_1.var_.characterEffect10145ui_story = var_296_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_9 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_9 and not isNil(var_296_8) then
				if arg_293_1.var_.characterEffect10145ui_story and not isNil(var_296_8) then
					arg_293_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_9)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_9 and arg_293_1.time_ < 0 + var_296_9 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.characterEffect10145ui_story then
				arg_293_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_296_10 = 0
			local var_296_11 = 0.575

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_12 = arg_293_1:GetWordFromCfg(421052072)
				local var_296_13 = arg_293_1:FormatText(var_296_12.content)

				arg_293_1.text_.text = var_296_13

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_15 = 23 <= 0 and var_296_11 or var_296_11 * (utf8.len(var_296_13) / 23)

				if (23 <= 0 and var_296_11 or var_296_11 * (utf8.len(var_296_13) / 23)) > 0 and var_296_11 < var_296_15 then
					arg_293_1.talkMaxDuration = var_296_15

					if var_296_15 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_15 + var_296_10
					end
				end

				arg_293_1.text_.text = var_296_13
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052072", "story_v_out_421052.awb") ~= 0 then
					local var_296_16 = manager.audio:GetVoiceLength("story_v_out_421052", "421052072", "story_v_out_421052.awb") / 1000

					if var_296_16 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_16 + var_296_10
					end

					if var_296_12.prefab_name ~= "" and arg_293_1.actors_[var_296_12.prefab_name] ~= nil then
						local var_296_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_12.prefab_name].transform, "story_v_out_421052", "421052072", "story_v_out_421052.awb")

						arg_293_1:RecordAudio("421052072", var_296_17)
						arg_293_1:RecordAudio("421052072", var_296_17)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_421052", "421052072", "story_v_out_421052.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_421052", "421052072", "story_v_out_421052.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_18 = math.max(var_296_11, arg_293_1.talkMaxDuration)

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_18 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_10) / var_296_18

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_10 + var_296_18 and arg_293_1.time_ < var_296_10 + var_296_18 + arg_296_0 then
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

		arg_293_1:InitPlayNodeList()
	end,
	Play421052073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421052073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421052074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) and arg_297_1.var_.characterEffect1047ui_story == nil then
				arg_297_1.var_.characterEffect1047ui_story = arg_297_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) then
				if arg_297_1.var_.characterEffect1047ui_story and not isNil(arg_297_1.actors_["1047ui_story"]) then
					arg_297_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) and arg_297_1.var_.characterEffect1047ui_story then
				arg_297_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.95

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(421052073).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 38 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 38)

				if (38 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 38)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play421052074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 421052074
		arg_301_1.duration_ = 14.1

		local var_301_0 = {
			zh = 10.3,
			ja = 14.1
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
				arg_301_0:Play421052075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1047ui_story = arg_301_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1047ui_story"].transform.position).z)
				arg_301_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1047ui_story"].transform.localEulerAngles = arg_301_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_301_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1047ui_story"].transform.position).z)
				arg_301_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1047ui_story"].transform.localEulerAngles = arg_301_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1047ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1047ui_story == nil then
				arg_301_1.var_.characterEffect1047ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1047ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1047ui_story then
				arg_301_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_304_4 = 0
			local var_304_5 = 1.05

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(421052074)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 42 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 42)

				if (42 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 42)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052074", "story_v_out_421052.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052074", "story_v_out_421052.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_421052", "421052074", "story_v_out_421052.awb")

						arg_301_1:RecordAudio("421052074", var_304_11)
						arg_301_1:RecordAudio("421052074", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_421052", "421052074", "story_v_out_421052.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_421052", "421052074", "story_v_out_421052.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play421052075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 421052075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play421052076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1047ui_story"]) and arg_305_1.var_.characterEffect1047ui_story == nil then
				arg_305_1.var_.characterEffect1047ui_story = arg_305_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1047ui_story"]) then
				if arg_305_1.var_.characterEffect1047ui_story and not isNil(arg_305_1.actors_["1047ui_story"]) then
					arg_305_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1047ui_story"]) and arg_305_1.var_.characterEffect1047ui_story then
				arg_305_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.875

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

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(421052075).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 35 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 35)

				if (35 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 35)) > 0 and var_308_2 < var_308_5 then
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
	Play421052076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 421052076
		arg_309_1.duration_ = 6.73

		local var_309_0 = {
			zh = 6.6,
			ja = 6.733
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
				arg_309_0:Play421052077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1047ui_story = arg_309_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).z)
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles = arg_309_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_309_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).z)
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles = arg_309_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1047ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1047ui_story == nil then
				arg_309_1.var_.characterEffect1047ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1047ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1047ui_story then
				arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_312_4 = 0
			local var_312_5 = 0.8

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(421052076)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 32 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 32)

				if (32 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 32)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052076", "story_v_out_421052.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052076", "story_v_out_421052.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_421052", "421052076", "story_v_out_421052.awb")

						arg_309_1:RecordAudio("421052076", var_312_11)
						arg_309_1:RecordAudio("421052076", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_421052", "421052076", "story_v_out_421052.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_421052", "421052076", "story_v_out_421052.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play421052077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 421052077
		arg_313_1.duration_ = 6.23

		local var_313_0 = {
			zh = 4.566,
			ja = 6.233
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play421052078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10102ui_story = arg_313_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).z)
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles = arg_313_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_313_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).z)
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles = arg_313_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1047ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1047ui_story = var_316_1.localPosition
			end

			local var_316_2 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 then
				var_316_1.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_313_1.time_ - 0) / var_316_2)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 then
				var_316_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			local var_316_3 = arg_313_1.actors_["10102ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect10102ui_story == nil then
				arg_313_1.var_.characterEffect10102ui_story = var_316_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_4 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 and not isNil(var_316_3) then
				if arg_313_1.var_.characterEffect10102ui_story and not isNil(var_316_3) then
					arg_313_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect10102ui_story then
				arg_313_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_316_6 = arg_313_1.actors_["1047ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect1047ui_story == nil then
				arg_313_1.var_.characterEffect1047ui_story = var_316_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_7 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 and not isNil(var_316_6) then
				if arg_313_1.var_.characterEffect1047ui_story and not isNil(var_316_6) then
					arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_7)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect1047ui_story then
				arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_8 = 0
			local var_316_9 = 0.5

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(421052077)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 20 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 20)

				if (20 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 20)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052077", "story_v_out_421052.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052077", "story_v_out_421052.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_421052", "421052077", "story_v_out_421052.awb")

						arg_313_1:RecordAudio("421052077", var_316_15)
						arg_313_1:RecordAudio("421052077", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_421052", "421052077", "story_v_out_421052.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_421052", "421052077", "story_v_out_421052.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play421052078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 421052078
		arg_317_1.duration_ = 8.23

		local var_317_0 = {
			zh = 6.2,
			ja = 8.233
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play421052079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1047ui_story = arg_317_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1047ui_story"].transform.position).z)
				arg_317_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1047ui_story"].transform.localEulerAngles = arg_317_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_317_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1047ui_story"].transform.position).z)
				arg_317_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1047ui_story"].transform.localEulerAngles = arg_317_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1047ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1047ui_story == nil then
				arg_317_1.var_.characterEffect1047ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1047ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1047ui_story then
				arg_317_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_320_4 = arg_317_1.actors_["10102ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect10102ui_story == nil then
				arg_317_1.var_.characterEffect10102ui_story = var_320_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_5 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_5 and not isNil(var_320_4) then
				if arg_317_1.var_.characterEffect10102ui_story and not isNil(var_320_4) then
					arg_317_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_5)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_5 and arg_317_1.time_ < 0 + var_320_5 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect10102ui_story then
				arg_317_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_6 = 0
			local var_320_7 = 0.7

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_8 = arg_317_1:GetWordFromCfg(421052078)
				local var_320_9 = arg_317_1:FormatText(var_320_8.content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 28 <= 0 and var_320_7 or var_320_7 * (utf8.len(var_320_9) / 28)

				if (28 <= 0 and var_320_7 or var_320_7 * (utf8.len(var_320_9) / 28)) > 0 and var_320_7 < var_320_11 then
					arg_317_1.talkMaxDuration = var_320_11

					if var_320_11 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052078", "story_v_out_421052.awb") ~= 0 then
					local var_320_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052078", "story_v_out_421052.awb") / 1000

					if var_320_12 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_6
					end

					if var_320_8.prefab_name ~= "" and arg_317_1.actors_[var_320_8.prefab_name] ~= nil then
						local var_320_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_8.prefab_name].transform, "story_v_out_421052", "421052078", "story_v_out_421052.awb")

						arg_317_1:RecordAudio("421052078", var_320_13)
						arg_317_1:RecordAudio("421052078", var_320_13)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_421052", "421052078", "story_v_out_421052.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_421052", "421052078", "story_v_out_421052.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play421052079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421052079
		arg_321_1.duration_ = 2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play421052080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10143ui_story = arg_321_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10143ui_story"].transform.position).z)
				arg_321_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10143ui_story"].transform.localEulerAngles = arg_321_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_321_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10143ui_story"].transform.position).z)
				arg_321_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10143ui_story"].transform.localEulerAngles = arg_321_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["10102ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10102ui_story = var_324_1.localPosition
			end

			local var_324_2 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 then
				var_324_1.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_2)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 then
				var_324_1.localPosition = Vector3.New(0, 100, 0)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			local var_324_3 = arg_321_1.actors_["10143ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect10143ui_story == nil then
				arg_321_1.var_.characterEffect10143ui_story = var_324_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_4 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 and not isNil(var_324_3) then
				if arg_321_1.var_.characterEffect10143ui_story and not isNil(var_324_3) then
					arg_321_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect10143ui_story then
				arg_321_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_324_6 = arg_321_1.actors_["1047ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect1047ui_story == nil then
				arg_321_1.var_.characterEffect1047ui_story = var_324_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_7 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 and not isNil(var_324_6) then
				if arg_321_1.var_.characterEffect1047ui_story and not isNil(var_324_6) then
					arg_321_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_7)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect1047ui_story then
				arg_321_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_324_8 = 0
			local var_324_9 = 0.075

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_10 = arg_321_1:GetWordFromCfg(421052079)
				local var_324_11 = arg_321_1:FormatText(var_324_10.content)

				arg_321_1.text_.text = var_324_11

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 3 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 3)

				if (3 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 3)) > 0 and var_324_9 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_8
					end
				end

				arg_321_1.text_.text = var_324_11
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052079", "story_v_out_421052.awb") ~= 0 then
					local var_324_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052079", "story_v_out_421052.awb") / 1000

					if var_324_14 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_8
					end

					if var_324_10.prefab_name ~= "" and arg_321_1.actors_[var_324_10.prefab_name] ~= nil then
						local var_324_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_10.prefab_name].transform, "story_v_out_421052", "421052079", "story_v_out_421052.awb")

						arg_321_1:RecordAudio("421052079", var_324_15)
						arg_321_1:RecordAudio("421052079", var_324_15)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_421052", "421052079", "story_v_out_421052.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_421052", "421052079", "story_v_out_421052.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_9, arg_321_1.talkMaxDuration)

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_8) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_8 + var_324_16 and arg_321_1.time_ < var_324_8 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play421052080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421052080
		arg_325_1.duration_ = 19.73

		local var_325_0 = {
			zh = 10.933,
			ja = 19.733
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421052081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1047ui_story = arg_325_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1047ui_story"].transform.position).z)
				arg_325_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1047ui_story"].transform.localEulerAngles = arg_325_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_325_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1047ui_story"].transform.position).z)
				arg_325_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1047ui_story"].transform.localEulerAngles = arg_325_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1047ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1047ui_story == nil then
				arg_325_1.var_.characterEffect1047ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1047ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1047ui_story then
				arg_325_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["10143ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10143ui_story == nil then
				arg_325_1.var_.characterEffect10143ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_5 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 and not isNil(var_328_4) then
				if arg_325_1.var_.characterEffect10143ui_story and not isNil(var_328_4) then
					arg_325_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_5)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10143ui_story then
				arg_325_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_328_6 = 0
			local var_328_7 = 1.1

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(421052080)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 44 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 44)

				if (44 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 44)) > 0 and var_328_7 < var_328_11 then
					arg_325_1.talkMaxDuration = var_328_11

					if var_328_11 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052080", "story_v_out_421052.awb") ~= 0 then
					local var_328_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052080", "story_v_out_421052.awb") / 1000

					if var_328_12 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_6
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_out_421052", "421052080", "story_v_out_421052.awb")

						arg_325_1:RecordAudio("421052080", var_328_13)
						arg_325_1:RecordAudio("421052080", var_328_13)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_421052", "421052080", "story_v_out_421052.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_421052", "421052080", "story_v_out_421052.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play421052081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421052081
		arg_329_1.duration_ = 11.7

		local var_329_0 = {
			zh = 9.733,
			ja = 11.7
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421052082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if arg_329_1.bgs_.ST2401 == nil then
				local var_332_0 = Object.Instantiate(arg_329_1.paintGo_)

				var_332_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_332_0.name = "ST2401"
				var_332_0.transform.parent = arg_329_1.stage_.transform
				var_332_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.bgs_.ST2401 = var_332_0
			end

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				local var_332_1 = arg_329_1.bgs_.ST2401

				arg_329_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_332_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_2 = var_332_1:GetComponent("SpriteRenderer")

				if var_332_2 and var_332_2.sprite then
					local var_332_3 = 2 * (var_332_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_332_1.transform.localScale = Vector3.New(var_332_3 / var_332_2.sprite.bounds.size.y < var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x and var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x or var_332_3 / var_332_2.sprite.bounds.size.y, var_332_3 / var_332_2.sprite.bounds.size.y < var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x and var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x or var_332_3 / var_332_2.sprite.bounds.size.y, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "ST2401" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_4 = 4

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_4 + 0.3 and arg_329_1.time_ < var_332_4 + 0.3 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_5 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_6 = 2

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_6 then
				local var_332_7 = Color.New(0, 0, 0)

				var_332_7.a = Mathf.Lerp(0, 1, (arg_329_1.time_ - var_332_5) / var_332_6)
				arg_329_1.mask_.color = var_332_7
			end

			if arg_329_1.time_ >= var_332_5 + var_332_6 and arg_329_1.time_ < var_332_5 + var_332_6 + arg_332_0 then
				local var_332_8 = Color.New(0, 0, 0)

				var_332_8.a = 1
				arg_329_1.mask_.color = var_332_8
			end

			local var_332_9 = 2

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_10 = 2

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 then
				local var_332_11 = Color.New(0, 0, 0)

				var_332_11.a = Mathf.Lerp(1, 0, (arg_329_1.time_ - var_332_9) / var_332_10)
				arg_329_1.mask_.color = var_332_11
			end

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 then
				local var_332_12 = Color.New(0, 0, 0)

				arg_329_1.mask_.enabled = false
				var_332_12.a = 0
				arg_329_1.mask_.color = var_332_12
			end

			local var_332_13 = arg_329_1.actors_["10143ui_story"].transform

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				arg_329_1.var_.moveOldPos10143ui_story = var_332_13.localPosition
			end

			local var_332_14 = 0.001

			if 2 <= arg_329_1.time_ and arg_329_1.time_ < 2 + var_332_14 then
				var_332_13.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 2) / var_332_14)
				var_332_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_13.position).x, (manager.ui.mainCamera.transform.position - var_332_13.position).y, (manager.ui.mainCamera.transform.position - var_332_13.position).z)
				var_332_13.localEulerAngles.z = 0
				var_332_13.localEulerAngles.x = 0
				var_332_13.localEulerAngles = var_332_13.localEulerAngles
			end

			if arg_329_1.time_ >= 2 + var_332_14 and arg_329_1.time_ < 2 + var_332_14 + arg_332_0 then
				var_332_13.localPosition = Vector3.New(0, 100, 0)
				var_332_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_13.position).x, (manager.ui.mainCamera.transform.position - var_332_13.position).y, (manager.ui.mainCamera.transform.position - var_332_13.position).z)
				var_332_13.localEulerAngles.z = 0
				var_332_13.localEulerAngles.x = 0
				var_332_13.localEulerAngles = var_332_13.localEulerAngles
			end

			local var_332_15 = arg_329_1.actors_["1047ui_story"].transform

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = var_332_15.localPosition
			end

			local var_332_16 = 0.001

			if 2 <= arg_329_1.time_ and arg_329_1.time_ < 2 + var_332_16 then
				var_332_15.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 2) / var_332_16)
				var_332_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_15.position).x, (manager.ui.mainCamera.transform.position - var_332_15.position).y, (manager.ui.mainCamera.transform.position - var_332_15.position).z)
				var_332_15.localEulerAngles.z = 0
				var_332_15.localEulerAngles.x = 0
				var_332_15.localEulerAngles = var_332_15.localEulerAngles
			end

			if arg_329_1.time_ >= 2 + var_332_16 and arg_329_1.time_ < 2 + var_332_16 + arg_332_0 then
				var_332_15.localPosition = Vector3.New(0, 100, 0)
				var_332_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_15.position).x, (manager.ui.mainCamera.transform.position - var_332_15.position).y, (manager.ui.mainCamera.transform.position - var_332_15.position).z)
				var_332_15.localEulerAngles.z = 0
				var_332_15.localEulerAngles.x = 0
				var_332_15.localEulerAngles = var_332_15.localEulerAngles
			end

			local var_332_17 = arg_329_1.actors_["1047ui_story"].transform

			if 3.8 < arg_329_1.time_ and arg_329_1.time_ <= 3.8 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = var_332_17.localPosition
			end

			local var_332_18 = 0.001

			if 3.8 <= arg_329_1.time_ and arg_329_1.time_ < 3.8 + var_332_18 then
				var_332_17.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_329_1.time_ - 3.8) / var_332_18)
				var_332_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_17.position).x, (manager.ui.mainCamera.transform.position - var_332_17.position).y, (manager.ui.mainCamera.transform.position - var_332_17.position).z)
				var_332_17.localEulerAngles.z = 0
				var_332_17.localEulerAngles.x = 0
				var_332_17.localEulerAngles = var_332_17.localEulerAngles
			end

			if arg_329_1.time_ >= 3.8 + var_332_18 and arg_329_1.time_ < 3.8 + var_332_18 + arg_332_0 then
				var_332_17.localPosition = Vector3.New(0, -1.13, -6.2)
				var_332_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_17.position).x, (manager.ui.mainCamera.transform.position - var_332_17.position).y, (manager.ui.mainCamera.transform.position - var_332_17.position).z)
				var_332_17.localEulerAngles.z = 0
				var_332_17.localEulerAngles.x = 0
				var_332_17.localEulerAngles = var_332_17.localEulerAngles
			end

			if 3.8 < arg_329_1.time_ and arg_329_1.time_ <= 3.8 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 3.8 < arg_329_1.time_ and arg_329_1.time_ <= 3.8 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_332_19 = arg_329_1.actors_["1047ui_story"]

			if 3.8 < arg_329_1.time_ and arg_329_1.time_ <= 3.8 + arg_332_0 and not isNil(var_332_19) and arg_329_1.var_.characterEffect1047ui_story == nil then
				arg_329_1.var_.characterEffect1047ui_story = var_332_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_20 = 0.200000002980232

			if 3.8 <= arg_329_1.time_ and arg_329_1.time_ < 3.8 + var_332_20 and not isNil(var_332_19) then
				if arg_329_1.var_.characterEffect1047ui_story and not isNil(var_332_19) then
					arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 3.8 + var_332_20 and arg_329_1.time_ < 3.8 + var_332_20 + arg_332_0 and not isNil(var_332_19) and arg_329_1.var_.characterEffect1047ui_story then
				arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0.1 < arg_329_1.time_ and arg_329_1.time_ <= 0.1 + arg_332_0 then
				arg_329_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 1.6 < arg_329_1.time_ and arg_329_1.time_ <= 1.6 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_24 = 4
			local var_332_25 = 0.65

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= var_332_24 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_26 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_26:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_27 = arg_329_1:GetWordFromCfg(421052081)
				local var_332_28 = arg_329_1:FormatText(var_332_27.content)

				arg_329_1.text_.text = var_332_28

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_30 = 26 <= 0 and var_332_25 or var_332_25 * (utf8.len(var_332_28) / 26)

				if (26 <= 0 and var_332_25 or var_332_25 * (utf8.len(var_332_28) / 26)) > 0 and var_332_25 < var_332_30 then
					arg_329_1.talkMaxDuration = var_332_30
					var_332_24 = var_332_24 + 0.3

					if var_332_30 + var_332_24 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_30 + var_332_24
					end
				end

				arg_329_1.text_.text = var_332_28
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052081", "story_v_out_421052.awb") ~= 0 then
					local var_332_31 = manager.audio:GetVoiceLength("story_v_out_421052", "421052081", "story_v_out_421052.awb") / 1000

					if var_332_31 + var_332_24 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_31 + var_332_24
					end

					if var_332_27.prefab_name ~= "" and arg_329_1.actors_[var_332_27.prefab_name] ~= nil then
						local var_332_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_27.prefab_name].transform, "story_v_out_421052", "421052081", "story_v_out_421052.awb")

						arg_329_1:RecordAudio("421052081", var_332_32)
						arg_329_1:RecordAudio("421052081", var_332_32)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_421052", "421052081", "story_v_out_421052.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_421052", "421052081", "story_v_out_421052.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_33 = var_332_24 + 0.3
			local var_332_34 = math.max(var_332_25, arg_329_1.talkMaxDuration)

			if var_332_24 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_33 + var_332_34 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_33) / var_332_34

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_33 + var_332_34 and arg_329_1.time_ < var_332_33 + var_332_34 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play421052082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 421052082
		arg_335_1.duration_ = 9.9

		local var_335_0 = {
			zh = 8.266,
			ja = 9.9
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
				arg_335_0:Play421052083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10102ui_story = arg_335_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["10102ui_story"].transform.position).z)
				arg_335_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["10102ui_story"].transform.localEulerAngles = arg_335_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_335_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["10102ui_story"].transform.position).z)
				arg_335_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["10102ui_story"].transform.localEulerAngles = arg_335_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1047ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1047ui_story = var_338_1.localPosition
			end

			local var_338_2 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 then
				var_338_1.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_335_1.time_ - 0) / var_338_2)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 then
				var_338_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			local var_338_3 = arg_335_1.actors_["10102ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect10102ui_story == nil then
				arg_335_1.var_.characterEffect10102ui_story = var_338_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 and not isNil(var_338_3) then
				if arg_335_1.var_.characterEffect10102ui_story and not isNil(var_338_3) then
					arg_335_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect10102ui_story then
				arg_335_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_338_6 = arg_335_1.actors_["1047ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect1047ui_story == nil then
				arg_335_1.var_.characterEffect1047ui_story = var_338_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_7 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 and not isNil(var_338_6) then
				if arg_335_1.var_.characterEffect1047ui_story and not isNil(var_338_6) then
					arg_335_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_7)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect1047ui_story then
				arg_335_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_338_8 = 0
			local var_338_9 = 1.2

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(421052082)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 48 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 48)

				if (48 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 48)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052082", "story_v_out_421052.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052082", "story_v_out_421052.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_out_421052", "421052082", "story_v_out_421052.awb")

						arg_335_1:RecordAudio("421052082", var_338_15)
						arg_335_1:RecordAudio("421052082", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_421052", "421052082", "story_v_out_421052.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_421052", "421052082", "story_v_out_421052.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play421052083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 421052083
		arg_339_1.duration_ = 11.97

		local var_339_0 = {
			zh = 8.066,
			ja = 11.966
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
				arg_339_0:Play421052084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1047ui_story = arg_339_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).z)
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles = arg_339_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
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

			local var_342_4 = arg_339_1.actors_["10102ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.characterEffect10102ui_story == nil then
				arg_339_1.var_.characterEffect10102ui_story = var_342_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_5 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_5 and not isNil(var_342_4) then
				if arg_339_1.var_.characterEffect10102ui_story and not isNil(var_342_4) then
					arg_339_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_339_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_5)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_5 and arg_339_1.time_ < 0 + var_342_5 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.characterEffect10102ui_story then
				arg_339_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_339_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_342_6 = 0
			local var_342_7 = 0.925

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
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

				local var_342_8 = arg_339_1:GetWordFromCfg(421052083)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 37 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 37)

				if (37 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 37)) > 0 and var_342_7 < var_342_11 then
					arg_339_1.talkMaxDuration = var_342_11

					if var_342_11 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052083", "story_v_out_421052.awb") ~= 0 then
					local var_342_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052083", "story_v_out_421052.awb") / 1000

					if var_342_12 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_6
					end

					if var_342_8.prefab_name ~= "" and arg_339_1.actors_[var_342_8.prefab_name] ~= nil then
						local var_342_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_8.prefab_name].transform, "story_v_out_421052", "421052083", "story_v_out_421052.awb")

						arg_339_1:RecordAudio("421052083", var_342_13)
						arg_339_1:RecordAudio("421052083", var_342_13)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_421052", "421052083", "story_v_out_421052.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_421052", "421052083", "story_v_out_421052.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
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
	Play421052084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 421052084
		arg_343_1.duration_ = 19.53

		local var_343_0 = {
			zh = 13,
			ja = 19.533
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
				arg_343_0:Play421052085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1047ui_story = arg_343_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).z)
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles = arg_343_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_343_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).z)
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles = arg_343_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_346_1 = 0
			local var_346_2 = 1.6

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
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

				local var_346_3 = arg_343_1:GetWordFromCfg(421052084)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 64 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 64)

				if (64 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 64)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052084", "story_v_out_421052.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052084", "story_v_out_421052.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_421052", "421052084", "story_v_out_421052.awb")

						arg_343_1:RecordAudio("421052084", var_346_8)
						arg_343_1:RecordAudio("421052084", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_421052", "421052084", "story_v_out_421052.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_421052", "421052084", "story_v_out_421052.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	Play421052085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 421052085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play421052086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1047ui_story"]) and arg_347_1.var_.characterEffect1047ui_story == nil then
				arg_347_1.var_.characterEffect1047ui_story = arg_347_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1047ui_story"]) then
				if arg_347_1.var_.characterEffect1047ui_story and not isNil(arg_347_1.actors_["1047ui_story"]) then
					arg_347_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1047ui_story"]) and arg_347_1.var_.characterEffect1047ui_story then
				arg_347_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.325

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(421052085).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 13 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 13)

				if (13 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 13)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play421052086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 421052086
		arg_351_1.duration_ = 13.9

		local var_351_0 = {
			zh = 8.466,
			ja = 13.9
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
				arg_351_0:Play421052087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1047ui_story = arg_351_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).z)
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles = arg_351_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_351_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).z)
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles = arg_351_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["1047ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1047ui_story == nil then
				arg_351_1.var_.characterEffect1047ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1047ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1047ui_story then
				arg_351_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_354_4 = 0
			local var_354_5 = 0.975

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(421052086)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 39 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 39)

				if (39 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 39)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052086", "story_v_out_421052.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052086", "story_v_out_421052.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_out_421052", "421052086", "story_v_out_421052.awb")

						arg_351_1:RecordAudio("421052086", var_354_11)
						arg_351_1:RecordAudio("421052086", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_421052", "421052086", "story_v_out_421052.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_421052", "421052086", "story_v_out_421052.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play421052087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 421052087
		arg_355_1.duration_ = 3.9

		local var_355_0 = {
			zh = 3.7,
			ja = 3.9
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
				arg_355_0:Play421052088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10102ui_story = arg_355_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10102ui_story"].transform.position).z)
				arg_355_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["10102ui_story"].transform.localEulerAngles = arg_355_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_355_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10102ui_story"].transform.position).z)
				arg_355_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["10102ui_story"].transform.localEulerAngles = arg_355_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["10102ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect10102ui_story == nil then
				arg_355_1.var_.characterEffect10102ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect10102ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect10102ui_story then
				arg_355_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_358_4 = arg_355_1.actors_["1047ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect1047ui_story == nil then
				arg_355_1.var_.characterEffect1047ui_story = var_358_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_5 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_5 and not isNil(var_358_4) then
				if arg_355_1.var_.characterEffect1047ui_story and not isNil(var_358_4) then
					arg_355_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_5)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_5 and arg_355_1.time_ < 0 + var_358_5 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect1047ui_story then
				arg_355_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_358_6 = 0
			local var_358_7 = 0.3

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_8 = arg_355_1:GetWordFromCfg(421052087)
				local var_358_9 = arg_355_1:FormatText(var_358_8.content)

				arg_355_1.text_.text = var_358_9

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 12 <= 0 and var_358_7 or var_358_7 * (utf8.len(var_358_9) / 12)

				if (12 <= 0 and var_358_7 or var_358_7 * (utf8.len(var_358_9) / 12)) > 0 and var_358_7 < var_358_11 then
					arg_355_1.talkMaxDuration = var_358_11

					if var_358_11 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_9
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052087", "story_v_out_421052.awb") ~= 0 then
					local var_358_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052087", "story_v_out_421052.awb") / 1000

					if var_358_12 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_12 + var_358_6
					end

					if var_358_8.prefab_name ~= "" and arg_355_1.actors_[var_358_8.prefab_name] ~= nil then
						local var_358_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_8.prefab_name].transform, "story_v_out_421052", "421052087", "story_v_out_421052.awb")

						arg_355_1:RecordAudio("421052087", var_358_13)
						arg_355_1:RecordAudio("421052087", var_358_13)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_421052", "421052087", "story_v_out_421052.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_421052", "421052087", "story_v_out_421052.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_14 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_14 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_14

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_14 and arg_355_1.time_ < var_358_6 + var_358_14 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play421052088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 421052088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play421052089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10102ui_story"]) and arg_359_1.var_.characterEffect10102ui_story == nil then
				arg_359_1.var_.characterEffect10102ui_story = arg_359_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10102ui_story"]) then
				if arg_359_1.var_.characterEffect10102ui_story and not isNil(arg_359_1.actors_["10102ui_story"]) then
					arg_359_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_359_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10102ui_story"]) and arg_359_1.var_.characterEffect10102ui_story then
				arg_359_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_359_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_362_1 = 0
			local var_362_2 = 0.8

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(421052088).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 32 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 32)

				if (32 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 32)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_6 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_6 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_6

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_6 and arg_359_1.time_ < var_362_1 + var_362_6 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play421052089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 421052089
		arg_363_1.duration_ = 3.37

		local var_363_0 = {
			zh = 3.366,
			ja = 3.2
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
				arg_363_0:Play421052090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1047ui_story = arg_363_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1047ui_story"].transform.position).z)
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1047ui_story"].transform.localEulerAngles = arg_363_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
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
				arg_363_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_366_4 = 0
			local var_366_5 = 0.525

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

				local var_366_6 = arg_363_1:GetWordFromCfg(421052089)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 21 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 21)

				if (21 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 21)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052089", "story_v_out_421052.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052089", "story_v_out_421052.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_421052", "421052089", "story_v_out_421052.awb")

						arg_363_1:RecordAudio("421052089", var_366_11)
						arg_363_1:RecordAudio("421052089", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_421052", "421052089", "story_v_out_421052.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_421052", "421052089", "story_v_out_421052.awb")
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
	Play421052090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 421052090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play421052091(arg_367_1)
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
			local var_370_2 = 0.55

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(421052090).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 22 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 22)

				if (22 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 22)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play421052091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 421052091
		arg_371_1.duration_ = 11.97

		local var_371_0 = {
			zh = 7.733,
			ja = 11.966
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
				arg_371_0:Play421052092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1047ui_story = arg_371_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1047ui_story"].transform.position).z)
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1047ui_story"].transform.localEulerAngles = arg_371_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
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
				arg_371_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_374_4 = 0
			local var_374_5 = 0.925

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

				local var_374_6 = arg_371_1:GetWordFromCfg(421052091)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 37 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 37)

				if (37 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 37)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052091", "story_v_out_421052.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052091", "story_v_out_421052.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_421052", "421052091", "story_v_out_421052.awb")

						arg_371_1:RecordAudio("421052091", var_374_11)
						arg_371_1:RecordAudio("421052091", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_421052", "421052091", "story_v_out_421052.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_421052", "421052091", "story_v_out_421052.awb")
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
	Play421052092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 421052092
		arg_375_1.duration_ = 2.2

		local var_375_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_375_0:Play421052093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10102ui_story = arg_375_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["10102ui_story"].transform.position).z)
				arg_375_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["10102ui_story"].transform.localEulerAngles = arg_375_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_375_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["10102ui_story"].transform.position).z)
				arg_375_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["10102ui_story"].transform.localEulerAngles = arg_375_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["10102ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect10102ui_story == nil then
				arg_375_1.var_.characterEffect10102ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect10102ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect10102ui_story then
				arg_375_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_378_4 = arg_375_1.actors_["1047ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_4) and arg_375_1.var_.characterEffect1047ui_story == nil then
				arg_375_1.var_.characterEffect1047ui_story = var_378_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_5 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_5 and not isNil(var_378_4) then
				if arg_375_1.var_.characterEffect1047ui_story and not isNil(var_378_4) then
					arg_375_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_5)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_5 and arg_375_1.time_ < 0 + var_378_5 + arg_378_0 and not isNil(var_378_4) and arg_375_1.var_.characterEffect1047ui_story then
				arg_375_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_378_6 = 0
			local var_378_7 = 0.175

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_8 = arg_375_1:GetWordFromCfg(421052092)
				local var_378_9 = arg_375_1:FormatText(var_378_8.content)

				arg_375_1.text_.text = var_378_9

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 7 <= 0 and var_378_7 or var_378_7 * (utf8.len(var_378_9) / 7)

				if (7 <= 0 and var_378_7 or var_378_7 * (utf8.len(var_378_9) / 7)) > 0 and var_378_7 < var_378_11 then
					arg_375_1.talkMaxDuration = var_378_11

					if var_378_11 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_9
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052092", "story_v_out_421052.awb") ~= 0 then
					local var_378_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052092", "story_v_out_421052.awb") / 1000

					if var_378_12 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_12 + var_378_6
					end

					if var_378_8.prefab_name ~= "" and arg_375_1.actors_[var_378_8.prefab_name] ~= nil then
						local var_378_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_8.prefab_name].transform, "story_v_out_421052", "421052092", "story_v_out_421052.awb")

						arg_375_1:RecordAudio("421052092", var_378_13)
						arg_375_1:RecordAudio("421052092", var_378_13)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_421052", "421052092", "story_v_out_421052.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_421052", "421052092", "story_v_out_421052.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_14 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_14 and arg_375_1.time_ < var_378_6 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play421052093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 421052093
		arg_379_1.duration_ = 3.77

		local var_379_0 = {
			zh = 2.766,
			ja = 3.766
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
				arg_379_0:Play421052094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1047ui_story = arg_379_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).z)
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles = arg_379_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_379_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).z)
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles = arg_379_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1047ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1047ui_story == nil then
				arg_379_1.var_.characterEffect1047ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1047ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1047ui_story then
				arg_379_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_382_4 = arg_379_1.actors_["10102ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect10102ui_story == nil then
				arg_379_1.var_.characterEffect10102ui_story = var_382_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_5 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_5 and not isNil(var_382_4) then
				if arg_379_1.var_.characterEffect10102ui_story and not isNil(var_382_4) then
					arg_379_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_379_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_5)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_5 and arg_379_1.time_ < 0 + var_382_5 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect10102ui_story then
				arg_379_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_379_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_382_6 = 0
			local var_382_7 = 0.275

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(421052093)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 11 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 11)

				if (11 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 11)) > 0 and var_382_7 < var_382_11 then
					arg_379_1.talkMaxDuration = var_382_11

					if var_382_11 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_11 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052093", "story_v_out_421052.awb") ~= 0 then
					local var_382_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052093", "story_v_out_421052.awb") / 1000

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end

					if var_382_8.prefab_name ~= "" and arg_379_1.actors_[var_382_8.prefab_name] ~= nil then
						local var_382_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_8.prefab_name].transform, "story_v_out_421052", "421052093", "story_v_out_421052.awb")

						arg_379_1:RecordAudio("421052093", var_382_13)
						arg_379_1:RecordAudio("421052093", var_382_13)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_421052", "421052093", "story_v_out_421052.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_421052", "421052093", "story_v_out_421052.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_14 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_14 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_14

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_14 and arg_379_1.time_ < var_382_6 + var_382_14 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play421052094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 421052094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play421052095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1047ui_story"]) and arg_383_1.var_.characterEffect1047ui_story == nil then
				arg_383_1.var_.characterEffect1047ui_story = arg_383_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1047ui_story"]) then
				if arg_383_1.var_.characterEffect1047ui_story and not isNil(arg_383_1.actors_["1047ui_story"]) then
					arg_383_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1047ui_story"]) and arg_383_1.var_.characterEffect1047ui_story then
				arg_383_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.3

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(421052094).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 12 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 12)

				if (12 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 12)) > 0 and var_386_2 < var_386_5 then
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

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play421052095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 421052095
		arg_387_1.duration_ = 9.93

		local var_387_0 = {
			zh = 6.966,
			ja = 9.933
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
				arg_387_0:Play421052096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1047ui_story = arg_387_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1047ui_story"].transform.position).z)
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1047ui_story"].transform.localEulerAngles = arg_387_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
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
				arg_387_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_390_4 = 0
			local var_390_5 = 0.775

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

				local var_390_6 = arg_387_1:GetWordFromCfg(421052095)
				local var_390_7 = arg_387_1:FormatText(var_390_6.content)

				arg_387_1.text_.text = var_390_7

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 31 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 31)

				if (31 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 31)) > 0 and var_390_5 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_7
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052095", "story_v_out_421052.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052095", "story_v_out_421052.awb") / 1000

					if var_390_10 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_4
					end

					if var_390_6.prefab_name ~= "" and arg_387_1.actors_[var_390_6.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_6.prefab_name].transform, "story_v_out_421052", "421052095", "story_v_out_421052.awb")

						arg_387_1:RecordAudio("421052095", var_390_11)
						arg_387_1:RecordAudio("421052095", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_421052", "421052095", "story_v_out_421052.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_421052", "421052095", "story_v_out_421052.awb")
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
	Play421052096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 421052096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play421052097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1047ui_story = arg_391_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).z)
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles = arg_391_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1047ui_story"].transform.position).z)
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1047ui_story"].transform.localEulerAngles = arg_391_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["10102ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10102ui_story = var_394_1.localPosition
			end

			local var_394_2 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 then
				var_394_1.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_2)
				var_394_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_1.position).x, (manager.ui.mainCamera.transform.position - var_394_1.position).y, (manager.ui.mainCamera.transform.position - var_394_1.position).z)
				var_394_1.localEulerAngles.z = 0
				var_394_1.localEulerAngles.x = 0
				var_394_1.localEulerAngles = var_394_1.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 then
				var_394_1.localPosition = Vector3.New(0, 100, 0)
				var_394_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_1.position).x, (manager.ui.mainCamera.transform.position - var_394_1.position).y, (manager.ui.mainCamera.transform.position - var_394_1.position).z)
				var_394_1.localEulerAngles.z = 0
				var_394_1.localEulerAngles.x = 0
				var_394_1.localEulerAngles = var_394_1.localEulerAngles
			end

			local var_394_3 = 0
			local var_394_4 = 1.175

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_5 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(421052096).content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 47 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_5) / 47)

				if (47 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_5) / 47)) > 0 and var_394_4 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_3 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_3
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_4, arg_391_1.talkMaxDuration)

			if var_394_3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_3 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_3) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_3 + var_394_8 and arg_391_1.time_ < var_394_3 + var_394_8 + arg_394_0 then
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
			},
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

		arg_391_1:InitPlayNodeList()
	end,
	Play421052097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 421052097
		arg_395_1.duration_ = 8.6

		local var_395_0 = {
			zh = 7.9,
			ja = 8.6
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play421052098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 2 < arg_395_1.time_ and arg_395_1.time_ <= 2 + arg_398_0 then
				local var_398_0 = arg_395_1.bgs_.B08b

				arg_395_1.bgs_.B08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_398_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_398_1 = var_398_0:GetComponent("SpriteRenderer")

				if var_398_1 and var_398_1.sprite then
					local var_398_2 = 2 * (var_398_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_398_0.transform.localScale = Vector3.New(var_398_2 / var_398_1.sprite.bounds.size.y < var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x and var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x or var_398_2 / var_398_1.sprite.bounds.size.y, var_398_2 / var_398_1.sprite.bounds.size.y < var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x and var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x or var_398_2 / var_398_1.sprite.bounds.size.y, 0)
				end

				for iter_398_0, iter_398_1 in pairs(arg_395_1.bgs_) do
					if iter_398_0 ~= "B08b" then
						iter_398_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_398_3 = 4

			if 4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_3 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			if arg_395_1.time_ >= var_398_3 + 0.3 and arg_395_1.time_ < var_398_3 + 0.3 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end

			local var_398_4 = 0

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_5 = 2

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_5 then
				local var_398_6 = Color.New(0, 0, 0)

				var_398_6.a = Mathf.Lerp(0, 1, (arg_395_1.time_ - var_398_4) / var_398_5)
				arg_395_1.mask_.color = var_398_6
			end

			if arg_395_1.time_ >= var_398_4 + var_398_5 and arg_395_1.time_ < var_398_4 + var_398_5 + arg_398_0 then
				local var_398_7 = Color.New(0, 0, 0)

				var_398_7.a = 1
				arg_395_1.mask_.color = var_398_7
			end

			local var_398_8 = 2

			if 2 < arg_395_1.time_ and arg_395_1.time_ <= var_398_8 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_9 = 2

			if var_398_8 <= arg_395_1.time_ and arg_395_1.time_ < var_398_8 + var_398_9 then
				local var_398_10 = Color.New(0, 0, 0)

				var_398_10.a = Mathf.Lerp(1, 0, (arg_395_1.time_ - var_398_8) / var_398_9)
				arg_395_1.mask_.color = var_398_10
			end

			if arg_395_1.time_ >= var_398_8 + var_398_9 and arg_395_1.time_ < var_398_8 + var_398_9 + arg_398_0 then
				local var_398_11 = Color.New(0, 0, 0)

				arg_395_1.mask_.enabled = false
				var_398_11.a = 0
				arg_395_1.mask_.color = var_398_11
			end

			local var_398_12 = arg_395_1.actors_["1047ui_story"].transform

			if 3.83333333333333 < arg_395_1.time_ and arg_395_1.time_ <= 3.83333333333333 + arg_398_0 then
				arg_395_1.var_.moveOldPos1047ui_story = var_398_12.localPosition
			end

			local var_398_13 = 0.001

			if 3.83333333333333 <= arg_395_1.time_ and arg_395_1.time_ < 3.83333333333333 + var_398_13 then
				var_398_12.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_395_1.time_ - 3.83333333333333) / var_398_13)
				var_398_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_398_12.position).x, (manager.ui.mainCamera.transform.position - var_398_12.position).y, (manager.ui.mainCamera.transform.position - var_398_12.position).z)
				var_398_12.localEulerAngles.z = 0
				var_398_12.localEulerAngles.x = 0
				var_398_12.localEulerAngles = var_398_12.localEulerAngles
			end

			if arg_395_1.time_ >= 3.83333333333333 + var_398_13 and arg_395_1.time_ < 3.83333333333333 + var_398_13 + arg_398_0 then
				var_398_12.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_398_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_398_12.position).x, (manager.ui.mainCamera.transform.position - var_398_12.position).y, (manager.ui.mainCamera.transform.position - var_398_12.position).z)
				var_398_12.localEulerAngles.z = 0
				var_398_12.localEulerAngles.x = 0
				var_398_12.localEulerAngles = var_398_12.localEulerAngles
			end

			local var_398_14 = arg_395_1.actors_["1047ui_story"]

			if 3.83333333333333 < arg_395_1.time_ and arg_395_1.time_ <= 3.83333333333333 + arg_398_0 and not isNil(var_398_14) and arg_395_1.var_.characterEffect1047ui_story == nil then
				arg_395_1.var_.characterEffect1047ui_story = var_398_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_15 = 0.200000002980232

			if 3.83333333333333 <= arg_395_1.time_ and arg_395_1.time_ < 3.83333333333333 + var_398_15 and not isNil(var_398_14) then
				if arg_395_1.var_.characterEffect1047ui_story and not isNil(var_398_14) then
					arg_395_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 3.83333333333333 + var_398_15 and arg_395_1.time_ < 3.83333333333333 + var_398_15 + arg_398_0 and not isNil(var_398_14) and arg_395_1.var_.characterEffect1047ui_story then
				arg_395_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_395_1.time_ and arg_395_1.time_ <= 3.83333333333333 + arg_398_0 then
				arg_395_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 3.83333333333333 < arg_395_1.time_ and arg_395_1.time_ <= 3.83333333333333 + arg_398_0 then
				arg_395_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_395_1.time_ and arg_395_1.time_ <= 0.1 + arg_398_0 then
				arg_395_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 1.56666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 1.56666666666667 + arg_398_0 then
				arg_395_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_19 = 4
			local var_398_20 = 0.425

			if 4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_19 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_21 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_21:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_22 = arg_395_1:GetWordFromCfg(421052097)
				local var_398_23 = arg_395_1:FormatText(var_398_22.content)

				arg_395_1.text_.text = var_398_23

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_25 = 17 <= 0 and var_398_20 or var_398_20 * (utf8.len(var_398_23) / 17)

				if (17 <= 0 and var_398_20 or var_398_20 * (utf8.len(var_398_23) / 17)) > 0 and var_398_20 < var_398_25 then
					arg_395_1.talkMaxDuration = var_398_25
					var_398_19 = var_398_19 + 0.3

					if var_398_25 + var_398_19 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_25 + var_398_19
					end
				end

				arg_395_1.text_.text = var_398_23
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052097", "story_v_out_421052.awb") ~= 0 then
					local var_398_26 = manager.audio:GetVoiceLength("story_v_out_421052", "421052097", "story_v_out_421052.awb") / 1000

					if var_398_26 + var_398_19 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_26 + var_398_19
					end

					if var_398_22.prefab_name ~= "" and arg_395_1.actors_[var_398_22.prefab_name] ~= nil then
						local var_398_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_22.prefab_name].transform, "story_v_out_421052", "421052097", "story_v_out_421052.awb")

						arg_395_1:RecordAudio("421052097", var_398_27)
						arg_395_1:RecordAudio("421052097", var_398_27)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_421052", "421052097", "story_v_out_421052.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_421052", "421052097", "story_v_out_421052.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_28 = var_398_19 + 0.3
			local var_398_29 = math.max(var_398_20, arg_395_1.talkMaxDuration)

			if var_398_19 + 0.3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_28 + var_398_29 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_28) / var_398_29

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_28 + var_398_29 and arg_395_1.time_ < var_398_28 + var_398_29 + arg_398_0 then
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
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play421052098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 421052098
		arg_401_1.duration_ = 5.57

		local var_401_0 = {
			zh = 4.333,
			ja = 5.566
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play421052099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos10145ui_story = arg_401_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10145ui_story"].transform.position).z)
				arg_401_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["10145ui_story"].transform.localEulerAngles = arg_401_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_401_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10145ui_story"].transform.position).z)
				arg_401_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["10145ui_story"].transform.localEulerAngles = arg_401_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["10145ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect10145ui_story == nil then
				arg_401_1.var_.characterEffect10145ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect10145ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect10145ui_story then
				arg_401_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_404_4 = arg_401_1.actors_["1047ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.characterEffect1047ui_story == nil then
				arg_401_1.var_.characterEffect1047ui_story = var_404_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_5 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_5 and not isNil(var_404_4) then
				if arg_401_1.var_.characterEffect1047ui_story and not isNil(var_404_4) then
					arg_401_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_5)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_5 and arg_401_1.time_ < 0 + var_404_5 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.characterEffect1047ui_story then
				arg_401_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_404_6 = 0
			local var_404_7 = 0.575

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_8 = arg_401_1:GetWordFromCfg(421052098)
				local var_404_9 = arg_401_1:FormatText(var_404_8.content)

				arg_401_1.text_.text = var_404_9

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 23 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 23)

				if (23 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 23)) > 0 and var_404_7 < var_404_11 then
					arg_401_1.talkMaxDuration = var_404_11

					if var_404_11 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_9
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052098", "story_v_out_421052.awb") ~= 0 then
					local var_404_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052098", "story_v_out_421052.awb") / 1000

					if var_404_12 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_12 + var_404_6
					end

					if var_404_8.prefab_name ~= "" and arg_401_1.actors_[var_404_8.prefab_name] ~= nil then
						local var_404_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_8.prefab_name].transform, "story_v_out_421052", "421052098", "story_v_out_421052.awb")

						arg_401_1:RecordAudio("421052098", var_404_13)
						arg_401_1:RecordAudio("421052098", var_404_13)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_421052", "421052098", "story_v_out_421052.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_421052", "421052098", "story_v_out_421052.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play421052099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 421052099
		arg_405_1.duration_ = 9.33

		local var_405_0 = {
			zh = 6.233,
			ja = 9.333
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
				arg_405_0:Play421052100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1047ui_story = arg_405_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).z)
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles = arg_405_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_405_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).z)
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles = arg_405_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1047ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1047ui_story == nil then
				arg_405_1.var_.characterEffect1047ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1047ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1047ui_story then
				arg_405_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_408_4 = arg_405_1.actors_["10145ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect10145ui_story == nil then
				arg_405_1.var_.characterEffect10145ui_story = var_408_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_5 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_5 and not isNil(var_408_4) then
				if arg_405_1.var_.characterEffect10145ui_story and not isNil(var_408_4) then
					arg_405_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_5)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_5 and arg_405_1.time_ < 0 + var_408_5 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect10145ui_story then
				arg_405_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_408_6 = 0
			local var_408_7 = 0.85

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_8 = arg_405_1:GetWordFromCfg(421052099)
				local var_408_9 = arg_405_1:FormatText(var_408_8.content)

				arg_405_1.text_.text = var_408_9

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 34 <= 0 and var_408_7 or var_408_7 * (utf8.len(var_408_9) / 34)

				if (34 <= 0 and var_408_7 or var_408_7 * (utf8.len(var_408_9) / 34)) > 0 and var_408_7 < var_408_11 then
					arg_405_1.talkMaxDuration = var_408_11

					if var_408_11 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_11 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_9
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052099", "story_v_out_421052.awb") ~= 0 then
					local var_408_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052099", "story_v_out_421052.awb") / 1000

					if var_408_12 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_12 + var_408_6
					end

					if var_408_8.prefab_name ~= "" and arg_405_1.actors_[var_408_8.prefab_name] ~= nil then
						local var_408_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_8.prefab_name].transform, "story_v_out_421052", "421052099", "story_v_out_421052.awb")

						arg_405_1:RecordAudio("421052099", var_408_13)
						arg_405_1:RecordAudio("421052099", var_408_13)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_421052", "421052099", "story_v_out_421052.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_421052", "421052099", "story_v_out_421052.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play421052100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 421052100
		arg_409_1.duration_ = 9.83

		local var_409_0 = {
			zh = 9.666,
			ja = 9.833
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play421052101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10145ui_story = arg_409_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10145ui_story"].transform.position).z)
				arg_409_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["10145ui_story"].transform.localEulerAngles = arg_409_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_409_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10145ui_story"].transform.position).z)
				arg_409_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["10145ui_story"].transform.localEulerAngles = arg_409_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["10145ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect10145ui_story == nil then
				arg_409_1.var_.characterEffect10145ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect10145ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect10145ui_story then
				arg_409_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_412_4 = arg_409_1.actors_["1047ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_4) and arg_409_1.var_.characterEffect1047ui_story == nil then
				arg_409_1.var_.characterEffect1047ui_story = var_412_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_5 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_5 and not isNil(var_412_4) then
				if arg_409_1.var_.characterEffect1047ui_story and not isNil(var_412_4) then
					arg_409_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_5)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_5 and arg_409_1.time_ < 0 + var_412_5 + arg_412_0 and not isNil(var_412_4) and arg_409_1.var_.characterEffect1047ui_story then
				arg_409_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_412_6 = 0
			local var_412_7 = 1.225

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_8 = arg_409_1:GetWordFromCfg(421052100)
				local var_412_9 = arg_409_1:FormatText(var_412_8.content)

				arg_409_1.text_.text = var_412_9

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_11 = 49 <= 0 and var_412_7 or var_412_7 * (utf8.len(var_412_9) / 49)

				if (49 <= 0 and var_412_7 or var_412_7 * (utf8.len(var_412_9) / 49)) > 0 and var_412_7 < var_412_11 then
					arg_409_1.talkMaxDuration = var_412_11

					if var_412_11 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_11 + var_412_6
					end
				end

				arg_409_1.text_.text = var_412_9
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052100", "story_v_out_421052.awb") ~= 0 then
					local var_412_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052100", "story_v_out_421052.awb") / 1000

					if var_412_12 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_12 + var_412_6
					end

					if var_412_8.prefab_name ~= "" and arg_409_1.actors_[var_412_8.prefab_name] ~= nil then
						local var_412_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_8.prefab_name].transform, "story_v_out_421052", "421052100", "story_v_out_421052.awb")

						arg_409_1:RecordAudio("421052100", var_412_13)
						arg_409_1:RecordAudio("421052100", var_412_13)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_421052", "421052100", "story_v_out_421052.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_421052", "421052100", "story_v_out_421052.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_14 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_14 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_14

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_14 and arg_409_1.time_ < var_412_6 + var_412_14 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play421052101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 421052101
		arg_413_1.duration_ = 8.5

		local var_413_0 = {
			zh = 6.666,
			ja = 8.5
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
				arg_413_0:Play421052102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.85

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:GetWordFromCfg(421052101)
				local var_416_2 = arg_413_1:FormatText(var_416_1.content)

				arg_413_1.text_.text = var_416_2

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 34 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 34)

				if (34 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 34)) > 0 and var_416_0 < var_416_4 then
					arg_413_1.talkMaxDuration = var_416_4

					if var_416_4 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_4 + 0
					end
				end

				arg_413_1.text_.text = var_416_2
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052101", "story_v_out_421052.awb") ~= 0 then
					local var_416_5 = manager.audio:GetVoiceLength("story_v_out_421052", "421052101", "story_v_out_421052.awb") / 1000

					if var_416_5 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + 0
					end

					if var_416_1.prefab_name ~= "" and arg_413_1.actors_[var_416_1.prefab_name] ~= nil then
						local var_416_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_1.prefab_name].transform, "story_v_out_421052", "421052101", "story_v_out_421052.awb")

						arg_413_1:RecordAudio("421052101", var_416_6)
						arg_413_1:RecordAudio("421052101", var_416_6)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_421052", "421052101", "story_v_out_421052.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_421052", "421052101", "story_v_out_421052.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_7 and arg_413_1.time_ < 0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play421052102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 421052102
		arg_417_1.duration_ = 5.07

		local var_417_0 = {
			zh = 3.1,
			ja = 5.066
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
				arg_417_0:Play421052103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1047ui_story = arg_417_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).z)
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles = arg_417_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_417_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).z)
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles = arg_417_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1047ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1047ui_story == nil then
				arg_417_1.var_.characterEffect1047ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1047ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1047ui_story then
				arg_417_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_420_4 = arg_417_1.actors_["10145ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect10145ui_story == nil then
				arg_417_1.var_.characterEffect10145ui_story = var_420_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_5 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_5 and not isNil(var_420_4) then
				if arg_417_1.var_.characterEffect10145ui_story and not isNil(var_420_4) then
					arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_5)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_5 and arg_417_1.time_ < 0 + var_420_5 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect10145ui_story then
				arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_420_6 = 0
			local var_420_7 = 0.375

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_8 = arg_417_1:GetWordFromCfg(421052102)
				local var_420_9 = arg_417_1:FormatText(var_420_8.content)

				arg_417_1.text_.text = var_420_9

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 15 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_9) / 15)

				if (15 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_9) / 15)) > 0 and var_420_7 < var_420_11 then
					arg_417_1.talkMaxDuration = var_420_11

					if var_420_11 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_9
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052102", "story_v_out_421052.awb") ~= 0 then
					local var_420_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052102", "story_v_out_421052.awb") / 1000

					if var_420_12 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_12 + var_420_6
					end

					if var_420_8.prefab_name ~= "" and arg_417_1.actors_[var_420_8.prefab_name] ~= nil then
						local var_420_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_8.prefab_name].transform, "story_v_out_421052", "421052102", "story_v_out_421052.awb")

						arg_417_1:RecordAudio("421052102", var_420_13)
						arg_417_1:RecordAudio("421052102", var_420_13)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_421052", "421052102", "story_v_out_421052.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_421052", "421052102", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
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
	Play421052103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 421052103
		arg_421_1.duration_ = 2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play421052104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos10145ui_story = arg_421_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10145ui_story"].transform.position).z)
				arg_421_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["10145ui_story"].transform.localEulerAngles = arg_421_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_421_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10145ui_story"].transform.position).z)
				arg_421_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["10145ui_story"].transform.localEulerAngles = arg_421_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["10145ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect10145ui_story == nil then
				arg_421_1.var_.characterEffect10145ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect10145ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect10145ui_story then
				arg_421_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_424_4 = arg_421_1.actors_["1047ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect1047ui_story == nil then
				arg_421_1.var_.characterEffect1047ui_story = var_424_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_5 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_5 and not isNil(var_424_4) then
				if arg_421_1.var_.characterEffect1047ui_story and not isNil(var_424_4) then
					arg_421_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_5)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_5 and arg_421_1.time_ < 0 + var_424_5 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect1047ui_story then
				arg_421_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_424_6 = 0
			local var_424_7 = 0.05

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_8 = arg_421_1:GetWordFromCfg(421052103)
				local var_424_9 = arg_421_1:FormatText(var_424_8.content)

				arg_421_1.text_.text = var_424_9

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 2 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_9) / 2)

				if (2 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_9) / 2)) > 0 and var_424_7 < var_424_11 then
					arg_421_1.talkMaxDuration = var_424_11

					if var_424_11 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_11 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_9
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052103", "story_v_out_421052.awb") ~= 0 then
					local var_424_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052103", "story_v_out_421052.awb") / 1000

					if var_424_12 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_12 + var_424_6
					end

					if var_424_8.prefab_name ~= "" and arg_421_1.actors_[var_424_8.prefab_name] ~= nil then
						local var_424_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_8.prefab_name].transform, "story_v_out_421052", "421052103", "story_v_out_421052.awb")

						arg_421_1:RecordAudio("421052103", var_424_13)
						arg_421_1:RecordAudio("421052103", var_424_13)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_421052", "421052103", "story_v_out_421052.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_421052", "421052103", "story_v_out_421052.awb")
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
				actorName = "10145ui_story",
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
	Play421052104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 421052104
		arg_425_1.duration_ = 14.07

		local var_425_0 = {
			zh = 8.766,
			ja = 14.066
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play421052105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1047ui_story = arg_425_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1047ui_story"].transform.position).z)
				arg_425_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1047ui_story"].transform.localEulerAngles = arg_425_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_425_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1047ui_story"].transform.position).z)
				arg_425_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1047ui_story"].transform.localEulerAngles = arg_425_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1047ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1047ui_story == nil then
				arg_425_1.var_.characterEffect1047ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1047ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1047ui_story then
				arg_425_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_428_4 = arg_425_1.actors_["10145ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_4) and arg_425_1.var_.characterEffect10145ui_story == nil then
				arg_425_1.var_.characterEffect10145ui_story = var_428_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_5 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_5 and not isNil(var_428_4) then
				if arg_425_1.var_.characterEffect10145ui_story and not isNil(var_428_4) then
					arg_425_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_425_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_5)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_5 and arg_425_1.time_ < 0 + var_428_5 + arg_428_0 and not isNil(var_428_4) and arg_425_1.var_.characterEffect10145ui_story then
				arg_425_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_425_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_428_6 = 0
			local var_428_7 = 0.9

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_8 = arg_425_1:GetWordFromCfg(421052104)
				local var_428_9 = arg_425_1:FormatText(var_428_8.content)

				arg_425_1.text_.text = var_428_9

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 36 <= 0 and var_428_7 or var_428_7 * (utf8.len(var_428_9) / 36)

				if (36 <= 0 and var_428_7 or var_428_7 * (utf8.len(var_428_9) / 36)) > 0 and var_428_7 < var_428_11 then
					arg_425_1.talkMaxDuration = var_428_11

					if var_428_11 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_11 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_9
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052104", "story_v_out_421052.awb") ~= 0 then
					local var_428_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052104", "story_v_out_421052.awb") / 1000

					if var_428_12 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_12 + var_428_6
					end

					if var_428_8.prefab_name ~= "" and arg_425_1.actors_[var_428_8.prefab_name] ~= nil then
						local var_428_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_8.prefab_name].transform, "story_v_out_421052", "421052104", "story_v_out_421052.awb")

						arg_425_1:RecordAudio("421052104", var_428_13)
						arg_425_1:RecordAudio("421052104", var_428_13)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_421052", "421052104", "story_v_out_421052.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_421052", "421052104", "story_v_out_421052.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_14 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_14 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_14

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_14 and arg_425_1.time_ < var_428_6 + var_428_14 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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
	Play421052105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 421052105
		arg_429_1.duration_ = 9.97

		local var_429_0 = {
			zh = 7.2,
			ja = 9.966
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
				arg_429_0:Play421052106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10145ui_story = arg_429_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10145ui_story"].transform.position).z)
				arg_429_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["10145ui_story"].transform.localEulerAngles = arg_429_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_429_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10145ui_story"].transform.position).z)
				arg_429_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["10145ui_story"].transform.localEulerAngles = arg_429_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["10145ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect10145ui_story == nil then
				arg_429_1.var_.characterEffect10145ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect10145ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect10145ui_story then
				arg_429_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_432_4 = arg_429_1.actors_["1047ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_4) and arg_429_1.var_.characterEffect1047ui_story == nil then
				arg_429_1.var_.characterEffect1047ui_story = var_432_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_5 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_5 and not isNil(var_432_4) then
				if arg_429_1.var_.characterEffect1047ui_story and not isNil(var_432_4) then
					arg_429_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_5)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_5 and arg_429_1.time_ < 0 + var_432_5 + arg_432_0 and not isNil(var_432_4) and arg_429_1.var_.characterEffect1047ui_story then
				arg_429_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_432_6 = 0
			local var_432_7 = 0.75

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_8 = arg_429_1:GetWordFromCfg(421052105)
				local var_432_9 = arg_429_1:FormatText(var_432_8.content)

				arg_429_1.text_.text = var_432_9

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 30 <= 0 and var_432_7 or var_432_7 * (utf8.len(var_432_9) / 30)

				if (30 <= 0 and var_432_7 or var_432_7 * (utf8.len(var_432_9) / 30)) > 0 and var_432_7 < var_432_11 then
					arg_429_1.talkMaxDuration = var_432_11

					if var_432_11 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_11 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_9
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052105", "story_v_out_421052.awb") ~= 0 then
					local var_432_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052105", "story_v_out_421052.awb") / 1000

					if var_432_12 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_12 + var_432_6
					end

					if var_432_8.prefab_name ~= "" and arg_429_1.actors_[var_432_8.prefab_name] ~= nil then
						local var_432_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_8.prefab_name].transform, "story_v_out_421052", "421052105", "story_v_out_421052.awb")

						arg_429_1:RecordAudio("421052105", var_432_13)
						arg_429_1:RecordAudio("421052105", var_432_13)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_421052", "421052105", "story_v_out_421052.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_421052", "421052105", "story_v_out_421052.awb")
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
				actorName = "10145ui_story",
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
	Play421052106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 421052106
		arg_433_1.duration_ = 6.4

		local var_433_0 = {
			zh = 3.233,
			ja = 6.4
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
				arg_433_0:Play421052107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1047ui_story = arg_433_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1047ui_story"].transform.position).z)
				arg_433_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1047ui_story"].transform.localEulerAngles = arg_433_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_433_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1047ui_story"].transform.position).z)
				arg_433_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1047ui_story"].transform.localEulerAngles = arg_433_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1047ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1047ui_story == nil then
				arg_433_1.var_.characterEffect1047ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1047ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1047ui_story then
				arg_433_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_436_4 = arg_433_1.actors_["10145ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect10145ui_story == nil then
				arg_433_1.var_.characterEffect10145ui_story = var_436_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_5 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_5 and not isNil(var_436_4) then
				if arg_433_1.var_.characterEffect10145ui_story and not isNil(var_436_4) then
					arg_433_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_433_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_5)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_5 and arg_433_1.time_ < 0 + var_436_5 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect10145ui_story then
				arg_433_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_433_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_436_6 = 0
			local var_436_7 = 0.3

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(421052106)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 12 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 12)

				if (12 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 12)) > 0 and var_436_7 < var_436_11 then
					arg_433_1.talkMaxDuration = var_436_11

					if var_436_11 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052106", "story_v_out_421052.awb") ~= 0 then
					local var_436_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052106", "story_v_out_421052.awb") / 1000

					if var_436_12 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_6
					end

					if var_436_8.prefab_name ~= "" and arg_433_1.actors_[var_436_8.prefab_name] ~= nil then
						local var_436_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_8.prefab_name].transform, "story_v_out_421052", "421052106", "story_v_out_421052.awb")

						arg_433_1:RecordAudio("421052106", var_436_13)
						arg_433_1:RecordAudio("421052106", var_436_13)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_421052", "421052106", "story_v_out_421052.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_421052", "421052106", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
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
	Play421052107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 421052107
		arg_437_1.duration_ = 7.67

		local var_437_0 = {
			zh = 4.966,
			ja = 7.666
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
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play421052108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos10145ui_story = arg_437_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["10145ui_story"].transform.position).z)
				arg_437_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["10145ui_story"].transform.localEulerAngles = arg_437_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_437_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["10145ui_story"].transform.position).z)
				arg_437_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["10145ui_story"].transform.localEulerAngles = arg_437_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["10145ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect10145ui_story == nil then
				arg_437_1.var_.characterEffect10145ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect10145ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect10145ui_story then
				arg_437_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_440_4 = arg_437_1.actors_["1047ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_4) and arg_437_1.var_.characterEffect1047ui_story == nil then
				arg_437_1.var_.characterEffect1047ui_story = var_440_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_5 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_5 and not isNil(var_440_4) then
				if arg_437_1.var_.characterEffect1047ui_story and not isNil(var_440_4) then
					arg_437_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_5)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_5 and arg_437_1.time_ < 0 + var_440_5 + arg_440_0 and not isNil(var_440_4) and arg_437_1.var_.characterEffect1047ui_story then
				arg_437_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_440_6 = 0
			local var_440_7 = 0.6

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_8 = arg_437_1:GetWordFromCfg(421052107)
				local var_440_9 = arg_437_1:FormatText(var_440_8.content)

				arg_437_1.text_.text = var_440_9

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 24 <= 0 and var_440_7 or var_440_7 * (utf8.len(var_440_9) / 24)

				if (24 <= 0 and var_440_7 or var_440_7 * (utf8.len(var_440_9) / 24)) > 0 and var_440_7 < var_440_11 then
					arg_437_1.talkMaxDuration = var_440_11

					if var_440_11 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_11 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_9
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052107", "story_v_out_421052.awb") ~= 0 then
					local var_440_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052107", "story_v_out_421052.awb") / 1000

					if var_440_12 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_12 + var_440_6
					end

					if var_440_8.prefab_name ~= "" and arg_437_1.actors_[var_440_8.prefab_name] ~= nil then
						local var_440_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_8.prefab_name].transform, "story_v_out_421052", "421052107", "story_v_out_421052.awb")

						arg_437_1:RecordAudio("421052107", var_440_13)
						arg_437_1:RecordAudio("421052107", var_440_13)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_421052", "421052107", "story_v_out_421052.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_421052", "421052107", "story_v_out_421052.awb")
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
				actorName = "10145ui_story",
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
	Play421052108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 421052108
		arg_441_1.duration_ = 8.43

		local var_441_0 = {
			zh = 5.133,
			ja = 8.433
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play421052109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1047ui_story = arg_441_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1047ui_story"].transform.position).z)
				arg_441_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1047ui_story"].transform.localEulerAngles = arg_441_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_441_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1047ui_story"].transform.position).z)
				arg_441_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1047ui_story"].transform.localEulerAngles = arg_441_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["1047ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1047ui_story == nil then
				arg_441_1.var_.characterEffect1047ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect1047ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1047ui_story then
				arg_441_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_444_4 = arg_441_1.actors_["10145ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_4) and arg_441_1.var_.characterEffect10145ui_story == nil then
				arg_441_1.var_.characterEffect10145ui_story = var_444_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_5 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_5 and not isNil(var_444_4) then
				if arg_441_1.var_.characterEffect10145ui_story and not isNil(var_444_4) then
					arg_441_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_441_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_5)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_5 and arg_441_1.time_ < 0 + var_444_5 + arg_444_0 and not isNil(var_444_4) and arg_441_1.var_.characterEffect10145ui_story then
				arg_441_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_441_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action463")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_444_6 = 0
			local var_444_7 = 0.6

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_8 = arg_441_1:GetWordFromCfg(421052108)
				local var_444_9 = arg_441_1:FormatText(var_444_8.content)

				arg_441_1.text_.text = var_444_9

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 24 <= 0 and var_444_7 or var_444_7 * (utf8.len(var_444_9) / 24)

				if (24 <= 0 and var_444_7 or var_444_7 * (utf8.len(var_444_9) / 24)) > 0 and var_444_7 < var_444_11 then
					arg_441_1.talkMaxDuration = var_444_11

					if var_444_11 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_11 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_9
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052108", "story_v_out_421052.awb") ~= 0 then
					local var_444_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052108", "story_v_out_421052.awb") / 1000

					if var_444_12 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_12 + var_444_6
					end

					if var_444_8.prefab_name ~= "" and arg_441_1.actors_[var_444_8.prefab_name] ~= nil then
						local var_444_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_8.prefab_name].transform, "story_v_out_421052", "421052108", "story_v_out_421052.awb")

						arg_441_1:RecordAudio("421052108", var_444_13)
						arg_441_1:RecordAudio("421052108", var_444_13)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_421052", "421052108", "story_v_out_421052.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_421052", "421052108", "story_v_out_421052.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_14 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_14 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_14

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_14 and arg_441_1.time_ < var_444_6 + var_444_14 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
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

		arg_441_1:InitPlayNodeList()
	end,
	Play421052109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 421052109
		arg_445_1.duration_ = 16.5

		local var_445_0 = {
			zh = 13.333,
			ja = 16.5
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play421052110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10145ui_story = arg_445_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10145ui_story"].transform.position).z)
				arg_445_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["10145ui_story"].transform.localEulerAngles = arg_445_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_445_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10145ui_story"].transform.position).z)
				arg_445_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["10145ui_story"].transform.localEulerAngles = arg_445_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["10145ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect10145ui_story == nil then
				arg_445_1.var_.characterEffect10145ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 and not isNil(var_448_1) then
				if arg_445_1.var_.characterEffect10145ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect10145ui_story then
				arg_445_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_448_4 = arg_445_1.actors_["1047ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_4) and arg_445_1.var_.characterEffect1047ui_story == nil then
				arg_445_1.var_.characterEffect1047ui_story = var_448_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_5 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_5 and not isNil(var_448_4) then
				if arg_445_1.var_.characterEffect1047ui_story and not isNil(var_448_4) then
					arg_445_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_5)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_5 and arg_445_1.time_ < 0 + var_448_5 + arg_448_0 and not isNil(var_448_4) and arg_445_1.var_.characterEffect1047ui_story then
				arg_445_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_448_6 = 0
			local var_448_7 = 1.675

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_6 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_8 = arg_445_1:GetWordFromCfg(421052109)
				local var_448_9 = arg_445_1:FormatText(var_448_8.content)

				arg_445_1.text_.text = var_448_9

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_11 = 67 <= 0 and var_448_7 or var_448_7 * (utf8.len(var_448_9) / 67)

				if (67 <= 0 and var_448_7 or var_448_7 * (utf8.len(var_448_9) / 67)) > 0 and var_448_7 < var_448_11 then
					arg_445_1.talkMaxDuration = var_448_11

					if var_448_11 + var_448_6 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_11 + var_448_6
					end
				end

				arg_445_1.text_.text = var_448_9
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052109", "story_v_out_421052.awb") ~= 0 then
					local var_448_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052109", "story_v_out_421052.awb") / 1000

					if var_448_12 + var_448_6 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_12 + var_448_6
					end

					if var_448_8.prefab_name ~= "" and arg_445_1.actors_[var_448_8.prefab_name] ~= nil then
						local var_448_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_8.prefab_name].transform, "story_v_out_421052", "421052109", "story_v_out_421052.awb")

						arg_445_1:RecordAudio("421052109", var_448_13)
						arg_445_1:RecordAudio("421052109", var_448_13)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_421052", "421052109", "story_v_out_421052.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_421052", "421052109", "story_v_out_421052.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_14 = math.max(var_448_7, arg_445_1.talkMaxDuration)

			if var_448_6 <= arg_445_1.time_ and arg_445_1.time_ < var_448_6 + var_448_14 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_6) / var_448_14

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_6 + var_448_14 and arg_445_1.time_ < var_448_6 + var_448_14 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
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

		arg_445_1:InitPlayNodeList()
	end,
	Play421052110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 421052110
		arg_449_1.duration_ = 8.07

		local var_449_0 = {
			zh = 4.766,
			ja = 8.066
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play421052111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos10145ui_story = arg_449_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).z)
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles = arg_449_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_449_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).z)
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles = arg_449_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_452_1 = 0
			local var_452_2 = 0.625

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_3 = arg_449_1:GetWordFromCfg(421052110)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_6 = 25 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_4) / 25)

				if (25 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_4) / 25)) > 0 and var_452_2 < var_452_6 then
					arg_449_1.talkMaxDuration = var_452_6

					if var_452_6 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_6 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052110", "story_v_out_421052.awb") ~= 0 then
					local var_452_7 = manager.audio:GetVoiceLength("story_v_out_421052", "421052110", "story_v_out_421052.awb") / 1000

					if var_452_7 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_1
					end

					if var_452_3.prefab_name ~= "" and arg_449_1.actors_[var_452_3.prefab_name] ~= nil then
						local var_452_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_3.prefab_name].transform, "story_v_out_421052", "421052110", "story_v_out_421052.awb")

						arg_449_1:RecordAudio("421052110", var_452_8)
						arg_449_1:RecordAudio("421052110", var_452_8)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_421052", "421052110", "story_v_out_421052.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_421052", "421052110", "story_v_out_421052.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_9 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_9 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_9

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_9 and arg_449_1.time_ < var_452_1 + var_452_9 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
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

		arg_449_1:InitPlayNodeList()
	end,
	Play421052111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 421052111
		arg_453_1.duration_ = 7.57

		local var_453_0 = {
			zh = 5.3,
			ja = 7.566
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play421052112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1047ui_story = arg_453_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).z)
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles = arg_453_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_453_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).z)
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles = arg_453_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1047ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1047ui_story == nil then
				arg_453_1.var_.characterEffect1047ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1047ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1047ui_story then
				arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_456_4 = arg_453_1.actors_["10145ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_4) and arg_453_1.var_.characterEffect10145ui_story == nil then
				arg_453_1.var_.characterEffect10145ui_story = var_456_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_5 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_5 and not isNil(var_456_4) then
				if arg_453_1.var_.characterEffect10145ui_story and not isNil(var_456_4) then
					arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_5)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_5 and arg_453_1.time_ < 0 + var_456_5 + arg_456_0 and not isNil(var_456_4) and arg_453_1.var_.characterEffect10145ui_story then
				arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_456_6 = 0
			local var_456_7 = 0.525

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_6 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_8 = arg_453_1:GetWordFromCfg(421052111)
				local var_456_9 = arg_453_1:FormatText(var_456_8.content)

				arg_453_1.text_.text = var_456_9

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_11 = 21 <= 0 and var_456_7 or var_456_7 * (utf8.len(var_456_9) / 21)

				if (21 <= 0 and var_456_7 or var_456_7 * (utf8.len(var_456_9) / 21)) > 0 and var_456_7 < var_456_11 then
					arg_453_1.talkMaxDuration = var_456_11

					if var_456_11 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_11 + var_456_6
					end
				end

				arg_453_1.text_.text = var_456_9
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052111", "story_v_out_421052.awb") ~= 0 then
					local var_456_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052111", "story_v_out_421052.awb") / 1000

					if var_456_12 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_12 + var_456_6
					end

					if var_456_8.prefab_name ~= "" and arg_453_1.actors_[var_456_8.prefab_name] ~= nil then
						local var_456_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_8.prefab_name].transform, "story_v_out_421052", "421052111", "story_v_out_421052.awb")

						arg_453_1:RecordAudio("421052111", var_456_13)
						arg_453_1:RecordAudio("421052111", var_456_13)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_421052", "421052111", "story_v_out_421052.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_421052", "421052111", "story_v_out_421052.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_14 = math.max(var_456_7, arg_453_1.talkMaxDuration)

			if var_456_6 <= arg_453_1.time_ and arg_453_1.time_ < var_456_6 + var_456_14 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_6) / var_456_14

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_6 + var_456_14 and arg_453_1.time_ < var_456_6 + var_456_14 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play421052112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 421052112
		arg_457_1.duration_ = 8.2

		local var_457_0 = {
			zh = 5.133,
			ja = 8.2
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play421052113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10145ui_story = arg_457_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10145ui_story"].transform.position).z)
				arg_457_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10145ui_story"].transform.localEulerAngles = arg_457_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_457_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10145ui_story"].transform.position).z)
				arg_457_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10145ui_story"].transform.localEulerAngles = arg_457_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["10145ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect10145ui_story == nil then
				arg_457_1.var_.characterEffect10145ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect10145ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect10145ui_story then
				arg_457_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_460_4 = arg_457_1.actors_["1047ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_4) and arg_457_1.var_.characterEffect1047ui_story == nil then
				arg_457_1.var_.characterEffect1047ui_story = var_460_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_5 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_5 and not isNil(var_460_4) then
				if arg_457_1.var_.characterEffect1047ui_story and not isNil(var_460_4) then
					arg_457_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_5)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_5 and arg_457_1.time_ < 0 + var_460_5 + arg_460_0 and not isNil(var_460_4) and arg_457_1.var_.characterEffect1047ui_story then
				arg_457_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_460_6 = 0
			local var_460_7 = 0.475

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_6 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_8 = arg_457_1:GetWordFromCfg(421052112)
				local var_460_9 = arg_457_1:FormatText(var_460_8.content)

				arg_457_1.text_.text = var_460_9

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_11 = 19 <= 0 and var_460_7 or var_460_7 * (utf8.len(var_460_9) / 19)

				if (19 <= 0 and var_460_7 or var_460_7 * (utf8.len(var_460_9) / 19)) > 0 and var_460_7 < var_460_11 then
					arg_457_1.talkMaxDuration = var_460_11

					if var_460_11 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_11 + var_460_6
					end
				end

				arg_457_1.text_.text = var_460_9
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052112", "story_v_out_421052.awb") ~= 0 then
					local var_460_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052112", "story_v_out_421052.awb") / 1000

					if var_460_12 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_12 + var_460_6
					end

					if var_460_8.prefab_name ~= "" and arg_457_1.actors_[var_460_8.prefab_name] ~= nil then
						local var_460_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_8.prefab_name].transform, "story_v_out_421052", "421052112", "story_v_out_421052.awb")

						arg_457_1:RecordAudio("421052112", var_460_13)
						arg_457_1:RecordAudio("421052112", var_460_13)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_421052", "421052112", "story_v_out_421052.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_421052", "421052112", "story_v_out_421052.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_14 = math.max(var_460_7, arg_457_1.talkMaxDuration)

			if var_460_6 <= arg_457_1.time_ and arg_457_1.time_ < var_460_6 + var_460_14 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_6) / var_460_14

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_6 + var_460_14 and arg_457_1.time_ < var_460_6 + var_460_14 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
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

		arg_457_1:InitPlayNodeList()
	end,
	Play421052113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 421052113
		arg_461_1.duration_ = 5.13

		local var_461_0 = {
			zh = 3.1,
			ja = 5.133
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play421052114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1047ui_story = arg_461_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).z)
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles = arg_461_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_461_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).z)
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles = arg_461_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["1047ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1047ui_story == nil then
				arg_461_1.var_.characterEffect1047ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect1047ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1047ui_story then
				arg_461_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_464_4 = arg_461_1.actors_["10145ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_4) and arg_461_1.var_.characterEffect10145ui_story == nil then
				arg_461_1.var_.characterEffect10145ui_story = var_464_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_5 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_5 and not isNil(var_464_4) then
				if arg_461_1.var_.characterEffect10145ui_story and not isNil(var_464_4) then
					arg_461_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_5)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_5 and arg_461_1.time_ < 0 + var_464_5 + arg_464_0 and not isNil(var_464_4) and arg_461_1.var_.characterEffect10145ui_story then
				arg_461_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_464_6 = 0
			local var_464_7 = 0.375

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_8 = arg_461_1:GetWordFromCfg(421052113)
				local var_464_9 = arg_461_1:FormatText(var_464_8.content)

				arg_461_1.text_.text = var_464_9

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_11 = 15 <= 0 and var_464_7 or var_464_7 * (utf8.len(var_464_9) / 15)

				if (15 <= 0 and var_464_7 or var_464_7 * (utf8.len(var_464_9) / 15)) > 0 and var_464_7 < var_464_11 then
					arg_461_1.talkMaxDuration = var_464_11

					if var_464_11 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_11 + var_464_6
					end
				end

				arg_461_1.text_.text = var_464_9
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052113", "story_v_out_421052.awb") ~= 0 then
					local var_464_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052113", "story_v_out_421052.awb") / 1000

					if var_464_12 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_12 + var_464_6
					end

					if var_464_8.prefab_name ~= "" and arg_461_1.actors_[var_464_8.prefab_name] ~= nil then
						local var_464_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_8.prefab_name].transform, "story_v_out_421052", "421052113", "story_v_out_421052.awb")

						arg_461_1:RecordAudio("421052113", var_464_13)
						arg_461_1:RecordAudio("421052113", var_464_13)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_421052", "421052113", "story_v_out_421052.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_421052", "421052113", "story_v_out_421052.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_14 = math.max(var_464_7, arg_461_1.talkMaxDuration)

			if var_464_6 <= arg_461_1.time_ and arg_461_1.time_ < var_464_6 + var_464_14 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_6) / var_464_14

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_6 + var_464_14 and arg_461_1.time_ < var_464_6 + var_464_14 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play421052114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 421052114
		arg_465_1.duration_ = 9.5

		local var_465_0 = {
			zh = 7.1,
			ja = 9.5
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play421052115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos10145ui_story = arg_465_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).z)
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles = arg_465_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_465_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).z)
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles = arg_465_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["10145ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect10145ui_story == nil then
				arg_465_1.var_.characterEffect10145ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect10145ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect10145ui_story then
				arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_468_4 = arg_465_1.actors_["1047ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_4) and arg_465_1.var_.characterEffect1047ui_story == nil then
				arg_465_1.var_.characterEffect1047ui_story = var_468_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_5 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_5 and not isNil(var_468_4) then
				if arg_465_1.var_.characterEffect1047ui_story and not isNil(var_468_4) then
					arg_465_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_5)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_5 and arg_465_1.time_ < 0 + var_468_5 + arg_468_0 and not isNil(var_468_4) and arg_465_1.var_.characterEffect1047ui_story then
				arg_465_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_468_6 = 0
			local var_468_7 = 0.8

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_8 = arg_465_1:GetWordFromCfg(421052114)
				local var_468_9 = arg_465_1:FormatText(var_468_8.content)

				arg_465_1.text_.text = var_468_9

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 32 <= 0 and var_468_7 or var_468_7 * (utf8.len(var_468_9) / 32)

				if (32 <= 0 and var_468_7 or var_468_7 * (utf8.len(var_468_9) / 32)) > 0 and var_468_7 < var_468_11 then
					arg_465_1.talkMaxDuration = var_468_11

					if var_468_11 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_11 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_9
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052114", "story_v_out_421052.awb") ~= 0 then
					local var_468_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052114", "story_v_out_421052.awb") / 1000

					if var_468_12 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_6
					end

					if var_468_8.prefab_name ~= "" and arg_465_1.actors_[var_468_8.prefab_name] ~= nil then
						local var_468_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_8.prefab_name].transform, "story_v_out_421052", "421052114", "story_v_out_421052.awb")

						arg_465_1:RecordAudio("421052114", var_468_13)
						arg_465_1:RecordAudio("421052114", var_468_13)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_421052", "421052114", "story_v_out_421052.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_421052", "421052114", "story_v_out_421052.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_14 and arg_465_1.time_ < var_468_6 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
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

		arg_465_1:InitPlayNodeList()
	end,
	Play421052115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 421052115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play421052116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos10145ui_story = arg_469_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["10145ui_story"].transform.position).z)
				arg_469_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["10145ui_story"].transform.localEulerAngles = arg_469_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["10145ui_story"].transform.position).z)
				arg_469_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["10145ui_story"].transform.localEulerAngles = arg_469_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["1047ui_story"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1047ui_story = var_472_1.localPosition
			end

			local var_472_2 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 then
				var_472_1.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_2)
				var_472_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_1.position).x, (manager.ui.mainCamera.transform.position - var_472_1.position).y, (manager.ui.mainCamera.transform.position - var_472_1.position).z)
				var_472_1.localEulerAngles.z = 0
				var_472_1.localEulerAngles.x = 0
				var_472_1.localEulerAngles = var_472_1.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 then
				var_472_1.localPosition = Vector3.New(0, 100, 0)
				var_472_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_1.position).x, (manager.ui.mainCamera.transform.position - var_472_1.position).y, (manager.ui.mainCamera.transform.position - var_472_1.position).z)
				var_472_1.localEulerAngles.z = 0
				var_472_1.localEulerAngles.x = 0
				var_472_1.localEulerAngles = var_472_1.localEulerAngles
			end

			local var_472_3 = 0
			local var_472_4 = 1

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_3 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_5 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(421052115).content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 40 <= 0 and var_472_4 or var_472_4 * (utf8.len(var_472_5) / 40)

				if (40 <= 0 and var_472_4 or var_472_4 * (utf8.len(var_472_5) / 40)) > 0 and var_472_4 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_3 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_3
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_4, arg_469_1.talkMaxDuration)

			if var_472_3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_3 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_3) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_3 + var_472_8 and arg_469_1.time_ < var_472_3 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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

		arg_469_1:InitPlayNodeList()
	end,
	Play421052116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 421052116
		arg_473_1.duration_ = 6.17

		local var_473_0 = {
			zh = 6.166,
			ja = 5.7
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play421052117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos10145ui_story = arg_473_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10145ui_story"].transform.position).z)
				arg_473_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["10145ui_story"].transform.localEulerAngles = arg_473_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_473_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10145ui_story"].transform.position).z)
				arg_473_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["10145ui_story"].transform.localEulerAngles = arg_473_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["10145ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect10145ui_story == nil then
				arg_473_1.var_.characterEffect10145ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect10145ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect10145ui_story then
				arg_473_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_476_4 = 0
			local var_476_5 = 0.65

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(421052116)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 26 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 26)

				if (26 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 26)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052116", "story_v_out_421052.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052116", "story_v_out_421052.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_out_421052", "421052116", "story_v_out_421052.awb")

						arg_473_1:RecordAudio("421052116", var_476_11)
						arg_473_1:RecordAudio("421052116", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_421052", "421052116", "story_v_out_421052.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_421052", "421052116", "story_v_out_421052.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
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

		arg_473_1:InitPlayNodeList()
	end,
	Play421052117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 421052117
		arg_477_1.duration_ = 9

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play421052118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				local var_480_0 = arg_477_1.bgs_.B10a

				arg_477_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_480_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_1 = var_480_0:GetComponent("SpriteRenderer")

				if var_480_1 and var_480_1.sprite then
					local var_480_2 = 2 * (var_480_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_480_0.transform.localScale = Vector3.New(var_480_2 / var_480_1.sprite.bounds.size.y < var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x and var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x or var_480_2 / var_480_1.sprite.bounds.size.y, var_480_2 / var_480_1.sprite.bounds.size.y < var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x and var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x or var_480_2 / var_480_1.sprite.bounds.size.y, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "B10a" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_3 = 4

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_3 + arg_480_0 then
				arg_477_1.allBtn_.enabled = false
			end

			if arg_477_1.time_ >= var_480_3 + 0.0666666666666664 and arg_477_1.time_ < var_480_3 + 0.0666666666666664 + arg_480_0 then
				arg_477_1.allBtn_.enabled = true
			end

			local var_480_4 = 0

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_5 = 2

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_5 then
				local var_480_6 = Color.New(0, 0, 0)

				var_480_6.a = Mathf.Lerp(0, 1, (arg_477_1.time_ - var_480_4) / var_480_5)
				arg_477_1.mask_.color = var_480_6
			end

			if arg_477_1.time_ >= var_480_4 + var_480_5 and arg_477_1.time_ < var_480_4 + var_480_5 + arg_480_0 then
				local var_480_7 = Color.New(0, 0, 0)

				var_480_7.a = 1
				arg_477_1.mask_.color = var_480_7
			end

			local var_480_8 = 2

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= var_480_8 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_9 = 2

			if var_480_8 <= arg_477_1.time_ and arg_477_1.time_ < var_480_8 + var_480_9 then
				local var_480_10 = Color.New(0, 0, 0)

				var_480_10.a = Mathf.Lerp(1, 0, (arg_477_1.time_ - var_480_8) / var_480_9)
				arg_477_1.mask_.color = var_480_10
			end

			if arg_477_1.time_ >= var_480_8 + var_480_9 and arg_477_1.time_ < var_480_8 + var_480_9 + arg_480_0 then
				local var_480_11 = Color.New(0, 0, 0)

				arg_477_1.mask_.enabled = false
				var_480_11.a = 0
				arg_477_1.mask_.color = var_480_11
			end

			local var_480_12 = arg_477_1.actors_["10145ui_story"].transform

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				arg_477_1.var_.moveOldPos10145ui_story = var_480_12.localPosition
			end

			local var_480_13 = 0.001

			if 2 <= arg_477_1.time_ and arg_477_1.time_ < 2 + var_480_13 then
				var_480_12.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 2) / var_480_13)
				var_480_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_12.position).x, (manager.ui.mainCamera.transform.position - var_480_12.position).y, (manager.ui.mainCamera.transform.position - var_480_12.position).z)
				var_480_12.localEulerAngles.z = 0
				var_480_12.localEulerAngles.x = 0
				var_480_12.localEulerAngles = var_480_12.localEulerAngles
			end

			if arg_477_1.time_ >= 2 + var_480_13 and arg_477_1.time_ < 2 + var_480_13 + arg_480_0 then
				var_480_12.localPosition = Vector3.New(0, 100, 0)
				var_480_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_12.position).x, (manager.ui.mainCamera.transform.position - var_480_12.position).y, (manager.ui.mainCamera.transform.position - var_480_12.position).z)
				var_480_12.localEulerAngles.z = 0
				var_480_12.localEulerAngles.x = 0
				var_480_12.localEulerAngles = var_480_12.localEulerAngles
			end

			if 0.1 < arg_477_1.time_ and arg_477_1.time_ <= 0.1 + arg_480_0 then
				arg_477_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 1.63333333333333 < arg_477_1.time_ and arg_477_1.time_ <= 1.63333333333333 + arg_480_0 then
				arg_477_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_16 = 4
			local var_480_17 = 0.15

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_16 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_18 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_18:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_19 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(421052117).content)

				arg_477_1.text_.text = var_480_19

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_21 = 6 <= 0 and var_480_17 or var_480_17 * (utf8.len(var_480_19) / 6)

				if (6 <= 0 and var_480_17 or var_480_17 * (utf8.len(var_480_19) / 6)) > 0 and var_480_17 < var_480_21 then
					arg_477_1.talkMaxDuration = var_480_21
					var_480_16 = var_480_16 + 0.3

					if var_480_21 + var_480_16 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_21 + var_480_16
					end
				end

				arg_477_1.text_.text = var_480_19
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_22 = var_480_16 + 0.3
			local var_480_23 = math.max(var_480_17, arg_477_1.talkMaxDuration)

			if var_480_16 + 0.3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_22 + var_480_23 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_22) / var_480_23

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_22 + var_480_23 and arg_477_1.time_ < var_480_22 + var_480_23 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
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

		arg_477_1:InitPlayNodeList()
	end,
	Play421052118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 421052118
		arg_483_1.duration_ = 5.2

		local var_483_0 = {
			zh = 2.8,
			ja = 5.2
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play421052119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10145ui_story = arg_483_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10145ui_story"].transform.position).z)
				arg_483_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10145ui_story"].transform.localEulerAngles = arg_483_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_483_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10145ui_story"].transform.position).z)
				arg_483_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10145ui_story"].transform.localEulerAngles = arg_483_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["10145ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10145ui_story == nil then
				arg_483_1.var_.characterEffect10145ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect10145ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10145ui_story then
				arg_483_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action8_1")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_486_4 = 0
			local var_486_5 = 0.325

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_6 = arg_483_1:GetWordFromCfg(421052118)
				local var_486_7 = arg_483_1:FormatText(var_486_6.content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 13 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 13)

				if (13 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 13)) > 0 and var_486_5 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052118", "story_v_out_421052.awb") ~= 0 then
					local var_486_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052118", "story_v_out_421052.awb") / 1000

					if var_486_10 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_10 + var_486_4
					end

					if var_486_6.prefab_name ~= "" and arg_483_1.actors_[var_486_6.prefab_name] ~= nil then
						local var_486_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_6.prefab_name].transform, "story_v_out_421052", "421052118", "story_v_out_421052.awb")

						arg_483_1:RecordAudio("421052118", var_486_11)
						arg_483_1:RecordAudio("421052118", var_486_11)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_421052", "421052118", "story_v_out_421052.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_421052", "421052118", "story_v_out_421052.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_12 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 <= arg_483_1.time_ and arg_483_1.time_ < var_486_4 + var_486_12 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_4) / var_486_12

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_4 + var_486_12 and arg_483_1.time_ < var_486_4 + var_486_12 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
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

		arg_483_1:InitPlayNodeList()
	end,
	Play421052119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 421052119
		arg_487_1.duration_ = 4.17

		local var_487_0 = {
			zh = 3.733,
			ja = 4.166
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play421052120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos10102ui_story = arg_487_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_490_0 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 then
				arg_487_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_487_1.time_ - 0) / var_490_0)
				arg_487_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["10102ui_story"].transform.position).z)
				arg_487_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["10102ui_story"].transform.localEulerAngles = arg_487_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_487_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["10102ui_story"].transform.position).z)
				arg_487_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["10102ui_story"].transform.localEulerAngles = arg_487_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_490_1 = arg_487_1.actors_["10145ui_story"].transform

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos10145ui_story = var_490_1.localPosition
			end

			local var_490_2 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 then
				var_490_1.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_487_1.time_ - 0) / var_490_2)
				var_490_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_1.position).x, (manager.ui.mainCamera.transform.position - var_490_1.position).y, (manager.ui.mainCamera.transform.position - var_490_1.position).z)
				var_490_1.localEulerAngles.z = 0
				var_490_1.localEulerAngles.x = 0
				var_490_1.localEulerAngles = var_490_1.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 then
				var_490_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_490_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_1.position).x, (manager.ui.mainCamera.transform.position - var_490_1.position).y, (manager.ui.mainCamera.transform.position - var_490_1.position).z)
				var_490_1.localEulerAngles.z = 0
				var_490_1.localEulerAngles.x = 0
				var_490_1.localEulerAngles = var_490_1.localEulerAngles
			end

			local var_490_3 = arg_487_1.actors_["10102ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_3) and arg_487_1.var_.characterEffect10102ui_story == nil then
				arg_487_1.var_.characterEffect10102ui_story = var_490_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_4 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 and not isNil(var_490_3) then
				if arg_487_1.var_.characterEffect10102ui_story and not isNil(var_490_3) then
					arg_487_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 and not isNil(var_490_3) and arg_487_1.var_.characterEffect10102ui_story then
				arg_487_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_490_6 = arg_487_1.actors_["10145ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_6) and arg_487_1.var_.characterEffect10145ui_story == nil then
				arg_487_1.var_.characterEffect10145ui_story = var_490_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_7 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 and not isNil(var_490_6) then
				if arg_487_1.var_.characterEffect10145ui_story and not isNil(var_490_6) then
					arg_487_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_487_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_7)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 and not isNil(var_490_6) and arg_487_1.var_.characterEffect10145ui_story then
				arg_487_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_487_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_490_8 = 0
			local var_490_9 = 0.4

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_8 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_10 = arg_487_1:GetWordFromCfg(421052119)
				local var_490_11 = arg_487_1:FormatText(var_490_10.content)

				arg_487_1.text_.text = var_490_11

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_13 = 16 <= 0 and var_490_9 or var_490_9 * (utf8.len(var_490_11) / 16)

				if (16 <= 0 and var_490_9 or var_490_9 * (utf8.len(var_490_11) / 16)) > 0 and var_490_9 < var_490_13 then
					arg_487_1.talkMaxDuration = var_490_13

					if var_490_13 + var_490_8 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_13 + var_490_8
					end
				end

				arg_487_1.text_.text = var_490_11
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052119", "story_v_out_421052.awb") ~= 0 then
					local var_490_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052119", "story_v_out_421052.awb") / 1000

					if var_490_14 + var_490_8 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_14 + var_490_8
					end

					if var_490_10.prefab_name ~= "" and arg_487_1.actors_[var_490_10.prefab_name] ~= nil then
						local var_490_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_10.prefab_name].transform, "story_v_out_421052", "421052119", "story_v_out_421052.awb")

						arg_487_1:RecordAudio("421052119", var_490_15)
						arg_487_1:RecordAudio("421052119", var_490_15)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_421052", "421052119", "story_v_out_421052.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_421052", "421052119", "story_v_out_421052.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_16 = math.max(var_490_9, arg_487_1.talkMaxDuration)

			if var_490_8 <= arg_487_1.time_ and arg_487_1.time_ < var_490_8 + var_490_16 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_8) / var_490_16

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_8 + var_490_16 and arg_487_1.time_ < var_490_8 + var_490_16 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
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

		arg_487_1:InitPlayNodeList()
	end,
	Play421052120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 421052120
		arg_491_1.duration_ = 8.1

		local var_491_0 = {
			zh = 7.533,
			ja = 8.1
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play421052121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10145ui_story = arg_491_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10145ui_story"].transform.position).z)
				arg_491_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["10145ui_story"].transform.localEulerAngles = arg_491_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_491_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10145ui_story"].transform.position).z)
				arg_491_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["10145ui_story"].transform.localEulerAngles = arg_491_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["10145ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect10145ui_story == nil then
				arg_491_1.var_.characterEffect10145ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect10145ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect10145ui_story then
				arg_491_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_494_4 = arg_491_1.actors_["10102ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_4) and arg_491_1.var_.characterEffect10102ui_story == nil then
				arg_491_1.var_.characterEffect10102ui_story = var_494_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_5 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_5 and not isNil(var_494_4) then
				if arg_491_1.var_.characterEffect10102ui_story and not isNil(var_494_4) then
					arg_491_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_491_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_491_1.time_ - 0) / var_494_5)
				end
			end

			if arg_491_1.time_ >= 0 + var_494_5 and arg_491_1.time_ < 0 + var_494_5 + arg_494_0 and not isNil(var_494_4) and arg_491_1.var_.characterEffect10102ui_story then
				arg_491_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_491_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action8_2")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_494_6 = 0
			local var_494_7 = 0.8

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_8 = arg_491_1:GetWordFromCfg(421052120)
				local var_494_9 = arg_491_1:FormatText(var_494_8.content)

				arg_491_1.text_.text = var_494_9

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 32 <= 0 and var_494_7 or var_494_7 * (utf8.len(var_494_9) / 32)

				if (32 <= 0 and var_494_7 or var_494_7 * (utf8.len(var_494_9) / 32)) > 0 and var_494_7 < var_494_11 then
					arg_491_1.talkMaxDuration = var_494_11

					if var_494_11 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_11 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_9
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052120", "story_v_out_421052.awb") ~= 0 then
					local var_494_12 = manager.audio:GetVoiceLength("story_v_out_421052", "421052120", "story_v_out_421052.awb") / 1000

					if var_494_12 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_12 + var_494_6
					end

					if var_494_8.prefab_name ~= "" and arg_491_1.actors_[var_494_8.prefab_name] ~= nil then
						local var_494_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_8.prefab_name].transform, "story_v_out_421052", "421052120", "story_v_out_421052.awb")

						arg_491_1:RecordAudio("421052120", var_494_13)
						arg_491_1:RecordAudio("421052120", var_494_13)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_421052", "421052120", "story_v_out_421052.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_421052", "421052120", "story_v_out_421052.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_14 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_14 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_14

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_14 and arg_491_1.time_ < var_494_6 + var_494_14 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
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

		arg_491_1:InitPlayNodeList()
	end,
	Play421052121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 421052121
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play421052122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["10145ui_story"]) and arg_495_1.var_.characterEffect10145ui_story == nil then
				arg_495_1.var_.characterEffect10145ui_story = arg_495_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["10145ui_story"]) then
				if arg_495_1.var_.characterEffect10145ui_story and not isNil(arg_495_1.actors_["10145ui_story"]) then
					arg_495_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_0)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["10145ui_story"]) and arg_495_1.var_.characterEffect10145ui_story then
				arg_495_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_498_1 = 0
			local var_498_2 = 0.225

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(421052121).content)

				arg_495_1.text_.text = var_498_3

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 9 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_3) / 9)

				if (9 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_3) / 9)) > 0 and var_498_2 < var_498_5 then
					arg_495_1.talkMaxDuration = var_498_5

					if var_498_5 + var_498_1 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + var_498_1
					end
				end

				arg_495_1.text_.text = var_498_3
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_6 = math.max(var_498_2, arg_495_1.talkMaxDuration)

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_6 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_1) / var_498_6

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_1 + var_498_6 and arg_495_1.time_ < var_498_1 + var_498_6 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play421052122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 421052122
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play421052123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10145ui_story = arg_499_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10145ui_story"].transform.position).z)
				arg_499_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["10145ui_story"].transform.localEulerAngles = arg_499_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_499_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10145ui_story"].transform.position).z)
				arg_499_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["10145ui_story"].transform.localEulerAngles = arg_499_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["10102ui_story"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10102ui_story = var_502_1.localPosition
			end

			local var_502_2 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 then
				var_502_1.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_2)
				var_502_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_1.position).x, (manager.ui.mainCamera.transform.position - var_502_1.position).y, (manager.ui.mainCamera.transform.position - var_502_1.position).z)
				var_502_1.localEulerAngles.z = 0
				var_502_1.localEulerAngles.x = 0
				var_502_1.localEulerAngles = var_502_1.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 then
				var_502_1.localPosition = Vector3.New(0, 100, 0)
				var_502_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_1.position).x, (manager.ui.mainCamera.transform.position - var_502_1.position).y, (manager.ui.mainCamera.transform.position - var_502_1.position).z)
				var_502_1.localEulerAngles.z = 0
				var_502_1.localEulerAngles.x = 0
				var_502_1.localEulerAngles = var_502_1.localEulerAngles
			end

			if 0.1 < arg_499_1.time_ and arg_499_1.time_ <= 0.1 + arg_502_0 then
				arg_499_1:AudioAction("play", "effect", "se_story_143", "se_story_143_foley_bag", "")
			end

			local var_502_4 = 0
			local var_502_5 = 0.725

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_6 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(421052122).content)

				arg_499_1.text_.text = var_502_6

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_8 = 29 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_6) / 29)

				if (29 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_6) / 29)) > 0 and var_502_5 < var_502_8 then
					arg_499_1.talkMaxDuration = var_502_8

					if var_502_8 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_4
					end
				end

				arg_499_1.text_.text = var_502_6
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_9 = math.max(var_502_5, arg_499_1.talkMaxDuration)

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_9 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_4) / var_502_9

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_4 + var_502_9 and arg_499_1.time_ < var_502_4 + var_502_9 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_499_1:InitPlayNodeList()
	end,
	Play421052123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 421052123
		arg_503_1.duration_ = 4.57

		local var_503_0 = {
			zh = 3.8,
			ja = 4.566
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play421052124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10145ui_story = arg_503_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["10145ui_story"].transform.position).z)
				arg_503_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["10145ui_story"].transform.localEulerAngles = arg_503_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_503_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["10145ui_story"].transform.position).z)
				arg_503_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["10145ui_story"].transform.localEulerAngles = arg_503_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_506_1 = arg_503_1.actors_["10145ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect10145ui_story == nil then
				arg_503_1.var_.characterEffect10145ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_2 and not isNil(var_506_1) then
				if arg_503_1.var_.characterEffect10145ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_2 and arg_503_1.time_ < 0 + var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect10145ui_story then
				arg_503_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_506_4 = 0
			local var_506_5 = 0.35

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_4 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_6 = arg_503_1:GetWordFromCfg(421052123)
				local var_506_7 = arg_503_1:FormatText(var_506_6.content)

				arg_503_1.text_.text = var_506_7

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_9 = 14 <= 0 and var_506_5 or var_506_5 * (utf8.len(var_506_7) / 14)

				if (14 <= 0 and var_506_5 or var_506_5 * (utf8.len(var_506_7) / 14)) > 0 and var_506_5 < var_506_9 then
					arg_503_1.talkMaxDuration = var_506_9

					if var_506_9 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_9 + var_506_4
					end
				end

				arg_503_1.text_.text = var_506_7
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052123", "story_v_out_421052.awb") ~= 0 then
					local var_506_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052123", "story_v_out_421052.awb") / 1000

					if var_506_10 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_10 + var_506_4
					end

					if var_506_6.prefab_name ~= "" and arg_503_1.actors_[var_506_6.prefab_name] ~= nil then
						local var_506_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_6.prefab_name].transform, "story_v_out_421052", "421052123", "story_v_out_421052.awb")

						arg_503_1:RecordAudio("421052123", var_506_11)
						arg_503_1:RecordAudio("421052123", var_506_11)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_421052", "421052123", "story_v_out_421052.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_421052", "421052123", "story_v_out_421052.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_12 = math.max(var_506_5, arg_503_1.talkMaxDuration)

			if var_506_4 <= arg_503_1.time_ and arg_503_1.time_ < var_506_4 + var_506_12 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_4) / var_506_12

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_4 + var_506_12 and arg_503_1.time_ < var_506_4 + var_506_12 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
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

		arg_503_1:InitPlayNodeList()
	end,
	Play421052124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 421052124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play421052125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["10145ui_story"]) and arg_507_1.var_.characterEffect10145ui_story == nil then
				arg_507_1.var_.characterEffect10145ui_story = arg_507_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_0 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["10145ui_story"]) then
				if arg_507_1.var_.characterEffect10145ui_story and not isNil(arg_507_1.actors_["10145ui_story"]) then
					arg_507_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_507_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_0)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["10145ui_story"]) and arg_507_1.var_.characterEffect10145ui_story then
				arg_507_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_507_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_510_1 = 0
			local var_510_2 = 0.975

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(421052124).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 39 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 39)

				if (39 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 39)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play421052125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 421052125
		arg_511_1.duration_ = 5.67

		local var_511_0 = {
			zh = 4,
			ja = 5.666
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play421052126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10145ui_story = arg_511_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10145ui_story"].transform.position).z)
				arg_511_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["10145ui_story"].transform.localEulerAngles = arg_511_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_511_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10145ui_story"].transform.position).z)
				arg_511_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["10145ui_story"].transform.localEulerAngles = arg_511_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_514_1 = arg_511_1.actors_["10145ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect10145ui_story == nil then
				arg_511_1.var_.characterEffect10145ui_story = var_514_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_2 and not isNil(var_514_1) then
				if arg_511_1.var_.characterEffect10145ui_story and not isNil(var_514_1) then
					arg_511_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_2 and arg_511_1.time_ < 0 + var_514_2 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect10145ui_story then
				arg_511_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_2")
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_514_4 = 0
			local var_514_5 = 0.7

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_6 = arg_511_1:GetWordFromCfg(421052125)
				local var_514_7 = arg_511_1:FormatText(var_514_6.content)

				arg_511_1.text_.text = var_514_7

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 28 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 28)

				if (28 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 28)) > 0 and var_514_5 < var_514_9 then
					arg_511_1.talkMaxDuration = var_514_9

					if var_514_9 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_9 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_7
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052125", "story_v_out_421052.awb") ~= 0 then
					local var_514_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052125", "story_v_out_421052.awb") / 1000

					if var_514_10 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_10 + var_514_4
					end

					if var_514_6.prefab_name ~= "" and arg_511_1.actors_[var_514_6.prefab_name] ~= nil then
						local var_514_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_6.prefab_name].transform, "story_v_out_421052", "421052125", "story_v_out_421052.awb")

						arg_511_1:RecordAudio("421052125", var_514_11)
						arg_511_1:RecordAudio("421052125", var_514_11)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_421052", "421052125", "story_v_out_421052.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_421052", "421052125", "story_v_out_421052.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_12 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_12 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_12

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_12 and arg_511_1.time_ < var_514_4 + var_514_12 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
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

		arg_511_1:InitPlayNodeList()
	end,
	Play421052126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 421052126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play421052127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10145ui_story = arg_515_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10145ui_story"].transform.position).z)
				arg_515_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["10145ui_story"].transform.localEulerAngles = arg_515_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_515_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10145ui_story"].transform.position).z)
				arg_515_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["10145ui_story"].transform.localEulerAngles = arg_515_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_518_1 = 0
			local var_518_2 = 0.35

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(421052126).content)

				arg_515_1.text_.text = var_518_3

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 14 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 14)

				if (14 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 14)) > 0 and var_518_2 < var_518_5 then
					arg_515_1.talkMaxDuration = var_518_5

					if var_518_5 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + var_518_1
					end
				end

				arg_515_1.text_.text = var_518_3
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_6 = math.max(var_518_2, arg_515_1.talkMaxDuration)

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_6 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_1) / var_518_6

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_1 + var_518_6 and arg_515_1.time_ < var_518_1 + var_518_6 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
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

		arg_515_1:InitPlayNodeList()
	end,
	Play421052127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 421052127
		arg_519_1.duration_ = 2

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play421052128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10102ui_story = arg_519_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10102ui_story"].transform.position).z)
				arg_519_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["10102ui_story"].transform.localEulerAngles = arg_519_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_519_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10102ui_story"].transform.position).z)
				arg_519_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["10102ui_story"].transform.localEulerAngles = arg_519_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["10102ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect10102ui_story == nil then
				arg_519_1.var_.characterEffect10102ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect10102ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect10102ui_story then
				arg_519_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_522_4 = 0
			local var_522_5 = 0.200000002980232

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_6 = arg_519_1:GetWordFromCfg(421052127)
				local var_522_7 = arg_519_1:FormatText(var_522_6.content)

				arg_519_1.text_.text = var_522_7

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_9 = 2 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 2)

				if (2 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 2)) > 0 and var_522_5 < var_522_9 then
					arg_519_1.talkMaxDuration = var_522_9

					if var_522_9 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_9 + var_522_4
					end
				end

				arg_519_1.text_.text = var_522_7
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052127", "story_v_out_421052.awb") ~= 0 then
					local var_522_10 = manager.audio:GetVoiceLength("story_v_out_421052", "421052127", "story_v_out_421052.awb") / 1000

					if var_522_10 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_10 + var_522_4
					end

					if var_522_6.prefab_name ~= "" and arg_519_1.actors_[var_522_6.prefab_name] ~= nil then
						local var_522_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_6.prefab_name].transform, "story_v_out_421052", "421052127", "story_v_out_421052.awb")

						arg_519_1:RecordAudio("421052127", var_522_11)
						arg_519_1:RecordAudio("421052127", var_522_11)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_421052", "421052127", "story_v_out_421052.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_421052", "421052127", "story_v_out_421052.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_12 = math.max(var_522_5, arg_519_1.talkMaxDuration)

			if var_522_4 <= arg_519_1.time_ and arg_519_1.time_ < var_522_4 + var_522_12 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_4) / var_522_12

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_4 + var_522_12 and arg_519_1.time_ < var_522_4 + var_522_12 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
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

		arg_519_1:InitPlayNodeList()
	end,
	Play421052128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 421052128
		arg_523_1.duration_ = 4.77

		local var_523_0 = {
			zh = 4.333,
			ja = 4.766
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play421052129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10102ui_story = arg_523_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_526_0 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 then
				arg_523_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 0) / var_526_0)
				arg_523_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_523_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10102ui_story"].transform.position).z)
				arg_523_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_523_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_523_1.actors_["10102ui_story"].transform.localEulerAngles = arg_523_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 then
				arg_523_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_523_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_523_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10102ui_story"].transform.position).z)
				arg_523_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_523_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_523_1.actors_["10102ui_story"].transform.localEulerAngles = arg_523_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_526_1 = arg_523_1.actors_["10145ui_story"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10145ui_story = var_526_1.localPosition
			end

			local var_526_2 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_2 then
				var_526_1.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_523_1.time_ - 0) / var_526_2)
				var_526_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_1.position).x, (manager.ui.mainCamera.transform.position - var_526_1.position).y, (manager.ui.mainCamera.transform.position - var_526_1.position).z)
				var_526_1.localEulerAngles.z = 0
				var_526_1.localEulerAngles.x = 0
				var_526_1.localEulerAngles = var_526_1.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_2 and arg_523_1.time_ < 0 + var_526_2 + arg_526_0 then
				var_526_1.localPosition = Vector3.New(0, -1, -6.2)
				var_526_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_1.position).x, (manager.ui.mainCamera.transform.position - var_526_1.position).y, (manager.ui.mainCamera.transform.position - var_526_1.position).z)
				var_526_1.localEulerAngles.z = 0
				var_526_1.localEulerAngles.x = 0
				var_526_1.localEulerAngles = var_526_1.localEulerAngles
			end

			local var_526_3 = arg_523_1.actors_["10145ui_story"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_3) and arg_523_1.var_.characterEffect10145ui_story == nil then
				arg_523_1.var_.characterEffect10145ui_story = var_526_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_4 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 and not isNil(var_526_3) then
				if arg_523_1.var_.characterEffect10145ui_story and not isNil(var_526_3) then
					arg_523_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 and not isNil(var_526_3) and arg_523_1.var_.characterEffect10145ui_story then
				arg_523_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_526_6 = arg_523_1.actors_["10102ui_story"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_6) and arg_523_1.var_.characterEffect10102ui_story == nil then
				arg_523_1.var_.characterEffect10102ui_story = var_526_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_7 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_7 and not isNil(var_526_6) then
				if arg_523_1.var_.characterEffect10102ui_story and not isNil(var_526_6) then
					arg_523_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_523_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_7)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_7 and arg_523_1.time_ < 0 + var_526_7 + arg_526_0 and not isNil(var_526_6) and arg_523_1.var_.characterEffect10102ui_story then
				arg_523_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_523_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_526_8 = 0
			local var_526_9 = 0.45

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_8 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_10 = arg_523_1:GetWordFromCfg(421052128)
				local var_526_11 = arg_523_1:FormatText(var_526_10.content)

				arg_523_1.text_.text = var_526_11

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_13 = 18 <= 0 and var_526_9 or var_526_9 * (utf8.len(var_526_11) / 18)

				if (18 <= 0 and var_526_9 or var_526_9 * (utf8.len(var_526_11) / 18)) > 0 and var_526_9 < var_526_13 then
					arg_523_1.talkMaxDuration = var_526_13

					if var_526_13 + var_526_8 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_13 + var_526_8
					end
				end

				arg_523_1.text_.text = var_526_11
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052128", "story_v_out_421052.awb") ~= 0 then
					local var_526_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052128", "story_v_out_421052.awb") / 1000

					if var_526_14 + var_526_8 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_14 + var_526_8
					end

					if var_526_10.prefab_name ~= "" and arg_523_1.actors_[var_526_10.prefab_name] ~= nil then
						local var_526_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_10.prefab_name].transform, "story_v_out_421052", "421052128", "story_v_out_421052.awb")

						arg_523_1:RecordAudio("421052128", var_526_15)
						arg_523_1:RecordAudio("421052128", var_526_15)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_421052", "421052128", "story_v_out_421052.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_421052", "421052128", "story_v_out_421052.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_16 = math.max(var_526_9, arg_523_1.talkMaxDuration)

			if var_526_8 <= arg_523_1.time_ and arg_523_1.time_ < var_526_8 + var_526_16 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_8) / var_526_16

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_8 + var_526_16 and arg_523_1.time_ < var_526_8 + var_526_16 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
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

		arg_523_1:InitPlayNodeList()
	end,
	Play421052129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 421052129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
			arg_527_1.auto_ = false
		end

		function arg_527_1.playNext_(arg_529_0)
			arg_527_1.onStoryFinished_()
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["10145ui_story"]) and arg_527_1.var_.characterEffect10145ui_story == nil then
				arg_527_1.var_.characterEffect10145ui_story = arg_527_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["10145ui_story"]) then
				if arg_527_1.var_.characterEffect10145ui_story and not isNil(arg_527_1.actors_["10145ui_story"]) then
					arg_527_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_527_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_0)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["10145ui_story"]) and arg_527_1.var_.characterEffect10145ui_story then
				arg_527_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_527_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_530_1 = 0
			local var_530_2 = 0.4

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(421052129).content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 16 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 16)

				if (16 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 16)) > 0 and var_530_2 < var_530_5 then
					arg_527_1.talkMaxDuration = var_530_5

					if var_530_5 + var_530_1 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + var_530_1
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_6 = math.max(var_530_2, arg_527_1.talkMaxDuration)

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_6 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_1) / var_530_6

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_1 + var_530_6 and arg_527_1.time_ < var_530_1 + var_530_6 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a",
		"TextureConfig/Background/B07b",
		"TextureConfig/Background/B08b",
		"TextureConfig/Background/ST2401"
	},
	voices = {
		"story_v_out_421052.awb"
	}
}
