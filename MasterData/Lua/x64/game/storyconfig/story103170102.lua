return {
	Play317012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K11f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_4_0.name = "K11f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K11f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K11f

				arg_1_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K11f" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if 1.75 < arg_1_1.time_ and arg_1_1.time_ <= 1.75 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_crake", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.75

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317012001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 30 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 30)

				if (30 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 30)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317012002
		arg_9_1.duration_ = 3.67

		local var_9_0 = {
			zh = 2.4,
			ja = 3.666
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
				arg_9_0:Play317012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1199ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1199ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1199ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1199ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1199ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1199ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_12_5 = arg_9_1.actors_["1199ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1199ui_story == nil then
				arg_9_1.var_.characterEffect1199ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1199ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1199ui_story then
				arg_9_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_12_8 = 0
			local var_12_9 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(317012002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 8 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 8)

				if (8 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 8)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012002", "story_v_out_317012.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012002", "story_v_out_317012.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_317012", "317012002", "story_v_out_317012.awb")

						arg_9_1:RecordAudio("317012002", var_12_15)
						arg_9_1:RecordAudio("317012002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317012", "317012002", "story_v_out_317012.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317012", "317012002", "story_v_out_317012.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play317012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1199ui_story"]) and arg_13_1.var_.characterEffect1199ui_story == nil then
				arg_13_1.var_.characterEffect1199ui_story = arg_13_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1199ui_story"]) then
				if arg_13_1.var_.characterEffect1199ui_story and not isNil(arg_13_1.actors_["1199ui_story"]) then
					arg_13_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1199ui_story"]) and arg_13_1.var_.characterEffect1199ui_story then
				arg_13_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1199ui_story.fillRatio = 0.5
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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(317012003).content)

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
	Play317012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317012004
		arg_17_1.duration_ = 11.63

		local var_17_0 = {
			zh = 9.633,
			ja = 11.633
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
				arg_17_0:Play317012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1199ui_story = arg_17_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).z)
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles = arg_17_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_17_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).z)
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles = arg_17_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_20_1 = arg_17_1.actors_["1199ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1199ui_story == nil then
				arg_17_1.var_.characterEffect1199ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1199ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1199ui_story then
				arg_17_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 1.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(317012004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 49 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 49)

				if (49 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 49)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012004", "story_v_out_317012.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_317012", "317012004", "story_v_out_317012.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_317012", "317012004", "story_v_out_317012.awb")

						arg_17_1:RecordAudio("317012004", var_20_11)
						arg_17_1:RecordAudio("317012004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317012", "317012004", "story_v_out_317012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317012", "317012004", "story_v_out_317012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play317012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317012005
		arg_21_1.duration_ = 3.67

		local var_21_0 = {
			zh = 1.999999999999,
			ja = 3.666
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
				arg_21_0:Play317012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1199ui_story = arg_21_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).z)
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles = arg_21_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_21_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).z)
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles = arg_21_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_24_1 = 0
			local var_24_2 = 0.1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(317012005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 4 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 4)

				if (4 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 4)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012005", "story_v_out_317012.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_317012", "317012005", "story_v_out_317012.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_317012", "317012005", "story_v_out_317012.awb")

						arg_21_1:RecordAudio("317012005", var_24_8)
						arg_21_1:RecordAudio("317012005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317012", "317012005", "story_v_out_317012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317012", "317012005", "story_v_out_317012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317012006
		arg_25_1.duration_ = 9

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_9000

			if arg_25_1.bgs_.K09g == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09g")
				var_28_0.name = "K09g"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.K09g = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.K09g

				arg_25_1.bgs_.K09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "K09g" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			local var_28_12 = arg_25_1.actors_["1199ui_story"].transform

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1.var_.moveOldPos1199ui_story = var_28_12.localPosition
			end

			local var_28_13 = 0.001

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_13 then
				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 2) / var_28_13)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			if arg_25_1.time_ >= 2 + var_28_13 and arg_25_1.time_ < 2 + var_28_13 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0, 100, 0)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= 4 + arg_28_0 then
				local var_28_14 = arg_25_1.var_.effectposui1

				if not arg_25_1.var_.effectposui1 then
					var_28_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), manager.ui.mainCamera.transform)
					var_28_14.name = "posui1"
					arg_25_1.var_.effectposui1 = var_28_14
				else
					var_28_14.transform:SetParent(var_28_9000)
				end

				var_28_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_28_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_16 = 4
			local var_28_17 = 1.425

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_18 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_18:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(317012006).content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 57 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 57)

				if (57 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 57)) > 0 and var_28_17 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21
					var_28_16 = var_28_16 + 0.3

					if var_28_21 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = var_28_16 + 0.3
			local var_28_23 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_22 + var_28_23 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_22) / var_28_23

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_22 + var_28_23 and arg_25_1.time_ < var_28_22 + var_28_23 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317012007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 317012007
		arg_31_1.duration_ = 10

		local var_31_0 = {
			zh = 9.366,
			ja = 10
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
				arg_31_0:Play317012008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.bgs_.K09h == nil then
				local var_34_0 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09h")
				var_34_0.name = "K09h"
				var_34_0.transform.parent = arg_31_1.stage_.transform
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_.K09h = var_34_0
			end

			if 2 < arg_31_1.time_ and arg_31_1.time_ <= 2 + arg_34_0 then
				local var_34_1 = arg_31_1.bgs_.K09h

				arg_31_1.bgs_.K09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_34_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_2 = var_34_1:GetComponent("SpriteRenderer")

				if var_34_2 and var_34_2.sprite then
					local var_34_3 = 2 * (var_34_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_34_1.transform.localScale = Vector3.New(var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "K09h" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_4 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_5 = 2

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_5 then
				local var_34_6 = Color.New(0, 0, 0)

				var_34_6.a = Mathf.Lerp(0, 1, (arg_31_1.time_ - var_34_4) / var_34_5)
				arg_31_1.mask_.color = var_34_6
			end

			if arg_31_1.time_ >= var_34_4 + var_34_5 and arg_31_1.time_ < var_34_4 + var_34_5 + arg_34_0 then
				local var_34_7 = Color.New(0, 0, 0)

				var_34_7.a = 1
				arg_31_1.mask_.color = var_34_7
			end

			local var_34_8 = 2

			if 2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_9 = 2

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_9 then
				local var_34_10 = Color.New(0, 0, 0)

				var_34_10.a = Mathf.Lerp(1, 0, (arg_31_1.time_ - var_34_8) / var_34_9)
				arg_31_1.mask_.color = var_34_10
			end

			if arg_31_1.time_ >= var_34_8 + var_34_9 and arg_31_1.time_ < var_34_8 + var_34_9 + arg_34_0 then
				local var_34_11 = Color.New(0, 0, 0)

				arg_31_1.mask_.enabled = false
				var_34_11.a = 0
				arg_31_1.mask_.color = var_34_11
			end

			if 2 < arg_31_1.time_ and arg_31_1.time_ <= 2 + arg_34_0 then
				if arg_31_1.var_.effectposui1 then
					Object.Destroy(arg_31_1.var_.effectposui1)

					arg_31_1.var_.effectposui1 = nil
				end
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_13 = 4
			local var_34_14 = 0.525

			if 4 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_15 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_15:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_16 = arg_31_1:GetWordFromCfg(317012007)
				local var_34_17 = arg_31_1:FormatText(var_34_16.content)

				arg_31_1.text_.text = var_34_17

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_19 = 21 <= 0 and var_34_14 or var_34_14 * (utf8.len(var_34_17) / 21)

				if (21 <= 0 and var_34_14 or var_34_14 * (utf8.len(var_34_17) / 21)) > 0 and var_34_14 < var_34_19 then
					arg_31_1.talkMaxDuration = var_34_19
					var_34_13 = var_34_13 + 0.3

					if var_34_19 + var_34_13 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_13
					end
				end

				arg_31_1.text_.text = var_34_17
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012007", "story_v_out_317012.awb") ~= 0 then
					local var_34_20 = manager.audio:GetVoiceLength("story_v_out_317012", "317012007", "story_v_out_317012.awb") / 1000

					if var_34_20 + var_34_13 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_13
					end

					if var_34_16.prefab_name ~= "" and arg_31_1.actors_[var_34_16.prefab_name] ~= nil then
						local var_34_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_16.prefab_name].transform, "story_v_out_317012", "317012007", "story_v_out_317012.awb")

						arg_31_1:RecordAudio("317012007", var_34_21)
						arg_31_1:RecordAudio("317012007", var_34_21)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_317012", "317012007", "story_v_out_317012.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_317012", "317012007", "story_v_out_317012.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_22 = var_34_13 + 0.3
			local var_34_23 = math.max(var_34_14, arg_31_1.talkMaxDuration)

			if var_34_13 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_22 + var_34_23 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_22) / var_34_23

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_22 + var_34_23 and arg_31_1.time_ < var_34_22 + var_34_23 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play317012008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317012008
		arg_37_1.duration_ = 4.3

		local var_37_0 = {
			zh = 1.366,
			ja = 4.3
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
				arg_37_0:Play317012009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(317012008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 5 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 5)

				if (5 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 5)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012008", "story_v_out_317012.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012008", "story_v_out_317012.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_317012", "317012008", "story_v_out_317012.awb")

						arg_37_1:RecordAudio("317012008", var_40_6)
						arg_37_1:RecordAudio("317012008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317012", "317012008", "story_v_out_317012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317012", "317012008", "story_v_out_317012.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317012009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317012009
		arg_41_1.duration_ = 2.6

		local var_41_0 = {
			zh = 2.6,
			ja = 2.5
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
				arg_41_0:Play317012010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(317012009)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 12 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 12)

				if (12 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 12)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012009", "story_v_out_317012.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012009", "story_v_out_317012.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_317012", "317012009", "story_v_out_317012.awb")

						arg_41_1:RecordAudio("317012009", var_44_6)
						arg_41_1:RecordAudio("317012009", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317012", "317012009", "story_v_out_317012.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317012", "317012009", "story_v_out_317012.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317012010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317012010
		arg_45_1.duration_ = 9.5

		local var_45_0 = {
			zh = 3.633,
			ja = 9.5
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
				arg_45_0:Play317012011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(317012010)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 15 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 15)

				if (15 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 15)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012010", "story_v_out_317012.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012010", "story_v_out_317012.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_317012", "317012010", "story_v_out_317012.awb")

						arg_45_1:RecordAudio("317012010", var_48_6)
						arg_45_1:RecordAudio("317012010", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317012", "317012010", "story_v_out_317012.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317012", "317012010", "story_v_out_317012.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play317012011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317012011
		arg_49_1.duration_ = 5.7

		local var_49_0 = {
			zh = 3.866,
			ja = 5.7
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
				arg_49_0:Play317012012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(317012011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 11 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 11)

				if (11 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 11)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012011", "story_v_out_317012.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012011", "story_v_out_317012.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_317012", "317012011", "story_v_out_317012.awb")

						arg_49_1:RecordAudio("317012011", var_52_6)
						arg_49_1:RecordAudio("317012011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317012", "317012011", "story_v_out_317012.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317012", "317012011", "story_v_out_317012.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play317012012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317012012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317012013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.125

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(317012012).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 45 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 45)

				if (45 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 45)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play317012013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317012013
		arg_57_1.duration_ = 4.33

		local var_57_0 = {
			zh = 2.1,
			ja = 4.333
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
				arg_57_0:Play317012014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(317012013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 7 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 7)

				if (7 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 7)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012013", "story_v_out_317012.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012013", "story_v_out_317012.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_317012", "317012013", "story_v_out_317012.awb")

						arg_57_1:RecordAudio("317012013", var_60_6)
						arg_57_1:RecordAudio("317012013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317012", "317012013", "story_v_out_317012.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317012", "317012013", "story_v_out_317012.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play317012014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317012014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317012015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.95

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(317012014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 38 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 38)

				if (38 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 38)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play317012015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317012015
		arg_65_1.duration_ = 7.7

		local var_65_0 = {
			zh = 4.1,
			ja = 7.7
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
				arg_65_0:Play317012016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(317012015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 14 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 14)

				if (14 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 14)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012015", "story_v_out_317012.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012015", "story_v_out_317012.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_317012", "317012015", "story_v_out_317012.awb")

						arg_65_1:RecordAudio("317012015", var_68_6)
						arg_65_1:RecordAudio("317012015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317012", "317012015", "story_v_out_317012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317012", "317012015", "story_v_out_317012.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play317012016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317012016
		arg_69_1.duration_ = 2.67

		local var_69_0 = {
			zh = 2.666,
			ja = 2.233
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
				arg_69_0:Play317012017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(317012016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 4 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 4)

				if (4 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 4)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012016", "story_v_out_317012.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012016", "story_v_out_317012.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_317012", "317012016", "story_v_out_317012.awb")

						arg_69_1:RecordAudio("317012016", var_72_6)
						arg_69_1:RecordAudio("317012016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317012", "317012016", "story_v_out_317012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317012", "317012016", "story_v_out_317012.awb")
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
	Play317012017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317012017
		arg_73_1.duration_ = 9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317012018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.bgs_.YA0101 == nil then
				local var_76_0 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0101")
				var_76_0.name = "YA0101"
				var_76_0.transform.parent = arg_73_1.stage_.transform
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_.YA0101 = var_76_0
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_1 = arg_73_1.bgs_.YA0101

				arg_73_1.bgs_.YA0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_2 = var_76_1:GetComponent("SpriteRenderer")

				if var_76_2 and var_76_2.sprite then
					local var_76_3 = 2 * (var_76_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_1.transform.localScale = Vector3.New(var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "YA0101" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_4 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_5 = 2

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_5 then
				local var_76_6 = Color.New(0, 0, 0)

				var_76_6.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_4) / var_76_5)
				arg_73_1.mask_.color = var_76_6
			end

			if arg_73_1.time_ >= var_76_4 + var_76_5 and arg_73_1.time_ < var_76_4 + var_76_5 + arg_76_0 then
				local var_76_7 = Color.New(0, 0, 0)

				var_76_7.a = 1
				arg_73_1.mask_.color = var_76_7
			end

			local var_76_8 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 then
				local var_76_10 = Color.New(0, 0, 0)

				var_76_10.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_8) / var_76_9)
				arg_73_1.mask_.color = var_76_10
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 then
				local var_76_11 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_11.a = 0
				arg_73_1.mask_.color = var_76_11
			end

			local var_76_12 = arg_73_1.bgs_.YA0101.transform

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				arg_73_1.var_.moveOldPosYA0101 = var_76_12.localPosition
			end

			local var_76_13 = 0.001

			if 2 <= arg_73_1.time_ and arg_73_1.time_ < 2 + var_76_13 then
				var_76_12.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPosYA0101, Vector3.New(0, 1, 10), (arg_73_1.time_ - 2) / var_76_13)
			end

			if arg_73_1.time_ >= 2 + var_76_13 and arg_73_1.time_ < 2 + var_76_13 + arg_76_0 then
				var_76_12.localPosition = Vector3.New(0, 1, 10)
			end

			local var_76_14 = arg_73_1.bgs_.YA0101.transform

			if 2.034 < arg_73_1.time_ and arg_73_1.time_ <= 2.034 + arg_76_0 then
				arg_73_1.var_.moveOldPosYA0101 = var_76_14.localPosition
			end

			local var_76_15 = 4

			if 2.034 <= arg_73_1.time_ and arg_73_1.time_ < 2.034 + var_76_15 then
				var_76_14.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPosYA0101, Vector3.New(0, 1, 9), (arg_73_1.time_ - 2.034) / var_76_15)
			end

			if arg_73_1.time_ >= 2.034 + var_76_15 and arg_73_1.time_ < 2.034 + var_76_15 + arg_76_0 then
				var_76_14.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_16 = 4
			local var_76_17 = 2

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_18 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_18:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(317012017).content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 80 <= 0 and var_76_17 or var_76_17 * (utf8.len(var_76_19) / 80)

				if (80 <= 0 and var_76_17 or var_76_17 * (utf8.len(var_76_19) / 80)) > 0 and var_76_17 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21
					var_76_16 = var_76_16 + 0.3

					if var_76_21 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = var_76_16 + 0.3
			local var_76_23 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_16 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_22 + var_76_23 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_22) / var_76_23

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_22 + var_76_23 and arg_73_1.time_ < var_76_22 + var_76_23 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317012018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 317012018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play317012019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.7

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(317012018).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 28 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 28)

				if (28 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 28)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play317012019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 317012019
		arg_83_1.duration_ = 11.27

		local var_83_0 = {
			zh = 7.2,
			ja = 11.266
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
				arg_83_0:Play317012020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.55

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(317012019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 22 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 22)

				if (22 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 22)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012019", "story_v_out_317012.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012019", "story_v_out_317012.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_317012", "317012019", "story_v_out_317012.awb")

						arg_83_1:RecordAudio("317012019", var_86_6)
						arg_83_1:RecordAudio("317012019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_317012", "317012019", "story_v_out_317012.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_317012", "317012019", "story_v_out_317012.awb")
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
	Play317012020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 317012020
		arg_87_1.duration_ = 17.77

		local var_87_0 = {
			zh = 12.133,
			ja = 17.766
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
				arg_87_0:Play317012021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(317012020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 44 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 44)

				if (44 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 44)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012020", "story_v_out_317012.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012020", "story_v_out_317012.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_317012", "317012020", "story_v_out_317012.awb")

						arg_87_1:RecordAudio("317012020", var_90_6)
						arg_87_1:RecordAudio("317012020", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_317012", "317012020", "story_v_out_317012.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_317012", "317012020", "story_v_out_317012.awb")
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
	Play317012021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 317012021
		arg_91_1.duration_ = 4.63

		local var_91_0 = {
			zh = 3.8,
			ja = 4.633
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
				arg_91_0:Play317012022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.4

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(317012021)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 16 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 16)

				if (16 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 16)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012021", "story_v_out_317012.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012021", "story_v_out_317012.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_317012", "317012021", "story_v_out_317012.awb")

						arg_91_1:RecordAudio("317012021", var_94_6)
						arg_91_1:RecordAudio("317012021", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_317012", "317012021", "story_v_out_317012.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_317012", "317012021", "story_v_out_317012.awb")
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
	Play317012022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 317012022
		arg_95_1.duration_ = 22.2

		local var_95_0 = {
			zh = 16.1,
			ja = 22.2
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
				arg_95_0:Play317012023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.4

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(317012022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 56 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 56)

				if (56 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 56)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012022", "story_v_out_317012.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012022", "story_v_out_317012.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_317012", "317012022", "story_v_out_317012.awb")

						arg_95_1:RecordAudio("317012022", var_98_6)
						arg_95_1:RecordAudio("317012022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317012", "317012022", "story_v_out_317012.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317012", "317012022", "story_v_out_317012.awb")
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
	Play317012023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317012023
		arg_99_1.duration_ = 5.13

		local var_99_0 = {
			zh = 1.666,
			ja = 5.133
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
				arg_99_0:Play317012024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(317012023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 6 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 6)

				if (6 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 6)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012023", "story_v_out_317012.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012023", "story_v_out_317012.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_317012", "317012023", "story_v_out_317012.awb")

						arg_99_1:RecordAudio("317012023", var_102_6)
						arg_99_1:RecordAudio("317012023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_317012", "317012023", "story_v_out_317012.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_317012", "317012023", "story_v_out_317012.awb")
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
	Play317012024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317012024
		arg_103_1.duration_ = 21.37

		local var_103_0 = {
			zh = 10.6,
			ja = 21.366
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
				arg_103_0:Play317012025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.025

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(317012024)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 40 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 40)

				if (40 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 40)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012024", "story_v_out_317012.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012024", "story_v_out_317012.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_317012", "317012024", "story_v_out_317012.awb")

						arg_103_1:RecordAudio("317012024", var_106_6)
						arg_103_1:RecordAudio("317012024", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317012", "317012024", "story_v_out_317012.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317012", "317012024", "story_v_out_317012.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play317012025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317012025
		arg_107_1.duration_ = 2.03

		local var_107_0 = {
			zh = 0.999999999999,
			ja = 2.033
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
				arg_107_0:Play317012026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.05

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:GetWordFromCfg(317012025)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 2 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 2)

				if (2 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 2)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012025", "story_v_out_317012.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012025", "story_v_out_317012.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_317012", "317012025", "story_v_out_317012.awb")

						arg_107_1:RecordAudio("317012025", var_110_6)
						arg_107_1:RecordAudio("317012025", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317012", "317012025", "story_v_out_317012.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317012", "317012025", "story_v_out_317012.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play317012026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 317012026
		arg_111_1.duration_ = 22.9

		local var_111_0 = {
			zh = 18.7,
			ja = 22.9
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
				arg_111_0:Play317012027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.375

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(317012026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 55 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 55)

				if (55 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 55)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012026", "story_v_out_317012.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012026", "story_v_out_317012.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_317012", "317012026", "story_v_out_317012.awb")

						arg_111_1:RecordAudio("317012026", var_114_6)
						arg_111_1:RecordAudio("317012026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_317012", "317012026", "story_v_out_317012.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_317012", "317012026", "story_v_out_317012.awb")
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
	Play317012027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317012027
		arg_115_1.duration_ = 21.33

		local var_115_0 = {
			zh = 17.666,
			ja = 21.333
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play317012028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.375

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(317012027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 55 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 55)

				if (55 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 55)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012027", "story_v_out_317012.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012027", "story_v_out_317012.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_317012", "317012027", "story_v_out_317012.awb")

						arg_115_1:RecordAudio("317012027", var_118_6)
						arg_115_1:RecordAudio("317012027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317012", "317012027", "story_v_out_317012.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317012", "317012027", "story_v_out_317012.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play317012028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317012028
		arg_119_1.duration_ = 22.67

		local var_119_0 = {
			zh = 15.4,
			ja = 22.666
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
				arg_119_0:Play317012029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 1.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(317012028)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 54 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 54)

				if (54 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 54)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012028", "story_v_out_317012.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012028", "story_v_out_317012.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_317012", "317012028", "story_v_out_317012.awb")

						arg_119_1:RecordAudio("317012028", var_122_6)
						arg_119_1:RecordAudio("317012028", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_317012", "317012028", "story_v_out_317012.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_317012", "317012028", "story_v_out_317012.awb")
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
	Play317012029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 317012029
		arg_123_1.duration_ = 9.1

		local var_123_0 = {
			zh = 4.633,
			ja = 9.1
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
				arg_123_0:Play317012030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.375

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(317012029)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 15 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 15)

				if (15 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 15)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012029", "story_v_out_317012.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012029", "story_v_out_317012.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_317012", "317012029", "story_v_out_317012.awb")

						arg_123_1:RecordAudio("317012029", var_126_6)
						arg_123_1:RecordAudio("317012029", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_317012", "317012029", "story_v_out_317012.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_317012", "317012029", "story_v_out_317012.awb")
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
	Play317012030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 317012030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play317012031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(317012030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 29)

				if (29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 29)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play317012031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317012031
		arg_131_1.duration_ = 4.97

		local var_131_0 = {
			zh = 3.566,
			ja = 4.966
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play317012032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.3

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(317012031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 12 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 12)

				if (12 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 12)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012031", "story_v_out_317012.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012031", "story_v_out_317012.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_317012", "317012031", "story_v_out_317012.awb")

						arg_131_1:RecordAudio("317012031", var_134_6)
						arg_131_1:RecordAudio("317012031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_317012", "317012031", "story_v_out_317012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_317012", "317012031", "story_v_out_317012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play317012032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 317012032
		arg_135_1.duration_ = 9.7

		local var_135_0 = {
			zh = 8.933,
			ja = 9.7
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
				arg_135_0:Play317012033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.75

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(317012032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 30 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 30)

				if (30 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 30)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012032", "story_v_out_317012.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012032", "story_v_out_317012.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_317012", "317012032", "story_v_out_317012.awb")

						arg_135_1:RecordAudio("317012032", var_138_6)
						arg_135_1:RecordAudio("317012032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_317012", "317012032", "story_v_out_317012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_317012", "317012032", "story_v_out_317012.awb")
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
	Play317012033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 317012033
		arg_139_1.duration_ = 5.7

		local var_139_0 = {
			zh = 4.3,
			ja = 5.7
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
				arg_139_0:Play317012034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.375

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(317012033)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 15 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 15)

				if (15 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 15)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012033", "story_v_out_317012.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012033", "story_v_out_317012.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_317012", "317012033", "story_v_out_317012.awb")

						arg_139_1:RecordAudio("317012033", var_142_6)
						arg_139_1:RecordAudio("317012033", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_317012", "317012033", "story_v_out_317012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_317012", "317012033", "story_v_out_317012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play317012034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 317012034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play317012035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.9

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(317012034).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 36 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 36)

				if (36 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 36)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play317012035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 317012035
		arg_147_1.duration_ = 7

		local var_147_0 = {
			zh = 2.5,
			ja = 7
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play317012036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.125

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(317012035)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 5 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 5)

				if (5 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 5)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012035", "story_v_out_317012.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012035", "story_v_out_317012.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_317012", "317012035", "story_v_out_317012.awb")

						arg_147_1:RecordAudio("317012035", var_150_6)
						arg_147_1:RecordAudio("317012035", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_317012", "317012035", "story_v_out_317012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_317012", "317012035", "story_v_out_317012.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play317012036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 317012036
		arg_151_1.duration_ = 3.8

		local var_151_0 = {
			zh = 2.466,
			ja = 3.8
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
				arg_151_0:Play317012037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.325

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(317012036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 12 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 12)

				if (12 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 12)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012036", "story_v_out_317012.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012036", "story_v_out_317012.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_317012", "317012036", "story_v_out_317012.awb")

						arg_151_1:RecordAudio("317012036", var_154_6)
						arg_151_1:RecordAudio("317012036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_317012", "317012036", "story_v_out_317012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_317012", "317012036", "story_v_out_317012.awb")
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
	Play317012037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 317012037
		arg_155_1.duration_ = 5.93

		local var_155_0 = {
			zh = 1.5,
			ja = 5.933
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
				arg_155_0:Play317012038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.175

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(317012037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 7 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 7)

				if (7 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 7)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012037", "story_v_out_317012.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012037", "story_v_out_317012.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_317012", "317012037", "story_v_out_317012.awb")

						arg_155_1:RecordAudio("317012037", var_158_6)
						arg_155_1:RecordAudio("317012037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_317012", "317012037", "story_v_out_317012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_317012", "317012037", "story_v_out_317012.awb")
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
	Play317012038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 317012038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play317012039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.175

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(317012038).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 47 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 47)

				if (47 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 47)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play317012039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317012039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play317012040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.375

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(317012039).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 15 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 15)

				if (15 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 15)) > 0 and var_166_0 < var_166_3 then
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
	Play317012040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317012040
		arg_167_1.duration_ = 13

		local var_167_0 = {
			zh = 5.7,
			ja = 13
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
				arg_167_0:Play317012041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(317012040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 18 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 18)

				if (18 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 18)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012040", "story_v_out_317012.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012040", "story_v_out_317012.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_317012", "317012040", "story_v_out_317012.awb")

						arg_167_1:RecordAudio("317012040", var_170_6)
						arg_167_1:RecordAudio("317012040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_317012", "317012040", "story_v_out_317012.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_317012", "317012040", "story_v_out_317012.awb")
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
	Play317012041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317012041
		arg_171_1.duration_ = 8.73

		local var_171_0 = {
			zh = 2.8,
			ja = 8.733
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
				arg_171_0:Play317012042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[526].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(317012041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 13 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 13)

				if (13 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 13)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012041", "story_v_out_317012.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012041", "story_v_out_317012.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_317012", "317012041", "story_v_out_317012.awb")

						arg_171_1:RecordAudio("317012041", var_174_6)
						arg_171_1:RecordAudio("317012041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_317012", "317012041", "story_v_out_317012.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_317012", "317012041", "story_v_out_317012.awb")
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
	Play317012042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317012042
		arg_175_1.duration_ = 10.1

		local var_175_0 = {
			zh = 6.166,
			ja = 10.1
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
				arg_175_0:Play317012043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.35

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(317012042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 14 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 14)

				if (14 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 14)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012042", "story_v_out_317012.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012042", "story_v_out_317012.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_317012", "317012042", "story_v_out_317012.awb")

						arg_175_1:RecordAudio("317012042", var_178_6)
						arg_175_1:RecordAudio("317012042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_317012", "317012042", "story_v_out_317012.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_317012", "317012042", "story_v_out_317012.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play317012043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317012043
		arg_179_1.duration_ = 7

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317012044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if arg_179_1.bgs_.STblack == nil then
				local var_182_0 = Object.Instantiate(arg_179_1.paintGo_)

				var_182_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_182_0.name = "STblack"
				var_182_0.transform.parent = arg_179_1.stage_.transform
				var_182_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.bgs_.STblack = var_182_0
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				local var_182_1 = arg_179_1.bgs_.STblack

				arg_179_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_182_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_2 = var_182_1:GetComponent("SpriteRenderer")

				if var_182_2 and var_182_2.sprite then
					local var_182_3 = 2 * (var_182_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_182_1.transform.localScale = Vector3.New(var_182_3 / var_182_2.sprite.bounds.size.y < var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x and var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x or var_182_3 / var_182_2.sprite.bounds.size.y, var_182_3 / var_182_2.sprite.bounds.size.y < var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x and var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x or var_182_3 / var_182_2.sprite.bounds.size.y, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "STblack" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_182_4 = 0

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_5 = 2

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_5 then
				local var_182_6 = Color.New(0, 0, 0)

				var_182_6.a = Mathf.Lerp(1, 0, (arg_179_1.time_ - var_182_4) / var_182_5)
				arg_179_1.mask_.color = var_182_6
			end

			if arg_179_1.time_ >= var_182_4 + var_182_5 and arg_179_1.time_ < var_182_4 + var_182_5 + arg_182_0 then
				local var_182_7 = Color.New(0, 0, 0)

				arg_179_1.mask_.enabled = false
				var_182_7.a = 0
				arg_179_1.mask_.color = var_182_7
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_8 = 2
			local var_182_9 = 0.9

			if 2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_10 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_10:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_11 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(317012043).content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 36 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 36)

				if (36 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 36)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13
					var_182_8 = var_182_8 + 0.3

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = var_182_8 + 0.3
			local var_182_15 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_14 + var_182_15 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_14) / var_182_15

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_14 + var_182_15 and arg_179_1.time_ < var_182_14 + var_182_15 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317012044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 317012044
		arg_185_1.duration_ = 4.83

		local var_185_0 = {
			zh = 3.233,
			ja = 4.833
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
				arg_185_0:Play317012045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if arg_185_1.bgs_.K02f == nil then
				local var_188_0 = Object.Instantiate(arg_185_1.paintGo_)

				var_188_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K02f")
				var_188_0.name = "K02f"
				var_188_0.transform.parent = arg_185_1.stage_.transform
				var_188_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_.K02f = var_188_0
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				local var_188_1 = arg_185_1.bgs_.K02f

				arg_185_1.bgs_.K02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_2 = var_188_1:GetComponent("SpriteRenderer")

				if var_188_2 and var_188_2.sprite then
					local var_188_3 = 2 * (var_188_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_1.transform.localScale = Vector3.New(var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "K02f" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_4 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_5 = 2

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_5 then
				local var_188_6 = Color.New(0, 0, 0)

				var_188_6.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_4) / var_188_5)
				arg_185_1.mask_.color = var_188_6
			end

			if arg_185_1.time_ >= var_188_4 + var_188_5 and arg_185_1.time_ < var_188_4 + var_188_5 + arg_188_0 then
				local var_188_7 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_7.a = 0
				arg_185_1.mask_.color = var_188_7
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_8 = 2
			local var_188_9 = 0.125

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_10 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_10:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_11 = arg_185_1:GetWordFromCfg(317012044)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_14 = 5 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_12) / 5)

				if (5 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_12) / 5)) > 0 and var_188_9 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14
					var_188_8 = var_188_8 + 0.3

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012044", "story_v_out_317012.awb") ~= 0 then
					local var_188_15 = manager.audio:GetVoiceLength("story_v_out_317012", "317012044", "story_v_out_317012.awb") / 1000

					if var_188_15 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_8
					end

					if var_188_11.prefab_name ~= "" and arg_185_1.actors_[var_188_11.prefab_name] ~= nil then
						local var_188_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_11.prefab_name].transform, "story_v_out_317012", "317012044", "story_v_out_317012.awb")

						arg_185_1:RecordAudio("317012044", var_188_16)
						arg_185_1:RecordAudio("317012044", var_188_16)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_317012", "317012044", "story_v_out_317012.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_317012", "317012044", "story_v_out_317012.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_17 = var_188_8 + 0.3
			local var_188_18 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_17 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_17) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_17 + var_188_18 and arg_185_1.time_ < var_188_17 + var_188_18 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play317012045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317012045
		arg_191_1.duration_ = 7.7

		local var_191_0 = {
			zh = 7.7,
			ja = 7.433
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
				arg_191_0:Play317012046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.875

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:GetWordFromCfg(317012045)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 35 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 35)

				if (35 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 35)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012045", "story_v_out_317012.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012045", "story_v_out_317012.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_317012", "317012045", "story_v_out_317012.awb")

						arg_191_1:RecordAudio("317012045", var_194_6)
						arg_191_1:RecordAudio("317012045", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_317012", "317012045", "story_v_out_317012.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_317012", "317012045", "story_v_out_317012.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play317012046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317012046
		arg_195_1.duration_ = 11

		local var_195_0 = {
			zh = 10.966,
			ja = 11
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
				arg_195_0:Play317012047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(317012046)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 49 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 49)

				if (49 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 49)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012046", "story_v_out_317012.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012046", "story_v_out_317012.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_317012", "317012046", "story_v_out_317012.awb")

						arg_195_1:RecordAudio("317012046", var_198_6)
						arg_195_1:RecordAudio("317012046", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_317012", "317012046", "story_v_out_317012.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_317012", "317012046", "story_v_out_317012.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317012047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317012047
		arg_199_1.duration_ = 2.97

		local var_199_0 = {
			zh = 2.966,
			ja = 2.5
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
				arg_199_0:Play317012048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.2

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(317012047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 8 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 8)

				if (8 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 8)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012047", "story_v_out_317012.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012047", "story_v_out_317012.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_317012", "317012047", "story_v_out_317012.awb")

						arg_199_1:RecordAudio("317012047", var_202_6)
						arg_199_1:RecordAudio("317012047", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317012", "317012047", "story_v_out_317012.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317012", "317012047", "story_v_out_317012.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play317012048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317012048
		arg_203_1.duration_ = 2.97

		local var_203_0 = {
			zh = 2.366,
			ja = 2.966
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
				arg_203_0:Play317012049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.15

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(317012048)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 6 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 6)

				if (6 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 6)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012048", "story_v_out_317012.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012048", "story_v_out_317012.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_317012", "317012048", "story_v_out_317012.awb")

						arg_203_1:RecordAudio("317012048", var_206_6)
						arg_203_1:RecordAudio("317012048", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_317012", "317012048", "story_v_out_317012.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_317012", "317012048", "story_v_out_317012.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play317012049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317012049
		arg_207_1.duration_ = 7.2

		local var_207_0 = {
			zh = 4.1,
			ja = 7.2
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
				arg_207_0:Play317012050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.425

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(317012049)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 17 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 17)

				if (17 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 17)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012049", "story_v_out_317012.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012049", "story_v_out_317012.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_317012", "317012049", "story_v_out_317012.awb")

						arg_207_1:RecordAudio("317012049", var_210_6)
						arg_207_1:RecordAudio("317012049", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_317012", "317012049", "story_v_out_317012.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_317012", "317012049", "story_v_out_317012.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play317012050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317012050
		arg_211_1.duration_ = 2.9

		local var_211_0 = {
			zh = 1.533,
			ja = 2.9
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play317012051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.175

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:GetWordFromCfg(317012050)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 7 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 7)

				if (7 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 7)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012050", "story_v_out_317012.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012050", "story_v_out_317012.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_317012", "317012050", "story_v_out_317012.awb")

						arg_211_1:RecordAudio("317012050", var_214_6)
						arg_211_1:RecordAudio("317012050", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_317012", "317012050", "story_v_out_317012.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_317012", "317012050", "story_v_out_317012.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play317012051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317012051
		arg_215_1.duration_ = 13.97

		local var_215_0 = {
			zh = 10.233,
			ja = 13.966
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
				arg_215_0:Play317012052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.075

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(317012051)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 43 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 43)

				if (43 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 43)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012051", "story_v_out_317012.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012051", "story_v_out_317012.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_317012", "317012051", "story_v_out_317012.awb")

						arg_215_1:RecordAudio("317012051", var_218_6)
						arg_215_1:RecordAudio("317012051", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317012", "317012051", "story_v_out_317012.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317012", "317012051", "story_v_out_317012.awb")
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
	Play317012052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317012052
		arg_219_1.duration_ = 4.97

		local var_219_0 = {
			zh = 4.633,
			ja = 4.966
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
				arg_219_0:Play317012053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.45

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:GetWordFromCfg(317012052)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 18 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 18)

				if (18 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 18)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012052", "story_v_out_317012.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012052", "story_v_out_317012.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_317012", "317012052", "story_v_out_317012.awb")

						arg_219_1:RecordAudio("317012052", var_222_6)
						arg_219_1:RecordAudio("317012052", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_317012", "317012052", "story_v_out_317012.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_317012", "317012052", "story_v_out_317012.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play317012053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317012053
		arg_223_1.duration_ = 6.93

		local var_223_0 = {
			zh = 5.366,
			ja = 6.933
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
				arg_223_0:Play317012054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.725

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[527].name)

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

				local var_226_1 = arg_223_1:GetWordFromCfg(317012053)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 29 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 29)

				if (29 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 29)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012053", "story_v_out_317012.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012053", "story_v_out_317012.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_317012", "317012053", "story_v_out_317012.awb")

						arg_223_1:RecordAudio("317012053", var_226_6)
						arg_223_1:RecordAudio("317012053", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_317012", "317012053", "story_v_out_317012.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_317012", "317012053", "story_v_out_317012.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play317012054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317012054
		arg_227_1.duration_ = 4.5

		local var_227_0 = {
			zh = 4.5,
			ja = 3.6
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
				arg_227_0:Play317012055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.35

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(317012054)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 14 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 14)

				if (14 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 14)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012054", "story_v_out_317012.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012054", "story_v_out_317012.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_317012", "317012054", "story_v_out_317012.awb")

						arg_227_1:RecordAudio("317012054", var_230_6)
						arg_227_1:RecordAudio("317012054", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_317012", "317012054", "story_v_out_317012.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_317012", "317012054", "story_v_out_317012.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play317012055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317012055
		arg_231_1.duration_ = 5.1

		local var_231_0 = {
			zh = 5.1,
			ja = 4.633
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
				arg_231_0:Play317012056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.275

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(317012055)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 11 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 11)

				if (11 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 11)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012055", "story_v_out_317012.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012055", "story_v_out_317012.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_317012", "317012055", "story_v_out_317012.awb")

						arg_231_1:RecordAudio("317012055", var_234_6)
						arg_231_1:RecordAudio("317012055", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_317012", "317012055", "story_v_out_317012.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_317012", "317012055", "story_v_out_317012.awb")
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
	Play317012056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317012056
		arg_235_1.duration_ = 7

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317012057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if arg_235_1.bgs_.STwhite == nil then
				local var_238_0 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_238_0.name = "STwhite"
				var_238_0.transform.parent = arg_235_1.stage_.transform
				var_238_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_.STwhite = var_238_0
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				local var_238_1 = arg_235_1.bgs_.STwhite

				arg_235_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_2 = var_238_1:GetComponent("SpriteRenderer")

				if var_238_2 and var_238_2.sprite then
					local var_238_3 = 2 * (var_238_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_1.transform.localScale = Vector3.New(var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "STwhite" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_4 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_5 = 2

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_5 then
				local var_238_6 = Color.New(0, 0, 0)

				var_238_6.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_4) / var_238_5)
				arg_235_1.mask_.color = var_238_6
			end

			if arg_235_1.time_ >= var_238_4 + var_238_5 and arg_235_1.time_ < var_238_4 + var_238_5 + arg_238_0 then
				local var_238_7 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_7.a = 0
				arg_235_1.mask_.color = var_238_7
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_238_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_10 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_10

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_10
						arg_235_1.bgmTxt2_.text = var_238_10
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_11 = 2
			local var_238_12 = 1.2

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_13 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_13:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_235_1.dialogCg_.alpha = arg_240_0
				end))
				var_238_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_14 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(317012056).content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_16 = 48 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_14) / 48)

				if (48 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_14) / 48)) > 0 and var_238_12 < var_238_16 then
					arg_235_1.talkMaxDuration = var_238_16
					var_238_11 = var_238_11 + 0.3

					if var_238_16 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_17 = var_238_11 + 0.3
			local var_238_18 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_17 + var_238_18 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_17) / var_238_18

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_17 + var_238_18 and arg_235_1.time_ < var_238_17 + var_238_18 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play317012057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 317012057
		arg_242_1.duration_ = 7

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play317012058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.bgs_.K06f == nil then
				local var_245_0 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06f")
				var_245_0.name = "K06f"
				var_245_0.transform.parent = arg_242_1.stage_.transform
				var_245_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_.K06f = var_245_0
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				local var_245_1 = arg_242_1.bgs_.K06f

				arg_242_1.bgs_.K06f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_2 = var_245_1:GetComponent("SpriteRenderer")

				if var_245_2 and var_245_2.sprite then
					local var_245_3 = 2 * (var_245_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_1.transform.localScale = Vector3.New(var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "K06f" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_4 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_5 = 2

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_5 then
				local var_245_6 = Color.New(0, 0, 0)

				var_245_6.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_4) / var_245_5)
				arg_242_1.mask_.color = var_245_6
			end

			if arg_242_1.time_ >= var_245_4 + var_245_5 and arg_242_1.time_ < var_245_4 + var_245_5 + arg_245_0 then
				local var_245_7 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_7.a = 0
				arg_242_1.mask_.color = var_245_7
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_245_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_10 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_10

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_10
						arg_242_1.bgmTxt2_.text = var_245_10
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.56666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 1.56666666666667 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_245_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_13 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_13

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_13
						arg_242_1.bgmTxt2_.text = var_245_13
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_14 = 2
			local var_245_15 = 1.425

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_16 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_16:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_242_1.dialogCg_.alpha = arg_248_0
				end))
				var_245_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_17 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(317012057).content)

				arg_242_1.text_.text = var_245_17

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_19 = 57 <= 0 and var_245_15 or var_245_15 * (utf8.len(var_245_17) / 57)

				if (57 <= 0 and var_245_15 or var_245_15 * (utf8.len(var_245_17) / 57)) > 0 and var_245_15 < var_245_19 then
					arg_242_1.talkMaxDuration = var_245_19
					var_245_14 = var_245_14 + 0.3

					if var_245_19 + var_245_14 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_19 + var_245_14
					end
				end

				arg_242_1.text_.text = var_245_17
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_20 = var_245_14 + 0.3
			local var_245_21 = math.max(var_245_15, arg_242_1.talkMaxDuration)

			if var_245_14 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_20 + var_245_21 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_20) / var_245_21

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_20 + var_245_21 and arg_242_1.time_ < var_245_20 + var_245_21 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play317012058 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 317012058
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play317012059(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 1.725

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(317012058).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 69 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 69)

				if (69 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 69)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play317012059 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 317012059
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play317012060(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.7

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(317012059).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 28 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 28)

				if (28 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 28)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play317012060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 317012060
		arg_258_1.duration_ = 4

		local var_258_0 = {
			zh = 3.8,
			ja = 4
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play317012061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.45

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[101].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:GetWordFromCfg(317012060)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 18 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 18)

				if (18 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 18)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012060", "story_v_out_317012.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012060", "story_v_out_317012.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_317012", "317012060", "story_v_out_317012.awb")

						arg_258_1:RecordAudio("317012060", var_261_6)
						arg_258_1:RecordAudio("317012060", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_317012", "317012060", "story_v_out_317012.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_317012", "317012060", "story_v_out_317012.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play317012061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 317012061
		arg_262_1.duration_ = 5.6

		local var_262_0 = {
			zh = 4.666,
			ja = 5.6
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play317012062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.525

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:GetWordFromCfg(317012061)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 21 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 21)

				if (21 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 21)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012061", "story_v_out_317012.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012061", "story_v_out_317012.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_out_317012", "317012061", "story_v_out_317012.awb")

						arg_262_1:RecordAudio("317012061", var_265_6)
						arg_262_1:RecordAudio("317012061", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_317012", "317012061", "story_v_out_317012.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_317012", "317012061", "story_v_out_317012.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play317012062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 317012062
		arg_266_1.duration_ = 8.63

		local var_266_0 = {
			zh = 5.8,
			ja = 8.633
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play317012063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.4

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[101].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:GetWordFromCfg(317012062)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 16 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 16)

				if (16 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 16)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012062", "story_v_out_317012.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012062", "story_v_out_317012.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_317012", "317012062", "story_v_out_317012.awb")

						arg_266_1:RecordAudio("317012062", var_269_6)
						arg_266_1:RecordAudio("317012062", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_317012", "317012062", "story_v_out_317012.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_317012", "317012062", "story_v_out_317012.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play317012063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 317012063
		arg_270_1.duration_ = 9.8

		local var_270_0 = {
			zh = 5.3,
			ja = 9.8
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play317012064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.525

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:GetWordFromCfg(317012063)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 21 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 21)

				if (21 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 21)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012063", "story_v_out_317012.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012063", "story_v_out_317012.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_317012", "317012063", "story_v_out_317012.awb")

						arg_270_1:RecordAudio("317012063", var_273_6)
						arg_270_1:RecordAudio("317012063", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_317012", "317012063", "story_v_out_317012.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_317012", "317012063", "story_v_out_317012.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play317012064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 317012064
		arg_274_1.duration_ = 14.03

		local var_274_0 = {
			zh = 5.1,
			ja = 14.033
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play317012065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.575

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[101].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:GetWordFromCfg(317012064)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 23 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 23)

				if (23 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 23)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012064", "story_v_out_317012.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012064", "story_v_out_317012.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_out_317012", "317012064", "story_v_out_317012.awb")

						arg_274_1:RecordAudio("317012064", var_277_6)
						arg_274_1:RecordAudio("317012064", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_317012", "317012064", "story_v_out_317012.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_317012", "317012064", "story_v_out_317012.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play317012065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 317012065
		arg_278_1.duration_ = 4.23

		local var_278_0 = {
			zh = 2.533,
			ja = 4.233
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play317012066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.225

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:GetWordFromCfg(317012065)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 9 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 9)

				if (9 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 9)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012065", "story_v_out_317012.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012065", "story_v_out_317012.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_317012", "317012065", "story_v_out_317012.awb")

						arg_278_1:RecordAudio("317012065", var_281_6)
						arg_278_1:RecordAudio("317012065", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_317012", "317012065", "story_v_out_317012.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_317012", "317012065", "story_v_out_317012.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play317012066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 317012066
		arg_282_1.duration_ = 17

		local var_282_0 = {
			zh = 17,
			ja = 14.066
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play317012067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 1.675

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[101].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_1 = arg_282_1:GetWordFromCfg(317012066)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.text_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 68 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 68)

				if (68 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 68)) > 0 and var_285_0 < var_285_4 then
					arg_282_1.talkMaxDuration = var_285_4

					if var_285_4 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_4 + 0
					end
				end

				arg_282_1.text_.text = var_285_2
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012066", "story_v_out_317012.awb") ~= 0 then
					local var_285_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012066", "story_v_out_317012.awb") / 1000

					if var_285_5 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + 0
					end

					if var_285_1.prefab_name ~= "" and arg_282_1.actors_[var_285_1.prefab_name] ~= nil then
						local var_285_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_1.prefab_name].transform, "story_v_out_317012", "317012066", "story_v_out_317012.awb")

						arg_282_1:RecordAudio("317012066", var_285_6)
						arg_282_1:RecordAudio("317012066", var_285_6)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_317012", "317012066", "story_v_out_317012.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_317012", "317012066", "story_v_out_317012.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play317012067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 317012067
		arg_286_1.duration_ = 5.6

		local var_286_0 = {
			zh = 3.666,
			ja = 5.6
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play317012068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.425

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:GetWordFromCfg(317012067)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 17 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 17)

				if (17 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 17)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012067", "story_v_out_317012.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012067", "story_v_out_317012.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_out_317012", "317012067", "story_v_out_317012.awb")

						arg_286_1:RecordAudio("317012067", var_289_6)
						arg_286_1:RecordAudio("317012067", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_317012", "317012067", "story_v_out_317012.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_317012", "317012067", "story_v_out_317012.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play317012068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 317012068
		arg_290_1.duration_ = 8.7

		local var_290_0 = {
			zh = 8.7,
			ja = 7.733
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play317012069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.975

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[101].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:GetWordFromCfg(317012068)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 39 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 39)

				if (39 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 39)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012068", "story_v_out_317012.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012068", "story_v_out_317012.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_317012", "317012068", "story_v_out_317012.awb")

						arg_290_1:RecordAudio("317012068", var_293_6)
						arg_290_1:RecordAudio("317012068", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_317012", "317012068", "story_v_out_317012.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_317012", "317012068", "story_v_out_317012.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play317012069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 317012069
		arg_294_1.duration_ = 7.8

		local var_294_0 = {
			zh = 1.8,
			ja = 7.8
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play317012070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.175

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:GetWordFromCfg(317012069)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 7 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 7)

				if (7 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 7)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012069", "story_v_out_317012.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_317012", "317012069", "story_v_out_317012.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_317012", "317012069", "story_v_out_317012.awb")

						arg_294_1:RecordAudio("317012069", var_297_6)
						arg_294_1:RecordAudio("317012069", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_317012", "317012069", "story_v_out_317012.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_317012", "317012069", "story_v_out_317012.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play317012070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 317012070
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play317012071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 1.7

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(317012070).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 68 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 68)

				if (68 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 68)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play317012071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 317012071
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play317012072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.8

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(317012071).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 32 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 32)

				if (32 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 32)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play317012072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 317012072
		arg_306_1.duration_ = 7.03

		local var_306_0 = {
			zh = 6.466,
			ja = 7.033
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play317012073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if arg_306_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_309_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_306_1.stage_.transform)

				var_309_0.name = "2078ui_story"
				var_309_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.actors_["2078ui_story"] = var_309_0

				local var_309_1 = var_309_0:GetComponentInChildren(typeof(CharacterEffect))

				var_309_1.enabled = true

				local var_309_2 = GameObjectTools.GetOrAddComponent(var_309_0, typeof(DynamicBoneHelper))

				if var_309_2 then
					var_309_2:EnableDynamicBone(false)
				end

				arg_306_1:ShowWeapon(var_309_1.transform, false)

				arg_306_1.var_["2078ui_story" .. "Animator"] = var_309_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_306_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_306_1.var_["2078ui_story" .. "LipSync"] = var_309_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_309_3 = arg_306_1.actors_["2078ui_story"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos2078ui_story = var_309_3.localPosition
			end

			local var_309_4 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				var_309_3.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_306_1.time_ - 0) / var_309_4)
				var_309_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_3.position).x, (manager.ui.mainCamera.transform.position - var_309_3.position).y, (manager.ui.mainCamera.transform.position - var_309_3.position).z)
				var_309_3.localEulerAngles.z = 0
				var_309_3.localEulerAngles.x = 0
				var_309_3.localEulerAngles = var_309_3.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				var_309_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_309_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_3.position).x, (manager.ui.mainCamera.transform.position - var_309_3.position).y, (manager.ui.mainCamera.transform.position - var_309_3.position).z)
				var_309_3.localEulerAngles.z = 0
				var_309_3.localEulerAngles.x = 0
				var_309_3.localEulerAngles = var_309_3.localEulerAngles
			end

			local var_309_5 = arg_306_1.actors_["2078ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect2078ui_story == nil then
				arg_306_1.var_.characterEffect2078ui_story = var_309_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_6 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_6 and not isNil(var_309_5) then
				if arg_306_1.var_.characterEffect2078ui_story and not isNil(var_309_5) then
					arg_306_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_6 and arg_306_1.time_ < 0 + var_309_6 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect2078ui_story then
				arg_306_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_309_8 = "1015ui_story"

			if arg_306_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_309_9 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_306_1.stage_.transform)

				var_309_9.name = var_309_8
				var_309_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.actors_[var_309_8] = var_309_9

				local var_309_10 = var_309_9:GetComponentInChildren(typeof(CharacterEffect))

				var_309_10.enabled = true

				local var_309_11 = GameObjectTools.GetOrAddComponent(var_309_9, typeof(DynamicBoneHelper))

				if var_309_11 then
					var_309_11:EnableDynamicBone(false)
				end

				arg_306_1:ShowWeapon(var_309_10.transform, false)

				arg_306_1.var_[var_309_8 .. "Animator"] = var_309_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_306_1.var_[var_309_8 .. "Animator"].applyRootMotion = true
				arg_306_1.var_[var_309_8 .. "LipSync"] = var_309_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_309_12 = arg_306_1.actors_["1015ui_story"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1015ui_story = var_309_12.localPosition
			end

			local var_309_13 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_13 then
				var_309_12.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_306_1.time_ - 0) / var_309_13)
				var_309_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_12.position).x, (manager.ui.mainCamera.transform.position - var_309_12.position).y, (manager.ui.mainCamera.transform.position - var_309_12.position).z)
				var_309_12.localEulerAngles.z = 0
				var_309_12.localEulerAngles.x = 0
				var_309_12.localEulerAngles = var_309_12.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_13 and arg_306_1.time_ < 0 + var_309_13 + arg_309_0 then
				var_309_12.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_309_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_12.position).x, (manager.ui.mainCamera.transform.position - var_309_12.position).y, (manager.ui.mainCamera.transform.position - var_309_12.position).z)
				var_309_12.localEulerAngles.z = 0
				var_309_12.localEulerAngles.x = 0
				var_309_12.localEulerAngles = var_309_12.localEulerAngles
			end

			local var_309_14 = arg_306_1.actors_["1015ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_14) and arg_306_1.var_.characterEffect1015ui_story == nil then
				arg_306_1.var_.characterEffect1015ui_story = var_309_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_15 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_15 and not isNil(var_309_14) then
				if arg_306_1.var_.characterEffect1015ui_story and not isNil(var_309_14) then
					arg_306_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_15)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_15 and arg_306_1.time_ < 0 + var_309_15 + arg_309_0 and not isNil(var_309_14) and arg_306_1.var_.characterEffect1015ui_story then
				arg_306_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_309_16 = 0
			local var_309_17 = 0.85

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_18 = arg_306_1:GetWordFromCfg(317012072)
				local var_309_19 = arg_306_1:FormatText(var_309_18.content)

				arg_306_1.text_.text = var_309_19

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_21 = 34 <= 0 and var_309_17 or var_309_17 * (utf8.len(var_309_19) / 34)

				if (34 <= 0 and var_309_17 or var_309_17 * (utf8.len(var_309_19) / 34)) > 0 and var_309_17 < var_309_21 then
					arg_306_1.talkMaxDuration = var_309_21

					if var_309_21 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_21 + var_309_16
					end
				end

				arg_306_1.text_.text = var_309_19
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012072", "story_v_out_317012.awb") ~= 0 then
					local var_309_22 = manager.audio:GetVoiceLength("story_v_out_317012", "317012072", "story_v_out_317012.awb") / 1000

					if var_309_22 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_16
					end

					if var_309_18.prefab_name ~= "" and arg_306_1.actors_[var_309_18.prefab_name] ~= nil then
						local var_309_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_18.prefab_name].transform, "story_v_out_317012", "317012072", "story_v_out_317012.awb")

						arg_306_1:RecordAudio("317012072", var_309_23)
						arg_306_1:RecordAudio("317012072", var_309_23)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_317012", "317012072", "story_v_out_317012.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_317012", "317012072", "story_v_out_317012.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_24 = math.max(var_309_17, arg_306_1.talkMaxDuration)

			if var_309_16 <= arg_306_1.time_ and arg_306_1.time_ < var_309_16 + var_309_24 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_16) / var_309_24

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_16 + var_309_24 and arg_306_1.time_ < var_309_16 + var_309_24 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play317012073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 317012073
		arg_310_1.duration_ = 4.27

		local var_310_0 = {
			zh = 3.566,
			ja = 4.266
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play317012074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos2078ui_story = arg_310_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["2078ui_story"].transform.position).z)
				arg_310_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["2078ui_story"].transform.localEulerAngles = arg_310_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_310_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["2078ui_story"].transform.position).z)
				arg_310_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["2078ui_story"].transform.localEulerAngles = arg_310_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_313_1 = arg_310_1.actors_["2078ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect2078ui_story == nil then
				arg_310_1.var_.characterEffect2078ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_2 and not isNil(var_313_1) then
				if arg_310_1.var_.characterEffect2078ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_310_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_2)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_2 and arg_310_1.time_ < 0 + var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect2078ui_story then
				arg_310_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_310_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_313_3 = arg_310_1.actors_["1015ui_story"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1015ui_story = var_313_3.localPosition
			end

			local var_313_4 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				var_313_3.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_310_1.time_ - 0) / var_313_4)
				var_313_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_3.position).x, (manager.ui.mainCamera.transform.position - var_313_3.position).y, (manager.ui.mainCamera.transform.position - var_313_3.position).z)
				var_313_3.localEulerAngles.z = 0
				var_313_3.localEulerAngles.x = 0
				var_313_3.localEulerAngles = var_313_3.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				var_313_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_313_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_3.position).x, (manager.ui.mainCamera.transform.position - var_313_3.position).y, (manager.ui.mainCamera.transform.position - var_313_3.position).z)
				var_313_3.localEulerAngles.z = 0
				var_313_3.localEulerAngles.x = 0
				var_313_3.localEulerAngles = var_313_3.localEulerAngles
			end

			local var_313_5 = arg_310_1.actors_["1015ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_5) and arg_310_1.var_.characterEffect1015ui_story == nil then
				arg_310_1.var_.characterEffect1015ui_story = var_313_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_6 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_6 and not isNil(var_313_5) then
				if arg_310_1.var_.characterEffect1015ui_story and not isNil(var_313_5) then
					arg_310_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_6 and arg_310_1.time_ < 0 + var_313_6 + arg_313_0 and not isNil(var_313_5) and arg_310_1.var_.characterEffect1015ui_story then
				arg_310_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_313_8 = 0
			local var_313_9 = 0.425

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_10 = arg_310_1:GetWordFromCfg(317012073)
				local var_313_11 = arg_310_1:FormatText(var_313_10.content)

				arg_310_1.text_.text = var_313_11

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_13 = 17 <= 0 and var_313_9 or var_313_9 * (utf8.len(var_313_11) / 17)

				if (17 <= 0 and var_313_9 or var_313_9 * (utf8.len(var_313_11) / 17)) > 0 and var_313_9 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_8
					end
				end

				arg_310_1.text_.text = var_313_11
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012073", "story_v_out_317012.awb") ~= 0 then
					local var_313_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012073", "story_v_out_317012.awb") / 1000

					if var_313_14 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_14 + var_313_8
					end

					if var_313_10.prefab_name ~= "" and arg_310_1.actors_[var_313_10.prefab_name] ~= nil then
						local var_313_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_10.prefab_name].transform, "story_v_out_317012", "317012073", "story_v_out_317012.awb")

						arg_310_1:RecordAudio("317012073", var_313_15)
						arg_310_1:RecordAudio("317012073", var_313_15)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_317012", "317012073", "story_v_out_317012.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_317012", "317012073", "story_v_out_317012.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_9, arg_310_1.talkMaxDuration)

			if var_313_8 <= arg_310_1.time_ and arg_310_1.time_ < var_313_8 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_8) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_8 + var_313_16 and arg_310_1.time_ < var_313_8 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play317012074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 317012074
		arg_314_1.duration_ = 10.47

		local var_314_0 = {
			zh = 9.533,
			ja = 10.466
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play317012075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_317_0 = 0
			local var_317_1 = 1.15

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(317012074)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 46 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 46)

				if (46 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 46)) > 0 and var_317_1 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012074", "story_v_out_317012.awb") ~= 0 then
					local var_317_6 = manager.audio:GetVoiceLength("story_v_out_317012", "317012074", "story_v_out_317012.awb") / 1000

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end

					if var_317_2.prefab_name ~= "" and arg_314_1.actors_[var_317_2.prefab_name] ~= nil then
						local var_317_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_2.prefab_name].transform, "story_v_out_317012", "317012074", "story_v_out_317012.awb")

						arg_314_1:RecordAudio("317012074", var_317_7)
						arg_314_1:RecordAudio("317012074", var_317_7)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_317012", "317012074", "story_v_out_317012.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_317012", "317012074", "story_v_out_317012.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play317012075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 317012075
		arg_318_1.duration_ = 1

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play317012076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["2078ui_story"]) and arg_318_1.var_.characterEffect2078ui_story == nil then
				arg_318_1.var_.characterEffect2078ui_story = arg_318_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["2078ui_story"]) then
				if arg_318_1.var_.characterEffect2078ui_story and not isNil(arg_318_1.actors_["2078ui_story"]) then
					arg_318_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["2078ui_story"]) and arg_318_1.var_.characterEffect2078ui_story then
				arg_318_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_321_2 = arg_318_1.actors_["1015ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1015ui_story == nil then
				arg_318_1.var_.characterEffect1015ui_story = var_321_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_3 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.characterEffect1015ui_story and not isNil(var_321_2) then
					arg_318_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_3)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1015ui_story then
				arg_318_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_321_4 = 0
			local var_321_5 = 0.075

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_6 = arg_318_1:GetWordFromCfg(317012075)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 3 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 3)

				if (3 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 3)) > 0 and var_321_5 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012075", "story_v_out_317012.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_out_317012", "317012075", "story_v_out_317012.awb") / 1000

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end

					if var_321_6.prefab_name ~= "" and arg_318_1.actors_[var_321_6.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_6.prefab_name].transform, "story_v_out_317012", "317012075", "story_v_out_317012.awb")

						arg_318_1:RecordAudio("317012075", var_321_11)
						arg_318_1:RecordAudio("317012075", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_317012", "317012075", "story_v_out_317012.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_317012", "317012075", "story_v_out_317012.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_12 and arg_318_1.time_ < var_321_4 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play317012076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 317012076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play317012077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["2078ui_story"]) and arg_322_1.var_.characterEffect2078ui_story == nil then
				arg_322_1.var_.characterEffect2078ui_story = arg_322_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["2078ui_story"]) then
				if arg_322_1.var_.characterEffect2078ui_story and not isNil(arg_322_1.actors_["2078ui_story"]) then
					arg_322_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_322_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["2078ui_story"]) and arg_322_1.var_.characterEffect2078ui_story then
				arg_322_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_322_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_325_1 = 0
			local var_325_2 = 1.175

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(317012076).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 47 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 47)

				if (47 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 47)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play317012077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 317012077
		arg_326_1.duration_ = 12.33

		local var_326_0 = {
			zh = 12.333,
			ja = 9.4
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play317012078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos2078ui_story = arg_326_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["2078ui_story"].transform.position).z)
				arg_326_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["2078ui_story"].transform.localEulerAngles = arg_326_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_326_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["2078ui_story"].transform.position).z)
				arg_326_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["2078ui_story"].transform.localEulerAngles = arg_326_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["2078ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect2078ui_story == nil then
				arg_326_1.var_.characterEffect2078ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect2078ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_326_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_2)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect2078ui_story then
				arg_326_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_326_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_329_3 = arg_326_1.actors_["1015ui_story"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1015ui_story = var_329_3.localPosition
			end

			local var_329_4 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				var_329_3.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_326_1.time_ - 0) / var_329_4)
				var_329_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_3.position).x, (manager.ui.mainCamera.transform.position - var_329_3.position).y, (manager.ui.mainCamera.transform.position - var_329_3.position).z)
				var_329_3.localEulerAngles.z = 0
				var_329_3.localEulerAngles.x = 0
				var_329_3.localEulerAngles = var_329_3.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				var_329_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_329_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_3.position).x, (manager.ui.mainCamera.transform.position - var_329_3.position).y, (manager.ui.mainCamera.transform.position - var_329_3.position).z)
				var_329_3.localEulerAngles.z = 0
				var_329_3.localEulerAngles.x = 0
				var_329_3.localEulerAngles = var_329_3.localEulerAngles
			end

			local var_329_5 = arg_326_1.actors_["1015ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_5) and arg_326_1.var_.characterEffect1015ui_story == nil then
				arg_326_1.var_.characterEffect1015ui_story = var_329_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_6 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_6 and not isNil(var_329_5) then
				if arg_326_1.var_.characterEffect1015ui_story and not isNil(var_329_5) then
					arg_326_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_6 and arg_326_1.time_ < 0 + var_329_6 + arg_329_0 and not isNil(var_329_5) and arg_326_1.var_.characterEffect1015ui_story then
				arg_326_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_329_8 = 0
			local var_329_9 = 1.425

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_10 = arg_326_1:GetWordFromCfg(317012077)
				local var_329_11 = arg_326_1:FormatText(var_329_10.content)

				arg_326_1.text_.text = var_329_11

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_13 = 57 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_11) / 57)

				if (57 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_11) / 57)) > 0 and var_329_9 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_11
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012077", "story_v_out_317012.awb") ~= 0 then
					local var_329_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012077", "story_v_out_317012.awb") / 1000

					if var_329_14 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_8
					end

					if var_329_10.prefab_name ~= "" and arg_326_1.actors_[var_329_10.prefab_name] ~= nil then
						local var_329_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_10.prefab_name].transform, "story_v_out_317012", "317012077", "story_v_out_317012.awb")

						arg_326_1:RecordAudio("317012077", var_329_15)
						arg_326_1:RecordAudio("317012077", var_329_15)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_317012", "317012077", "story_v_out_317012.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_317012", "317012077", "story_v_out_317012.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_16 and arg_326_1.time_ < var_329_8 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play317012078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 317012078
		arg_330_1.duration_ = 6.37

		local var_330_0 = {
			zh = 3.8,
			ja = 6.366
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play317012079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1015ui_story = arg_330_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1015ui_story"].transform.position).z)
				arg_330_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1015ui_story"].transform.localEulerAngles = arg_330_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_330_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1015ui_story"].transform.position).z)
				arg_330_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1015ui_story"].transform.localEulerAngles = arg_330_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["1015ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1015ui_story == nil then
				arg_330_1.var_.characterEffect1015ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect1015ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_2)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1015ui_story then
				arg_330_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_333_3 = "2079ui_story"

			if arg_330_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_333_4 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_330_1.stage_.transform)

				var_333_4.name = var_333_3
				var_333_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_330_1.actors_[var_333_3] = var_333_4

				local var_333_5 = var_333_4:GetComponentInChildren(typeof(CharacterEffect))

				var_333_5.enabled = true

				local var_333_6 = GameObjectTools.GetOrAddComponent(var_333_4, typeof(DynamicBoneHelper))

				if var_333_6 then
					var_333_6:EnableDynamicBone(false)
				end

				arg_330_1:ShowWeapon(var_333_5.transform, false)

				arg_330_1.var_[var_333_3 .. "Animator"] = var_333_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_330_1.var_[var_333_3 .. "Animator"].applyRootMotion = true
				arg_330_1.var_[var_333_3 .. "LipSync"] = var_333_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_333_7 = arg_330_1.actors_["2079ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_7) and arg_330_1.var_.characterEffect2079ui_story == nil then
				arg_330_1.var_.characterEffect2079ui_story = var_333_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_8 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_8 and not isNil(var_333_7) then
				if arg_330_1.var_.characterEffect2079ui_story and not isNil(var_333_7) then
					arg_330_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_8 and arg_330_1.time_ < 0 + var_333_8 + arg_333_0 and not isNil(var_333_7) and arg_330_1.var_.characterEffect2079ui_story then
				arg_330_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_333_10 = arg_330_1.actors_["2078ui_story"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos2078ui_story = var_333_10.localPosition
			end

			local var_333_11 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_11 then
				var_333_10.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_330_1.time_ - 0) / var_333_11)
				var_333_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_10.position).x, (manager.ui.mainCamera.transform.position - var_333_10.position).y, (manager.ui.mainCamera.transform.position - var_333_10.position).z)
				var_333_10.localEulerAngles.z = 0
				var_333_10.localEulerAngles.x = 0
				var_333_10.localEulerAngles = var_333_10.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_11 and arg_330_1.time_ < 0 + var_333_11 + arg_333_0 then
				var_333_10.localPosition = Vector3.New(0, 100, 0)
				var_333_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_10.position).x, (manager.ui.mainCamera.transform.position - var_333_10.position).y, (manager.ui.mainCamera.transform.position - var_333_10.position).z)
				var_333_10.localEulerAngles.z = 0
				var_333_10.localEulerAngles.x = 0
				var_333_10.localEulerAngles = var_333_10.localEulerAngles
			end

			local var_333_12 = arg_330_1.actors_["2078ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_12) and arg_330_1.var_.characterEffect2078ui_story == nil then
				arg_330_1.var_.characterEffect2078ui_story = var_333_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_13 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_13 and not isNil(var_333_12) then
				if arg_330_1.var_.characterEffect2078ui_story and not isNil(var_333_12) then
					arg_330_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_330_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_13)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_13 and arg_330_1.time_ < 0 + var_333_13 + arg_333_0 and not isNil(var_333_12) and arg_330_1.var_.characterEffect2078ui_story then
				arg_330_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_330_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_333_14 = arg_330_1.actors_["2079ui_story"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos2079ui_story = var_333_14.localPosition
			end

			local var_333_15 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_15 then
				var_333_14.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_330_1.time_ - 0) / var_333_15)
				var_333_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_14.position).x, (manager.ui.mainCamera.transform.position - var_333_14.position).y, (manager.ui.mainCamera.transform.position - var_333_14.position).z)
				var_333_14.localEulerAngles.z = 0
				var_333_14.localEulerAngles.x = 0
				var_333_14.localEulerAngles = var_333_14.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_15 and arg_330_1.time_ < 0 + var_333_15 + arg_333_0 then
				var_333_14.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_333_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_14.position).x, (manager.ui.mainCamera.transform.position - var_333_14.position).y, (manager.ui.mainCamera.transform.position - var_333_14.position).z)
				var_333_14.localEulerAngles.z = 0
				var_333_14.localEulerAngles.x = 0
				var_333_14.localEulerAngles = var_333_14.localEulerAngles
			end

			local var_333_16 = 0
			local var_333_17 = 0.475

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_16 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(317012078)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_21 = 19 <= 0 and var_333_17 or var_333_17 * (utf8.len(var_333_19) / 19)

				if (19 <= 0 and var_333_17 or var_333_17 * (utf8.len(var_333_19) / 19)) > 0 and var_333_17 < var_333_21 then
					arg_330_1.talkMaxDuration = var_333_21

					if var_333_21 + var_333_16 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_21 + var_333_16
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012078", "story_v_out_317012.awb") ~= 0 then
					local var_333_22 = manager.audio:GetVoiceLength("story_v_out_317012", "317012078", "story_v_out_317012.awb") / 1000

					if var_333_22 + var_333_16 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_16
					end

					if var_333_18.prefab_name ~= "" and arg_330_1.actors_[var_333_18.prefab_name] ~= nil then
						local var_333_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_18.prefab_name].transform, "story_v_out_317012", "317012078", "story_v_out_317012.awb")

						arg_330_1:RecordAudio("317012078", var_333_23)
						arg_330_1:RecordAudio("317012078", var_333_23)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_317012", "317012078", "story_v_out_317012.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_317012", "317012078", "story_v_out_317012.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_24 = math.max(var_333_17, arg_330_1.talkMaxDuration)

			if var_333_16 <= arg_330_1.time_ and arg_330_1.time_ < var_333_16 + var_333_24 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_16) / var_333_24

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_16 + var_333_24 and arg_330_1.time_ < var_333_16 + var_333_24 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play317012079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 317012079
		arg_334_1.duration_ = 2.5

		local var_334_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play317012080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1015ui_story = arg_334_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1015ui_story"].transform.position).z)
				arg_334_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1015ui_story"].transform.localEulerAngles = arg_334_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_334_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1015ui_story"].transform.position).z)
				arg_334_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1015ui_story"].transform.localEulerAngles = arg_334_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["1015ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1015ui_story == nil then
				arg_334_1.var_.characterEffect1015ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect1015ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1015ui_story then
				arg_334_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_337_4 = arg_334_1.actors_["2079ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos2079ui_story = var_337_4.localPosition
			end

			local var_337_5 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_5 then
				var_337_4.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_334_1.time_ - 0) / var_337_5)
				var_337_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_4.position).x, (manager.ui.mainCamera.transform.position - var_337_4.position).y, (manager.ui.mainCamera.transform.position - var_337_4.position).z)
				var_337_4.localEulerAngles.z = 0
				var_337_4.localEulerAngles.x = 0
				var_337_4.localEulerAngles = var_337_4.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_5 and arg_334_1.time_ < 0 + var_337_5 + arg_337_0 then
				var_337_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_337_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_4.position).x, (manager.ui.mainCamera.transform.position - var_337_4.position).y, (manager.ui.mainCamera.transform.position - var_337_4.position).z)
				var_337_4.localEulerAngles.z = 0
				var_337_4.localEulerAngles.x = 0
				var_337_4.localEulerAngles = var_337_4.localEulerAngles
			end

			local var_337_6 = arg_334_1.actors_["2079ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_6) and arg_334_1.var_.characterEffect2079ui_story == nil then
				arg_334_1.var_.characterEffect2079ui_story = var_337_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_7 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 and not isNil(var_337_6) then
				if arg_334_1.var_.characterEffect2079ui_story and not isNil(var_337_6) then
					arg_334_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_334_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_7)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 and not isNil(var_337_6) and arg_334_1.var_.characterEffect2079ui_story then
				arg_334_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_334_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_337_8 = 0
			local var_337_9 = 0.1

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_10 = arg_334_1:GetWordFromCfg(317012079)
				local var_337_11 = arg_334_1:FormatText(var_337_10.content)

				arg_334_1.text_.text = var_337_11

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_13 = 4 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_11) / 4)

				if (4 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_11) / 4)) > 0 and var_337_9 < var_337_13 then
					arg_334_1.talkMaxDuration = var_337_13

					if var_337_13 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_11
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012079", "story_v_out_317012.awb") ~= 0 then
					local var_337_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012079", "story_v_out_317012.awb") / 1000

					if var_337_14 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_14 + var_337_8
					end

					if var_337_10.prefab_name ~= "" and arg_334_1.actors_[var_337_10.prefab_name] ~= nil then
						local var_337_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_10.prefab_name].transform, "story_v_out_317012", "317012079", "story_v_out_317012.awb")

						arg_334_1:RecordAudio("317012079", var_337_15)
						arg_334_1:RecordAudio("317012079", var_337_15)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_317012", "317012079", "story_v_out_317012.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_317012", "317012079", "story_v_out_317012.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_16 and arg_334_1.time_ < var_337_8 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play317012080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 317012080
		arg_338_1.duration_ = 9.87

		local var_338_0 = {
			zh = 6.733,
			ja = 9.866
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play317012081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos2078ui_story = arg_338_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_341_0 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 then
				arg_338_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_338_1.time_ - 0) / var_341_0)
				arg_338_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["2078ui_story"].transform.position).z)
				arg_338_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["2078ui_story"].transform.localEulerAngles = arg_338_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 then
				arg_338_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_338_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["2078ui_story"].transform.position).z)
				arg_338_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["2078ui_story"].transform.localEulerAngles = arg_338_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_341_1 = arg_338_1.actors_["2078ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect2078ui_story == nil then
				arg_338_1.var_.characterEffect2078ui_story = var_341_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 and not isNil(var_341_1) then
				if arg_338_1.var_.characterEffect2078ui_story and not isNil(var_341_1) then
					arg_338_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect2078ui_story then
				arg_338_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_341_4 = arg_338_1.actors_["1015ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1015ui_story = var_341_4.localPosition
			end

			local var_341_5 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_5 then
				var_341_4.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_338_1.time_ - 0) / var_341_5)
				var_341_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_4.position).x, (manager.ui.mainCamera.transform.position - var_341_4.position).y, (manager.ui.mainCamera.transform.position - var_341_4.position).z)
				var_341_4.localEulerAngles.z = 0
				var_341_4.localEulerAngles.x = 0
				var_341_4.localEulerAngles = var_341_4.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_5 and arg_338_1.time_ < 0 + var_341_5 + arg_341_0 then
				var_341_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_341_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_4.position).x, (manager.ui.mainCamera.transform.position - var_341_4.position).y, (manager.ui.mainCamera.transform.position - var_341_4.position).z)
				var_341_4.localEulerAngles.z = 0
				var_341_4.localEulerAngles.x = 0
				var_341_4.localEulerAngles = var_341_4.localEulerAngles
			end

			local var_341_6 = arg_338_1.actors_["1015ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_6) and arg_338_1.var_.characterEffect1015ui_story == nil then
				arg_338_1.var_.characterEffect1015ui_story = var_341_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_7 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 and not isNil(var_341_6) then
				if arg_338_1.var_.characterEffect1015ui_story and not isNil(var_341_6) then
					arg_338_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_7)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 and not isNil(var_341_6) and arg_338_1.var_.characterEffect1015ui_story then
				arg_338_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_341_8 = arg_338_1.actors_["2079ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos2079ui_story = var_341_8.localPosition
			end

			local var_341_9 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_9 then
				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 0) / var_341_9)
				var_341_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_8.position).x, (manager.ui.mainCamera.transform.position - var_341_8.position).y, (manager.ui.mainCamera.transform.position - var_341_8.position).z)
				var_341_8.localEulerAngles.z = 0
				var_341_8.localEulerAngles.x = 0
				var_341_8.localEulerAngles = var_341_8.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_9 and arg_338_1.time_ < 0 + var_341_9 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, 100, 0)
				var_341_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_8.position).x, (manager.ui.mainCamera.transform.position - var_341_8.position).y, (manager.ui.mainCamera.transform.position - var_341_8.position).z)
				var_341_8.localEulerAngles.z = 0
				var_341_8.localEulerAngles.x = 0
				var_341_8.localEulerAngles = var_341_8.localEulerAngles
			end

			local var_341_10 = arg_338_1.actors_["2079ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_10) and arg_338_1.var_.characterEffect2079ui_story == nil then
				arg_338_1.var_.characterEffect2079ui_story = var_341_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_11 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_11 and not isNil(var_341_10) then
				if arg_338_1.var_.characterEffect2079ui_story and not isNil(var_341_10) then
					arg_338_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_338_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_11)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_11 and arg_338_1.time_ < 0 + var_341_11 + arg_341_0 and not isNil(var_341_10) and arg_338_1.var_.characterEffect2079ui_story then
				arg_338_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_338_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_341_12 = 0
			local var_341_13 = 0.925

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_12 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_14 = arg_338_1:GetWordFromCfg(317012080)
				local var_341_15 = arg_338_1:FormatText(var_341_14.content)

				arg_338_1.text_.text = var_341_15

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_17 = 37 <= 0 and var_341_13 or var_341_13 * (utf8.len(var_341_15) / 37)

				if (37 <= 0 and var_341_13 or var_341_13 * (utf8.len(var_341_15) / 37)) > 0 and var_341_13 < var_341_17 then
					arg_338_1.talkMaxDuration = var_341_17

					if var_341_17 + var_341_12 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_17 + var_341_12
					end
				end

				arg_338_1.text_.text = var_341_15
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012080", "story_v_out_317012.awb") ~= 0 then
					local var_341_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012080", "story_v_out_317012.awb") / 1000

					if var_341_18 + var_341_12 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_18 + var_341_12
					end

					if var_341_14.prefab_name ~= "" and arg_338_1.actors_[var_341_14.prefab_name] ~= nil then
						local var_341_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_14.prefab_name].transform, "story_v_out_317012", "317012080", "story_v_out_317012.awb")

						arg_338_1:RecordAudio("317012080", var_341_19)
						arg_338_1:RecordAudio("317012080", var_341_19)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_317012", "317012080", "story_v_out_317012.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_317012", "317012080", "story_v_out_317012.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_20 = math.max(var_341_13, arg_338_1.talkMaxDuration)

			if var_341_12 <= arg_338_1.time_ and arg_338_1.time_ < var_341_12 + var_341_20 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_12) / var_341_20

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_12 + var_341_20 and arg_338_1.time_ < var_341_12 + var_341_20 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play317012081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 317012081
		arg_342_1.duration_ = 2.53

		local var_342_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play317012082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos2078ui_story = arg_342_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_345_0 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 then
				arg_342_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_342_1.time_ - 0) / var_345_0)
				arg_342_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["2078ui_story"].transform.position).z)
				arg_342_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["2078ui_story"].transform.localEulerAngles = arg_342_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 then
				arg_342_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_342_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["2078ui_story"].transform.position).z)
				arg_342_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["2078ui_story"].transform.localEulerAngles = arg_342_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_345_1 = arg_342_1.actors_["2078ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect2078ui_story == nil then
				arg_342_1.var_.characterEffect2078ui_story = var_345_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_2 and not isNil(var_345_1) then
				if arg_342_1.var_.characterEffect2078ui_story and not isNil(var_345_1) then
					arg_342_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_342_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_2)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_2 and arg_342_1.time_ < 0 + var_345_2 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect2078ui_story then
				arg_342_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_342_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_345_3 = arg_342_1.actors_["1015ui_story"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1015ui_story = var_345_3.localPosition
			end

			local var_345_4 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				var_345_3.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_342_1.time_ - 0) / var_345_4)
				var_345_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_3.position).x, (manager.ui.mainCamera.transform.position - var_345_3.position).y, (manager.ui.mainCamera.transform.position - var_345_3.position).z)
				var_345_3.localEulerAngles.z = 0
				var_345_3.localEulerAngles.x = 0
				var_345_3.localEulerAngles = var_345_3.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				var_345_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_345_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_3.position).x, (manager.ui.mainCamera.transform.position - var_345_3.position).y, (manager.ui.mainCamera.transform.position - var_345_3.position).z)
				var_345_3.localEulerAngles.z = 0
				var_345_3.localEulerAngles.x = 0
				var_345_3.localEulerAngles = var_345_3.localEulerAngles
			end

			local var_345_5 = arg_342_1.actors_["1015ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_5) and arg_342_1.var_.characterEffect1015ui_story == nil then
				arg_342_1.var_.characterEffect1015ui_story = var_345_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_6 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_6 and not isNil(var_345_5) then
				if arg_342_1.var_.characterEffect1015ui_story and not isNil(var_345_5) then
					arg_342_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_6 and arg_342_1.time_ < 0 + var_345_6 + arg_345_0 and not isNil(var_345_5) and arg_342_1.var_.characterEffect1015ui_story then
				arg_342_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_345_8 = 0
			local var_345_9 = 0.1

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_10 = arg_342_1:GetWordFromCfg(317012081)
				local var_345_11 = arg_342_1:FormatText(var_345_10.content)

				arg_342_1.text_.text = var_345_11

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 4 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 4)

				if (4 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 4)) > 0 and var_345_9 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_11
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012081", "story_v_out_317012.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012081", "story_v_out_317012.awb") / 1000

					if var_345_14 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_8
					end

					if var_345_10.prefab_name ~= "" and arg_342_1.actors_[var_345_10.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_10.prefab_name].transform, "story_v_out_317012", "317012081", "story_v_out_317012.awb")

						arg_342_1:RecordAudio("317012081", var_345_15)
						arg_342_1:RecordAudio("317012081", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_317012", "317012081", "story_v_out_317012.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_317012", "317012081", "story_v_out_317012.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_16 and arg_342_1.time_ < var_345_8 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play317012082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 317012082
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play317012083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1015ui_story"]) and arg_346_1.var_.characterEffect1015ui_story == nil then
				arg_346_1.var_.characterEffect1015ui_story = arg_346_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1015ui_story"]) then
				if arg_346_1.var_.characterEffect1015ui_story and not isNil(arg_346_1.actors_["1015ui_story"]) then
					arg_346_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1015ui_story"]) and arg_346_1.var_.characterEffect1015ui_story then
				arg_346_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_349_1 = 0
			local var_349_2 = 0.35

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(317012082).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 14 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 14)

				if (14 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 14)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play317012083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 317012083
		arg_350_1.duration_ = 3.13

		local var_350_0 = {
			zh = 3.133,
			ja = 2.9
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play317012084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos2078ui_story = arg_350_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2078ui_story"].transform.position).z)
				arg_350_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["2078ui_story"].transform.localEulerAngles = arg_350_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_350_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2078ui_story"].transform.position).z)
				arg_350_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["2078ui_story"].transform.localEulerAngles = arg_350_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_353_1 = arg_350_1.actors_["2078ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect2078ui_story == nil then
				arg_350_1.var_.characterEffect2078ui_story = var_353_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 and not isNil(var_353_1) then
				if arg_350_1.var_.characterEffect2078ui_story and not isNil(var_353_1) then
					arg_350_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_350_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_2)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect2078ui_story then
				arg_350_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_350_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_353_3 = arg_350_1.actors_["1015ui_story"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1015ui_story = var_353_3.localPosition
			end

			local var_353_4 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				var_353_3.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_350_1.time_ - 0) / var_353_4)
				var_353_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_3.position).x, (manager.ui.mainCamera.transform.position - var_353_3.position).y, (manager.ui.mainCamera.transform.position - var_353_3.position).z)
				var_353_3.localEulerAngles.z = 0
				var_353_3.localEulerAngles.x = 0
				var_353_3.localEulerAngles = var_353_3.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				var_353_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_353_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_3.position).x, (manager.ui.mainCamera.transform.position - var_353_3.position).y, (manager.ui.mainCamera.transform.position - var_353_3.position).z)
				var_353_3.localEulerAngles.z = 0
				var_353_3.localEulerAngles.x = 0
				var_353_3.localEulerAngles = var_353_3.localEulerAngles
			end

			local var_353_5 = arg_350_1.actors_["1015ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_5) and arg_350_1.var_.characterEffect1015ui_story == nil then
				arg_350_1.var_.characterEffect1015ui_story = var_353_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_6 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_6 and not isNil(var_353_5) then
				if arg_350_1.var_.characterEffect1015ui_story and not isNil(var_353_5) then
					arg_350_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_6 and arg_350_1.time_ < 0 + var_353_6 + arg_353_0 and not isNil(var_353_5) and arg_350_1.var_.characterEffect1015ui_story then
				arg_350_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_2")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_353_8 = 0
			local var_353_9 = 0.325

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_10 = arg_350_1:GetWordFromCfg(317012083)
				local var_353_11 = arg_350_1:FormatText(var_353_10.content)

				arg_350_1.text_.text = var_353_11

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_13 = 13 <= 0 and var_353_9 or var_353_9 * (utf8.len(var_353_11) / 13)

				if (13 <= 0 and var_353_9 or var_353_9 * (utf8.len(var_353_11) / 13)) > 0 and var_353_9 < var_353_13 then
					arg_350_1.talkMaxDuration = var_353_13

					if var_353_13 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_13 + var_353_8
					end
				end

				arg_350_1.text_.text = var_353_11
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012083", "story_v_out_317012.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012083", "story_v_out_317012.awb") / 1000

					if var_353_14 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_8
					end

					if var_353_10.prefab_name ~= "" and arg_350_1.actors_[var_353_10.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_10.prefab_name].transform, "story_v_out_317012", "317012083", "story_v_out_317012.awb")

						arg_350_1:RecordAudio("317012083", var_353_15)
						arg_350_1:RecordAudio("317012083", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_317012", "317012083", "story_v_out_317012.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_317012", "317012083", "story_v_out_317012.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_9, arg_350_1.talkMaxDuration)

			if var_353_8 <= arg_350_1.time_ and arg_350_1.time_ < var_353_8 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_8) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_8 + var_353_16 and arg_350_1.time_ < var_353_8 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play317012084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 317012084
		arg_354_1.duration_ = 2.87

		local var_354_0 = {
			zh = 2.866,
			ja = 2
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play317012085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos2078ui_story = arg_354_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).z)
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles = arg_354_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_354_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).z)
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles = arg_354_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["2078ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect2078ui_story == nil then
				arg_354_1.var_.characterEffect2078ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect2078ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect2078ui_story then
				arg_354_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_357_4 = arg_354_1.actors_["1015ui_story"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1015ui_story = var_357_4.localPosition
			end

			local var_357_5 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_5 then
				var_357_4.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_354_1.time_ - 0) / var_357_5)
				var_357_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_4.position).x, (manager.ui.mainCamera.transform.position - var_357_4.position).y, (manager.ui.mainCamera.transform.position - var_357_4.position).z)
				var_357_4.localEulerAngles.z = 0
				var_357_4.localEulerAngles.x = 0
				var_357_4.localEulerAngles = var_357_4.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_5 and arg_354_1.time_ < 0 + var_357_5 + arg_357_0 then
				var_357_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_357_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_4.position).x, (manager.ui.mainCamera.transform.position - var_357_4.position).y, (manager.ui.mainCamera.transform.position - var_357_4.position).z)
				var_357_4.localEulerAngles.z = 0
				var_357_4.localEulerAngles.x = 0
				var_357_4.localEulerAngles = var_357_4.localEulerAngles
			end

			local var_357_6 = arg_354_1.actors_["1015ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_6) and arg_354_1.var_.characterEffect1015ui_story == nil then
				arg_354_1.var_.characterEffect1015ui_story = var_357_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_7 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 and not isNil(var_357_6) then
				if arg_354_1.var_.characterEffect1015ui_story and not isNil(var_357_6) then
					arg_354_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_7)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 and not isNil(var_357_6) and arg_354_1.var_.characterEffect1015ui_story then
				arg_354_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_357_8 = 0
			local var_357_9 = 0.3

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_10 = arg_354_1:GetWordFromCfg(317012084)
				local var_357_11 = arg_354_1:FormatText(var_357_10.content)

				arg_354_1.text_.text = var_357_11

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_13 = 12 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 12)

				if (12 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 12)) > 0 and var_357_9 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_11
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012084", "story_v_out_317012.awb") ~= 0 then
					local var_357_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012084", "story_v_out_317012.awb") / 1000

					if var_357_14 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_8
					end

					if var_357_10.prefab_name ~= "" and arg_354_1.actors_[var_357_10.prefab_name] ~= nil then
						local var_357_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_10.prefab_name].transform, "story_v_out_317012", "317012084", "story_v_out_317012.awb")

						arg_354_1:RecordAudio("317012084", var_357_15)
						arg_354_1:RecordAudio("317012084", var_357_15)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_317012", "317012084", "story_v_out_317012.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_317012", "317012084", "story_v_out_317012.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_16 and arg_354_1.time_ < var_357_8 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play317012085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 317012085
		arg_358_1.duration_ = 12.7

		local var_358_0 = {
			zh = 12.266,
			ja = 12.7
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play317012086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos2078ui_story = arg_358_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["2078ui_story"].transform.position).z)
				arg_358_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["2078ui_story"].transform.localEulerAngles = arg_358_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_358_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["2078ui_story"].transform.position).z)
				arg_358_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["2078ui_story"].transform.localEulerAngles = arg_358_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["2078ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect2078ui_story == nil then
				arg_358_1.var_.characterEffect2078ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect2078ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_358_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_2)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect2078ui_story then
				arg_358_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_358_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_361_3 = arg_358_1.actors_["1015ui_story"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1015ui_story = var_361_3.localPosition
			end

			local var_361_4 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				var_361_3.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_358_1.time_ - 0) / var_361_4)
				var_361_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_361_3.position).x, (manager.ui.mainCamera.transform.position - var_361_3.position).y, (manager.ui.mainCamera.transform.position - var_361_3.position).z)
				var_361_3.localEulerAngles.z = 0
				var_361_3.localEulerAngles.x = 0
				var_361_3.localEulerAngles = var_361_3.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				var_361_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_361_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_361_3.position).x, (manager.ui.mainCamera.transform.position - var_361_3.position).y, (manager.ui.mainCamera.transform.position - var_361_3.position).z)
				var_361_3.localEulerAngles.z = 0
				var_361_3.localEulerAngles.x = 0
				var_361_3.localEulerAngles = var_361_3.localEulerAngles
			end

			local var_361_5 = arg_358_1.actors_["1015ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_5) and arg_358_1.var_.characterEffect1015ui_story == nil then
				arg_358_1.var_.characterEffect1015ui_story = var_361_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_6 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_6 and not isNil(var_361_5) then
				if arg_358_1.var_.characterEffect1015ui_story and not isNil(var_361_5) then
					arg_358_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_6 and arg_358_1.time_ < 0 + var_361_6 + arg_361_0 and not isNil(var_361_5) and arg_358_1.var_.characterEffect1015ui_story then
				arg_358_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_361_8 = 0
			local var_361_9 = 1.1

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_8 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_10 = arg_358_1:GetWordFromCfg(317012085)
				local var_361_11 = arg_358_1:FormatText(var_361_10.content)

				arg_358_1.text_.text = var_361_11

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_13 = 44 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 44)

				if (44 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 44)) > 0 and var_361_9 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_8
					end
				end

				arg_358_1.text_.text = var_361_11
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012085", "story_v_out_317012.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012085", "story_v_out_317012.awb") / 1000

					if var_361_14 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_8
					end

					if var_361_10.prefab_name ~= "" and arg_358_1.actors_[var_361_10.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_10.prefab_name].transform, "story_v_out_317012", "317012085", "story_v_out_317012.awb")

						arg_358_1:RecordAudio("317012085", var_361_15)
						arg_358_1:RecordAudio("317012085", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_317012", "317012085", "story_v_out_317012.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_317012", "317012085", "story_v_out_317012.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_9, arg_358_1.talkMaxDuration)

			if var_361_8 <= arg_358_1.time_ and arg_358_1.time_ < var_361_8 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_8) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_8 + var_361_16 and arg_358_1.time_ < var_361_8 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play317012086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 317012086
		arg_362_1.duration_ = 2.07

		local var_362_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play317012087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos2078ui_story = arg_362_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2078ui_story"].transform.position).z)
				arg_362_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["2078ui_story"].transform.localEulerAngles = arg_362_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_362_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2078ui_story"].transform.position).z)
				arg_362_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["2078ui_story"].transform.localEulerAngles = arg_362_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["2078ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect2078ui_story == nil then
				arg_362_1.var_.characterEffect2078ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 and not isNil(var_365_1) then
				if arg_362_1.var_.characterEffect2078ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect2078ui_story then
				arg_362_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_365_4 = arg_362_1.actors_["1015ui_story"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1015ui_story = var_365_4.localPosition
			end

			local var_365_5 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_5 then
				var_365_4.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_362_1.time_ - 0) / var_365_5)
				var_365_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_4.position).x, (manager.ui.mainCamera.transform.position - var_365_4.position).y, (manager.ui.mainCamera.transform.position - var_365_4.position).z)
				var_365_4.localEulerAngles.z = 0
				var_365_4.localEulerAngles.x = 0
				var_365_4.localEulerAngles = var_365_4.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_5 and arg_362_1.time_ < 0 + var_365_5 + arg_365_0 then
				var_365_4.localPosition = Vector3.New(0, 100, 0)
				var_365_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_4.position).x, (manager.ui.mainCamera.transform.position - var_365_4.position).y, (manager.ui.mainCamera.transform.position - var_365_4.position).z)
				var_365_4.localEulerAngles.z = 0
				var_365_4.localEulerAngles.x = 0
				var_365_4.localEulerAngles = var_365_4.localEulerAngles
			end

			local var_365_6 = arg_362_1.actors_["1015ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_6) and arg_362_1.var_.characterEffect1015ui_story == nil then
				arg_362_1.var_.characterEffect1015ui_story = var_365_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_7 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 and not isNil(var_365_6) then
				if arg_362_1.var_.characterEffect1015ui_story and not isNil(var_365_6) then
					arg_362_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_7)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 and not isNil(var_365_6) and arg_362_1.var_.characterEffect1015ui_story then
				arg_362_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_365_8 = arg_362_1.actors_["2079ui_story"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos2079ui_story = var_365_8.localPosition
			end

			local var_365_9 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_9 then
				var_365_8.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_362_1.time_ - 0) / var_365_9)
				var_365_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_8.position).x, (manager.ui.mainCamera.transform.position - var_365_8.position).y, (manager.ui.mainCamera.transform.position - var_365_8.position).z)
				var_365_8.localEulerAngles.z = 0
				var_365_8.localEulerAngles.x = 0
				var_365_8.localEulerAngles = var_365_8.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_9 and arg_362_1.time_ < 0 + var_365_9 + arg_365_0 then
				var_365_8.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_365_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_8.position).x, (manager.ui.mainCamera.transform.position - var_365_8.position).y, (manager.ui.mainCamera.transform.position - var_365_8.position).z)
				var_365_8.localEulerAngles.z = 0
				var_365_8.localEulerAngles.x = 0
				var_365_8.localEulerAngles = var_365_8.localEulerAngles
			end

			local var_365_10 = 0
			local var_365_11 = 0.075

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_10 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_12 = arg_362_1:GetWordFromCfg(317012086)
				local var_365_13 = arg_362_1:FormatText(var_365_12.content)

				arg_362_1.text_.text = var_365_13

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_15 = 3 <= 0 and var_365_11 or var_365_11 * (utf8.len(var_365_13) / 3)

				if (3 <= 0 and var_365_11 or var_365_11 * (utf8.len(var_365_13) / 3)) > 0 and var_365_11 < var_365_15 then
					arg_362_1.talkMaxDuration = var_365_15

					if var_365_15 + var_365_10 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_15 + var_365_10
					end
				end

				arg_362_1.text_.text = var_365_13
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012086", "story_v_out_317012.awb") ~= 0 then
					local var_365_16 = manager.audio:GetVoiceLength("story_v_out_317012", "317012086", "story_v_out_317012.awb") / 1000

					if var_365_16 + var_365_10 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_16 + var_365_10
					end

					if var_365_12.prefab_name ~= "" and arg_362_1.actors_[var_365_12.prefab_name] ~= nil then
						local var_365_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_12.prefab_name].transform, "story_v_out_317012", "317012086", "story_v_out_317012.awb")

						arg_362_1:RecordAudio("317012086", var_365_17)
						arg_362_1:RecordAudio("317012086", var_365_17)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_317012", "317012086", "story_v_out_317012.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_317012", "317012086", "story_v_out_317012.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_18 = math.max(var_365_11, arg_362_1.talkMaxDuration)

			if var_365_10 <= arg_362_1.time_ and arg_362_1.time_ < var_365_10 + var_365_18 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_10) / var_365_18

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_10 + var_365_18 and arg_362_1.time_ < var_365_10 + var_365_18 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play317012087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 317012087
		arg_366_1.duration_ = 2.3

		local var_366_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play317012088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos2079ui_story = arg_366_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).z)
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles = arg_366_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_366_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).z)
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles = arg_366_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_369_1 = arg_366_1.actors_["2079ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect2079ui_story == nil then
				arg_366_1.var_.characterEffect2079ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect2079ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect2079ui_story then
				arg_366_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_369_4 = arg_366_1.actors_["2078ui_story"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos2078ui_story = var_369_4.localPosition
			end

			local var_369_5 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_5 then
				var_369_4.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_366_1.time_ - 0) / var_369_5)
				var_369_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_369_4.position).x, (manager.ui.mainCamera.transform.position - var_369_4.position).y, (manager.ui.mainCamera.transform.position - var_369_4.position).z)
				var_369_4.localEulerAngles.z = 0
				var_369_4.localEulerAngles.x = 0
				var_369_4.localEulerAngles = var_369_4.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_5 and arg_366_1.time_ < 0 + var_369_5 + arg_369_0 then
				var_369_4.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_369_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_369_4.position).x, (manager.ui.mainCamera.transform.position - var_369_4.position).y, (manager.ui.mainCamera.transform.position - var_369_4.position).z)
				var_369_4.localEulerAngles.z = 0
				var_369_4.localEulerAngles.x = 0
				var_369_4.localEulerAngles = var_369_4.localEulerAngles
			end

			local var_369_6 = arg_366_1.actors_["2078ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_6) and arg_366_1.var_.characterEffect2078ui_story == nil then
				arg_366_1.var_.characterEffect2078ui_story = var_369_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_7 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 and not isNil(var_369_6) then
				if arg_366_1.var_.characterEffect2078ui_story and not isNil(var_369_6) then
					arg_366_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_366_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_7)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 and not isNil(var_369_6) and arg_366_1.var_.characterEffect2078ui_story then
				arg_366_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_366_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_369_8 = 0
			local var_369_9 = 0.075

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:GetWordFromCfg(317012087)
				local var_369_11 = arg_366_1:FormatText(var_369_10.content)

				arg_366_1.text_.text = var_369_11

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 3 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 3)

				if (3 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 3)) > 0 and var_369_9 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_11
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012087", "story_v_out_317012.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012087", "story_v_out_317012.awb") / 1000

					if var_369_14 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_8
					end

					if var_369_10.prefab_name ~= "" and arg_366_1.actors_[var_369_10.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_10.prefab_name].transform, "story_v_out_317012", "317012087", "story_v_out_317012.awb")

						arg_366_1:RecordAudio("317012087", var_369_15)
						arg_366_1:RecordAudio("317012087", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_317012", "317012087", "story_v_out_317012.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_317012", "317012087", "story_v_out_317012.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_16 and arg_366_1.time_ < var_369_8 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play317012088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 317012088
		arg_370_1.duration_ = 1.6

		local var_370_0 = {
			zh = 1.4,
			ja = 1.6
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play317012089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos2078ui_story = arg_370_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_373_0 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 then
				arg_370_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_370_1.time_ - 0) / var_373_0)
				arg_370_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["2078ui_story"].transform.position).z)
				arg_370_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["2078ui_story"].transform.localEulerAngles = arg_370_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 then
				arg_370_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_370_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["2078ui_story"].transform.position).z)
				arg_370_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["2078ui_story"].transform.localEulerAngles = arg_370_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_373_1 = arg_370_1.actors_["2078ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect2078ui_story == nil then
				arg_370_1.var_.characterEffect2078ui_story = var_373_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_2 and not isNil(var_373_1) then
				if arg_370_1.var_.characterEffect2078ui_story and not isNil(var_373_1) then
					arg_370_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_2 and arg_370_1.time_ < 0 + var_373_2 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect2078ui_story then
				arg_370_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_373_4 = arg_370_1.actors_["1015ui_story"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1015ui_story = var_373_4.localPosition
			end

			local var_373_5 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_5 then
				var_373_4.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_370_1.time_ - 0) / var_373_5)
				var_373_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_373_4.position).x, (manager.ui.mainCamera.transform.position - var_373_4.position).y, (manager.ui.mainCamera.transform.position - var_373_4.position).z)
				var_373_4.localEulerAngles.z = 0
				var_373_4.localEulerAngles.x = 0
				var_373_4.localEulerAngles = var_373_4.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_5 and arg_370_1.time_ < 0 + var_373_5 + arg_373_0 then
				var_373_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_373_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_373_4.position).x, (manager.ui.mainCamera.transform.position - var_373_4.position).y, (manager.ui.mainCamera.transform.position - var_373_4.position).z)
				var_373_4.localEulerAngles.z = 0
				var_373_4.localEulerAngles.x = 0
				var_373_4.localEulerAngles = var_373_4.localEulerAngles
			end

			local var_373_6 = arg_370_1.actors_["1015ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_6) and arg_370_1.var_.characterEffect1015ui_story == nil then
				arg_370_1.var_.characterEffect1015ui_story = var_373_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_7 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 and not isNil(var_373_6) then
				if arg_370_1.var_.characterEffect1015ui_story and not isNil(var_373_6) then
					arg_370_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_7)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 and not isNil(var_373_6) and arg_370_1.var_.characterEffect1015ui_story then
				arg_370_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_373_8 = arg_370_1.actors_["2079ui_story"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos2079ui_story = var_373_8.localPosition
			end

			local var_373_9 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_9 then
				var_373_8.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_370_1.time_ - 0) / var_373_9)
				var_373_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_373_8.position).x, (manager.ui.mainCamera.transform.position - var_373_8.position).y, (manager.ui.mainCamera.transform.position - var_373_8.position).z)
				var_373_8.localEulerAngles.z = 0
				var_373_8.localEulerAngles.x = 0
				var_373_8.localEulerAngles = var_373_8.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_9 and arg_370_1.time_ < 0 + var_373_9 + arg_373_0 then
				var_373_8.localPosition = Vector3.New(0, 100, 0)
				var_373_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_373_8.position).x, (manager.ui.mainCamera.transform.position - var_373_8.position).y, (manager.ui.mainCamera.transform.position - var_373_8.position).z)
				var_373_8.localEulerAngles.z = 0
				var_373_8.localEulerAngles.x = 0
				var_373_8.localEulerAngles = var_373_8.localEulerAngles
			end

			local var_373_10 = arg_370_1.actors_["2079ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_10) and arg_370_1.var_.characterEffect2079ui_story == nil then
				arg_370_1.var_.characterEffect2079ui_story = var_373_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_11 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_11 and not isNil(var_373_10) then
				if arg_370_1.var_.characterEffect2079ui_story and not isNil(var_373_10) then
					arg_370_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_370_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_11)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_11 and arg_370_1.time_ < 0 + var_373_11 + arg_373_0 and not isNil(var_373_10) and arg_370_1.var_.characterEffect2079ui_story then
				arg_370_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_370_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_373_12 = 0
			local var_373_13 = 0.075

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_12 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_14 = arg_370_1:GetWordFromCfg(317012088)
				local var_373_15 = arg_370_1:FormatText(var_373_14.content)

				arg_370_1.text_.text = var_373_15

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_17 = 3 <= 0 and var_373_13 or var_373_13 * (utf8.len(var_373_15) / 3)

				if (3 <= 0 and var_373_13 or var_373_13 * (utf8.len(var_373_15) / 3)) > 0 and var_373_13 < var_373_17 then
					arg_370_1.talkMaxDuration = var_373_17

					if var_373_17 + var_373_12 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_12
					end
				end

				arg_370_1.text_.text = var_373_15
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012088", "story_v_out_317012.awb") ~= 0 then
					local var_373_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012088", "story_v_out_317012.awb") / 1000

					if var_373_18 + var_373_12 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_18 + var_373_12
					end

					if var_373_14.prefab_name ~= "" and arg_370_1.actors_[var_373_14.prefab_name] ~= nil then
						local var_373_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_14.prefab_name].transform, "story_v_out_317012", "317012088", "story_v_out_317012.awb")

						arg_370_1:RecordAudio("317012088", var_373_19)
						arg_370_1:RecordAudio("317012088", var_373_19)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_317012", "317012088", "story_v_out_317012.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_317012", "317012088", "story_v_out_317012.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_20 = math.max(var_373_13, arg_370_1.talkMaxDuration)

			if var_373_12 <= arg_370_1.time_ and arg_370_1.time_ < var_373_12 + var_373_20 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_12) / var_373_20

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_12 + var_373_20 and arg_370_1.time_ < var_373_12 + var_373_20 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play317012089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 317012089
		arg_374_1.duration_ = 9.9

		local var_374_0 = {
			zh = 9.9,
			ja = 6
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play317012090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_377_0 = arg_374_1.actors_["1015ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1015ui_story == nil then
				arg_374_1.var_.characterEffect1015ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_1 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_1 and not isNil(var_377_0) then
				if arg_374_1.var_.characterEffect1015ui_story and not isNil(var_377_0) then
					arg_374_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_1 and arg_374_1.time_ < 0 + var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1015ui_story then
				arg_374_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_377_3 = arg_374_1.actors_["2078ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_3) and arg_374_1.var_.characterEffect2078ui_story == nil then
				arg_374_1.var_.characterEffect2078ui_story = var_377_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_4 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 and not isNil(var_377_3) then
				if arg_374_1.var_.characterEffect2078ui_story and not isNil(var_377_3) then
					arg_374_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_374_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_4)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 and not isNil(var_377_3) and arg_374_1.var_.characterEffect2078ui_story then
				arg_374_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_374_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_377_5 = 0
			local var_377_6 = 1.175

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_7 = arg_374_1:GetWordFromCfg(317012089)
				local var_377_8 = arg_374_1:FormatText(var_377_7.content)

				arg_374_1.text_.text = var_377_8

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_10 = 47 <= 0 and var_377_6 or var_377_6 * (utf8.len(var_377_8) / 47)

				if (47 <= 0 and var_377_6 or var_377_6 * (utf8.len(var_377_8) / 47)) > 0 and var_377_6 < var_377_10 then
					arg_374_1.talkMaxDuration = var_377_10

					if var_377_10 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_5
					end
				end

				arg_374_1.text_.text = var_377_8
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012089", "story_v_out_317012.awb") ~= 0 then
					local var_377_11 = manager.audio:GetVoiceLength("story_v_out_317012", "317012089", "story_v_out_317012.awb") / 1000

					if var_377_11 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_11 + var_377_5
					end

					if var_377_7.prefab_name ~= "" and arg_374_1.actors_[var_377_7.prefab_name] ~= nil then
						local var_377_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_7.prefab_name].transform, "story_v_out_317012", "317012089", "story_v_out_317012.awb")

						arg_374_1:RecordAudio("317012089", var_377_12)
						arg_374_1:RecordAudio("317012089", var_377_12)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_317012", "317012089", "story_v_out_317012.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_317012", "317012089", "story_v_out_317012.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_13 = math.max(var_377_6, arg_374_1.talkMaxDuration)

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_13 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_5) / var_377_13

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_5 + var_377_13 and arg_374_1.time_ < var_377_5 + var_377_13 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play317012090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 317012090
		arg_378_1.duration_ = 6.9

		local var_378_0 = {
			zh = 5.466,
			ja = 6.9
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play317012091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1015ui_story = arg_378_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1015ui_story"].transform.position).z)
				arg_378_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1015ui_story"].transform.localEulerAngles = arg_378_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_378_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1015ui_story"].transform.position).z)
				arg_378_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1015ui_story"].transform.localEulerAngles = arg_378_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_381_1 = arg_378_1.actors_["1015ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1015ui_story == nil then
				arg_378_1.var_.characterEffect1015ui_story = var_381_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_2 and not isNil(var_381_1) then
				if arg_378_1.var_.characterEffect1015ui_story and not isNil(var_381_1) then
					arg_378_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_2)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_2 and arg_378_1.time_ < 0 + var_381_2 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1015ui_story then
				arg_378_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_381_3 = arg_378_1.actors_["2079ui_story"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos2079ui_story = var_381_3.localPosition
			end

			local var_381_4 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				var_381_3.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_378_1.time_ - 0) / var_381_4)
				var_381_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_381_3.position).x, (manager.ui.mainCamera.transform.position - var_381_3.position).y, (manager.ui.mainCamera.transform.position - var_381_3.position).z)
				var_381_3.localEulerAngles.z = 0
				var_381_3.localEulerAngles.x = 0
				var_381_3.localEulerAngles = var_381_3.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				var_381_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_381_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_381_3.position).x, (manager.ui.mainCamera.transform.position - var_381_3.position).y, (manager.ui.mainCamera.transform.position - var_381_3.position).z)
				var_381_3.localEulerAngles.z = 0
				var_381_3.localEulerAngles.x = 0
				var_381_3.localEulerAngles = var_381_3.localEulerAngles
			end

			local var_381_5 = arg_378_1.actors_["2079ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_5) and arg_378_1.var_.characterEffect2079ui_story == nil then
				arg_378_1.var_.characterEffect2079ui_story = var_381_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_6 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_6 and not isNil(var_381_5) then
				if arg_378_1.var_.characterEffect2079ui_story and not isNil(var_381_5) then
					arg_378_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_6 and arg_378_1.time_ < 0 + var_381_6 + arg_381_0 and not isNil(var_381_5) and arg_378_1.var_.characterEffect2079ui_story then
				arg_378_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_381_8 = arg_378_1.actors_["2078ui_story"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos2078ui_story = var_381_8.localPosition
			end

			local var_381_9 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_9 then
				var_381_8.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_378_1.time_ - 0) / var_381_9)
				var_381_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_381_8.position).x, (manager.ui.mainCamera.transform.position - var_381_8.position).y, (manager.ui.mainCamera.transform.position - var_381_8.position).z)
				var_381_8.localEulerAngles.z = 0
				var_381_8.localEulerAngles.x = 0
				var_381_8.localEulerAngles = var_381_8.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_9 and arg_378_1.time_ < 0 + var_381_9 + arg_381_0 then
				var_381_8.localPosition = Vector3.New(0, 100, 0)
				var_381_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_381_8.position).x, (manager.ui.mainCamera.transform.position - var_381_8.position).y, (manager.ui.mainCamera.transform.position - var_381_8.position).z)
				var_381_8.localEulerAngles.z = 0
				var_381_8.localEulerAngles.x = 0
				var_381_8.localEulerAngles = var_381_8.localEulerAngles
			end

			local var_381_10 = 0
			local var_381_11 = 0.5

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_12 = arg_378_1:GetWordFromCfg(317012090)
				local var_381_13 = arg_378_1:FormatText(var_381_12.content)

				arg_378_1.text_.text = var_381_13

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_15 = 20 <= 0 and var_381_11 or var_381_11 * (utf8.len(var_381_13) / 20)

				if (20 <= 0 and var_381_11 or var_381_11 * (utf8.len(var_381_13) / 20)) > 0 and var_381_11 < var_381_15 then
					arg_378_1.talkMaxDuration = var_381_15

					if var_381_15 + var_381_10 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_15 + var_381_10
					end
				end

				arg_378_1.text_.text = var_381_13
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012090", "story_v_out_317012.awb") ~= 0 then
					local var_381_16 = manager.audio:GetVoiceLength("story_v_out_317012", "317012090", "story_v_out_317012.awb") / 1000

					if var_381_16 + var_381_10 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_16 + var_381_10
					end

					if var_381_12.prefab_name ~= "" and arg_378_1.actors_[var_381_12.prefab_name] ~= nil then
						local var_381_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_12.prefab_name].transform, "story_v_out_317012", "317012090", "story_v_out_317012.awb")

						arg_378_1:RecordAudio("317012090", var_381_17)
						arg_378_1:RecordAudio("317012090", var_381_17)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_317012", "317012090", "story_v_out_317012.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_317012", "317012090", "story_v_out_317012.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_18 = math.max(var_381_11, arg_378_1.talkMaxDuration)

			if var_381_10 <= arg_378_1.time_ and arg_378_1.time_ < var_381_10 + var_381_18 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_10) / var_381_18

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_10 + var_381_18 and arg_378_1.time_ < var_381_10 + var_381_18 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play317012091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 317012091
		arg_382_1.duration_ = 12.13

		local var_382_0 = {
			zh = 12.133,
			ja = 10.5
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play317012092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos2078ui_story = arg_382_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["2078ui_story"].transform.position).z)
				arg_382_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["2078ui_story"].transform.localEulerAngles = arg_382_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_382_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["2078ui_story"].transform.position).z)
				arg_382_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["2078ui_story"].transform.localEulerAngles = arg_382_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_385_1 = arg_382_1.actors_["2078ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect2078ui_story == nil then
				arg_382_1.var_.characterEffect2078ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_2 and not isNil(var_385_1) then
				if arg_382_1.var_.characterEffect2078ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_2 and arg_382_1.time_ < 0 + var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect2078ui_story then
				arg_382_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_385_4 = arg_382_1.actors_["1015ui_story"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1015ui_story = var_385_4.localPosition
			end

			local var_385_5 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_5 then
				var_385_4.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_382_1.time_ - 0) / var_385_5)
				var_385_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_4.position).x, (manager.ui.mainCamera.transform.position - var_385_4.position).y, (manager.ui.mainCamera.transform.position - var_385_4.position).z)
				var_385_4.localEulerAngles.z = 0
				var_385_4.localEulerAngles.x = 0
				var_385_4.localEulerAngles = var_385_4.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_5 and arg_382_1.time_ < 0 + var_385_5 + arg_385_0 then
				var_385_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_385_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_4.position).x, (manager.ui.mainCamera.transform.position - var_385_4.position).y, (manager.ui.mainCamera.transform.position - var_385_4.position).z)
				var_385_4.localEulerAngles.z = 0
				var_385_4.localEulerAngles.x = 0
				var_385_4.localEulerAngles = var_385_4.localEulerAngles
			end

			local var_385_6 = arg_382_1.actors_["1015ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_6) and arg_382_1.var_.characterEffect1015ui_story == nil then
				arg_382_1.var_.characterEffect1015ui_story = var_385_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_7 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 and not isNil(var_385_6) then
				if arg_382_1.var_.characterEffect1015ui_story and not isNil(var_385_6) then
					arg_382_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_7)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 and not isNil(var_385_6) and arg_382_1.var_.characterEffect1015ui_story then
				arg_382_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_385_8 = arg_382_1.actors_["2079ui_story"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos2079ui_story = var_385_8.localPosition
			end

			local var_385_9 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_9 then
				var_385_8.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_382_1.time_ - 0) / var_385_9)
				var_385_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_8.position).x, (manager.ui.mainCamera.transform.position - var_385_8.position).y, (manager.ui.mainCamera.transform.position - var_385_8.position).z)
				var_385_8.localEulerAngles.z = 0
				var_385_8.localEulerAngles.x = 0
				var_385_8.localEulerAngles = var_385_8.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_9 and arg_382_1.time_ < 0 + var_385_9 + arg_385_0 then
				var_385_8.localPosition = Vector3.New(0, 100, 0)
				var_385_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_8.position).x, (manager.ui.mainCamera.transform.position - var_385_8.position).y, (manager.ui.mainCamera.transform.position - var_385_8.position).z)
				var_385_8.localEulerAngles.z = 0
				var_385_8.localEulerAngles.x = 0
				var_385_8.localEulerAngles = var_385_8.localEulerAngles
			end

			local var_385_10 = arg_382_1.actors_["2079ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_10) and arg_382_1.var_.characterEffect2079ui_story == nil then
				arg_382_1.var_.characterEffect2079ui_story = var_385_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_11 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_11 and not isNil(var_385_10) then
				if arg_382_1.var_.characterEffect2079ui_story and not isNil(var_385_10) then
					arg_382_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_382_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_11)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_11 and arg_382_1.time_ < 0 + var_385_11 + arg_385_0 and not isNil(var_385_10) and arg_382_1.var_.characterEffect2079ui_story then
				arg_382_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_382_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_385_12 = 0
			local var_385_13 = 1.425

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_12 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_14 = arg_382_1:GetWordFromCfg(317012091)
				local var_385_15 = arg_382_1:FormatText(var_385_14.content)

				arg_382_1.text_.text = var_385_15

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_17 = 57 <= 0 and var_385_13 or var_385_13 * (utf8.len(var_385_15) / 57)

				if (57 <= 0 and var_385_13 or var_385_13 * (utf8.len(var_385_15) / 57)) > 0 and var_385_13 < var_385_17 then
					arg_382_1.talkMaxDuration = var_385_17

					if var_385_17 + var_385_12 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_17 + var_385_12
					end
				end

				arg_382_1.text_.text = var_385_15
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012091", "story_v_out_317012.awb") ~= 0 then
					local var_385_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012091", "story_v_out_317012.awb") / 1000

					if var_385_18 + var_385_12 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_18 + var_385_12
					end

					if var_385_14.prefab_name ~= "" and arg_382_1.actors_[var_385_14.prefab_name] ~= nil then
						local var_385_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_14.prefab_name].transform, "story_v_out_317012", "317012091", "story_v_out_317012.awb")

						arg_382_1:RecordAudio("317012091", var_385_19)
						arg_382_1:RecordAudio("317012091", var_385_19)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_317012", "317012091", "story_v_out_317012.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_317012", "317012091", "story_v_out_317012.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_20 = math.max(var_385_13, arg_382_1.talkMaxDuration)

			if var_385_12 <= arg_382_1.time_ and arg_382_1.time_ < var_385_12 + var_385_20 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_12) / var_385_20

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_12 + var_385_20 and arg_382_1.time_ < var_385_12 + var_385_20 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play317012092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 317012092
		arg_386_1.duration_ = 1.87

		local var_386_0 = {
			zh = 1.866,
			ja = 1.733
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play317012093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos2078ui_story = arg_386_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_389_0 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 then
				arg_386_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_386_1.time_ - 0) / var_389_0)
				arg_386_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["2078ui_story"].transform.position).z)
				arg_386_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["2078ui_story"].transform.localEulerAngles = arg_386_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 then
				arg_386_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_386_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["2078ui_story"].transform.position).z)
				arg_386_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["2078ui_story"].transform.localEulerAngles = arg_386_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_389_1 = arg_386_1.actors_["2078ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect2078ui_story == nil then
				arg_386_1.var_.characterEffect2078ui_story = var_389_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_2 and not isNil(var_389_1) then
				if arg_386_1.var_.characterEffect2078ui_story and not isNil(var_389_1) then
					arg_386_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_386_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_2)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_2 and arg_386_1.time_ < 0 + var_389_2 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect2078ui_story then
				arg_386_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_386_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_389_3 = arg_386_1.actors_["1015ui_story"].transform

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1015ui_story = var_389_3.localPosition
			end

			local var_389_4 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				var_389_3.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_386_1.time_ - 0) / var_389_4)
				var_389_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_389_3.position).x, (manager.ui.mainCamera.transform.position - var_389_3.position).y, (manager.ui.mainCamera.transform.position - var_389_3.position).z)
				var_389_3.localEulerAngles.z = 0
				var_389_3.localEulerAngles.x = 0
				var_389_3.localEulerAngles = var_389_3.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				var_389_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_389_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_389_3.position).x, (manager.ui.mainCamera.transform.position - var_389_3.position).y, (manager.ui.mainCamera.transform.position - var_389_3.position).z)
				var_389_3.localEulerAngles.z = 0
				var_389_3.localEulerAngles.x = 0
				var_389_3.localEulerAngles = var_389_3.localEulerAngles
			end

			local var_389_5 = arg_386_1.actors_["1015ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_5) and arg_386_1.var_.characterEffect1015ui_story == nil then
				arg_386_1.var_.characterEffect1015ui_story = var_389_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_6 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_6 and not isNil(var_389_5) then
				if arg_386_1.var_.characterEffect1015ui_story and not isNil(var_389_5) then
					arg_386_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_6 and arg_386_1.time_ < 0 + var_389_6 + arg_389_0 and not isNil(var_389_5) and arg_386_1.var_.characterEffect1015ui_story then
				arg_386_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_389_8 = 0
			local var_389_9 = 0.25

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_10 = arg_386_1:GetWordFromCfg(317012092)
				local var_389_11 = arg_386_1:FormatText(var_389_10.content)

				arg_386_1.text_.text = var_389_11

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_13 = 10 <= 0 and var_389_9 or var_389_9 * (utf8.len(var_389_11) / 10)

				if (10 <= 0 and var_389_9 or var_389_9 * (utf8.len(var_389_11) / 10)) > 0 and var_389_9 < var_389_13 then
					arg_386_1.talkMaxDuration = var_389_13

					if var_389_13 + var_389_8 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_8
					end
				end

				arg_386_1.text_.text = var_389_11
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012092", "story_v_out_317012.awb") ~= 0 then
					local var_389_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012092", "story_v_out_317012.awb") / 1000

					if var_389_14 + var_389_8 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_14 + var_389_8
					end

					if var_389_10.prefab_name ~= "" and arg_386_1.actors_[var_389_10.prefab_name] ~= nil then
						local var_389_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_10.prefab_name].transform, "story_v_out_317012", "317012092", "story_v_out_317012.awb")

						arg_386_1:RecordAudio("317012092", var_389_15)
						arg_386_1:RecordAudio("317012092", var_389_15)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_317012", "317012092", "story_v_out_317012.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_317012", "317012092", "story_v_out_317012.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_16 = math.max(var_389_9, arg_386_1.talkMaxDuration)

			if var_389_8 <= arg_386_1.time_ and arg_386_1.time_ < var_389_8 + var_389_16 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_8) / var_389_16

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_8 + var_389_16 and arg_386_1.time_ < var_389_8 + var_389_16 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play317012093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 317012093
		arg_390_1.duration_ = 2.9

		local var_390_0 = {
			zh = 1.866,
			ja = 2.9
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play317012094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos2078ui_story = arg_390_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["2078ui_story"].transform.position).z)
				arg_390_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["2078ui_story"].transform.localEulerAngles = arg_390_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_390_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["2078ui_story"].transform.position).z)
				arg_390_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["2078ui_story"].transform.localEulerAngles = arg_390_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_393_1 = arg_390_1.actors_["2078ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_1) and arg_390_1.var_.characterEffect2078ui_story == nil then
				arg_390_1.var_.characterEffect2078ui_story = var_393_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_2 and not isNil(var_393_1) then
				if arg_390_1.var_.characterEffect2078ui_story and not isNil(var_393_1) then
					arg_390_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_2 and arg_390_1.time_ < 0 + var_393_2 + arg_393_0 and not isNil(var_393_1) and arg_390_1.var_.characterEffect2078ui_story then
				arg_390_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_393_4 = arg_390_1.actors_["1015ui_story"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1015ui_story = var_393_4.localPosition
			end

			local var_393_5 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_5 then
				var_393_4.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_390_1.time_ - 0) / var_393_5)
				var_393_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_4.position).x, (manager.ui.mainCamera.transform.position - var_393_4.position).y, (manager.ui.mainCamera.transform.position - var_393_4.position).z)
				var_393_4.localEulerAngles.z = 0
				var_393_4.localEulerAngles.x = 0
				var_393_4.localEulerAngles = var_393_4.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_5 and arg_390_1.time_ < 0 + var_393_5 + arg_393_0 then
				var_393_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_393_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_4.position).x, (manager.ui.mainCamera.transform.position - var_393_4.position).y, (manager.ui.mainCamera.transform.position - var_393_4.position).z)
				var_393_4.localEulerAngles.z = 0
				var_393_4.localEulerAngles.x = 0
				var_393_4.localEulerAngles = var_393_4.localEulerAngles
			end

			local var_393_6 = arg_390_1.actors_["1015ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_6) and arg_390_1.var_.characterEffect1015ui_story == nil then
				arg_390_1.var_.characterEffect1015ui_story = var_393_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_7 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 and not isNil(var_393_6) then
				if arg_390_1.var_.characterEffect1015ui_story and not isNil(var_393_6) then
					arg_390_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_7)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 and not isNil(var_393_6) and arg_390_1.var_.characterEffect1015ui_story then
				arg_390_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_393_8 = 0
			local var_393_9 = 0.25

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_10 = arg_390_1:GetWordFromCfg(317012093)
				local var_393_11 = arg_390_1:FormatText(var_393_10.content)

				arg_390_1.text_.text = var_393_11

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_13 = 10 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_11) / 10)

				if (10 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_11) / 10)) > 0 and var_393_9 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_8
					end
				end

				arg_390_1.text_.text = var_393_11
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012093", "story_v_out_317012.awb") ~= 0 then
					local var_393_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012093", "story_v_out_317012.awb") / 1000

					if var_393_14 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_14 + var_393_8
					end

					if var_393_10.prefab_name ~= "" and arg_390_1.actors_[var_393_10.prefab_name] ~= nil then
						local var_393_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_10.prefab_name].transform, "story_v_out_317012", "317012093", "story_v_out_317012.awb")

						arg_390_1:RecordAudio("317012093", var_393_15)
						arg_390_1:RecordAudio("317012093", var_393_15)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_317012", "317012093", "story_v_out_317012.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_317012", "317012093", "story_v_out_317012.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_16 = math.max(var_393_9, arg_390_1.talkMaxDuration)

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_16 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_8) / var_393_16

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_8 + var_393_16 and arg_390_1.time_ < var_393_8 + var_393_16 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play317012094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 317012094
		arg_394_1.duration_ = 16.37

		local var_394_0 = {
			zh = 16.366,
			ja = 9.7
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play317012095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos2078ui_story = arg_394_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_397_0 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 then
				arg_394_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_394_1.time_ - 0) / var_397_0)
				arg_394_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["2078ui_story"].transform.position).z)
				arg_394_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["2078ui_story"].transform.localEulerAngles = arg_394_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 then
				arg_394_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_394_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["2078ui_story"].transform.position).z)
				arg_394_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["2078ui_story"].transform.localEulerAngles = arg_394_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_397_1 = arg_394_1.actors_["2078ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_1) and arg_394_1.var_.characterEffect2078ui_story == nil then
				arg_394_1.var_.characterEffect2078ui_story = var_397_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_2 and not isNil(var_397_1) then
				if arg_394_1.var_.characterEffect2078ui_story and not isNil(var_397_1) then
					arg_394_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_394_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_2)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_2 and arg_394_1.time_ < 0 + var_397_2 + arg_397_0 and not isNil(var_397_1) and arg_394_1.var_.characterEffect2078ui_story then
				arg_394_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_394_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_397_3 = arg_394_1.actors_["1015ui_story"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1015ui_story = var_397_3.localPosition
			end

			local var_397_4 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				var_397_3.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_394_1.time_ - 0) / var_397_4)
				var_397_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_397_3.position).x, (manager.ui.mainCamera.transform.position - var_397_3.position).y, (manager.ui.mainCamera.transform.position - var_397_3.position).z)
				var_397_3.localEulerAngles.z = 0
				var_397_3.localEulerAngles.x = 0
				var_397_3.localEulerAngles = var_397_3.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				var_397_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_397_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_397_3.position).x, (manager.ui.mainCamera.transform.position - var_397_3.position).y, (manager.ui.mainCamera.transform.position - var_397_3.position).z)
				var_397_3.localEulerAngles.z = 0
				var_397_3.localEulerAngles.x = 0
				var_397_3.localEulerAngles = var_397_3.localEulerAngles
			end

			local var_397_5 = arg_394_1.actors_["1015ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_5) and arg_394_1.var_.characterEffect1015ui_story == nil then
				arg_394_1.var_.characterEffect1015ui_story = var_397_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_6 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_6 and not isNil(var_397_5) then
				if arg_394_1.var_.characterEffect1015ui_story and not isNil(var_397_5) then
					arg_394_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_6 and arg_394_1.time_ < 0 + var_397_6 + arg_397_0 and not isNil(var_397_5) and arg_394_1.var_.characterEffect1015ui_story then
				arg_394_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_397_8 = 0
			local var_397_9 = 1.75

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_8 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_10 = arg_394_1:GetWordFromCfg(317012094)
				local var_397_11 = arg_394_1:FormatText(var_397_10.content)

				arg_394_1.text_.text = var_397_11

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_13 = 70 <= 0 and var_397_9 or var_397_9 * (utf8.len(var_397_11) / 70)

				if (70 <= 0 and var_397_9 or var_397_9 * (utf8.len(var_397_11) / 70)) > 0 and var_397_9 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_8 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_8
					end
				end

				arg_394_1.text_.text = var_397_11
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012094", "story_v_out_317012.awb") ~= 0 then
					local var_397_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012094", "story_v_out_317012.awb") / 1000

					if var_397_14 + var_397_8 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_14 + var_397_8
					end

					if var_397_10.prefab_name ~= "" and arg_394_1.actors_[var_397_10.prefab_name] ~= nil then
						local var_397_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_10.prefab_name].transform, "story_v_out_317012", "317012094", "story_v_out_317012.awb")

						arg_394_1:RecordAudio("317012094", var_397_15)
						arg_394_1:RecordAudio("317012094", var_397_15)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_317012", "317012094", "story_v_out_317012.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_317012", "317012094", "story_v_out_317012.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = math.max(var_397_9, arg_394_1.talkMaxDuration)

			if var_397_8 <= arg_394_1.time_ and arg_394_1.time_ < var_397_8 + var_397_16 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_8) / var_397_16

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_8 + var_397_16 and arg_394_1.time_ < var_397_8 + var_397_16 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play317012095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 317012095
		arg_398_1.duration_ = 10.77

		local var_398_0 = {
			zh = 10.766,
			ja = 9.6
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play317012096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_401_0 = 0
			local var_401_1 = 1.375

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(317012095)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 55 <= 0 and var_401_1 or var_401_1 * (utf8.len(var_401_3) / 55)

				if (55 <= 0 and var_401_1 or var_401_1 * (utf8.len(var_401_3) / 55)) > 0 and var_401_1 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012095", "story_v_out_317012.awb") ~= 0 then
					local var_401_6 = manager.audio:GetVoiceLength("story_v_out_317012", "317012095", "story_v_out_317012.awb") / 1000

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end

					if var_401_2.prefab_name ~= "" and arg_398_1.actors_[var_401_2.prefab_name] ~= nil then
						local var_401_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_2.prefab_name].transform, "story_v_out_317012", "317012095", "story_v_out_317012.awb")

						arg_398_1:RecordAudio("317012095", var_401_7)
						arg_398_1:RecordAudio("317012095", var_401_7)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_317012", "317012095", "story_v_out_317012.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_317012", "317012095", "story_v_out_317012.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play317012096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 317012096
		arg_402_1.duration_ = 12.23

		local var_402_0 = {
			zh = 9.566,
			ja = 12.233
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play317012097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_405_0 = 0
			local var_405_1 = 1.275

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_2 = arg_402_1:GetWordFromCfg(317012096)
				local var_405_3 = arg_402_1:FormatText(var_405_2.content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 51 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_3) / 51)

				if (51 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_3) / 51)) > 0 and var_405_1 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012096", "story_v_out_317012.awb") ~= 0 then
					local var_405_6 = manager.audio:GetVoiceLength("story_v_out_317012", "317012096", "story_v_out_317012.awb") / 1000

					if var_405_6 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_0
					end

					if var_405_2.prefab_name ~= "" and arg_402_1.actors_[var_405_2.prefab_name] ~= nil then
						local var_405_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_2.prefab_name].transform, "story_v_out_317012", "317012096", "story_v_out_317012.awb")

						arg_402_1:RecordAudio("317012096", var_405_7)
						arg_402_1:RecordAudio("317012096", var_405_7)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_317012", "317012096", "story_v_out_317012.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_317012", "317012096", "story_v_out_317012.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play317012097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 317012097
		arg_406_1.duration_ = 4.3

		local var_406_0 = {
			zh = 4.3,
			ja = 3
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play317012098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1015ui_story = arg_406_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_409_0 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 then
				arg_406_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_406_1.time_ - 0) / var_409_0)
				arg_406_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1015ui_story"].transform.position).z)
				arg_406_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1015ui_story"].transform.localEulerAngles = arg_406_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 then
				arg_406_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_406_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1015ui_story"].transform.position).z)
				arg_406_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1015ui_story"].transform.localEulerAngles = arg_406_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_409_1 = arg_406_1.actors_["1015ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_1) and arg_406_1.var_.characterEffect1015ui_story == nil then
				arg_406_1.var_.characterEffect1015ui_story = var_409_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_2 and not isNil(var_409_1) then
				if arg_406_1.var_.characterEffect1015ui_story and not isNil(var_409_1) then
					arg_406_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_2)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_2 and arg_406_1.time_ < 0 + var_409_2 + arg_409_0 and not isNil(var_409_1) and arg_406_1.var_.characterEffect1015ui_story then
				arg_406_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_409_3 = arg_406_1.actors_["2079ui_story"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos2079ui_story = var_409_3.localPosition
			end

			local var_409_4 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				var_409_3.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_406_1.time_ - 0) / var_409_4)
				var_409_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_3.position).x, (manager.ui.mainCamera.transform.position - var_409_3.position).y, (manager.ui.mainCamera.transform.position - var_409_3.position).z)
				var_409_3.localEulerAngles.z = 0
				var_409_3.localEulerAngles.x = 0
				var_409_3.localEulerAngles = var_409_3.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				var_409_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_409_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_3.position).x, (manager.ui.mainCamera.transform.position - var_409_3.position).y, (manager.ui.mainCamera.transform.position - var_409_3.position).z)
				var_409_3.localEulerAngles.z = 0
				var_409_3.localEulerAngles.x = 0
				var_409_3.localEulerAngles = var_409_3.localEulerAngles
			end

			local var_409_5 = arg_406_1.actors_["2079ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_5) and arg_406_1.var_.characterEffect2079ui_story == nil then
				arg_406_1.var_.characterEffect2079ui_story = var_409_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_6 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_6 and not isNil(var_409_5) then
				if arg_406_1.var_.characterEffect2079ui_story and not isNil(var_409_5) then
					arg_406_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_6 and arg_406_1.time_ < 0 + var_409_6 + arg_409_0 and not isNil(var_409_5) and arg_406_1.var_.characterEffect2079ui_story then
				arg_406_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_409_8 = arg_406_1.actors_["2078ui_story"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos2078ui_story = var_409_8.localPosition
			end

			local var_409_9 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_9 then
				var_409_8.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_406_1.time_ - 0) / var_409_9)
				var_409_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_8.position).x, (manager.ui.mainCamera.transform.position - var_409_8.position).y, (manager.ui.mainCamera.transform.position - var_409_8.position).z)
				var_409_8.localEulerAngles.z = 0
				var_409_8.localEulerAngles.x = 0
				var_409_8.localEulerAngles = var_409_8.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_9 and arg_406_1.time_ < 0 + var_409_9 + arg_409_0 then
				var_409_8.localPosition = Vector3.New(0, 100, 0)
				var_409_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_8.position).x, (manager.ui.mainCamera.transform.position - var_409_8.position).y, (manager.ui.mainCamera.transform.position - var_409_8.position).z)
				var_409_8.localEulerAngles.z = 0
				var_409_8.localEulerAngles.x = 0
				var_409_8.localEulerAngles = var_409_8.localEulerAngles
			end

			local var_409_10 = arg_406_1.actors_["2078ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_10) and arg_406_1.var_.characterEffect2078ui_story == nil then
				arg_406_1.var_.characterEffect2078ui_story = var_409_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_11 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_11 and not isNil(var_409_10) then
				if arg_406_1.var_.characterEffect2078ui_story and not isNil(var_409_10) then
					arg_406_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_406_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_11)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_11 and arg_406_1.time_ < 0 + var_409_11 + arg_409_0 and not isNil(var_409_10) and arg_406_1.var_.characterEffect2078ui_story then
				arg_406_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_406_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_409_12 = 0
			local var_409_13 = 0.275

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_12 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_14 = arg_406_1:GetWordFromCfg(317012097)
				local var_409_15 = arg_406_1:FormatText(var_409_14.content)

				arg_406_1.text_.text = var_409_15

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_17 = 11 <= 0 and var_409_13 or var_409_13 * (utf8.len(var_409_15) / 11)

				if (11 <= 0 and var_409_13 or var_409_13 * (utf8.len(var_409_15) / 11)) > 0 and var_409_13 < var_409_17 then
					arg_406_1.talkMaxDuration = var_409_17

					if var_409_17 + var_409_12 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_17 + var_409_12
					end
				end

				arg_406_1.text_.text = var_409_15
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012097", "story_v_out_317012.awb") ~= 0 then
					local var_409_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012097", "story_v_out_317012.awb") / 1000

					if var_409_18 + var_409_12 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_18 + var_409_12
					end

					if var_409_14.prefab_name ~= "" and arg_406_1.actors_[var_409_14.prefab_name] ~= nil then
						local var_409_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_14.prefab_name].transform, "story_v_out_317012", "317012097", "story_v_out_317012.awb")

						arg_406_1:RecordAudio("317012097", var_409_19)
						arg_406_1:RecordAudio("317012097", var_409_19)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_317012", "317012097", "story_v_out_317012.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_317012", "317012097", "story_v_out_317012.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_20 = math.max(var_409_13, arg_406_1.talkMaxDuration)

			if var_409_12 <= arg_406_1.time_ and arg_406_1.time_ < var_409_12 + var_409_20 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_12) / var_409_20

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_12 + var_409_20 and arg_406_1.time_ < var_409_12 + var_409_20 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play317012098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 317012098
		arg_410_1.duration_ = 4.93

		local var_410_0 = {
			zh = 4.166,
			ja = 4.933
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play317012099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1015ui_story = arg_410_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_413_0 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				arg_410_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_410_1.time_ - 0) / var_413_0)
				arg_410_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1015ui_story"].transform.position).z)
				arg_410_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1015ui_story"].transform.localEulerAngles = arg_410_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				arg_410_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_410_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1015ui_story"].transform.position).z)
				arg_410_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1015ui_story"].transform.localEulerAngles = arg_410_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_413_1 = arg_410_1.actors_["1015ui_story"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_1) and arg_410_1.var_.characterEffect1015ui_story == nil then
				arg_410_1.var_.characterEffect1015ui_story = var_413_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_2 and not isNil(var_413_1) then
				if arg_410_1.var_.characterEffect1015ui_story and not isNil(var_413_1) then
					arg_410_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_2 and arg_410_1.time_ < 0 + var_413_2 + arg_413_0 and not isNil(var_413_1) and arg_410_1.var_.characterEffect1015ui_story then
				arg_410_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_413_4 = arg_410_1.actors_["2079ui_story"].transform

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos2079ui_story = var_413_4.localPosition
			end

			local var_413_5 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_5 then
				var_413_4.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_410_1.time_ - 0) / var_413_5)
				var_413_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_413_4.position).x, (manager.ui.mainCamera.transform.position - var_413_4.position).y, (manager.ui.mainCamera.transform.position - var_413_4.position).z)
				var_413_4.localEulerAngles.z = 0
				var_413_4.localEulerAngles.x = 0
				var_413_4.localEulerAngles = var_413_4.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_5 and arg_410_1.time_ < 0 + var_413_5 + arg_413_0 then
				var_413_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_413_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_413_4.position).x, (manager.ui.mainCamera.transform.position - var_413_4.position).y, (manager.ui.mainCamera.transform.position - var_413_4.position).z)
				var_413_4.localEulerAngles.z = 0
				var_413_4.localEulerAngles.x = 0
				var_413_4.localEulerAngles = var_413_4.localEulerAngles
			end

			local var_413_6 = arg_410_1.actors_["2079ui_story"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_6) and arg_410_1.var_.characterEffect2079ui_story == nil then
				arg_410_1.var_.characterEffect2079ui_story = var_413_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_7 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 and not isNil(var_413_6) then
				if arg_410_1.var_.characterEffect2079ui_story and not isNil(var_413_6) then
					arg_410_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_410_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_7)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 and not isNil(var_413_6) and arg_410_1.var_.characterEffect2079ui_story then
				arg_410_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_410_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_413_8 = 0
			local var_413_9 = 0.525

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_10 = arg_410_1:GetWordFromCfg(317012098)
				local var_413_11 = arg_410_1:FormatText(var_413_10.content)

				arg_410_1.text_.text = var_413_11

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_13 = 21 <= 0 and var_413_9 or var_413_9 * (utf8.len(var_413_11) / 21)

				if (21 <= 0 and var_413_9 or var_413_9 * (utf8.len(var_413_11) / 21)) > 0 and var_413_9 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_8
					end
				end

				arg_410_1.text_.text = var_413_11
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012098", "story_v_out_317012.awb") ~= 0 then
					local var_413_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012098", "story_v_out_317012.awb") / 1000

					if var_413_14 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_14 + var_413_8
					end

					if var_413_10.prefab_name ~= "" and arg_410_1.actors_[var_413_10.prefab_name] ~= nil then
						local var_413_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_10.prefab_name].transform, "story_v_out_317012", "317012098", "story_v_out_317012.awb")

						arg_410_1:RecordAudio("317012098", var_413_15)
						arg_410_1:RecordAudio("317012098", var_413_15)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_317012", "317012098", "story_v_out_317012.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_317012", "317012098", "story_v_out_317012.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_16 = math.max(var_413_9, arg_410_1.talkMaxDuration)

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_16 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_8) / var_413_16

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_8 + var_413_16 and arg_410_1.time_ < var_413_8 + var_413_16 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play317012099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 317012099
		arg_414_1.duration_ = 1.8

		local var_414_0 = {
			zh = 1.533,
			ja = 1.8
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play317012100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1015ui_story = arg_414_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1015ui_story"].transform.position).z)
				arg_414_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1015ui_story"].transform.localEulerAngles = arg_414_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_414_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1015ui_story"].transform.position).z)
				arg_414_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1015ui_story"].transform.localEulerAngles = arg_414_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["1015ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect1015ui_story == nil then
				arg_414_1.var_.characterEffect1015ui_story = var_417_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_2 and not isNil(var_417_1) then
				if arg_414_1.var_.characterEffect1015ui_story and not isNil(var_417_1) then
					arg_414_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_2)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_2 and arg_414_1.time_ < 0 + var_417_2 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect1015ui_story then
				arg_414_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_417_3 = arg_414_1.actors_["2079ui_story"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos2079ui_story = var_417_3.localPosition
			end

			local var_417_4 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				var_417_3.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_414_1.time_ - 0) / var_417_4)
				var_417_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_3.position).x, (manager.ui.mainCamera.transform.position - var_417_3.position).y, (manager.ui.mainCamera.transform.position - var_417_3.position).z)
				var_417_3.localEulerAngles.z = 0
				var_417_3.localEulerAngles.x = 0
				var_417_3.localEulerAngles = var_417_3.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				var_417_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_417_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_3.position).x, (manager.ui.mainCamera.transform.position - var_417_3.position).y, (manager.ui.mainCamera.transform.position - var_417_3.position).z)
				var_417_3.localEulerAngles.z = 0
				var_417_3.localEulerAngles.x = 0
				var_417_3.localEulerAngles = var_417_3.localEulerAngles
			end

			local var_417_5 = arg_414_1.actors_["2079ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_5) and arg_414_1.var_.characterEffect2079ui_story == nil then
				arg_414_1.var_.characterEffect2079ui_story = var_417_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_6 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_6 and not isNil(var_417_5) then
				if arg_414_1.var_.characterEffect2079ui_story and not isNil(var_417_5) then
					arg_414_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_6 and arg_414_1.time_ < 0 + var_417_6 + arg_417_0 and not isNil(var_417_5) and arg_414_1.var_.characterEffect2079ui_story then
				arg_414_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_417_8 = 0
			local var_417_9 = 0.075

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(317012099)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_13 = 3 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 3)

				if (3 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 3)) > 0 and var_417_9 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012099", "story_v_out_317012.awb") ~= 0 then
					local var_417_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012099", "story_v_out_317012.awb") / 1000

					if var_417_14 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_8
					end

					if var_417_10.prefab_name ~= "" and arg_414_1.actors_[var_417_10.prefab_name] ~= nil then
						local var_417_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_10.prefab_name].transform, "story_v_out_317012", "317012099", "story_v_out_317012.awb")

						arg_414_1:RecordAudio("317012099", var_417_15)
						arg_414_1:RecordAudio("317012099", var_417_15)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_317012", "317012099", "story_v_out_317012.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_317012", "317012099", "story_v_out_317012.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_16 and arg_414_1.time_ < var_417_8 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play317012100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 317012100
		arg_418_1.duration_ = 5.43

		local var_418_0 = {
			zh = 5.433,
			ja = 4.366
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play317012101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos1015ui_story = arg_418_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_421_0 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 then
				arg_418_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_418_1.time_ - 0) / var_421_0)
				arg_418_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1015ui_story"].transform.position).z)
				arg_418_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1015ui_story"].transform.localEulerAngles = arg_418_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 then
				arg_418_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_418_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1015ui_story"].transform.position).z)
				arg_418_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1015ui_story"].transform.localEulerAngles = arg_418_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_421_1 = arg_418_1.actors_["1015ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1015ui_story == nil then
				arg_418_1.var_.characterEffect1015ui_story = var_421_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_2 and not isNil(var_421_1) then
				if arg_418_1.var_.characterEffect1015ui_story and not isNil(var_421_1) then
					arg_418_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_2 and arg_418_1.time_ < 0 + var_421_2 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1015ui_story then
				arg_418_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_421_4 = arg_418_1.actors_["2079ui_story"].transform

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos2079ui_story = var_421_4.localPosition
			end

			local var_421_5 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_5 then
				var_421_4.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_418_1.time_ - 0) / var_421_5)
				var_421_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_4.position).x, (manager.ui.mainCamera.transform.position - var_421_4.position).y, (manager.ui.mainCamera.transform.position - var_421_4.position).z)
				var_421_4.localEulerAngles.z = 0
				var_421_4.localEulerAngles.x = 0
				var_421_4.localEulerAngles = var_421_4.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_5 and arg_418_1.time_ < 0 + var_421_5 + arg_421_0 then
				var_421_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_421_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_4.position).x, (manager.ui.mainCamera.transform.position - var_421_4.position).y, (manager.ui.mainCamera.transform.position - var_421_4.position).z)
				var_421_4.localEulerAngles.z = 0
				var_421_4.localEulerAngles.x = 0
				var_421_4.localEulerAngles = var_421_4.localEulerAngles
			end

			local var_421_6 = arg_418_1.actors_["2079ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_6) and arg_418_1.var_.characterEffect2079ui_story == nil then
				arg_418_1.var_.characterEffect2079ui_story = var_421_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_7 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_7 and not isNil(var_421_6) then
				if arg_418_1.var_.characterEffect2079ui_story and not isNil(var_421_6) then
					arg_418_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_418_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_7)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_7 and arg_418_1.time_ < 0 + var_421_7 + arg_421_0 and not isNil(var_421_6) and arg_418_1.var_.characterEffect2079ui_story then
				arg_418_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_418_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_421_8 = 0
			local var_421_9 = 0.75

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_8 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_10 = arg_418_1:GetWordFromCfg(317012100)
				local var_421_11 = arg_418_1:FormatText(var_421_10.content)

				arg_418_1.text_.text = var_421_11

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_13 = 30 <= 0 and var_421_9 or var_421_9 * (utf8.len(var_421_11) / 30)

				if (30 <= 0 and var_421_9 or var_421_9 * (utf8.len(var_421_11) / 30)) > 0 and var_421_9 < var_421_13 then
					arg_418_1.talkMaxDuration = var_421_13

					if var_421_13 + var_421_8 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_13 + var_421_8
					end
				end

				arg_418_1.text_.text = var_421_11
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012100", "story_v_out_317012.awb") ~= 0 then
					local var_421_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012100", "story_v_out_317012.awb") / 1000

					if var_421_14 + var_421_8 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_14 + var_421_8
					end

					if var_421_10.prefab_name ~= "" and arg_418_1.actors_[var_421_10.prefab_name] ~= nil then
						local var_421_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_10.prefab_name].transform, "story_v_out_317012", "317012100", "story_v_out_317012.awb")

						arg_418_1:RecordAudio("317012100", var_421_15)
						arg_418_1:RecordAudio("317012100", var_421_15)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_317012", "317012100", "story_v_out_317012.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_317012", "317012100", "story_v_out_317012.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_16 = math.max(var_421_9, arg_418_1.talkMaxDuration)

			if var_421_8 <= arg_418_1.time_ and arg_418_1.time_ < var_421_8 + var_421_16 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_8) / var_421_16

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_8 + var_421_16 and arg_418_1.time_ < var_421_8 + var_421_16 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play317012101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 317012101
		arg_422_1.duration_ = 10.9

		local var_422_0 = {
			zh = 9.366,
			ja = 10.9
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play317012102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_425_0 = 0
			local var_425_1 = 1.325

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(317012101)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 53 <= 0 and var_425_1 or var_425_1 * (utf8.len(var_425_3) / 53)

				if (53 <= 0 and var_425_1 or var_425_1 * (utf8.len(var_425_3) / 53)) > 0 and var_425_1 < var_425_5 then
					arg_422_1.talkMaxDuration = var_425_5

					if var_425_5 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012101", "story_v_out_317012.awb") ~= 0 then
					local var_425_6 = manager.audio:GetVoiceLength("story_v_out_317012", "317012101", "story_v_out_317012.awb") / 1000

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end

					if var_425_2.prefab_name ~= "" and arg_422_1.actors_[var_425_2.prefab_name] ~= nil then
						local var_425_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_2.prefab_name].transform, "story_v_out_317012", "317012101", "story_v_out_317012.awb")

						arg_422_1:RecordAudio("317012101", var_425_7)
						arg_422_1:RecordAudio("317012101", var_425_7)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_317012", "317012101", "story_v_out_317012.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_317012", "317012101", "story_v_out_317012.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_8 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_8 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_8

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_8 and arg_422_1.time_ < var_425_0 + var_425_8 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play317012102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 317012102
		arg_426_1.duration_ = 5.4

		local var_426_0 = {
			zh = 3.633,
			ja = 5.4
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play317012103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos2078ui_story = arg_426_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["2078ui_story"].transform.position).z)
				arg_426_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["2078ui_story"].transform.localEulerAngles = arg_426_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_426_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["2078ui_story"].transform.position).z)
				arg_426_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["2078ui_story"].transform.localEulerAngles = arg_426_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_429_1 = arg_426_1.actors_["2078ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect2078ui_story == nil then
				arg_426_1.var_.characterEffect2078ui_story = var_429_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_2 and not isNil(var_429_1) then
				if arg_426_1.var_.characterEffect2078ui_story and not isNil(var_429_1) then
					arg_426_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_2 and arg_426_1.time_ < 0 + var_429_2 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect2078ui_story then
				arg_426_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_429_4 = arg_426_1.actors_["1015ui_story"].transform

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1015ui_story = var_429_4.localPosition
			end

			local var_429_5 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_5 then
				var_429_4.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_426_1.time_ - 0) / var_429_5)
				var_429_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_429_4.position).x, (manager.ui.mainCamera.transform.position - var_429_4.position).y, (manager.ui.mainCamera.transform.position - var_429_4.position).z)
				var_429_4.localEulerAngles.z = 0
				var_429_4.localEulerAngles.x = 0
				var_429_4.localEulerAngles = var_429_4.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_5 and arg_426_1.time_ < 0 + var_429_5 + arg_429_0 then
				var_429_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_429_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_429_4.position).x, (manager.ui.mainCamera.transform.position - var_429_4.position).y, (manager.ui.mainCamera.transform.position - var_429_4.position).z)
				var_429_4.localEulerAngles.z = 0
				var_429_4.localEulerAngles.x = 0
				var_429_4.localEulerAngles = var_429_4.localEulerAngles
			end

			local var_429_6 = arg_426_1.actors_["1015ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_6) and arg_426_1.var_.characterEffect1015ui_story == nil then
				arg_426_1.var_.characterEffect1015ui_story = var_429_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_7 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 and not isNil(var_429_6) then
				if arg_426_1.var_.characterEffect1015ui_story and not isNil(var_429_6) then
					arg_426_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_7)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 and not isNil(var_429_6) and arg_426_1.var_.characterEffect1015ui_story then
				arg_426_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_429_8 = arg_426_1.actors_["2079ui_story"].transform

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos2079ui_story = var_429_8.localPosition
			end

			local var_429_9 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_9 then
				var_429_8.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_426_1.time_ - 0) / var_429_9)
				var_429_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_429_8.position).x, (manager.ui.mainCamera.transform.position - var_429_8.position).y, (manager.ui.mainCamera.transform.position - var_429_8.position).z)
				var_429_8.localEulerAngles.z = 0
				var_429_8.localEulerAngles.x = 0
				var_429_8.localEulerAngles = var_429_8.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_9 and arg_426_1.time_ < 0 + var_429_9 + arg_429_0 then
				var_429_8.localPosition = Vector3.New(0, 100, 0)
				var_429_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_429_8.position).x, (manager.ui.mainCamera.transform.position - var_429_8.position).y, (manager.ui.mainCamera.transform.position - var_429_8.position).z)
				var_429_8.localEulerAngles.z = 0
				var_429_8.localEulerAngles.x = 0
				var_429_8.localEulerAngles = var_429_8.localEulerAngles
			end

			local var_429_10 = arg_426_1.actors_["2079ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_10) and arg_426_1.var_.characterEffect2079ui_story == nil then
				arg_426_1.var_.characterEffect2079ui_story = var_429_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_11 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_11 and not isNil(var_429_10) then
				if arg_426_1.var_.characterEffect2079ui_story and not isNil(var_429_10) then
					arg_426_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_426_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_11)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_11 and arg_426_1.time_ < 0 + var_429_11 + arg_429_0 and not isNil(var_429_10) and arg_426_1.var_.characterEffect2079ui_story then
				arg_426_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_426_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_429_12 = 0
			local var_429_13 = 0.375

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_12 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_14 = arg_426_1:GetWordFromCfg(317012102)
				local var_429_15 = arg_426_1:FormatText(var_429_14.content)

				arg_426_1.text_.text = var_429_15

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_17 = 15 <= 0 and var_429_13 or var_429_13 * (utf8.len(var_429_15) / 15)

				if (15 <= 0 and var_429_13 or var_429_13 * (utf8.len(var_429_15) / 15)) > 0 and var_429_13 < var_429_17 then
					arg_426_1.talkMaxDuration = var_429_17

					if var_429_17 + var_429_12 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_17 + var_429_12
					end
				end

				arg_426_1.text_.text = var_429_15
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012102", "story_v_out_317012.awb") ~= 0 then
					local var_429_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012102", "story_v_out_317012.awb") / 1000

					if var_429_18 + var_429_12 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_18 + var_429_12
					end

					if var_429_14.prefab_name ~= "" and arg_426_1.actors_[var_429_14.prefab_name] ~= nil then
						local var_429_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_14.prefab_name].transform, "story_v_out_317012", "317012102", "story_v_out_317012.awb")

						arg_426_1:RecordAudio("317012102", var_429_19)
						arg_426_1:RecordAudio("317012102", var_429_19)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_317012", "317012102", "story_v_out_317012.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_317012", "317012102", "story_v_out_317012.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_20 = math.max(var_429_13, arg_426_1.talkMaxDuration)

			if var_429_12 <= arg_426_1.time_ and arg_426_1.time_ < var_429_12 + var_429_20 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_12) / var_429_20

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_12 + var_429_20 and arg_426_1.time_ < var_429_12 + var_429_20 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play317012103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 317012103
		arg_430_1.duration_ = 11.43

		local var_430_0 = {
			zh = 11.433,
			ja = 8.333
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play317012104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos2078ui_story = arg_430_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["2078ui_story"].transform.position).z)
				arg_430_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["2078ui_story"].transform.localEulerAngles = arg_430_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_430_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["2078ui_story"].transform.position).z)
				arg_430_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["2078ui_story"].transform.localEulerAngles = arg_430_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["2078ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect2078ui_story == nil then
				arg_430_1.var_.characterEffect2078ui_story = var_433_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 and not isNil(var_433_1) then
				if arg_430_1.var_.characterEffect2078ui_story and not isNil(var_433_1) then
					arg_430_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_430_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_2)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect2078ui_story then
				arg_430_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_430_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_433_3 = arg_430_1.actors_["1015ui_story"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1015ui_story = var_433_3.localPosition
			end

			local var_433_4 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				var_433_3.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_430_1.time_ - 0) / var_433_4)
				var_433_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_3.position).x, (manager.ui.mainCamera.transform.position - var_433_3.position).y, (manager.ui.mainCamera.transform.position - var_433_3.position).z)
				var_433_3.localEulerAngles.z = 0
				var_433_3.localEulerAngles.x = 0
				var_433_3.localEulerAngles = var_433_3.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				var_433_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_433_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_3.position).x, (manager.ui.mainCamera.transform.position - var_433_3.position).y, (manager.ui.mainCamera.transform.position - var_433_3.position).z)
				var_433_3.localEulerAngles.z = 0
				var_433_3.localEulerAngles.x = 0
				var_433_3.localEulerAngles = var_433_3.localEulerAngles
			end

			local var_433_5 = arg_430_1.actors_["1015ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_5) and arg_430_1.var_.characterEffect1015ui_story == nil then
				arg_430_1.var_.characterEffect1015ui_story = var_433_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_6 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_6 and not isNil(var_433_5) then
				if arg_430_1.var_.characterEffect1015ui_story and not isNil(var_433_5) then
					arg_430_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_6 and arg_430_1.time_ < 0 + var_433_6 + arg_433_0 and not isNil(var_433_5) and arg_430_1.var_.characterEffect1015ui_story then
				arg_430_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_433_8 = 0
			local var_433_9 = 1.275

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_8 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_10 = arg_430_1:GetWordFromCfg(317012103)
				local var_433_11 = arg_430_1:FormatText(var_433_10.content)

				arg_430_1.text_.text = var_433_11

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_13 = 51 <= 0 and var_433_9 or var_433_9 * (utf8.len(var_433_11) / 51)

				if (51 <= 0 and var_433_9 or var_433_9 * (utf8.len(var_433_11) / 51)) > 0 and var_433_9 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_8 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_8
					end
				end

				arg_430_1.text_.text = var_433_11
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012103", "story_v_out_317012.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012103", "story_v_out_317012.awb") / 1000

					if var_433_14 + var_433_8 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_8
					end

					if var_433_10.prefab_name ~= "" and arg_430_1.actors_[var_433_10.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_10.prefab_name].transform, "story_v_out_317012", "317012103", "story_v_out_317012.awb")

						arg_430_1:RecordAudio("317012103", var_433_15)
						arg_430_1:RecordAudio("317012103", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_317012", "317012103", "story_v_out_317012.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_317012", "317012103", "story_v_out_317012.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_9, arg_430_1.talkMaxDuration)

			if var_433_8 <= arg_430_1.time_ and arg_430_1.time_ < var_433_8 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_8) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_8 + var_433_16 and arg_430_1.time_ < var_433_8 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play317012104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 317012104
		arg_434_1.duration_ = 5.1

		local var_434_0 = {
			zh = 5.1,
			ja = 4.666
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play317012105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos2078ui_story = arg_434_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["2078ui_story"].transform.position).z)
				arg_434_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["2078ui_story"].transform.localEulerAngles = arg_434_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_434_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["2078ui_story"].transform.position).z)
				arg_434_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["2078ui_story"].transform.localEulerAngles = arg_434_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_437_1 = arg_434_1.actors_["2078ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect2078ui_story == nil then
				arg_434_1.var_.characterEffect2078ui_story = var_437_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 and not isNil(var_437_1) then
				if arg_434_1.var_.characterEffect2078ui_story and not isNil(var_437_1) then
					arg_434_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect2078ui_story then
				arg_434_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_437_4 = arg_434_1.actors_["1015ui_story"].transform

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1015ui_story = var_437_4.localPosition
			end

			local var_437_5 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_5 then
				var_437_4.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_434_1.time_ - 0) / var_437_5)
				var_437_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_4.position).x, (manager.ui.mainCamera.transform.position - var_437_4.position).y, (manager.ui.mainCamera.transform.position - var_437_4.position).z)
				var_437_4.localEulerAngles.z = 0
				var_437_4.localEulerAngles.x = 0
				var_437_4.localEulerAngles = var_437_4.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_5 and arg_434_1.time_ < 0 + var_437_5 + arg_437_0 then
				var_437_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_437_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_4.position).x, (manager.ui.mainCamera.transform.position - var_437_4.position).y, (manager.ui.mainCamera.transform.position - var_437_4.position).z)
				var_437_4.localEulerAngles.z = 0
				var_437_4.localEulerAngles.x = 0
				var_437_4.localEulerAngles = var_437_4.localEulerAngles
			end

			local var_437_6 = arg_434_1.actors_["1015ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_6) and arg_434_1.var_.characterEffect1015ui_story == nil then
				arg_434_1.var_.characterEffect1015ui_story = var_437_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_7 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 and not isNil(var_437_6) then
				if arg_434_1.var_.characterEffect1015ui_story and not isNil(var_437_6) then
					arg_434_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_7)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 and not isNil(var_437_6) and arg_434_1.var_.characterEffect1015ui_story then
				arg_434_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_437_8 = 0
			local var_437_9 = 0.55

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_8 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_10 = arg_434_1:GetWordFromCfg(317012104)
				local var_437_11 = arg_434_1:FormatText(var_437_10.content)

				arg_434_1.text_.text = var_437_11

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_13 = 22 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 22)

				if (22 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 22)) > 0 and var_437_9 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_8
					end
				end

				arg_434_1.text_.text = var_437_11
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012104", "story_v_out_317012.awb") ~= 0 then
					local var_437_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012104", "story_v_out_317012.awb") / 1000

					if var_437_14 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_8
					end

					if var_437_10.prefab_name ~= "" and arg_434_1.actors_[var_437_10.prefab_name] ~= nil then
						local var_437_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_10.prefab_name].transform, "story_v_out_317012", "317012104", "story_v_out_317012.awb")

						arg_434_1:RecordAudio("317012104", var_437_15)
						arg_434_1:RecordAudio("317012104", var_437_15)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_317012", "317012104", "story_v_out_317012.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_317012", "317012104", "story_v_out_317012.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_9, arg_434_1.talkMaxDuration)

			if var_437_8 <= arg_434_1.time_ and arg_434_1.time_ < var_437_8 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_8) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_8 + var_437_16 and arg_434_1.time_ < var_437_8 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play317012105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 317012105
		arg_438_1.duration_ = 11.3

		local var_438_0 = {
			zh = 11.3,
			ja = 11
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play317012106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos2078ui_story = arg_438_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_441_0 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 then
				arg_438_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_438_1.time_ - 0) / var_441_0)
				arg_438_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["2078ui_story"].transform.position).z)
				arg_438_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["2078ui_story"].transform.localEulerAngles = arg_438_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 then
				arg_438_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_438_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["2078ui_story"].transform.position).z)
				arg_438_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["2078ui_story"].transform.localEulerAngles = arg_438_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_441_1 = arg_438_1.actors_["2078ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect2078ui_story == nil then
				arg_438_1.var_.characterEffect2078ui_story = var_441_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_2 and not isNil(var_441_1) then
				if arg_438_1.var_.characterEffect2078ui_story and not isNil(var_441_1) then
					arg_438_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_438_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_2)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_2 and arg_438_1.time_ < 0 + var_441_2 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect2078ui_story then
				arg_438_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_438_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_441_3 = arg_438_1.actors_["1015ui_story"].transform

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1015ui_story = var_441_3.localPosition
			end

			local var_441_4 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 then
				var_441_3.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_438_1.time_ - 0) / var_441_4)
				var_441_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_441_3.position).x, (manager.ui.mainCamera.transform.position - var_441_3.position).y, (manager.ui.mainCamera.transform.position - var_441_3.position).z)
				var_441_3.localEulerAngles.z = 0
				var_441_3.localEulerAngles.x = 0
				var_441_3.localEulerAngles = var_441_3.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 then
				var_441_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_441_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_441_3.position).x, (manager.ui.mainCamera.transform.position - var_441_3.position).y, (manager.ui.mainCamera.transform.position - var_441_3.position).z)
				var_441_3.localEulerAngles.z = 0
				var_441_3.localEulerAngles.x = 0
				var_441_3.localEulerAngles = var_441_3.localEulerAngles
			end

			local var_441_5 = arg_438_1.actors_["1015ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_5) and arg_438_1.var_.characterEffect1015ui_story == nil then
				arg_438_1.var_.characterEffect1015ui_story = var_441_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_6 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_6 and not isNil(var_441_5) then
				if arg_438_1.var_.characterEffect1015ui_story and not isNil(var_441_5) then
					arg_438_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_6 and arg_438_1.time_ < 0 + var_441_6 + arg_441_0 and not isNil(var_441_5) and arg_438_1.var_.characterEffect1015ui_story then
				arg_438_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_441_8 = 0
			local var_441_9 = 1.325

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_8 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_10 = arg_438_1:GetWordFromCfg(317012105)
				local var_441_11 = arg_438_1:FormatText(var_441_10.content)

				arg_438_1.text_.text = var_441_11

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_13 = 53 <= 0 and var_441_9 or var_441_9 * (utf8.len(var_441_11) / 53)

				if (53 <= 0 and var_441_9 or var_441_9 * (utf8.len(var_441_11) / 53)) > 0 and var_441_9 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_8 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_8
					end
				end

				arg_438_1.text_.text = var_441_11
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012105", "story_v_out_317012.awb") ~= 0 then
					local var_441_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012105", "story_v_out_317012.awb") / 1000

					if var_441_14 + var_441_8 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_14 + var_441_8
					end

					if var_441_10.prefab_name ~= "" and arg_438_1.actors_[var_441_10.prefab_name] ~= nil then
						local var_441_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_10.prefab_name].transform, "story_v_out_317012", "317012105", "story_v_out_317012.awb")

						arg_438_1:RecordAudio("317012105", var_441_15)
						arg_438_1:RecordAudio("317012105", var_441_15)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_317012", "317012105", "story_v_out_317012.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_317012", "317012105", "story_v_out_317012.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_16 = math.max(var_441_9, arg_438_1.talkMaxDuration)

			if var_441_8 <= arg_438_1.time_ and arg_438_1.time_ < var_441_8 + var_441_16 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_8) / var_441_16

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_8 + var_441_16 and arg_438_1.time_ < var_441_8 + var_441_16 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play317012106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 317012106
		arg_442_1.duration_ = 1.9

		local var_442_0 = {
			zh = 1.3,
			ja = 1.9
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play317012107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos2078ui_story = arg_442_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["2078ui_story"].transform.position).z)
				arg_442_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["2078ui_story"].transform.localEulerAngles = arg_442_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_442_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["2078ui_story"].transform.position).z)
				arg_442_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["2078ui_story"].transform.localEulerAngles = arg_442_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["2078ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect2078ui_story == nil then
				arg_442_1.var_.characterEffect2078ui_story = var_445_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 and not isNil(var_445_1) then
				if arg_442_1.var_.characterEffect2078ui_story and not isNil(var_445_1) then
					arg_442_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect2078ui_story then
				arg_442_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_445_4 = arg_442_1.actors_["1015ui_story"].transform

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1015ui_story = var_445_4.localPosition
			end

			local var_445_5 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_5 then
				var_445_4.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_442_1.time_ - 0) / var_445_5)
				var_445_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_4.position).x, (manager.ui.mainCamera.transform.position - var_445_4.position).y, (manager.ui.mainCamera.transform.position - var_445_4.position).z)
				var_445_4.localEulerAngles.z = 0
				var_445_4.localEulerAngles.x = 0
				var_445_4.localEulerAngles = var_445_4.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_5 and arg_442_1.time_ < 0 + var_445_5 + arg_445_0 then
				var_445_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_445_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_4.position).x, (manager.ui.mainCamera.transform.position - var_445_4.position).y, (manager.ui.mainCamera.transform.position - var_445_4.position).z)
				var_445_4.localEulerAngles.z = 0
				var_445_4.localEulerAngles.x = 0
				var_445_4.localEulerAngles = var_445_4.localEulerAngles
			end

			local var_445_6 = arg_442_1.actors_["1015ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_6) and arg_442_1.var_.characterEffect1015ui_story == nil then
				arg_442_1.var_.characterEffect1015ui_story = var_445_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_7 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 and not isNil(var_445_6) then
				if arg_442_1.var_.characterEffect1015ui_story and not isNil(var_445_6) then
					arg_442_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_442_1.time_ - 0) / var_445_7)
				end
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 and not isNil(var_445_6) and arg_442_1.var_.characterEffect1015ui_story then
				arg_442_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_445_8 = 0
			local var_445_9 = 0.075

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_10 = arg_442_1:GetWordFromCfg(317012106)
				local var_445_11 = arg_442_1:FormatText(var_445_10.content)

				arg_442_1.text_.text = var_445_11

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 3 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 3)

				if (3 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 3)) > 0 and var_445_9 < var_445_13 then
					arg_442_1.talkMaxDuration = var_445_13

					if var_445_13 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_11
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012106", "story_v_out_317012.awb") ~= 0 then
					local var_445_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012106", "story_v_out_317012.awb") / 1000

					if var_445_14 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_14 + var_445_8
					end

					if var_445_10.prefab_name ~= "" and arg_442_1.actors_[var_445_10.prefab_name] ~= nil then
						local var_445_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_10.prefab_name].transform, "story_v_out_317012", "317012106", "story_v_out_317012.awb")

						arg_442_1:RecordAudio("317012106", var_445_15)
						arg_442_1:RecordAudio("317012106", var_445_15)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_317012", "317012106", "story_v_out_317012.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_317012", "317012106", "story_v_out_317012.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_16 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_16 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_16

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_16 and arg_442_1.time_ < var_445_8 + var_445_16 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play317012107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 317012107
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play317012108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["2078ui_story"]) and arg_446_1.var_.characterEffect2078ui_story == nil then
				arg_446_1.var_.characterEffect2078ui_story = arg_446_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["2078ui_story"]) then
				if arg_446_1.var_.characterEffect2078ui_story and not isNil(arg_446_1.actors_["2078ui_story"]) then
					arg_446_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_446_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_0)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["2078ui_story"]) and arg_446_1.var_.characterEffect2078ui_story then
				arg_446_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_446_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_449_1 = 0
			local var_449_2 = 0.9

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_3 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(317012107).content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 36 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_3) / 36)

				if (36 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_3) / 36)) > 0 and var_449_2 < var_449_5 then
					arg_446_1.talkMaxDuration = var_449_5

					if var_449_5 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + var_449_1
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_6 = math.max(var_449_2, arg_446_1.talkMaxDuration)

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_6 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_1) / var_449_6

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_1 + var_449_6 and arg_446_1.time_ < var_449_1 + var_449_6 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play317012108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 317012108
		arg_450_1.duration_ = 8.83

		local var_450_0 = {
			zh = 7.533,
			ja = 8.833
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play317012109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos2078ui_story = arg_450_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_453_0 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 then
				arg_450_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_450_1.time_ - 0) / var_453_0)
				arg_450_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["2078ui_story"].transform.position).z)
				arg_450_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["2078ui_story"].transform.localEulerAngles = arg_450_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 then
				arg_450_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_450_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["2078ui_story"].transform.position).z)
				arg_450_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["2078ui_story"].transform.localEulerAngles = arg_450_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_453_1 = arg_450_1.actors_["2078ui_story"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_1) and arg_450_1.var_.characterEffect2078ui_story == nil then
				arg_450_1.var_.characterEffect2078ui_story = var_453_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_2 and not isNil(var_453_1) then
				if arg_450_1.var_.characterEffect2078ui_story and not isNil(var_453_1) then
					arg_450_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_450_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_2)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_2 and arg_450_1.time_ < 0 + var_453_2 + arg_453_0 and not isNil(var_453_1) and arg_450_1.var_.characterEffect2078ui_story then
				arg_450_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_450_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_453_3 = arg_450_1.actors_["1015ui_story"].transform

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1015ui_story = var_453_3.localPosition
			end

			local var_453_4 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 then
				var_453_3.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_450_1.time_ - 0) / var_453_4)
				var_453_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_453_3.position).x, (manager.ui.mainCamera.transform.position - var_453_3.position).y, (manager.ui.mainCamera.transform.position - var_453_3.position).z)
				var_453_3.localEulerAngles.z = 0
				var_453_3.localEulerAngles.x = 0
				var_453_3.localEulerAngles = var_453_3.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 then
				var_453_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_453_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_453_3.position).x, (manager.ui.mainCamera.transform.position - var_453_3.position).y, (manager.ui.mainCamera.transform.position - var_453_3.position).z)
				var_453_3.localEulerAngles.z = 0
				var_453_3.localEulerAngles.x = 0
				var_453_3.localEulerAngles = var_453_3.localEulerAngles
			end

			local var_453_5 = arg_450_1.actors_["1015ui_story"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_5) and arg_450_1.var_.characterEffect1015ui_story == nil then
				arg_450_1.var_.characterEffect1015ui_story = var_453_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_6 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_6 and not isNil(var_453_5) then
				if arg_450_1.var_.characterEffect1015ui_story and not isNil(var_453_5) then
					arg_450_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= 0 + var_453_6 and arg_450_1.time_ < 0 + var_453_6 + arg_453_0 and not isNil(var_453_5) and arg_450_1.var_.characterEffect1015ui_story then
				arg_450_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_453_8 = 0
			local var_453_9 = 0.975

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_10 = arg_450_1:GetWordFromCfg(317012108)
				local var_453_11 = arg_450_1:FormatText(var_453_10.content)

				arg_450_1.text_.text = var_453_11

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 39 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 39)

				if (39 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 39)) > 0 and var_453_9 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_11
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012108", "story_v_out_317012.awb") ~= 0 then
					local var_453_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012108", "story_v_out_317012.awb") / 1000

					if var_453_14 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_14 + var_453_8
					end

					if var_453_10.prefab_name ~= "" and arg_450_1.actors_[var_453_10.prefab_name] ~= nil then
						local var_453_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_10.prefab_name].transform, "story_v_out_317012", "317012108", "story_v_out_317012.awb")

						arg_450_1:RecordAudio("317012108", var_453_15)
						arg_450_1:RecordAudio("317012108", var_453_15)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_317012", "317012108", "story_v_out_317012.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_317012", "317012108", "story_v_out_317012.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_16 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_16 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_16

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_16 and arg_450_1.time_ < var_453_8 + var_453_16 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play317012109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 317012109
		arg_454_1.duration_ = 1

		local var_454_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play317012110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1015ui_story = arg_454_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_457_0 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 then
				arg_454_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_454_1.time_ - 0) / var_457_0)
				arg_454_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_454_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1015ui_story"].transform.position).z)
				arg_454_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_454_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_454_1.actors_["1015ui_story"].transform.localEulerAngles = arg_454_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 then
				arg_454_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_454_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_454_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1015ui_story"].transform.position).z)
				arg_454_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_454_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_454_1.actors_["1015ui_story"].transform.localEulerAngles = arg_454_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_457_1 = arg_454_1.actors_["1015ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_1) and arg_454_1.var_.characterEffect1015ui_story == nil then
				arg_454_1.var_.characterEffect1015ui_story = var_457_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_2 and not isNil(var_457_1) then
				if arg_454_1.var_.characterEffect1015ui_story and not isNil(var_457_1) then
					arg_454_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_454_1.time_ - 0) / var_457_2)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_2 and arg_454_1.time_ < 0 + var_457_2 + arg_457_0 and not isNil(var_457_1) and arg_454_1.var_.characterEffect1015ui_story then
				arg_454_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_457_3 = arg_454_1.actors_["2078ui_story"].transform

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos2078ui_story = var_457_3.localPosition
			end

			local var_457_4 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				var_457_3.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_454_1.time_ - 0) / var_457_4)
				var_457_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_3.position).x, (manager.ui.mainCamera.transform.position - var_457_3.position).y, (manager.ui.mainCamera.transform.position - var_457_3.position).z)
				var_457_3.localEulerAngles.z = 0
				var_457_3.localEulerAngles.x = 0
				var_457_3.localEulerAngles = var_457_3.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				var_457_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_457_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_3.position).x, (manager.ui.mainCamera.transform.position - var_457_3.position).y, (manager.ui.mainCamera.transform.position - var_457_3.position).z)
				var_457_3.localEulerAngles.z = 0
				var_457_3.localEulerAngles.x = 0
				var_457_3.localEulerAngles = var_457_3.localEulerAngles
			end

			local var_457_5 = arg_454_1.actors_["2078ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_5) and arg_454_1.var_.characterEffect2078ui_story == nil then
				arg_454_1.var_.characterEffect2078ui_story = var_457_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_6 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_6 and not isNil(var_457_5) then
				if arg_454_1.var_.characterEffect2078ui_story and not isNil(var_457_5) then
					arg_454_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_6 and arg_454_1.time_ < 0 + var_457_6 + arg_457_0 and not isNil(var_457_5) and arg_454_1.var_.characterEffect2078ui_story then
				arg_454_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_457_8 = 0
			local var_457_9 = 0.075

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_8 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_10 = arg_454_1:GetWordFromCfg(317012109)
				local var_457_11 = arg_454_1:FormatText(var_457_10.content)

				arg_454_1.text_.text = var_457_11

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_13 = 3 <= 0 and var_457_9 or var_457_9 * (utf8.len(var_457_11) / 3)

				if (3 <= 0 and var_457_9 or var_457_9 * (utf8.len(var_457_11) / 3)) > 0 and var_457_9 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_8
					end
				end

				arg_454_1.text_.text = var_457_11
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012109", "story_v_out_317012.awb") ~= 0 then
					local var_457_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012109", "story_v_out_317012.awb") / 1000

					if var_457_14 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_14 + var_457_8
					end

					if var_457_10.prefab_name ~= "" and arg_454_1.actors_[var_457_10.prefab_name] ~= nil then
						local var_457_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_10.prefab_name].transform, "story_v_out_317012", "317012109", "story_v_out_317012.awb")

						arg_454_1:RecordAudio("317012109", var_457_15)
						arg_454_1:RecordAudio("317012109", var_457_15)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_317012", "317012109", "story_v_out_317012.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_317012", "317012109", "story_v_out_317012.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_16 = math.max(var_457_9, arg_454_1.talkMaxDuration)

			if var_457_8 <= arg_454_1.time_ and arg_454_1.time_ < var_457_8 + var_457_16 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_8) / var_457_16

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_8 + var_457_16 and arg_454_1.time_ < var_457_8 + var_457_16 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play317012110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 317012110
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play317012111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["2078ui_story"]) and arg_458_1.var_.characterEffect2078ui_story == nil then
				arg_458_1.var_.characterEffect2078ui_story = arg_458_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["2078ui_story"]) then
				if arg_458_1.var_.characterEffect2078ui_story and not isNil(arg_458_1.actors_["2078ui_story"]) then
					arg_458_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_458_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["2078ui_story"]) and arg_458_1.var_.characterEffect2078ui_story then
				arg_458_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_458_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.625

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(317012110).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 25 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 25)

				if (25 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 25)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play317012111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 317012111
		arg_462_1.duration_ = 5.3

		local var_462_0 = {
			zh = 1.333,
			ja = 5.3
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play317012112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos2078ui_story = arg_462_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_465_0 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 then
				arg_462_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_462_1.time_ - 0) / var_465_0)
				arg_462_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["2078ui_story"].transform.position).z)
				arg_462_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["2078ui_story"].transform.localEulerAngles = arg_462_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 then
				arg_462_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_462_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["2078ui_story"].transform.position).z)
				arg_462_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["2078ui_story"].transform.localEulerAngles = arg_462_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_465_1 = arg_462_1.actors_["2078ui_story"]

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(var_465_1) and arg_462_1.var_.characterEffect2078ui_story == nil then
				arg_462_1.var_.characterEffect2078ui_story = var_465_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_2 and not isNil(var_465_1) then
				if arg_462_1.var_.characterEffect2078ui_story and not isNil(var_465_1) then
					arg_462_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_462_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_462_1.time_ - 0) / var_465_2)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_2 and arg_462_1.time_ < 0 + var_465_2 + arg_465_0 and not isNil(var_465_1) and arg_462_1.var_.characterEffect2078ui_story then
				arg_462_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_462_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_465_3 = arg_462_1.actors_["1015ui_story"].transform

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos1015ui_story = var_465_3.localPosition
			end

			local var_465_4 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				var_465_3.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_462_1.time_ - 0) / var_465_4)
				var_465_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_465_3.position).x, (manager.ui.mainCamera.transform.position - var_465_3.position).y, (manager.ui.mainCamera.transform.position - var_465_3.position).z)
				var_465_3.localEulerAngles.z = 0
				var_465_3.localEulerAngles.x = 0
				var_465_3.localEulerAngles = var_465_3.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				var_465_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_465_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_465_3.position).x, (manager.ui.mainCamera.transform.position - var_465_3.position).y, (manager.ui.mainCamera.transform.position - var_465_3.position).z)
				var_465_3.localEulerAngles.z = 0
				var_465_3.localEulerAngles.x = 0
				var_465_3.localEulerAngles = var_465_3.localEulerAngles
			end

			local var_465_5 = arg_462_1.actors_["1015ui_story"]

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(var_465_5) and arg_462_1.var_.characterEffect1015ui_story == nil then
				arg_462_1.var_.characterEffect1015ui_story = var_465_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_6 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_6 and not isNil(var_465_5) then
				if arg_462_1.var_.characterEffect1015ui_story and not isNil(var_465_5) then
					arg_462_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_6 and arg_462_1.time_ < 0 + var_465_6 + arg_465_0 and not isNil(var_465_5) and arg_462_1.var_.characterEffect1015ui_story then
				arg_462_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_465_8 = 0
			local var_465_9 = 0.125

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_8 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_10 = arg_462_1:GetWordFromCfg(317012111)
				local var_465_11 = arg_462_1:FormatText(var_465_10.content)

				arg_462_1.text_.text = var_465_11

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_13 = 5 <= 0 and var_465_9 or var_465_9 * (utf8.len(var_465_11) / 5)

				if (5 <= 0 and var_465_9 or var_465_9 * (utf8.len(var_465_11) / 5)) > 0 and var_465_9 < var_465_13 then
					arg_462_1.talkMaxDuration = var_465_13

					if var_465_13 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_13 + var_465_8
					end
				end

				arg_462_1.text_.text = var_465_11
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012111", "story_v_out_317012.awb") ~= 0 then
					local var_465_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012111", "story_v_out_317012.awb") / 1000

					if var_465_14 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_14 + var_465_8
					end

					if var_465_10.prefab_name ~= "" and arg_462_1.actors_[var_465_10.prefab_name] ~= nil then
						local var_465_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_10.prefab_name].transform, "story_v_out_317012", "317012111", "story_v_out_317012.awb")

						arg_462_1:RecordAudio("317012111", var_465_15)
						arg_462_1:RecordAudio("317012111", var_465_15)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_317012", "317012111", "story_v_out_317012.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_317012", "317012111", "story_v_out_317012.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_16 = math.max(var_465_9, arg_462_1.talkMaxDuration)

			if var_465_8 <= arg_462_1.time_ and arg_462_1.time_ < var_465_8 + var_465_16 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_8) / var_465_16

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_8 + var_465_16 and arg_462_1.time_ < var_465_8 + var_465_16 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play317012112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 317012112
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play317012113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1015ui_story"]) and arg_466_1.var_.characterEffect1015ui_story == nil then
				arg_466_1.var_.characterEffect1015ui_story = arg_466_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1015ui_story"]) then
				if arg_466_1.var_.characterEffect1015ui_story and not isNil(arg_466_1.actors_["1015ui_story"]) then
					arg_466_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1015ui_story"]) and arg_466_1.var_.characterEffect1015ui_story then
				arg_466_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 1.175

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_3 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(317012112).content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 47 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 47)

				if (47 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 47)) > 0 and var_469_2 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_6 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_6 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_6

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_6 and arg_466_1.time_ < var_469_1 + var_469_6 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play317012113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 317012113
		arg_470_1.duration_ = 11.67

		local var_470_0 = {
			zh = 11.666,
			ja = 3.466
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play317012114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos2078ui_story = arg_470_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["2078ui_story"].transform.position).z)
				arg_470_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["2078ui_story"].transform.localEulerAngles = arg_470_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_470_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["2078ui_story"].transform.position).z)
				arg_470_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["2078ui_story"].transform.localEulerAngles = arg_470_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["2078ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect2078ui_story == nil then
				arg_470_1.var_.characterEffect2078ui_story = var_473_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 and not isNil(var_473_1) then
				if arg_470_1.var_.characterEffect2078ui_story and not isNil(var_473_1) then
					arg_470_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect2078ui_story then
				arg_470_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_473_4 = arg_470_1.actors_["1015ui_story"].transform

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1015ui_story = var_473_4.localPosition
			end

			local var_473_5 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_5 then
				var_473_4.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_5)
				var_473_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_4.position).x, (manager.ui.mainCamera.transform.position - var_473_4.position).y, (manager.ui.mainCamera.transform.position - var_473_4.position).z)
				var_473_4.localEulerAngles.z = 0
				var_473_4.localEulerAngles.x = 0
				var_473_4.localEulerAngles = var_473_4.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_5 and arg_470_1.time_ < 0 + var_473_5 + arg_473_0 then
				var_473_4.localPosition = Vector3.New(0, 100, 0)
				var_473_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_4.position).x, (manager.ui.mainCamera.transform.position - var_473_4.position).y, (manager.ui.mainCamera.transform.position - var_473_4.position).z)
				var_473_4.localEulerAngles.z = 0
				var_473_4.localEulerAngles.x = 0
				var_473_4.localEulerAngles = var_473_4.localEulerAngles
			end

			local var_473_6 = arg_470_1.actors_["1015ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_6) and arg_470_1.var_.characterEffect1015ui_story == nil then
				arg_470_1.var_.characterEffect1015ui_story = var_473_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_7 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 and not isNil(var_473_6) then
				if arg_470_1.var_.characterEffect1015ui_story and not isNil(var_473_6) then
					arg_470_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_7)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 and not isNil(var_473_6) and arg_470_1.var_.characterEffect1015ui_story then
				arg_470_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_473_8 = 0
			local var_473_9 = 1.475

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_8 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_10 = arg_470_1:GetWordFromCfg(317012113)
				local var_473_11 = arg_470_1:FormatText(var_473_10.content)

				arg_470_1.text_.text = var_473_11

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_13 = 59 <= 0 and var_473_9 or var_473_9 * (utf8.len(var_473_11) / 59)

				if (59 <= 0 and var_473_9 or var_473_9 * (utf8.len(var_473_11) / 59)) > 0 and var_473_9 < var_473_13 then
					arg_470_1.talkMaxDuration = var_473_13

					if var_473_13 + var_473_8 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_13 + var_473_8
					end
				end

				arg_470_1.text_.text = var_473_11
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012113", "story_v_out_317012.awb") ~= 0 then
					local var_473_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012113", "story_v_out_317012.awb") / 1000

					if var_473_14 + var_473_8 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_14 + var_473_8
					end

					if var_473_10.prefab_name ~= "" and arg_470_1.actors_[var_473_10.prefab_name] ~= nil then
						local var_473_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_10.prefab_name].transform, "story_v_out_317012", "317012113", "story_v_out_317012.awb")

						arg_470_1:RecordAudio("317012113", var_473_15)
						arg_470_1:RecordAudio("317012113", var_473_15)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_317012", "317012113", "story_v_out_317012.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_317012", "317012113", "story_v_out_317012.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_16 = math.max(var_473_9, arg_470_1.talkMaxDuration)

			if var_473_8 <= arg_470_1.time_ and arg_470_1.time_ < var_473_8 + var_473_16 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_8) / var_473_16

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_8 + var_473_16 and arg_470_1.time_ < var_473_8 + var_473_16 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play317012114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 317012114
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play317012115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["2078ui_story"]) and arg_474_1.var_.characterEffect2078ui_story == nil then
				arg_474_1.var_.characterEffect2078ui_story = arg_474_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_0 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["2078ui_story"]) then
				if arg_474_1.var_.characterEffect2078ui_story and not isNil(arg_474_1.actors_["2078ui_story"]) then
					arg_474_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_474_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_0)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["2078ui_story"]) and arg_474_1.var_.characterEffect2078ui_story then
				arg_474_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_474_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_477_1 = 0
			local var_477_2 = 0.625

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_3 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(317012114).content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 25 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 25)

				if (25 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 25)) > 0 and var_477_2 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_6 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_6 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_6

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_6 and arg_474_1.time_ < var_477_1 + var_477_6 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play317012115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 317012115
		arg_478_1.duration_ = 4.07

		local var_478_0 = {
			zh = 3.866,
			ja = 4.066
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play317012116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos2078ui_story = arg_478_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_481_0 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 then
				arg_478_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_478_1.time_ - 0) / var_481_0)
				arg_478_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["2078ui_story"].transform.position).z)
				arg_478_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["2078ui_story"].transform.localEulerAngles = arg_478_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 then
				arg_478_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_478_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["2078ui_story"].transform.position).z)
				arg_478_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["2078ui_story"].transform.localEulerAngles = arg_478_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_481_1 = arg_478_1.actors_["2078ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_1) and arg_478_1.var_.characterEffect2078ui_story == nil then
				arg_478_1.var_.characterEffect2078ui_story = var_481_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_2 and not isNil(var_481_1) then
				if arg_478_1.var_.characterEffect2078ui_story and not isNil(var_481_1) then
					arg_478_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_478_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_2)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_2 and arg_478_1.time_ < 0 + var_481_2 + arg_481_0 and not isNil(var_481_1) and arg_478_1.var_.characterEffect2078ui_story then
				arg_478_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_478_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_481_3 = arg_478_1.actors_["2079ui_story"].transform

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos2079ui_story = var_481_3.localPosition
			end

			local var_481_4 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 then
				var_481_3.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_478_1.time_ - 0) / var_481_4)
				var_481_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_3.position).x, (manager.ui.mainCamera.transform.position - var_481_3.position).y, (manager.ui.mainCamera.transform.position - var_481_3.position).z)
				var_481_3.localEulerAngles.z = 0
				var_481_3.localEulerAngles.x = 0
				var_481_3.localEulerAngles = var_481_3.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 then
				var_481_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_481_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_3.position).x, (manager.ui.mainCamera.transform.position - var_481_3.position).y, (manager.ui.mainCamera.transform.position - var_481_3.position).z)
				var_481_3.localEulerAngles.z = 0
				var_481_3.localEulerAngles.x = 0
				var_481_3.localEulerAngles = var_481_3.localEulerAngles
			end

			local var_481_5 = arg_478_1.actors_["2079ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_5) and arg_478_1.var_.characterEffect2079ui_story == nil then
				arg_478_1.var_.characterEffect2079ui_story = var_481_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_6 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_6 and not isNil(var_481_5) then
				if arg_478_1.var_.characterEffect2079ui_story and not isNil(var_481_5) then
					arg_478_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_6 and arg_478_1.time_ < 0 + var_481_6 + arg_481_0 and not isNil(var_481_5) and arg_478_1.var_.characterEffect2079ui_story then
				arg_478_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_481_8 = 0
			local var_481_9 = 0.375

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_8 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_10 = arg_478_1:GetWordFromCfg(317012115)
				local var_481_11 = arg_478_1:FormatText(var_481_10.content)

				arg_478_1.text_.text = var_481_11

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_13 = 15 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_11) / 15)

				if (15 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_11) / 15)) > 0 and var_481_9 < var_481_13 then
					arg_478_1.talkMaxDuration = var_481_13

					if var_481_13 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_13 + var_481_8
					end
				end

				arg_478_1.text_.text = var_481_11
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012115", "story_v_out_317012.awb") ~= 0 then
					local var_481_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012115", "story_v_out_317012.awb") / 1000

					if var_481_14 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_14 + var_481_8
					end

					if var_481_10.prefab_name ~= "" and arg_478_1.actors_[var_481_10.prefab_name] ~= nil then
						local var_481_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_10.prefab_name].transform, "story_v_out_317012", "317012115", "story_v_out_317012.awb")

						arg_478_1:RecordAudio("317012115", var_481_15)
						arg_478_1:RecordAudio("317012115", var_481_15)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_317012", "317012115", "story_v_out_317012.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_317012", "317012115", "story_v_out_317012.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_16 = math.max(var_481_9, arg_478_1.talkMaxDuration)

			if var_481_8 <= arg_478_1.time_ and arg_478_1.time_ < var_481_8 + var_481_16 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_8) / var_481_16

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_8 + var_481_16 and arg_478_1.time_ < var_481_8 + var_481_16 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play317012116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 317012116
		arg_482_1.duration_ = 9.37

		local var_482_0 = {
			zh = 8.133,
			ja = 9.366
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play317012117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.moveOldPos2078ui_story = arg_482_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_485_0 = 0.001

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 then
				arg_482_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_482_1.time_ - 0) / var_485_0)
				arg_482_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["2078ui_story"].transform.position).z)
				arg_482_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["2078ui_story"].transform.localEulerAngles = arg_482_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 then
				arg_482_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_482_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["2078ui_story"].transform.position).z)
				arg_482_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["2078ui_story"].transform.localEulerAngles = arg_482_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_485_1 = arg_482_1.actors_["2078ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect2078ui_story == nil then
				arg_482_1.var_.characterEffect2078ui_story = var_485_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_2 and not isNil(var_485_1) then
				if arg_482_1.var_.characterEffect2078ui_story and not isNil(var_485_1) then
					arg_482_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_2 and arg_482_1.time_ < 0 + var_485_2 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect2078ui_story then
				arg_482_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_485_4 = arg_482_1.actors_["2079ui_story"].transform

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.moveOldPos2079ui_story = var_485_4.localPosition
			end

			local var_485_5 = 0.001

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_5 then
				var_485_4.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_482_1.time_ - 0) / var_485_5)
				var_485_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_485_4.position).x, (manager.ui.mainCamera.transform.position - var_485_4.position).y, (manager.ui.mainCamera.transform.position - var_485_4.position).z)
				var_485_4.localEulerAngles.z = 0
				var_485_4.localEulerAngles.x = 0
				var_485_4.localEulerAngles = var_485_4.localEulerAngles
			end

			if arg_482_1.time_ >= 0 + var_485_5 and arg_482_1.time_ < 0 + var_485_5 + arg_485_0 then
				var_485_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_485_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_485_4.position).x, (manager.ui.mainCamera.transform.position - var_485_4.position).y, (manager.ui.mainCamera.transform.position - var_485_4.position).z)
				var_485_4.localEulerAngles.z = 0
				var_485_4.localEulerAngles.x = 0
				var_485_4.localEulerAngles = var_485_4.localEulerAngles
			end

			local var_485_6 = arg_482_1.actors_["2079ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_6) and arg_482_1.var_.characterEffect2079ui_story == nil then
				arg_482_1.var_.characterEffect2079ui_story = var_485_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_7 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 and not isNil(var_485_6) then
				if arg_482_1.var_.characterEffect2079ui_story and not isNil(var_485_6) then
					arg_482_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_482_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_7)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 and not isNil(var_485_6) and arg_482_1.var_.characterEffect2079ui_story then
				arg_482_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_482_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_485_8 = 0
			local var_485_9 = 0.9

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_8 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_10 = arg_482_1:GetWordFromCfg(317012116)
				local var_485_11 = arg_482_1:FormatText(var_485_10.content)

				arg_482_1.text_.text = var_485_11

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_13 = 36 <= 0 and var_485_9 or var_485_9 * (utf8.len(var_485_11) / 36)

				if (36 <= 0 and var_485_9 or var_485_9 * (utf8.len(var_485_11) / 36)) > 0 and var_485_9 < var_485_13 then
					arg_482_1.talkMaxDuration = var_485_13

					if var_485_13 + var_485_8 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_13 + var_485_8
					end
				end

				arg_482_1.text_.text = var_485_11
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012116", "story_v_out_317012.awb") ~= 0 then
					local var_485_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012116", "story_v_out_317012.awb") / 1000

					if var_485_14 + var_485_8 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_14 + var_485_8
					end

					if var_485_10.prefab_name ~= "" and arg_482_1.actors_[var_485_10.prefab_name] ~= nil then
						local var_485_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_10.prefab_name].transform, "story_v_out_317012", "317012116", "story_v_out_317012.awb")

						arg_482_1:RecordAudio("317012116", var_485_15)
						arg_482_1:RecordAudio("317012116", var_485_15)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_317012", "317012116", "story_v_out_317012.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_317012", "317012116", "story_v_out_317012.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_16 = math.max(var_485_9, arg_482_1.talkMaxDuration)

			if var_485_8 <= arg_482_1.time_ and arg_482_1.time_ < var_485_8 + var_485_16 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_8) / var_485_16

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_8 + var_485_16 and arg_482_1.time_ < var_485_8 + var_485_16 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play317012117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 317012117
		arg_486_1.duration_ = 7.53

		local var_486_0 = {
			zh = 3.866,
			ja = 7.533
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play317012118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos2078ui_story = arg_486_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_489_0 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				arg_486_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_486_1.time_ - 0) / var_489_0)
				arg_486_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["2078ui_story"].transform.position).z)
				arg_486_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["2078ui_story"].transform.localEulerAngles = arg_486_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				arg_486_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_486_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["2078ui_story"].transform.position).z)
				arg_486_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["2078ui_story"].transform.localEulerAngles = arg_486_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_489_1 = arg_486_1.actors_["2078ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect2078ui_story == nil then
				arg_486_1.var_.characterEffect2078ui_story = var_489_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_2 and not isNil(var_489_1) then
				if arg_486_1.var_.characterEffect2078ui_story and not isNil(var_489_1) then
					arg_486_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_486_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_2)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_2 and arg_486_1.time_ < 0 + var_489_2 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect2078ui_story then
				arg_486_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_486_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_489_3 = arg_486_1.actors_["2079ui_story"].transform

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos2079ui_story = var_489_3.localPosition
			end

			local var_489_4 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_4 then
				var_489_3.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_486_1.time_ - 0) / var_489_4)
				var_489_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_489_3.position).x, (manager.ui.mainCamera.transform.position - var_489_3.position).y, (manager.ui.mainCamera.transform.position - var_489_3.position).z)
				var_489_3.localEulerAngles.z = 0
				var_489_3.localEulerAngles.x = 0
				var_489_3.localEulerAngles = var_489_3.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_4 and arg_486_1.time_ < 0 + var_489_4 + arg_489_0 then
				var_489_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_489_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_489_3.position).x, (manager.ui.mainCamera.transform.position - var_489_3.position).y, (manager.ui.mainCamera.transform.position - var_489_3.position).z)
				var_489_3.localEulerAngles.z = 0
				var_489_3.localEulerAngles.x = 0
				var_489_3.localEulerAngles = var_489_3.localEulerAngles
			end

			local var_489_5 = arg_486_1.actors_["2079ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_5) and arg_486_1.var_.characterEffect2079ui_story == nil then
				arg_486_1.var_.characterEffect2079ui_story = var_489_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_6 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_6 and not isNil(var_489_5) then
				if arg_486_1.var_.characterEffect2079ui_story and not isNil(var_489_5) then
					arg_486_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_6 and arg_486_1.time_ < 0 + var_489_6 + arg_489_0 and not isNil(var_489_5) and arg_486_1.var_.characterEffect2079ui_story then
				arg_486_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_489_8 = 0
			local var_489_9 = 0.35

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_8 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_10 = arg_486_1:GetWordFromCfg(317012117)
				local var_489_11 = arg_486_1:FormatText(var_489_10.content)

				arg_486_1.text_.text = var_489_11

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_13 = 14 <= 0 and var_489_9 or var_489_9 * (utf8.len(var_489_11) / 14)

				if (14 <= 0 and var_489_9 or var_489_9 * (utf8.len(var_489_11) / 14)) > 0 and var_489_9 < var_489_13 then
					arg_486_1.talkMaxDuration = var_489_13

					if var_489_13 + var_489_8 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_13 + var_489_8
					end
				end

				arg_486_1.text_.text = var_489_11
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012117", "story_v_out_317012.awb") ~= 0 then
					local var_489_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012117", "story_v_out_317012.awb") / 1000

					if var_489_14 + var_489_8 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_14 + var_489_8
					end

					if var_489_10.prefab_name ~= "" and arg_486_1.actors_[var_489_10.prefab_name] ~= nil then
						local var_489_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_10.prefab_name].transform, "story_v_out_317012", "317012117", "story_v_out_317012.awb")

						arg_486_1:RecordAudio("317012117", var_489_15)
						arg_486_1:RecordAudio("317012117", var_489_15)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_317012", "317012117", "story_v_out_317012.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_317012", "317012117", "story_v_out_317012.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_16 = math.max(var_489_9, arg_486_1.talkMaxDuration)

			if var_489_8 <= arg_486_1.time_ and arg_486_1.time_ < var_489_8 + var_489_16 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_8) / var_489_16

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_8 + var_489_16 and arg_486_1.time_ < var_489_8 + var_489_16 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play317012118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 317012118
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play317012119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["2079ui_story"]) and arg_490_1.var_.characterEffect2079ui_story == nil then
				arg_490_1.var_.characterEffect2079ui_story = arg_490_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["2079ui_story"]) then
				if arg_490_1.var_.characterEffect2079ui_story and not isNil(arg_490_1.actors_["2079ui_story"]) then
					arg_490_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_490_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_0)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["2079ui_story"]) and arg_490_1.var_.characterEffect2079ui_story then
				arg_490_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_490_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_493_1 = 0
			local var_493_2 = 0.5

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(317012118).content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 20 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 20)

				if (20 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 20)) > 0 and var_493_2 < var_493_5 then
					arg_490_1.talkMaxDuration = var_493_5

					if var_493_5 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + var_493_1
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_6 = math.max(var_493_2, arg_490_1.talkMaxDuration)

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_6 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_1) / var_493_6

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_1 + var_493_6 and arg_490_1.time_ < var_493_1 + var_493_6 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play317012119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 317012119
		arg_494_1.duration_ = 12.43

		local var_494_0 = {
			zh = 10.4,
			ja = 12.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play317012120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos2078ui_story = arg_494_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_497_0 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 then
				arg_494_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_494_1.time_ - 0) / var_497_0)
				arg_494_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["2078ui_story"].transform.position).z)
				arg_494_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["2078ui_story"].transform.localEulerAngles = arg_494_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 then
				arg_494_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_494_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["2078ui_story"].transform.position).z)
				arg_494_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["2078ui_story"].transform.localEulerAngles = arg_494_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_497_1 = arg_494_1.actors_["2078ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect2078ui_story == nil then
				arg_494_1.var_.characterEffect2078ui_story = var_497_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_2 and not isNil(var_497_1) then
				if arg_494_1.var_.characterEffect2078ui_story and not isNil(var_497_1) then
					arg_494_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_494_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_2)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_2 and arg_494_1.time_ < 0 + var_497_2 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect2078ui_story then
				arg_494_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_494_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_497_3 = arg_494_1.actors_["2079ui_story"].transform

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos2079ui_story = var_497_3.localPosition
			end

			local var_497_4 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				var_497_3.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_494_1.time_ - 0) / var_497_4)
				var_497_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_3.position).x, (manager.ui.mainCamera.transform.position - var_497_3.position).y, (manager.ui.mainCamera.transform.position - var_497_3.position).z)
				var_497_3.localEulerAngles.z = 0
				var_497_3.localEulerAngles.x = 0
				var_497_3.localEulerAngles = var_497_3.localEulerAngles
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				var_497_3.localPosition = Vector3.New(0, 100, 0)
				var_497_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_3.position).x, (manager.ui.mainCamera.transform.position - var_497_3.position).y, (manager.ui.mainCamera.transform.position - var_497_3.position).z)
				var_497_3.localEulerAngles.z = 0
				var_497_3.localEulerAngles.x = 0
				var_497_3.localEulerAngles = var_497_3.localEulerAngles
			end

			local var_497_5 = arg_494_1.actors_["2079ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_5) and arg_494_1.var_.characterEffect2079ui_story == nil then
				arg_494_1.var_.characterEffect2079ui_story = var_497_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_6 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_6 and not isNil(var_497_5) then
				if arg_494_1.var_.characterEffect2079ui_story and not isNil(var_497_5) then
					arg_494_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_494_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_6)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_6 and arg_494_1.time_ < 0 + var_497_6 + arg_497_0 and not isNil(var_497_5) and arg_494_1.var_.characterEffect2079ui_story then
				arg_494_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_494_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_497_7 = arg_494_1.actors_["1015ui_story"].transform

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos1015ui_story = var_497_7.localPosition
			end

			local var_497_8 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_8 then
				var_497_7.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_494_1.time_ - 0) / var_497_8)
				var_497_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_7.position).x, (manager.ui.mainCamera.transform.position - var_497_7.position).y, (manager.ui.mainCamera.transform.position - var_497_7.position).z)
				var_497_7.localEulerAngles.z = 0
				var_497_7.localEulerAngles.x = 0
				var_497_7.localEulerAngles = var_497_7.localEulerAngles
			end

			if arg_494_1.time_ >= 0 + var_497_8 and arg_494_1.time_ < 0 + var_497_8 + arg_497_0 then
				var_497_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_497_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_7.position).x, (manager.ui.mainCamera.transform.position - var_497_7.position).y, (manager.ui.mainCamera.transform.position - var_497_7.position).z)
				var_497_7.localEulerAngles.z = 0
				var_497_7.localEulerAngles.x = 0
				var_497_7.localEulerAngles = var_497_7.localEulerAngles
			end

			local var_497_9 = arg_494_1.actors_["1015ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1015ui_story == nil then
				arg_494_1.var_.characterEffect1015ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_10 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_10 and not isNil(var_497_9) then
				if arg_494_1.var_.characterEffect1015ui_story and not isNil(var_497_9) then
					arg_494_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= 0 + var_497_10 and arg_494_1.time_ < 0 + var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1015ui_story then
				arg_494_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_497_12 = 0
			local var_497_13 = 1.1

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_12 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_14 = arg_494_1:GetWordFromCfg(317012119)
				local var_497_15 = arg_494_1:FormatText(var_497_14.content)

				arg_494_1.text_.text = var_497_15

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_17 = 44 <= 0 and var_497_13 or var_497_13 * (utf8.len(var_497_15) / 44)

				if (44 <= 0 and var_497_13 or var_497_13 * (utf8.len(var_497_15) / 44)) > 0 and var_497_13 < var_497_17 then
					arg_494_1.talkMaxDuration = var_497_17

					if var_497_17 + var_497_12 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_17 + var_497_12
					end
				end

				arg_494_1.text_.text = var_497_15
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012119", "story_v_out_317012.awb") ~= 0 then
					local var_497_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012119", "story_v_out_317012.awb") / 1000

					if var_497_18 + var_497_12 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_18 + var_497_12
					end

					if var_497_14.prefab_name ~= "" and arg_494_1.actors_[var_497_14.prefab_name] ~= nil then
						local var_497_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_14.prefab_name].transform, "story_v_out_317012", "317012119", "story_v_out_317012.awb")

						arg_494_1:RecordAudio("317012119", var_497_19)
						arg_494_1:RecordAudio("317012119", var_497_19)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_317012", "317012119", "story_v_out_317012.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_317012", "317012119", "story_v_out_317012.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_20 = math.max(var_497_13, arg_494_1.talkMaxDuration)

			if var_497_12 <= arg_494_1.time_ and arg_494_1.time_ < var_497_12 + var_497_20 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_12) / var_497_20

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_12 + var_497_20 and arg_494_1.time_ < var_497_12 + var_497_20 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play317012120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 317012120
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play317012121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1015ui_story"]) and arg_498_1.var_.characterEffect1015ui_story == nil then
				arg_498_1.var_.characterEffect1015ui_story = arg_498_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1015ui_story"]) then
				if arg_498_1.var_.characterEffect1015ui_story and not isNil(arg_498_1.actors_["1015ui_story"]) then
					arg_498_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_498_1.time_ - 0) / var_501_0)
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1015ui_story"]) and arg_498_1.var_.characterEffect1015ui_story then
				arg_498_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_501_1 = 0
			local var_501_2 = 0.3

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_3 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(317012120).content)

				arg_498_1.text_.text = var_501_3

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_5 = 12 <= 0 and var_501_2 or var_501_2 * (utf8.len(var_501_3) / 12)

				if (12 <= 0 and var_501_2 or var_501_2 * (utf8.len(var_501_3) / 12)) > 0 and var_501_2 < var_501_5 then
					arg_498_1.talkMaxDuration = var_501_5

					if var_501_5 + var_501_1 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + var_501_1
					end
				end

				arg_498_1.text_.text = var_501_3
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_6 = math.max(var_501_2, arg_498_1.talkMaxDuration)

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_6 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_1) / var_501_6

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_1 + var_501_6 and arg_498_1.time_ < var_501_1 + var_501_6 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play317012121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 317012121
		arg_502_1.duration_ = 8.9

		local var_502_0 = {
			zh = 7.7,
			ja = 8.9
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play317012122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.var_.moveOldPos1015ui_story = arg_502_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_505_0 = 0.001

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 then
				arg_502_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_502_1.time_ - 0) / var_505_0)
				arg_502_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1015ui_story"].transform.position).z)
				arg_502_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1015ui_story"].transform.localEulerAngles = arg_502_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 then
				arg_502_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_502_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1015ui_story"].transform.position).z)
				arg_502_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1015ui_story"].transform.localEulerAngles = arg_502_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_505_1 = arg_502_1.actors_["1015ui_story"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1015ui_story == nil then
				arg_502_1.var_.characterEffect1015ui_story = var_505_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_2 and not isNil(var_505_1) then
				if arg_502_1.var_.characterEffect1015ui_story and not isNil(var_505_1) then
					arg_502_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= 0 + var_505_2 and arg_502_1.time_ < 0 + var_505_2 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1015ui_story then
				arg_502_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_505_4 = 0
			local var_505_5 = 0.8

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(317012121)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_9 = 32 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 32)

				if (32 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 32)) > 0 and var_505_5 < var_505_9 then
					arg_502_1.talkMaxDuration = var_505_9

					if var_505_9 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_9 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012121", "story_v_out_317012.awb") ~= 0 then
					local var_505_10 = manager.audio:GetVoiceLength("story_v_out_317012", "317012121", "story_v_out_317012.awb") / 1000

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end

					if var_505_6.prefab_name ~= "" and arg_502_1.actors_[var_505_6.prefab_name] ~= nil then
						local var_505_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_6.prefab_name].transform, "story_v_out_317012", "317012121", "story_v_out_317012.awb")

						arg_502_1:RecordAudio("317012121", var_505_11)
						arg_502_1:RecordAudio("317012121", var_505_11)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_317012", "317012121", "story_v_out_317012.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_317012", "317012121", "story_v_out_317012.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_12 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_12 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_12

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_12 and arg_502_1.time_ < var_505_4 + var_505_12 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play317012122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 317012122
		arg_506_1.duration_ = 4.47

		local var_506_0 = {
			zh = 2,
			ja = 4.466
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play317012123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos2078ui_story = arg_506_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_509_0 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 then
				arg_506_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_506_1.time_ - 0) / var_509_0)
				arg_506_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["2078ui_story"].transform.position).z)
				arg_506_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["2078ui_story"].transform.localEulerAngles = arg_506_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 then
				arg_506_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_506_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["2078ui_story"].transform.position).z)
				arg_506_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["2078ui_story"].transform.localEulerAngles = arg_506_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_509_1 = arg_506_1.actors_["2078ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect2078ui_story == nil then
				arg_506_1.var_.characterEffect2078ui_story = var_509_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_2 and not isNil(var_509_1) then
				if arg_506_1.var_.characterEffect2078ui_story and not isNil(var_509_1) then
					arg_506_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_506_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_2)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_2 and arg_506_1.time_ < 0 + var_509_2 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect2078ui_story then
				arg_506_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_506_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_509_3 = arg_506_1.actors_["2079ui_story"].transform

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos2079ui_story = var_509_3.localPosition
			end

			local var_509_4 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				var_509_3.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_506_1.time_ - 0) / var_509_4)
				var_509_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_509_3.position).x, (manager.ui.mainCamera.transform.position - var_509_3.position).y, (manager.ui.mainCamera.transform.position - var_509_3.position).z)
				var_509_3.localEulerAngles.z = 0
				var_509_3.localEulerAngles.x = 0
				var_509_3.localEulerAngles = var_509_3.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				var_509_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_509_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_509_3.position).x, (manager.ui.mainCamera.transform.position - var_509_3.position).y, (manager.ui.mainCamera.transform.position - var_509_3.position).z)
				var_509_3.localEulerAngles.z = 0
				var_509_3.localEulerAngles.x = 0
				var_509_3.localEulerAngles = var_509_3.localEulerAngles
			end

			local var_509_5 = arg_506_1.actors_["2079ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_5) and arg_506_1.var_.characterEffect2079ui_story == nil then
				arg_506_1.var_.characterEffect2079ui_story = var_509_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_6 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_6 and not isNil(var_509_5) then
				if arg_506_1.var_.characterEffect2079ui_story and not isNil(var_509_5) then
					arg_506_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_6 and arg_506_1.time_ < 0 + var_509_6 + arg_509_0 and not isNil(var_509_5) and arg_506_1.var_.characterEffect2079ui_story then
				arg_506_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_509_8 = arg_506_1.actors_["1015ui_story"].transform

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos1015ui_story = var_509_8.localPosition
			end

			local var_509_9 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_9 then
				var_509_8.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_506_1.time_ - 0) / var_509_9)
				var_509_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_509_8.position).x, (manager.ui.mainCamera.transform.position - var_509_8.position).y, (manager.ui.mainCamera.transform.position - var_509_8.position).z)
				var_509_8.localEulerAngles.z = 0
				var_509_8.localEulerAngles.x = 0
				var_509_8.localEulerAngles = var_509_8.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_9 and arg_506_1.time_ < 0 + var_509_9 + arg_509_0 then
				var_509_8.localPosition = Vector3.New(0, 100, 0)
				var_509_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_509_8.position).x, (manager.ui.mainCamera.transform.position - var_509_8.position).y, (manager.ui.mainCamera.transform.position - var_509_8.position).z)
				var_509_8.localEulerAngles.z = 0
				var_509_8.localEulerAngles.x = 0
				var_509_8.localEulerAngles = var_509_8.localEulerAngles
			end

			local var_509_10 = arg_506_1.actors_["1015ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_10) and arg_506_1.var_.characterEffect1015ui_story == nil then
				arg_506_1.var_.characterEffect1015ui_story = var_509_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_11 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_11 and not isNil(var_509_10) then
				if arg_506_1.var_.characterEffect1015ui_story and not isNil(var_509_10) then
					arg_506_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_11)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_11 and arg_506_1.time_ < 0 + var_509_11 + arg_509_0 and not isNil(var_509_10) and arg_506_1.var_.characterEffect1015ui_story then
				arg_506_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_509_12 = 0
			local var_509_13 = 0.25

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_12 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_14 = arg_506_1:GetWordFromCfg(317012122)
				local var_509_15 = arg_506_1:FormatText(var_509_14.content)

				arg_506_1.text_.text = var_509_15

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_17 = 10 <= 0 and var_509_13 or var_509_13 * (utf8.len(var_509_15) / 10)

				if (10 <= 0 and var_509_13 or var_509_13 * (utf8.len(var_509_15) / 10)) > 0 and var_509_13 < var_509_17 then
					arg_506_1.talkMaxDuration = var_509_17

					if var_509_17 + var_509_12 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_17 + var_509_12
					end
				end

				arg_506_1.text_.text = var_509_15
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012122", "story_v_out_317012.awb") ~= 0 then
					local var_509_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012122", "story_v_out_317012.awb") / 1000

					if var_509_18 + var_509_12 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_18 + var_509_12
					end

					if var_509_14.prefab_name ~= "" and arg_506_1.actors_[var_509_14.prefab_name] ~= nil then
						local var_509_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_14.prefab_name].transform, "story_v_out_317012", "317012122", "story_v_out_317012.awb")

						arg_506_1:RecordAudio("317012122", var_509_19)
						arg_506_1:RecordAudio("317012122", var_509_19)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_317012", "317012122", "story_v_out_317012.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_317012", "317012122", "story_v_out_317012.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_20 = math.max(var_509_13, arg_506_1.talkMaxDuration)

			if var_509_12 <= arg_506_1.time_ and arg_506_1.time_ < var_509_12 + var_509_20 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_12) / var_509_20

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_12 + var_509_20 and arg_506_1.time_ < var_509_12 + var_509_20 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play317012123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 317012123
		arg_510_1.duration_ = 5.6

		local var_510_0 = {
			zh = 5.6,
			ja = 5.066
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play317012124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos2078ui_story = arg_510_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_513_0 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				arg_510_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["2078ui_story"].transform.position).z)
				arg_510_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["2078ui_story"].transform.localEulerAngles = arg_510_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				arg_510_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_510_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["2078ui_story"].transform.position).z)
				arg_510_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["2078ui_story"].transform.localEulerAngles = arg_510_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_513_1 = arg_510_1.actors_["2078ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect2078ui_story == nil then
				arg_510_1.var_.characterEffect2078ui_story = var_513_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_2 and not isNil(var_513_1) then
				if arg_510_1.var_.characterEffect2078ui_story and not isNil(var_513_1) then
					arg_510_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_2 and arg_510_1.time_ < 0 + var_513_2 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect2078ui_story then
				arg_510_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_513_4 = arg_510_1.actors_["2079ui_story"].transform

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos2079ui_story = var_513_4.localPosition
			end

			local var_513_5 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_5 then
				var_513_4.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_510_1.time_ - 0) / var_513_5)
				var_513_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_513_4.position).x, (manager.ui.mainCamera.transform.position - var_513_4.position).y, (manager.ui.mainCamera.transform.position - var_513_4.position).z)
				var_513_4.localEulerAngles.z = 0
				var_513_4.localEulerAngles.x = 0
				var_513_4.localEulerAngles = var_513_4.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_5 and arg_510_1.time_ < 0 + var_513_5 + arg_513_0 then
				var_513_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_513_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_513_4.position).x, (manager.ui.mainCamera.transform.position - var_513_4.position).y, (manager.ui.mainCamera.transform.position - var_513_4.position).z)
				var_513_4.localEulerAngles.z = 0
				var_513_4.localEulerAngles.x = 0
				var_513_4.localEulerAngles = var_513_4.localEulerAngles
			end

			local var_513_6 = arg_510_1.actors_["2079ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_6) and arg_510_1.var_.characterEffect2079ui_story == nil then
				arg_510_1.var_.characterEffect2079ui_story = var_513_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_7 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_7 and not isNil(var_513_6) then
				if arg_510_1.var_.characterEffect2079ui_story and not isNil(var_513_6) then
					arg_510_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_510_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_7)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_7 and arg_510_1.time_ < 0 + var_513_7 + arg_513_0 and not isNil(var_513_6) and arg_510_1.var_.characterEffect2079ui_story then
				arg_510_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_510_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_513_8 = 0
			local var_513_9 = 0.675

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_8 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_10 = arg_510_1:GetWordFromCfg(317012123)
				local var_513_11 = arg_510_1:FormatText(var_513_10.content)

				arg_510_1.text_.text = var_513_11

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_13 = 27 <= 0 and var_513_9 or var_513_9 * (utf8.len(var_513_11) / 27)

				if (27 <= 0 and var_513_9 or var_513_9 * (utf8.len(var_513_11) / 27)) > 0 and var_513_9 < var_513_13 then
					arg_510_1.talkMaxDuration = var_513_13

					if var_513_13 + var_513_8 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_13 + var_513_8
					end
				end

				arg_510_1.text_.text = var_513_11
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012123", "story_v_out_317012.awb") ~= 0 then
					local var_513_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012123", "story_v_out_317012.awb") / 1000

					if var_513_14 + var_513_8 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_14 + var_513_8
					end

					if var_513_10.prefab_name ~= "" and arg_510_1.actors_[var_513_10.prefab_name] ~= nil then
						local var_513_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_10.prefab_name].transform, "story_v_out_317012", "317012123", "story_v_out_317012.awb")

						arg_510_1:RecordAudio("317012123", var_513_15)
						arg_510_1:RecordAudio("317012123", var_513_15)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_317012", "317012123", "story_v_out_317012.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_317012", "317012123", "story_v_out_317012.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_16 = math.max(var_513_9, arg_510_1.talkMaxDuration)

			if var_513_8 <= arg_510_1.time_ and arg_510_1.time_ < var_513_8 + var_513_16 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_8) / var_513_16

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_8 + var_513_16 and arg_510_1.time_ < var_513_8 + var_513_16 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play317012124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 317012124
		arg_514_1.duration_ = 4.1

		local var_514_0 = {
			zh = 2.766,
			ja = 4.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play317012125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos2078ui_story = arg_514_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_517_0 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 then
				arg_514_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 0) / var_517_0)
				arg_514_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["2078ui_story"].transform.position).z)
				arg_514_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["2078ui_story"].transform.localEulerAngles = arg_514_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 then
				arg_514_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["2078ui_story"].transform.position).z)
				arg_514_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["2078ui_story"].transform.localEulerAngles = arg_514_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_517_1 = arg_514_1.actors_["2078ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect2078ui_story == nil then
				arg_514_1.var_.characterEffect2078ui_story = var_517_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_2 and not isNil(var_517_1) then
				if arg_514_1.var_.characterEffect2078ui_story and not isNil(var_517_1) then
					arg_514_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_514_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_2)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_2 and arg_514_1.time_ < 0 + var_517_2 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect2078ui_story then
				arg_514_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_514_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_517_3 = arg_514_1.actors_["2079ui_story"].transform

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos2079ui_story = var_517_3.localPosition
			end

			local var_517_4 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_4 then
				var_517_3.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 0) / var_517_4)
				var_517_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_3.position).x, (manager.ui.mainCamera.transform.position - var_517_3.position).y, (manager.ui.mainCamera.transform.position - var_517_3.position).z)
				var_517_3.localEulerAngles.z = 0
				var_517_3.localEulerAngles.x = 0
				var_517_3.localEulerAngles = var_517_3.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_4 and arg_514_1.time_ < 0 + var_517_4 + arg_517_0 then
				var_517_3.localPosition = Vector3.New(0, 100, 0)
				var_517_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_3.position).x, (manager.ui.mainCamera.transform.position - var_517_3.position).y, (manager.ui.mainCamera.transform.position - var_517_3.position).z)
				var_517_3.localEulerAngles.z = 0
				var_517_3.localEulerAngles.x = 0
				var_517_3.localEulerAngles = var_517_3.localEulerAngles
			end

			local var_517_5 = arg_514_1.actors_["2079ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_5) and arg_514_1.var_.characterEffect2079ui_story == nil then
				arg_514_1.var_.characterEffect2079ui_story = var_517_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_6 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_6 and not isNil(var_517_5) then
				if arg_514_1.var_.characterEffect2079ui_story and not isNil(var_517_5) then
					arg_514_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_514_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_6)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_6 and arg_514_1.time_ < 0 + var_517_6 + arg_517_0 and not isNil(var_517_5) and arg_514_1.var_.characterEffect2079ui_story then
				arg_514_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_514_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_517_7 = arg_514_1.actors_["1015ui_story"].transform

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos1015ui_story = var_517_7.localPosition
			end

			local var_517_8 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_8 then
				var_517_7.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_514_1.time_ - 0) / var_517_8)
				var_517_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_7.position).x, (manager.ui.mainCamera.transform.position - var_517_7.position).y, (manager.ui.mainCamera.transform.position - var_517_7.position).z)
				var_517_7.localEulerAngles.z = 0
				var_517_7.localEulerAngles.x = 0
				var_517_7.localEulerAngles = var_517_7.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_8 and arg_514_1.time_ < 0 + var_517_8 + arg_517_0 then
				var_517_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_517_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_7.position).x, (manager.ui.mainCamera.transform.position - var_517_7.position).y, (manager.ui.mainCamera.transform.position - var_517_7.position).z)
				var_517_7.localEulerAngles.z = 0
				var_517_7.localEulerAngles.x = 0
				var_517_7.localEulerAngles = var_517_7.localEulerAngles
			end

			local var_517_9 = arg_514_1.actors_["1015ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect1015ui_story == nil then
				arg_514_1.var_.characterEffect1015ui_story = var_517_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_10 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_10 and not isNil(var_517_9) then
				if arg_514_1.var_.characterEffect1015ui_story and not isNil(var_517_9) then
					arg_514_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_10 and arg_514_1.time_ < 0 + var_517_10 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect1015ui_story then
				arg_514_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_517_12 = 0
			local var_517_13 = 0.35

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_12 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_14 = arg_514_1:GetWordFromCfg(317012124)
				local var_517_15 = arg_514_1:FormatText(var_517_14.content)

				arg_514_1.text_.text = var_517_15

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_17 = 14 <= 0 and var_517_13 or var_517_13 * (utf8.len(var_517_15) / 14)

				if (14 <= 0 and var_517_13 or var_517_13 * (utf8.len(var_517_15) / 14)) > 0 and var_517_13 < var_517_17 then
					arg_514_1.talkMaxDuration = var_517_17

					if var_517_17 + var_517_12 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_17 + var_517_12
					end
				end

				arg_514_1.text_.text = var_517_15
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012124", "story_v_out_317012.awb") ~= 0 then
					local var_517_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012124", "story_v_out_317012.awb") / 1000

					if var_517_18 + var_517_12 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_18 + var_517_12
					end

					if var_517_14.prefab_name ~= "" and arg_514_1.actors_[var_517_14.prefab_name] ~= nil then
						local var_517_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_14.prefab_name].transform, "story_v_out_317012", "317012124", "story_v_out_317012.awb")

						arg_514_1:RecordAudio("317012124", var_517_19)
						arg_514_1:RecordAudio("317012124", var_517_19)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_317012", "317012124", "story_v_out_317012.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_317012", "317012124", "story_v_out_317012.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_20 = math.max(var_517_13, arg_514_1.talkMaxDuration)

			if var_517_12 <= arg_514_1.time_ and arg_514_1.time_ < var_517_12 + var_517_20 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_12) / var_517_20

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_12 + var_517_20 and arg_514_1.time_ < var_517_12 + var_517_20 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play317012125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 317012125
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play317012126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos2078ui_story = arg_518_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_521_0 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 then
				arg_518_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_518_1.time_ - 0) / var_521_0)
				arg_518_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["2078ui_story"].transform.position).z)
				arg_518_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["2078ui_story"].transform.localEulerAngles = arg_518_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 then
				arg_518_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_518_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["2078ui_story"].transform.position).z)
				arg_518_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["2078ui_story"].transform.localEulerAngles = arg_518_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_521_1 = arg_518_1.actors_["2078ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_1) and arg_518_1.var_.characterEffect2078ui_story == nil then
				arg_518_1.var_.characterEffect2078ui_story = var_521_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_2 and not isNil(var_521_1) then
				if arg_518_1.var_.characterEffect2078ui_story and not isNil(var_521_1) then
					arg_518_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_518_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_2)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_2 and arg_518_1.time_ < 0 + var_521_2 + arg_521_0 and not isNil(var_521_1) and arg_518_1.var_.characterEffect2078ui_story then
				arg_518_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_518_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_521_3 = arg_518_1.actors_["2079ui_story"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos2079ui_story = var_521_3.localPosition
			end

			local var_521_4 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_4 then
				var_521_3.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_518_1.time_ - 0) / var_521_4)
				var_521_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_3.position).x, (manager.ui.mainCamera.transform.position - var_521_3.position).y, (manager.ui.mainCamera.transform.position - var_521_3.position).z)
				var_521_3.localEulerAngles.z = 0
				var_521_3.localEulerAngles.x = 0
				var_521_3.localEulerAngles = var_521_3.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_4 and arg_518_1.time_ < 0 + var_521_4 + arg_521_0 then
				var_521_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_521_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_3.position).x, (manager.ui.mainCamera.transform.position - var_521_3.position).y, (manager.ui.mainCamera.transform.position - var_521_3.position).z)
				var_521_3.localEulerAngles.z = 0
				var_521_3.localEulerAngles.x = 0
				var_521_3.localEulerAngles = var_521_3.localEulerAngles
			end

			local var_521_5 = arg_518_1.actors_["2079ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_5) and arg_518_1.var_.characterEffect2079ui_story == nil then
				arg_518_1.var_.characterEffect2079ui_story = var_521_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_6 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_6 and not isNil(var_521_5) then
				if arg_518_1.var_.characterEffect2079ui_story and not isNil(var_521_5) then
					arg_518_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_518_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_6)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_6 and arg_518_1.time_ < 0 + var_521_6 + arg_521_0 and not isNil(var_521_5) and arg_518_1.var_.characterEffect2079ui_story then
				arg_518_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_518_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_521_7 = arg_518_1.actors_["1015ui_story"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos1015ui_story = var_521_7.localPosition
			end

			local var_521_8 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_8 then
				var_521_7.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_518_1.time_ - 0) / var_521_8)
				var_521_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_7.position).x, (manager.ui.mainCamera.transform.position - var_521_7.position).y, (manager.ui.mainCamera.transform.position - var_521_7.position).z)
				var_521_7.localEulerAngles.z = 0
				var_521_7.localEulerAngles.x = 0
				var_521_7.localEulerAngles = var_521_7.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_8 and arg_518_1.time_ < 0 + var_521_8 + arg_521_0 then
				var_521_7.localPosition = Vector3.New(0, 100, 0)
				var_521_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_521_7.position).x, (manager.ui.mainCamera.transform.position - var_521_7.position).y, (manager.ui.mainCamera.transform.position - var_521_7.position).z)
				var_521_7.localEulerAngles.z = 0
				var_521_7.localEulerAngles.x = 0
				var_521_7.localEulerAngles = var_521_7.localEulerAngles
			end

			local var_521_9 = arg_518_1.actors_["1015ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect1015ui_story == nil then
				arg_518_1.var_.characterEffect1015ui_story = var_521_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_10 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_10 and not isNil(var_521_9) then
				if arg_518_1.var_.characterEffect1015ui_story and not isNil(var_521_9) then
					arg_518_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_10)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_10 and arg_518_1.time_ < 0 + var_521_10 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect1015ui_story then
				arg_518_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_521_11 = 0
			local var_521_12 = 1.475

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_11 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_13 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(317012125).content)

				arg_518_1.text_.text = var_521_13

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_15 = 59 <= 0 and var_521_12 or var_521_12 * (utf8.len(var_521_13) / 59)

				if (59 <= 0 and var_521_12 or var_521_12 * (utf8.len(var_521_13) / 59)) > 0 and var_521_12 < var_521_15 then
					arg_518_1.talkMaxDuration = var_521_15

					if var_521_15 + var_521_11 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_15 + var_521_11
					end
				end

				arg_518_1.text_.text = var_521_13
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_16 = math.max(var_521_12, arg_518_1.talkMaxDuration)

			if var_521_11 <= arg_518_1.time_ and arg_518_1.time_ < var_521_11 + var_521_16 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_11) / var_521_16

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_11 + var_521_16 and arg_518_1.time_ < var_521_11 + var_521_16 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play317012126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 317012126
		arg_522_1.duration_ = 9.53

		local var_522_0 = {
			zh = 9.533,
			ja = 9.366
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play317012127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos2078ui_story = arg_522_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_525_0 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 then
				arg_522_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_522_1.time_ - 0) / var_525_0)
				arg_522_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["2078ui_story"].transform.position).z)
				arg_522_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["2078ui_story"].transform.localEulerAngles = arg_522_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 then
				arg_522_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_522_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["2078ui_story"].transform.position).z)
				arg_522_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["2078ui_story"].transform.localEulerAngles = arg_522_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_525_1 = arg_522_1.actors_["2078ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect2078ui_story == nil then
				arg_522_1.var_.characterEffect2078ui_story = var_525_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_2 and not isNil(var_525_1) then
				if arg_522_1.var_.characterEffect2078ui_story and not isNil(var_525_1) then
					arg_522_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_522_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_2)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_2 and arg_522_1.time_ < 0 + var_525_2 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect2078ui_story then
				arg_522_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_522_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_525_3 = arg_522_1.actors_["2079ui_story"].transform

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos2079ui_story = var_525_3.localPosition
			end

			local var_525_4 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_4 then
				var_525_3.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_522_1.time_ - 0) / var_525_4)
				var_525_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_3.position).x, (manager.ui.mainCamera.transform.position - var_525_3.position).y, (manager.ui.mainCamera.transform.position - var_525_3.position).z)
				var_525_3.localEulerAngles.z = 0
				var_525_3.localEulerAngles.x = 0
				var_525_3.localEulerAngles = var_525_3.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_4 and arg_522_1.time_ < 0 + var_525_4 + arg_525_0 then
				var_525_3.localPosition = Vector3.New(0, 100, 0)
				var_525_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_3.position).x, (manager.ui.mainCamera.transform.position - var_525_3.position).y, (manager.ui.mainCamera.transform.position - var_525_3.position).z)
				var_525_3.localEulerAngles.z = 0
				var_525_3.localEulerAngles.x = 0
				var_525_3.localEulerAngles = var_525_3.localEulerAngles
			end

			local var_525_5 = arg_522_1.actors_["2079ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_5) and arg_522_1.var_.characterEffect2079ui_story == nil then
				arg_522_1.var_.characterEffect2079ui_story = var_525_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_6 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_6 and not isNil(var_525_5) then
				if arg_522_1.var_.characterEffect2079ui_story and not isNil(var_525_5) then
					arg_522_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_522_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_6)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_6 and arg_522_1.time_ < 0 + var_525_6 + arg_525_0 and not isNil(var_525_5) and arg_522_1.var_.characterEffect2079ui_story then
				arg_522_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_522_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_525_7 = arg_522_1.actors_["1015ui_story"].transform

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos1015ui_story = var_525_7.localPosition
			end

			local var_525_8 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_8 then
				var_525_7.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_522_1.time_ - 0) / var_525_8)
				var_525_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_7.position).x, (manager.ui.mainCamera.transform.position - var_525_7.position).y, (manager.ui.mainCamera.transform.position - var_525_7.position).z)
				var_525_7.localEulerAngles.z = 0
				var_525_7.localEulerAngles.x = 0
				var_525_7.localEulerAngles = var_525_7.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_8 and arg_522_1.time_ < 0 + var_525_8 + arg_525_0 then
				var_525_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_525_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_7.position).x, (manager.ui.mainCamera.transform.position - var_525_7.position).y, (manager.ui.mainCamera.transform.position - var_525_7.position).z)
				var_525_7.localEulerAngles.z = 0
				var_525_7.localEulerAngles.x = 0
				var_525_7.localEulerAngles = var_525_7.localEulerAngles
			end

			local var_525_9 = arg_522_1.actors_["1015ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect1015ui_story == nil then
				arg_522_1.var_.characterEffect1015ui_story = var_525_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_10 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_10 and not isNil(var_525_9) then
				if arg_522_1.var_.characterEffect1015ui_story and not isNil(var_525_9) then
					arg_522_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_10 and arg_522_1.time_ < 0 + var_525_10 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect1015ui_story then
				arg_522_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_525_12 = 0
			local var_525_13 = 1.05

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_12 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_14 = arg_522_1:GetWordFromCfg(317012126)
				local var_525_15 = arg_522_1:FormatText(var_525_14.content)

				arg_522_1.text_.text = var_525_15

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_17 = 42 <= 0 and var_525_13 or var_525_13 * (utf8.len(var_525_15) / 42)

				if (42 <= 0 and var_525_13 or var_525_13 * (utf8.len(var_525_15) / 42)) > 0 and var_525_13 < var_525_17 then
					arg_522_1.talkMaxDuration = var_525_17

					if var_525_17 + var_525_12 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_17 + var_525_12
					end
				end

				arg_522_1.text_.text = var_525_15
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012126", "story_v_out_317012.awb") ~= 0 then
					local var_525_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012126", "story_v_out_317012.awb") / 1000

					if var_525_18 + var_525_12 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_18 + var_525_12
					end

					if var_525_14.prefab_name ~= "" and arg_522_1.actors_[var_525_14.prefab_name] ~= nil then
						local var_525_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_14.prefab_name].transform, "story_v_out_317012", "317012126", "story_v_out_317012.awb")

						arg_522_1:RecordAudio("317012126", var_525_19)
						arg_522_1:RecordAudio("317012126", var_525_19)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_317012", "317012126", "story_v_out_317012.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_317012", "317012126", "story_v_out_317012.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_20 = math.max(var_525_13, arg_522_1.talkMaxDuration)

			if var_525_12 <= arg_522_1.time_ and arg_522_1.time_ < var_525_12 + var_525_20 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_12) / var_525_20

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_12 + var_525_20 and arg_522_1.time_ < var_525_12 + var_525_20 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play317012127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 317012127
		arg_526_1.duration_ = 1.3

		local var_526_0 = {
			zh = 1.133,
			ja = 1.3
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
			arg_526_1.auto_ = false
		end

		function arg_526_1.playNext_(arg_528_0)
			arg_526_1.onStoryFinished_()
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos2078ui_story = arg_526_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_529_0 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 then
				arg_526_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_526_1.time_ - 0) / var_529_0)
				arg_526_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["2078ui_story"].transform.position).z)
				arg_526_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["2078ui_story"].transform.localEulerAngles = arg_526_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 then
				arg_526_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_526_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["2078ui_story"].transform.position).z)
				arg_526_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["2078ui_story"].transform.localEulerAngles = arg_526_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_529_1 = arg_526_1.actors_["2078ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_1) and arg_526_1.var_.characterEffect2078ui_story == nil then
				arg_526_1.var_.characterEffect2078ui_story = var_529_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_2 and not isNil(var_529_1) then
				if arg_526_1.var_.characterEffect2078ui_story and not isNil(var_529_1) then
					arg_526_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_2 and arg_526_1.time_ < 0 + var_529_2 + arg_529_0 and not isNil(var_529_1) and arg_526_1.var_.characterEffect2078ui_story then
				arg_526_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_529_4 = arg_526_1.actors_["1015ui_story"].transform

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos1015ui_story = var_529_4.localPosition
			end

			local var_529_5 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_5 then
				var_529_4.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_526_1.time_ - 0) / var_529_5)
				var_529_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_529_4.position).x, (manager.ui.mainCamera.transform.position - var_529_4.position).y, (manager.ui.mainCamera.transform.position - var_529_4.position).z)
				var_529_4.localEulerAngles.z = 0
				var_529_4.localEulerAngles.x = 0
				var_529_4.localEulerAngles = var_529_4.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_5 and arg_526_1.time_ < 0 + var_529_5 + arg_529_0 then
				var_529_4.localPosition = Vector3.New(0, 100, 0)
				var_529_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_529_4.position).x, (manager.ui.mainCamera.transform.position - var_529_4.position).y, (manager.ui.mainCamera.transform.position - var_529_4.position).z)
				var_529_4.localEulerAngles.z = 0
				var_529_4.localEulerAngles.x = 0
				var_529_4.localEulerAngles = var_529_4.localEulerAngles
			end

			local var_529_6 = arg_526_1.actors_["1015ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_6) and arg_526_1.var_.characterEffect1015ui_story == nil then
				arg_526_1.var_.characterEffect1015ui_story = var_529_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_7 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_7 and not isNil(var_529_6) then
				if arg_526_1.var_.characterEffect1015ui_story and not isNil(var_529_6) then
					arg_526_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_526_1.time_ - 0) / var_529_7)
				end
			end

			if arg_526_1.time_ >= 0 + var_529_7 and arg_526_1.time_ < 0 + var_529_7 + arg_529_0 and not isNil(var_529_6) and arg_526_1.var_.characterEffect1015ui_story then
				arg_526_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_529_8 = 0
			local var_529_9 = 0.1

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_8 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_10 = arg_526_1:GetWordFromCfg(317012127)
				local var_529_11 = arg_526_1:FormatText(var_529_10.content)

				arg_526_1.text_.text = var_529_11

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_13 = 4 <= 0 and var_529_9 or var_529_9 * (utf8.len(var_529_11) / 4)

				if (4 <= 0 and var_529_9 or var_529_9 * (utf8.len(var_529_11) / 4)) > 0 and var_529_9 < var_529_13 then
					arg_526_1.talkMaxDuration = var_529_13

					if var_529_13 + var_529_8 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_13 + var_529_8
					end
				end

				arg_526_1.text_.text = var_529_11
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012127", "story_v_out_317012.awb") ~= 0 then
					local var_529_14 = manager.audio:GetVoiceLength("story_v_out_317012", "317012127", "story_v_out_317012.awb") / 1000

					if var_529_14 + var_529_8 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_14 + var_529_8
					end

					if var_529_10.prefab_name ~= "" and arg_526_1.actors_[var_529_10.prefab_name] ~= nil then
						local var_529_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_10.prefab_name].transform, "story_v_out_317012", "317012127", "story_v_out_317012.awb")

						arg_526_1:RecordAudio("317012127", var_529_15)
						arg_526_1:RecordAudio("317012127", var_529_15)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_317012", "317012127", "story_v_out_317012.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_317012", "317012127", "story_v_out_317012.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_16 = math.max(var_529_9, arg_526_1.talkMaxDuration)

			if var_529_8 <= arg_526_1.time_ and arg_526_1.time_ < var_529_8 + var_529_16 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_8) / var_529_16

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_8 + var_529_16 and arg_526_1.time_ < var_529_8 + var_529_16 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/K09g",
		"TextureConfig/Background/K09h",
		"TextureConfig/Background/YA0101",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K02f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/K06f"
	},
	voices = {
		"story_v_out_317012.awb"
	}
}
