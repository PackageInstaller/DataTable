return {
	Play123432001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123432001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123432002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K01f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K01f")
				var_4_0.name = "K01f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K01f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K01f

				arg_1_1.bgs_.K01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K01f" then
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

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest")

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

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_gun", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.475

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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123432001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 19 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 19)

				if (19 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 19)) > 0 and var_4_16 < var_4_20 then
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
	Play123432002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123432002
		arg_9_1.duration_ = 8.07

		local var_9_0 = {
			zh = 6.4,
			ja = 8.066
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
				arg_9_0:Play123432003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10048ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10048ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10048ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10048ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10048ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10048ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10048ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10048ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10048ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.155, -6.13)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10048ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10048ui_story == nil then
				arg_9_1.var_.characterEffect10048ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10048ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10048ui_story then
				arg_9_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.825

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(123432002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 33 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 33)

				if (33 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 33)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432002", "story_v_out_123432.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_123432", "123432002", "story_v_out_123432.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_123432", "123432002", "story_v_out_123432.awb")

						arg_9_1:RecordAudio("123432002", var_12_15)
						arg_9_1:RecordAudio("123432002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_123432", "123432002", "story_v_out_123432.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_123432", "123432002", "story_v_out_123432.awb")
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
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play123432003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123432003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123432004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10048ui_story"]) and arg_13_1.var_.characterEffect10048ui_story == nil then
				arg_13_1.var_.characterEffect10048ui_story = arg_13_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10048ui_story"]) then
				if arg_13_1.var_.characterEffect10048ui_story and not isNil(arg_13_1.actors_["10048ui_story"]) then
					arg_13_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10048ui_story"]) and arg_13_1.var_.characterEffect10048ui_story then
				arg_13_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(123432003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 15 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 15)

				if (15 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 15)) > 0 and var_16_2 < var_16_5 then
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
	Play123432004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123432004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play123432005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10048ui_story = arg_17_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10048ui_story"].transform.position).z)
				arg_17_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10048ui_story"].transform.localEulerAngles = arg_17_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10048ui_story"].transform.position).z)
				arg_17_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10048ui_story"].transform.localEulerAngles = arg_17_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10048ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10048ui_story == nil then
				arg_17_1.var_.characterEffect10048ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10048ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10048ui_story then
				arg_17_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.9

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

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(123432004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 36 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 36)

				if (36 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 36)) > 0 and var_20_4 < var_20_7 then
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
				actorName = "10048ui_story",
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
	Play123432005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123432005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123432006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.85

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(123432005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 34 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 34)

				if (34 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 34)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123432006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123432006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123432007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10048ui_story = arg_25_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10048ui_story"].transform.position).z)
				arg_25_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10048ui_story"].transform.localEulerAngles = arg_25_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, -1.155, -6.13)
				arg_25_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10048ui_story"].transform.position).z)
				arg_25_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10048ui_story"].transform.localEulerAngles = arg_25_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10048ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10048ui_story == nil then
				arg_25_1.var_.characterEffect10048ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect10048ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10048ui_story then
				arg_25_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
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

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(123432006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 17 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 17)

				if (17 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 17)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
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
	Play123432007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123432007
		arg_29_1.duration_ = 6.4

		local var_29_0 = {
			zh = 5.266,
			ja = 6.4
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
				arg_29_0:Play123432008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10048ui_story = arg_29_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10048ui_story"].transform.position).z)
				arg_29_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10048ui_story"].transform.localEulerAngles = arg_29_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, -1.155, -6.13)
				arg_29_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10048ui_story"].transform.position).z)
				arg_29_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10048ui_story"].transform.localEulerAngles = arg_29_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10048ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10048ui_story == nil then
				arg_29_1.var_.characterEffect10048ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10048ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10048ui_story then
				arg_29_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action3_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_4 = 0
			local var_32_5 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(123432007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 29 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 29)

				if (29 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 29)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432007", "story_v_out_123432.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_123432", "123432007", "story_v_out_123432.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_123432", "123432007", "story_v_out_123432.awb")

						arg_29_1:RecordAudio("123432007", var_32_11)
						arg_29_1:RecordAudio("123432007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_123432", "123432007", "story_v_out_123432.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_123432", "123432007", "story_v_out_123432.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play123432008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123432008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123432009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10048ui_story"]) and arg_33_1.var_.characterEffect10048ui_story == nil then
				arg_33_1.var_.characterEffect10048ui_story = arg_33_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10048ui_story"]) then
				if arg_33_1.var_.characterEffect10048ui_story and not isNil(arg_33_1.actors_["10048ui_story"]) then
					arg_33_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10048ui_story"]) and arg_33_1.var_.characterEffect10048ui_story then
				arg_33_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(123432008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 25 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 25)

				if (25 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 25)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123432009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123432009
		arg_37_1.duration_ = 3.37

		local var_37_0 = {
			zh = 3.366,
			ja = 2
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
				arg_37_0:Play123432010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10048ui_story = arg_37_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10048ui_story"].transform.position).z)
				arg_37_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10048ui_story"].transform.localEulerAngles = arg_37_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, -1.155, -6.13)
				arg_37_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10048ui_story"].transform.position).z)
				arg_37_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10048ui_story"].transform.localEulerAngles = arg_37_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10048ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10048ui_story == nil then
				arg_37_1.var_.characterEffect10048ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10048ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10048ui_story then
				arg_37_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action3_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(123432009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)

				if (11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432009", "story_v_out_123432.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_123432", "123432009", "story_v_out_123432.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_123432", "123432009", "story_v_out_123432.awb")

						arg_37_1:RecordAudio("123432009", var_40_11)
						arg_37_1:RecordAudio("123432009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123432", "123432009", "story_v_out_123432.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123432", "123432009", "story_v_out_123432.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
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
	Play123432010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123432010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play123432011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10048ui_story = arg_41_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10048ui_story"].transform.position).z)
				arg_41_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10048ui_story"].transform.localEulerAngles = arg_41_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10048ui_story"].transform.position).z)
				arg_41_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10048ui_story"].transform.localEulerAngles = arg_41_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10048ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10048ui_story == nil then
				arg_41_1.var_.characterEffect10048ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect10048ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10048ui_story then
				arg_41_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_44_3 = 0
			local var_44_4 = 0.55

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
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

				local var_44_5 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(123432010).content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 22 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 22)

				if (22 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 22)) > 0 and var_44_4 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_8 and arg_41_1.time_ < var_44_3 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
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
	Play123432011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123432011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123432012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.15

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(123432011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 46 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 46)

				if (46 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 46)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123432012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123432012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123432013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.4

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(123432012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 16 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 16)

				if (16 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 16)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123432013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123432013
		arg_53_1.duration_ = 4.8

		local var_53_0 = {
			zh = 2.7,
			ja = 4.8
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
				arg_53_0:Play123432014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10048ui_story"]) and arg_53_1.var_.characterEffect10048ui_story == nil then
				arg_53_1.var_.characterEffect10048ui_story = arg_53_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10048ui_story"]) then
				if arg_53_1.var_.characterEffect10048ui_story and not isNil(arg_53_1.actors_["10048ui_story"]) then
					arg_53_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10048ui_story"]) and arg_53_1.var_.characterEffect10048ui_story then
				arg_53_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_2 = arg_53_1.actors_["10048ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10048ui_story = var_56_2.localPosition
			end

			local var_56_3 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_53_1.time_ - 0) / var_56_3)
				var_56_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_2.position).x, (manager.ui.mainCamera.transform.position - var_56_2.position).y, (manager.ui.mainCamera.transform.position - var_56_2.position).z)
				var_56_2.localEulerAngles.z = 0
				var_56_2.localEulerAngles.x = 0
				var_56_2.localEulerAngles = var_56_2.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -1.155, -6.13)
				var_56_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_2.position).x, (manager.ui.mainCamera.transform.position - var_56_2.position).y, (manager.ui.mainCamera.transform.position - var_56_2.position).z)
				var_56_2.localEulerAngles.z = 0
				var_56_2.localEulerAngles.x = 0
				var_56_2.localEulerAngles = var_56_2.localEulerAngles
			end

			local var_56_4 = 0
			local var_56_5 = 0.325

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(123432013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 13 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 13)

				if (13 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 13)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432013", "story_v_out_123432.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_123432", "123432013", "story_v_out_123432.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_123432", "123432013", "story_v_out_123432.awb")

						arg_53_1:RecordAudio("123432013", var_56_11)
						arg_53_1:RecordAudio("123432013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123432", "123432013", "story_v_out_123432.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123432", "123432013", "story_v_out_123432.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play123432014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123432014
		arg_57_1.duration_ = 7.83

		local var_57_0 = {
			zh = 7.833,
			ja = 7.8
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
				arg_57_0:Play123432015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.875

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(123432014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 35 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 35)

				if (35 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 35)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432014", "story_v_out_123432.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_123432", "123432014", "story_v_out_123432.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_123432", "123432014", "story_v_out_123432.awb")

						arg_57_1:RecordAudio("123432014", var_60_6)
						arg_57_1:RecordAudio("123432014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_123432", "123432014", "story_v_out_123432.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_123432", "123432014", "story_v_out_123432.awb")
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
	Play123432015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123432015
		arg_61_1.duration_ = 12.83

		local var_61_0 = {
			zh = 11.6,
			ja = 12.833
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123432016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(123432015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 40 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 40)

				if (40 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 40)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432015", "story_v_out_123432.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_123432", "123432015", "story_v_out_123432.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_123432", "123432015", "story_v_out_123432.awb")

						arg_61_1:RecordAudio("123432015", var_64_6)
						arg_61_1:RecordAudio("123432015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_123432", "123432015", "story_v_out_123432.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_123432", "123432015", "story_v_out_123432.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123432016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123432016
		arg_65_1.duration_ = 10.07

		local var_65_0 = {
			zh = 5.266,
			ja = 10.066
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
				arg_65_0:Play123432017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(123432016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 28 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 28)

				if (28 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 28)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432016", "story_v_out_123432.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_123432", "123432016", "story_v_out_123432.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_123432", "123432016", "story_v_out_123432.awb")

						arg_65_1:RecordAudio("123432016", var_68_7)
						arg_65_1:RecordAudio("123432016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123432", "123432016", "story_v_out_123432.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123432", "123432016", "story_v_out_123432.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play123432017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123432017
		arg_69_1.duration_ = 4.9

		local var_69_0 = {
			zh = 1.733,
			ja = 4.9
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
				arg_69_0:Play123432018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(123432017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 10 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 10)

				if (10 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 10)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432017", "story_v_out_123432.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_123432", "123432017", "story_v_out_123432.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_123432", "123432017", "story_v_out_123432.awb")

						arg_69_1:RecordAudio("123432017", var_72_6)
						arg_69_1:RecordAudio("123432017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123432", "123432017", "story_v_out_123432.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123432", "123432017", "story_v_out_123432.awb")
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
	Play123432018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123432018
		arg_73_1.duration_ = 5.77

		local var_73_0 = {
			zh = 4.6,
			ja = 5.766
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play123432019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_76_0 = 0
			local var_76_1 = 0.55

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(123432018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 22 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 22)

				if (22 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 22)) > 0 and var_76_1 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432018", "story_v_out_123432.awb") ~= 0 then
					local var_76_6 = manager.audio:GetVoiceLength("story_v_out_123432", "123432018", "story_v_out_123432.awb") / 1000

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end

					if var_76_2.prefab_name ~= "" and arg_73_1.actors_[var_76_2.prefab_name] ~= nil then
						local var_76_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_2.prefab_name].transform, "story_v_out_123432", "123432018", "story_v_out_123432.awb")

						arg_73_1:RecordAudio("123432018", var_76_7)
						arg_73_1:RecordAudio("123432018", var_76_7)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123432", "123432018", "story_v_out_123432.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123432", "123432018", "story_v_out_123432.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123432019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123432019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play123432020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10048ui_story"]) and arg_77_1.var_.characterEffect10048ui_story == nil then
				arg_77_1.var_.characterEffect10048ui_story = arg_77_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10048ui_story"]) then
				if arg_77_1.var_.characterEffect10048ui_story and not isNil(arg_77_1.actors_["10048ui_story"]) then
					arg_77_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10048ui_story"]) and arg_77_1.var_.characterEffect10048ui_story then
				arg_77_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.625

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(123432019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 25 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 25)

				if (25 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 25)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play123432020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123432020
		arg_81_1.duration_ = 10.63

		local var_81_0 = {
			zh = 10.433,
			ja = 10.633
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
				arg_81_0:Play123432021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10048ui_story"]) and arg_81_1.var_.characterEffect10048ui_story == nil then
				arg_81_1.var_.characterEffect10048ui_story = arg_81_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10048ui_story"]) then
				if arg_81_1.var_.characterEffect10048ui_story and not isNil(arg_81_1.actors_["10048ui_story"]) then
					arg_81_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10048ui_story"]) and arg_81_1.var_.characterEffect10048ui_story then
				arg_81_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action2_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = 0
			local var_84_3 = 1.025

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(123432020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 41 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 41)

				if (41 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 41)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432020", "story_v_out_123432.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_123432", "123432020", "story_v_out_123432.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_123432", "123432020", "story_v_out_123432.awb")

						arg_81_1:RecordAudio("123432020", var_84_9)
						arg_81_1:RecordAudio("123432020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_123432", "123432020", "story_v_out_123432.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_123432", "123432020", "story_v_out_123432.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123432021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123432021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play123432022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10048ui_story = arg_85_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10048ui_story"].transform.position).z)
				arg_85_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10048ui_story"].transform.localEulerAngles = arg_85_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10048ui_story"].transform.position).z)
				arg_85_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10048ui_story"].transform.localEulerAngles = arg_85_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10048ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10048ui_story == nil then
				arg_85_1.var_.characterEffect10048ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10048ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10048ui_story then
				arg_85_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_88_3 = 0
			local var_88_4 = 1.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(123432021).content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 55 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 55)

				if (55 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 55)) > 0 and var_88_4 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_8 and arg_85_1.time_ < var_88_3 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play123432022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123432022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play123432023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(123432022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 14 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 14)

				if (14 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 14)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play123432023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123432023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play123432024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.9

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(123432023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 36 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 36)

				if (36 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 36)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123432024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123432024
		arg_97_1.duration_ = 4.87

		local var_97_0 = {
			zh = 3.733,
			ja = 4.866
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play123432025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10048ui_story = arg_97_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10048ui_story"].transform.position).z)
				arg_97_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10048ui_story"].transform.localEulerAngles = arg_97_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, -1.155, -6.13)
				arg_97_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10048ui_story"].transform.position).z)
				arg_97_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10048ui_story"].transform.localEulerAngles = arg_97_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10048ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10048ui_story == nil then
				arg_97_1.var_.characterEffect10048ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10048ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10048ui_story then
				arg_97_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(123432024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 16 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 16)

				if (16 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 16)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432024", "story_v_out_123432.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_123432", "123432024", "story_v_out_123432.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_123432", "123432024", "story_v_out_123432.awb")

						arg_97_1:RecordAudio("123432024", var_100_11)
						arg_97_1:RecordAudio("123432024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123432", "123432024", "story_v_out_123432.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123432", "123432024", "story_v_out_123432.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play123432025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123432025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play123432026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10048ui_story"]) and arg_101_1.var_.characterEffect10048ui_story == nil then
				arg_101_1.var_.characterEffect10048ui_story = arg_101_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10048ui_story"]) then
				if arg_101_1.var_.characterEffect10048ui_story and not isNil(arg_101_1.actors_["10048ui_story"]) then
					arg_101_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10048ui_story"]) and arg_101_1.var_.characterEffect10048ui_story then
				arg_101_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.725

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(123432025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 29 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 29)

				if (29 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 29)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play123432026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123432026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play123432027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.5

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(123432026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 20 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 20)

				if (20 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 20)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123432027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123432027
		arg_109_1.duration_ = 7.13

		local var_109_0 = {
			zh = 4.633,
			ja = 7.133
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play123432028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10048ui_story"]) and arg_109_1.var_.characterEffect10048ui_story == nil then
				arg_109_1.var_.characterEffect10048ui_story = arg_109_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10048ui_story"]) then
				if arg_109_1.var_.characterEffect10048ui_story and not isNil(arg_109_1.actors_["10048ui_story"]) then
					arg_109_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10048ui_story"]) and arg_109_1.var_.characterEffect10048ui_story then
				arg_109_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(123432027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 10 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 10)

				if (10 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 10)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432027", "story_v_out_123432.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_123432", "123432027", "story_v_out_123432.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_123432", "123432027", "story_v_out_123432.awb")

						arg_109_1:RecordAudio("123432027", var_112_9)
						arg_109_1:RecordAudio("123432027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123432", "123432027", "story_v_out_123432.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123432", "123432027", "story_v_out_123432.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play123432028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123432028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123432029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10048ui_story = arg_113_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10048ui_story"].transform.position).z)
				arg_113_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10048ui_story"].transform.localEulerAngles = arg_113_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10048ui_story"].transform.position).z)
				arg_113_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10048ui_story"].transform.localEulerAngles = arg_113_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10048ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10048ui_story == nil then
				arg_113_1.var_.characterEffect10048ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10048ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10048ui_story then
				arg_113_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_116_3 = 0
			local var_116_4 = 0.85

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(123432028).content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 34 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 34)

				if (34 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 34)) > 0 and var_116_4 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_8 and arg_113_1.time_ < var_116_3 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play123432029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123432029
		arg_117_1.duration_ = 4.3

		local var_117_0 = {
			zh = 3.6,
			ja = 4.3
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
			arg_117_1.auto_ = false
		end

		function arg_117_1.playNext_(arg_119_0)
			arg_117_1.onStoryFinished_()
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10048ui_story = arg_117_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10048ui_story"].transform.position).z)
				arg_117_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10048ui_story"].transform.localEulerAngles = arg_117_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, -1.155, -6.13)
				arg_117_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10048ui_story"].transform.position).z)
				arg_117_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10048ui_story"].transform.localEulerAngles = arg_117_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10048ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10048ui_story == nil then
				arg_117_1.var_.characterEffect10048ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10048ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10048ui_story then
				arg_117_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(123432029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 14 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 14)

				if (14 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 14)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123432", "123432029", "story_v_out_123432.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_123432", "123432029", "story_v_out_123432.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_123432", "123432029", "story_v_out_123432.awb")

						arg_117_1:RecordAudio("123432029", var_120_11)
						arg_117_1:RecordAudio("123432029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123432", "123432029", "story_v_out_123432.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123432", "123432029", "story_v_out_123432.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K01f"
	},
	voices = {
		"story_v_out_123432.awb"
	}
}
