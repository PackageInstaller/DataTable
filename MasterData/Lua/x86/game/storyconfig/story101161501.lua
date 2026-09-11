return {
	Play116151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116151001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I05a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_4_0.name = "I05a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I05a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.I05a

				arg_1_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I05a" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.925

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116151001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 37 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 37)

				if (37 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 37)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116151002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116151002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116151003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(116151002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 47 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 47)

				if (47 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 47)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play116151003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116151003
		arg_13_1.duration_ = 9.67

		local var_13_0 = {
			zh = 7.8,
			ja = 9.666
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
				arg_13_0:Play116151004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1066ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1066ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1066ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1066ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1066ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1066ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_16_5 = arg_13_1.actors_["1066ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1066ui_story == nil then
				arg_13_1.var_.characterEffect1066ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1066ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1066ui_story then
				arg_13_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_16_8 = 0
			local var_16_9 = 0.875

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(116151003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 35 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 35)

				if (35 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 35)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151003", "story_v_out_116151.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_116151", "116151003", "story_v_out_116151.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_116151", "116151003", "story_v_out_116151.awb")

						arg_13_1:RecordAudio("116151003", var_16_15)
						arg_13_1:RecordAudio("116151003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116151", "116151003", "story_v_out_116151.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116151", "116151003", "story_v_out_116151.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play116151004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116151004
		arg_17_1.duration_ = 6.37

		local var_17_0 = {
			zh = 5.833,
			ja = 6.366
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
				arg_17_0:Play116151005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1066ui_story"]) and arg_17_1.var_.characterEffect1066ui_story == nil then
				arg_17_1.var_.characterEffect1066ui_story = arg_17_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1066ui_story"]) then
				if arg_17_1.var_.characterEffect1066ui_story and not isNil(arg_17_1.actors_["1066ui_story"]) then
					arg_17_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1066ui_story"]) and arg_17_1.var_.characterEffect1066ui_story then
				arg_17_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_20_1 = "1033ui_story"

			if arg_17_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_17_1.stage_.transform)

				var_20_2.name = var_20_1
				var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_1] = var_20_2

				local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

				var_20_3.enabled = true

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_3.transform, false)

				arg_17_1.var_[var_20_1 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_1 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_1 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_5 = arg_17_1.actors_["1033ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1033ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_7 = arg_17_1.actors_["1033ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1033ui_story == nil then
				arg_17_1.var_.characterEffect1033ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect1033ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1033ui_story then
				arg_17_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_20_10 = 0
			local var_20_11 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(116151004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 28 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 28)

				if (28 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 28)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151004", "story_v_out_116151.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_116151", "116151004", "story_v_out_116151.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_116151", "116151004", "story_v_out_116151.awb")

						arg_17_1:RecordAudio("116151004", var_20_17)
						arg_17_1:RecordAudio("116151004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116151", "116151004", "story_v_out_116151.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116151", "116151004", "story_v_out_116151.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play116151005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116151005
		arg_21_1.duration_ = 6.67

		local var_21_0 = {
			zh = 4.033,
			ja = 6.666
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
				arg_21_0:Play116151006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_24_0 = arg_21_1.actors_["1066ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1066ui_story == nil then
				arg_21_1.var_.characterEffect1066ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_1 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 and not isNil(var_24_0) then
				if arg_21_1.var_.characterEffect1066ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1066ui_story then
				arg_21_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_24_3 = arg_21_1.actors_["1033ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1033ui_story == nil then
				arg_21_1.var_.characterEffect1033ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect1033ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_4)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1033ui_story then
				arg_21_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_24_5 = 0
			local var_24_6 = 0.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(116151005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 14 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 14)

				if (14 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 14)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151005", "story_v_out_116151.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151005", "story_v_out_116151.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_116151", "116151005", "story_v_out_116151.awb")

						arg_21_1:RecordAudio("116151005", var_24_12)
						arg_21_1:RecordAudio("116151005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116151", "116151005", "story_v_out_116151.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116151", "116151005", "story_v_out_116151.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play116151006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116151006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116151007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1033ui_story"]) and arg_25_1.var_.characterEffect1033ui_story == nil then
				arg_25_1.var_.characterEffect1033ui_story = arg_25_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1033ui_story"]) then
				if arg_25_1.var_.characterEffect1033ui_story and not isNil(arg_25_1.actors_["1033ui_story"]) then
					arg_25_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1033ui_story"]) and arg_25_1.var_.characterEffect1033ui_story then
				arg_25_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.actors_["1066ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1066ui_story == nil then
				arg_25_1.var_.characterEffect1066ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1066ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1066ui_story then
				arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.05

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(116151006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 2 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 2)

				if (2 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 2)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151006", "story_v_out_116151.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151006", "story_v_out_116151.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_116151", "116151006", "story_v_out_116151.awb")

						arg_25_1:RecordAudio("116151006", var_28_11)
						arg_25_1:RecordAudio("116151006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_116151", "116151006", "story_v_out_116151.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_116151", "116151006", "story_v_out_116151.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116151007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116151007
		arg_29_1.duration_ = 5.9

		local var_29_0 = {
			zh = 4.033,
			ja = 5.9
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
				arg_29_0:Play116151008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_32_0 = arg_29_1.actors_["1066ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(var_32_0) then
				if arg_29_1.var_.characterEffect1066ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1066ui_story then
				arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_32_3 = arg_29_1.actors_["1033ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect1033ui_story == nil then
				arg_29_1.var_.characterEffect1033ui_story = var_32_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 and not isNil(var_32_3) then
				if arg_29_1.var_.characterEffect1033ui_story and not isNil(var_32_3) then
					arg_29_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_4)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect1033ui_story then
				arg_29_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_32_5 = 0
			local var_32_6 = 0.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(116151007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 15 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 15)

				if (15 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 15)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151007", "story_v_out_116151.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151007", "story_v_out_116151.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_116151", "116151007", "story_v_out_116151.awb")

						arg_29_1:RecordAudio("116151007", var_32_12)
						arg_29_1:RecordAudio("116151007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_116151", "116151007", "story_v_out_116151.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_116151", "116151007", "story_v_out_116151.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116151008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116151008
		arg_33_1.duration_ = 5.7

		local var_33_0 = {
			zh = 5.7,
			ja = 4.366
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
				arg_33_0:Play116151009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1033ui_story"]) and arg_33_1.var_.characterEffect1033ui_story == nil then
				arg_33_1.var_.characterEffect1033ui_story = arg_33_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1033ui_story"]) then
				if arg_33_1.var_.characterEffect1033ui_story and not isNil(arg_33_1.actors_["1033ui_story"]) then
					arg_33_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1033ui_story"]) and arg_33_1.var_.characterEffect1033ui_story then
				arg_33_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["1066ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1066ui_story == nil then
				arg_33_1.var_.characterEffect1066ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1066ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1066ui_story then
				arg_33_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_36_4 = 0
			local var_36_5 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(116151008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 25 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 25)

				if (25 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 25)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151008", "story_v_out_116151.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151008", "story_v_out_116151.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_116151", "116151008", "story_v_out_116151.awb")

						arg_33_1:RecordAudio("116151008", var_36_11)
						arg_33_1:RecordAudio("116151008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116151", "116151008", "story_v_out_116151.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116151", "116151008", "story_v_out_116151.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116151009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116151009
		arg_37_1.duration_ = 5.5

		local var_37_0 = {
			zh = 3.733,
			ja = 5.5
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
				arg_37_0:Play116151010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_40_0 = arg_37_1.actors_["1066ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(var_40_0) then
				if arg_37_1.var_.characterEffect1066ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1066ui_story then
				arg_37_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_40_3 = arg_37_1.actors_["1033ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1033ui_story == nil then
				arg_37_1.var_.characterEffect1033ui_story = var_40_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_4 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 and not isNil(var_40_3) then
				if arg_37_1.var_.characterEffect1033ui_story and not isNil(var_40_3) then
					arg_37_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_4)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1033ui_story then
				arg_37_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_40_5 = 0
			local var_40_6 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(116151009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 15 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 15)

				if (15 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 15)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151009", "story_v_out_116151.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151009", "story_v_out_116151.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_116151", "116151009", "story_v_out_116151.awb")

						arg_37_1:RecordAudio("116151009", var_40_12)
						arg_37_1:RecordAudio("116151009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116151", "116151009", "story_v_out_116151.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116151", "116151009", "story_v_out_116151.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116151010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116151010
		arg_41_1.duration_ = 9.33

		local var_41_0 = {
			zh = 6.966,
			ja = 9.333
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
				arg_41_0:Play116151011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_0 = 0
			local var_44_1 = 0.85

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(116151010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 34 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 34)

				if (34 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 34)) > 0 and var_44_1 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151010", "story_v_out_116151.awb") ~= 0 then
					local var_44_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151010", "story_v_out_116151.awb") / 1000

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end

					if var_44_2.prefab_name ~= "" and arg_41_1.actors_[var_44_2.prefab_name] ~= nil then
						local var_44_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_2.prefab_name].transform, "story_v_out_116151", "116151010", "story_v_out_116151.awb")

						arg_41_1:RecordAudio("116151010", var_44_7)
						arg_41_1:RecordAudio("116151010", var_44_7)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116151", "116151010", "story_v_out_116151.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116151", "116151010", "story_v_out_116151.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play116151011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116151011
		arg_45_1.duration_ = 7.47

		local var_45_0 = {
			zh = 7.466,
			ja = 3.733
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
				arg_45_0:Play116151012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1033ui_story"]) and arg_45_1.var_.characterEffect1033ui_story == nil then
				arg_45_1.var_.characterEffect1033ui_story = arg_45_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1033ui_story"]) then
				if arg_45_1.var_.characterEffect1033ui_story and not isNil(arg_45_1.actors_["1033ui_story"]) then
					arg_45_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1033ui_story"]) and arg_45_1.var_.characterEffect1033ui_story then
				arg_45_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_48_2 = arg_45_1.actors_["1066ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1066ui_story == nil then
				arg_45_1.var_.characterEffect1066ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect1066ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1066ui_story then
				arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action432")
			end

			local var_48_4 = 0
			local var_48_5 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(116151011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 28 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 28)

				if (28 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 28)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151011", "story_v_out_116151.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151011", "story_v_out_116151.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_116151", "116151011", "story_v_out_116151.awb")

						arg_45_1:RecordAudio("116151011", var_48_11)
						arg_45_1:RecordAudio("116151011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116151", "116151011", "story_v_out_116151.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116151", "116151011", "story_v_out_116151.awb")
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

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116151012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116151012
		arg_49_1.duration_ = 2.23

		local var_49_0 = {
			zh = 2.1,
			ja = 2.233
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
				arg_49_0:Play116151013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1066ui_story"]) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = arg_49_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1066ui_story"]) then
				if arg_49_1.var_.characterEffect1066ui_story and not isNil(arg_49_1.actors_["1066ui_story"]) then
					arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1066ui_story"]) and arg_49_1.var_.characterEffect1066ui_story then
				arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1033ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1033ui_story == nil then
				arg_49_1.var_.characterEffect1033ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1033ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1033ui_story then
				arg_49_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(116151012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 6 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 6)

				if (6 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 6)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151012", "story_v_out_116151.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151012", "story_v_out_116151.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_116151", "116151012", "story_v_out_116151.awb")

						arg_49_1:RecordAudio("116151012", var_52_11)
						arg_49_1:RecordAudio("116151012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116151", "116151012", "story_v_out_116151.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116151", "116151012", "story_v_out_116151.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116151013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116151013
		arg_53_1.duration_ = 2.8

		local var_53_0 = {
			zh = 2,
			ja = 2.8
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
				arg_53_0:Play116151014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = arg_53_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) then
				if arg_53_1.var_.characterEffect1066ui_story and not isNil(arg_53_1.actors_["1066ui_story"]) then
					arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) and arg_53_1.var_.characterEffect1066ui_story then
				arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_56_1 = arg_53_1.actors_["1033ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1033ui_story == nil then
				arg_53_1.var_.characterEffect1033ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1033ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1033ui_story then
				arg_53_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_4 = 0
			local var_56_5 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(116151013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 9 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 9)

				if (9 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 9)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151013", "story_v_out_116151.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151013", "story_v_out_116151.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_116151", "116151013", "story_v_out_116151.awb")

						arg_53_1:RecordAudio("116151013", var_56_11)
						arg_53_1:RecordAudio("116151013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116151", "116151013", "story_v_out_116151.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116151", "116151013", "story_v_out_116151.awb")
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

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116151014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116151014
		arg_57_1.duration_ = 2.83

		local var_57_0 = {
			zh = 2.333,
			ja = 2.833
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
				arg_57_0:Play116151015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1066ui_story"]) and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = arg_57_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1066ui_story"]) then
				if arg_57_1.var_.characterEffect1066ui_story and not isNil(arg_57_1.actors_["1066ui_story"]) then
					arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1066ui_story"]) and arg_57_1.var_.characterEffect1066ui_story then
				arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1033ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1033ui_story == nil then
				arg_57_1.var_.characterEffect1033ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1033ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1033ui_story then
				arg_57_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(116151014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 8 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 8)

				if (8 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 8)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151014", "story_v_out_116151.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151014", "story_v_out_116151.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_116151", "116151014", "story_v_out_116151.awb")

						arg_57_1:RecordAudio("116151014", var_60_11)
						arg_57_1:RecordAudio("116151014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116151", "116151014", "story_v_out_116151.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116151", "116151014", "story_v_out_116151.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play116151015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116151015
		arg_61_1.duration_ = 9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play116151016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 1.966 < arg_61_1.time_ and arg_61_1.time_ <= 1.966 + arg_64_0 then
				arg_61_1.var_.moveOldPos1033ui_story = arg_61_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 1.966 <= arg_61_1.time_ and arg_61_1.time_ < 1.966 + var_64_0 then
				arg_61_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 1.966) / var_64_0)
				arg_61_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1033ui_story"].transform.position).z)
				arg_61_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1033ui_story"].transform.localEulerAngles = arg_61_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 1.966 + var_64_0 and arg_61_1.time_ < 1.966 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1033ui_story"].transform.position).z)
				arg_61_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1033ui_story"].transform.localEulerAngles = arg_61_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1066ui_story"].transform

			if 1.966 < arg_61_1.time_ and arg_61_1.time_ <= 1.966 + arg_64_0 then
				arg_61_1.var_.moveOldPos1066ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 1.966 <= arg_61_1.time_ and arg_61_1.time_ < 1.966 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 1.966) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 1.966 + var_64_2 and arg_61_1.time_ < 1.966 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 100, 0)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_4 = 2

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 then
				local var_64_5 = Color.New(0, 0, 0)

				var_64_5.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_3) / var_64_4)
				arg_61_1.mask_.color = var_64_5
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 then
				local var_64_6 = Color.New(0, 0, 0)

				var_64_6.a = 1
				arg_61_1.mask_.color = var_64_6
			end

			local var_64_7 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_8 = 2

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 then
				local var_64_9 = Color.New(0, 0, 0)

				var_64_9.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_7) / var_64_8)
				arg_61_1.mask_.color = var_64_9
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 then
				local var_64_10 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_10.a = 0
				arg_61_1.mask_.color = var_64_10
			end

			local var_64_11 = "I05f"

			if arg_61_1.bgs_.I05f == nil then
				local var_64_12 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_64_11)
				var_64_12.name = var_64_11
				var_64_12.transform.parent = arg_61_1.stage_.transform
				var_64_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_[var_64_11] = var_64_12
			end

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				if arg_61_0.sceneSettingEffect_ then
					arg_61_1.sceneSettingEffect_.enabled = false
				end

				arg_61_1.sceneSettingGo_:SetActive(true)

				local var_64_13 = arg_61_1.bgs_.I05f

				arg_61_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_14 = var_64_13:GetComponent("SpriteRenderer")

				if var_64_14 and var_64_14.sprite then
					local var_64_15 = 2 * (var_64_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_13.transform.localScale = Vector3.New(var_64_15 / var_64_14.sprite.bounds.size.y < var_64_15 * manager.ui.mainCameraCom_.aspect / var_64_14.sprite.bounds.size.x and var_64_15 * manager.ui.mainCameraCom_.aspect / var_64_14.sprite.bounds.size.x or var_64_15 / var_64_14.sprite.bounds.size.y, var_64_15 / var_64_14.sprite.bounds.size.y < var_64_15 * manager.ui.mainCameraCom_.aspect / var_64_14.sprite.bounds.size.x and var_64_15 * manager.ui.mainCameraCom_.aspect / var_64_14.sprite.bounds.size.x or var_64_15 / var_64_14.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "I05f" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_16 = 4
			local var_64_17 = 0.375

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_18 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_18:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(116151015).content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 15 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_19) / 15)

				if (15 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_19) / 15)) > 0 and var_64_17 < var_64_21 then
					arg_61_1.talkMaxDuration = var_64_21
					var_64_16 = var_64_16 + 0.3

					if var_64_21 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = var_64_16 + 0.3
			local var_64_23 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_22 + var_64_23 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_22) / var_64_23

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_22 + var_64_23 and arg_61_1.time_ < var_64_22 + var_64_23 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play116151016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116151016
		arg_67_1.duration_ = 5.73

		local var_67_0 = {
			zh = 4.2,
			ja = 5.733
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play116151017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1033ui_story = arg_67_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1033ui_story"].transform.position).z)
				arg_67_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1033ui_story"].transform.localEulerAngles = arg_67_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_67_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1033ui_story"].transform.position).z)
				arg_67_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1033ui_story"].transform.localEulerAngles = arg_67_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_1 = arg_67_1.actors_["1033ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1033ui_story == nil then
				arg_67_1.var_.characterEffect1033ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1033ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1033ui_story then
				arg_67_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_70_4 = 0
			local var_70_5 = 0.525

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(116151016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 21 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 21)

				if (21 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 21)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151016", "story_v_out_116151.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151016", "story_v_out_116151.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_116151", "116151016", "story_v_out_116151.awb")

						arg_67_1:RecordAudio("116151016", var_70_11)
						arg_67_1:RecordAudio("116151016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116151", "116151016", "story_v_out_116151.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116151", "116151016", "story_v_out_116151.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play116151017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116151017
		arg_71_1.duration_ = 2.53

		local var_71_0 = {
			zh = 2.133,
			ja = 2.533
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
				arg_71_0:Play116151018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1033ui_story"]) and arg_71_1.var_.characterEffect1033ui_story == nil then
				arg_71_1.var_.characterEffect1033ui_story = arg_71_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1033ui_story"]) then
				if arg_71_1.var_.characterEffect1033ui_story and not isNil(arg_71_1.actors_["1033ui_story"]) then
					arg_71_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1033ui_story"]) and arg_71_1.var_.characterEffect1033ui_story then
				arg_71_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_74_1 = arg_71_1.actors_["1066ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1066ui_story = var_74_1.localPosition
			end

			local var_74_2 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_71_1.time_ - 0) / var_74_2)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_74_3 = arg_71_1.actors_["1066ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect1066ui_story == nil then
				arg_71_1.var_.characterEffect1066ui_story = var_74_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_4 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 and not isNil(var_74_3) then
				if arg_71_1.var_.characterEffect1066ui_story and not isNil(var_74_3) then
					arg_71_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect1066ui_story then
				arg_71_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_74_6 = 0
			local var_74_7 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(116151017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 8 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 8)

				if (8 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 8)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151017", "story_v_out_116151.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_116151", "116151017", "story_v_out_116151.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_116151", "116151017", "story_v_out_116151.awb")

						arg_71_1:RecordAudio("116151017", var_74_13)
						arg_71_1:RecordAudio("116151017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116151", "116151017", "story_v_out_116151.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116151", "116151017", "story_v_out_116151.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play116151018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116151018
		arg_75_1.duration_ = 9.63

		local var_75_0 = {
			zh = 4,
			ja = 9.633
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
				arg_75_0:Play116151019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_78_0 = arg_75_1.actors_["1033ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1033ui_story == nil then
				arg_75_1.var_.characterEffect1033ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_1 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 and not isNil(var_78_0) then
				if arg_75_1.var_.characterEffect1033ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1033ui_story then
				arg_75_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			local var_78_3 = arg_75_1.actors_["1066ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.characterEffect1066ui_story == nil then
				arg_75_1.var_.characterEffect1066ui_story = var_78_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_4 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 and not isNil(var_78_3) then
				if arg_75_1.var_.characterEffect1066ui_story and not isNil(var_78_3) then
					arg_75_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_4)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.characterEffect1066ui_story then
				arg_75_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_78_5 = 0
			local var_78_6 = 0.525

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(116151018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 21 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 21)

				if (21 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 21)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151018", "story_v_out_116151.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151018", "story_v_out_116151.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_116151", "116151018", "story_v_out_116151.awb")

						arg_75_1:RecordAudio("116151018", var_78_12)
						arg_75_1:RecordAudio("116151018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116151", "116151018", "story_v_out_116151.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116151", "116151018", "story_v_out_116151.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_13 and arg_75_1.time_ < var_78_5 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play116151019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116151019
		arg_79_1.duration_ = 7.77

		local var_79_0 = {
			zh = 4.966,
			ja = 7.766
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
				arg_79_0:Play116151020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_82_0 = arg_79_1.actors_["1066ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1066ui_story == nil then
				arg_79_1.var_.characterEffect1066ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect1066ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1066ui_story then
				arg_79_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_82_3 = arg_79_1.actors_["1033ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1033ui_story == nil then
				arg_79_1.var_.characterEffect1033ui_story = var_82_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 and not isNil(var_82_3) then
				if arg_79_1.var_.characterEffect1033ui_story and not isNil(var_82_3) then
					arg_79_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_4)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1033ui_story then
				arg_79_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_82_5 = 0
			local var_82_6 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:GetWordFromCfg(116151019)
				local var_82_8 = arg_79_1:FormatText(var_82_7.content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 23 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 23)

				if (23 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 23)) > 0 and var_82_6 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151019", "story_v_out_116151.awb") ~= 0 then
					local var_82_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151019", "story_v_out_116151.awb") / 1000

					if var_82_11 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_5
					end

					if var_82_7.prefab_name ~= "" and arg_79_1.actors_[var_82_7.prefab_name] ~= nil then
						local var_82_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_7.prefab_name].transform, "story_v_out_116151", "116151019", "story_v_out_116151.awb")

						arg_79_1:RecordAudio("116151019", var_82_12)
						arg_79_1:RecordAudio("116151019", var_82_12)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116151", "116151019", "story_v_out_116151.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116151", "116151019", "story_v_out_116151.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_13 and arg_79_1.time_ < var_82_5 + var_82_13 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116151020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116151020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116151021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1066ui_story"]) and arg_83_1.var_.characterEffect1066ui_story == nil then
				arg_83_1.var_.characterEffect1066ui_story = arg_83_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1066ui_story"]) then
				if arg_83_1.var_.characterEffect1066ui_story and not isNil(arg_83_1.actors_["1066ui_story"]) then
					arg_83_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1066ui_story"]) and arg_83_1.var_.characterEffect1066ui_story then
				arg_83_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(116151020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 26 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 26)

				if (26 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 26)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116151021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116151021
		arg_87_1.duration_ = 3.7

		local var_87_0 = {
			zh = 3.7,
			ja = 2.433
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
				arg_87_0:Play116151022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_90_0 = arg_87_1.actors_["1066ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1066ui_story == nil then
				arg_87_1.var_.characterEffect1066ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_1 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 and not isNil(var_90_0) then
				if arg_87_1.var_.characterEffect1066ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1066ui_story then
				arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_90_3 = 0
			local var_90_4 = 0.275

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:GetWordFromCfg(116151021)
				local var_90_6 = arg_87_1:FormatText(var_90_5.content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 11 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 11)

				if (11 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 11)) > 0 and var_90_4 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151021", "story_v_out_116151.awb") ~= 0 then
					local var_90_9 = manager.audio:GetVoiceLength("story_v_out_116151", "116151021", "story_v_out_116151.awb") / 1000

					if var_90_9 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_3
					end

					if var_90_5.prefab_name ~= "" and arg_87_1.actors_[var_90_5.prefab_name] ~= nil then
						local var_90_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_5.prefab_name].transform, "story_v_out_116151", "116151021", "story_v_out_116151.awb")

						arg_87_1:RecordAudio("116151021", var_90_10)
						arg_87_1:RecordAudio("116151021", var_90_10)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116151", "116151021", "story_v_out_116151.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116151", "116151021", "story_v_out_116151.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_11 and arg_87_1.time_ < var_90_3 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116151022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116151022
		arg_91_1.duration_ = 9.4

		local var_91_0 = {
			zh = 5.966,
			ja = 9.4
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
				arg_91_0:Play116151023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_94_0 = 0
			local var_94_1 = 0.75

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(116151022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 30 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_3) / 30)

				if (30 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_3) / 30)) > 0 and var_94_1 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151022", "story_v_out_116151.awb") ~= 0 then
					local var_94_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151022", "story_v_out_116151.awb") / 1000

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end

					if var_94_2.prefab_name ~= "" and arg_91_1.actors_[var_94_2.prefab_name] ~= nil then
						local var_94_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_2.prefab_name].transform, "story_v_out_116151", "116151022", "story_v_out_116151.awb")

						arg_91_1:RecordAudio("116151022", var_94_7)
						arg_91_1:RecordAudio("116151022", var_94_7)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116151", "116151022", "story_v_out_116151.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116151", "116151022", "story_v_out_116151.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play116151023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116151023
		arg_95_1.duration_ = 8.7

		local var_95_0 = {
			zh = 6.6,
			ja = 8.7
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
				arg_95_0:Play116151024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_98_0 = arg_95_1.actors_["1033ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1033ui_story == nil then
				arg_95_1.var_.characterEffect1033ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_1 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 and not isNil(var_98_0) then
				if arg_95_1.var_.characterEffect1033ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1033ui_story then
				arg_95_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_2")
			end

			local var_98_3 = arg_95_1.actors_["1066ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_3) and arg_95_1.var_.characterEffect1066ui_story == nil then
				arg_95_1.var_.characterEffect1066ui_story = var_98_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_4 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 and not isNil(var_98_3) then
				if arg_95_1.var_.characterEffect1066ui_story and not isNil(var_98_3) then
					arg_95_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_4)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 and not isNil(var_98_3) and arg_95_1.var_.characterEffect1066ui_story then
				arg_95_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_98_5 = 0
			local var_98_6 = 0.675

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(116151023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 27 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 27)

				if (27 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 27)) > 0 and var_98_6 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151023", "story_v_out_116151.awb") ~= 0 then
					local var_98_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151023", "story_v_out_116151.awb") / 1000

					if var_98_11 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_5
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_116151", "116151023", "story_v_out_116151.awb")

						arg_95_1:RecordAudio("116151023", var_98_12)
						arg_95_1:RecordAudio("116151023", var_98_12)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116151", "116151023", "story_v_out_116151.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116151", "116151023", "story_v_out_116151.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_13 and arg_95_1.time_ < var_98_5 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116151024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116151024
		arg_99_1.duration_ = 13.4

		local var_99_0 = {
			zh = 10.1,
			ja = 13.4
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
				arg_99_0:Play116151025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1033ui_story"]) and arg_99_1.var_.characterEffect1033ui_story == nil then
				arg_99_1.var_.characterEffect1033ui_story = arg_99_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1033ui_story"]) then
				if arg_99_1.var_.characterEffect1033ui_story and not isNil(arg_99_1.actors_["1033ui_story"]) then
					arg_99_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1033ui_story"]) and arg_99_1.var_.characterEffect1033ui_story then
				arg_99_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_102_1 = arg_99_1.actors_["1066ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1066ui_story == nil then
				arg_99_1.var_.characterEffect1066ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1066ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1066ui_story then
				arg_99_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_4 = 0
			local var_102_5 = 1.225

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(116151024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 49 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 49)

				if (49 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 49)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151024", "story_v_out_116151.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151024", "story_v_out_116151.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_116151", "116151024", "story_v_out_116151.awb")

						arg_99_1:RecordAudio("116151024", var_102_11)
						arg_99_1:RecordAudio("116151024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116151", "116151024", "story_v_out_116151.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116151", "116151024", "story_v_out_116151.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play116151025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116151025
		arg_103_1.duration_ = 6.07

		local var_103_0 = {
			zh = 3.6,
			ja = 6.066
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
				arg_103_0:Play116151026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_106_0 = arg_103_1.actors_["1033ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1033ui_story == nil then
				arg_103_1.var_.characterEffect1033ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_1 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 and not isNil(var_106_0) then
				if arg_103_1.var_.characterEffect1033ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1033ui_story then
				arg_103_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_106_3 = arg_103_1.actors_["1066ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect1066ui_story == nil then
				arg_103_1.var_.characterEffect1066ui_story = var_106_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_4 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 and not isNil(var_106_3) then
				if arg_103_1.var_.characterEffect1066ui_story and not isNil(var_106_3) then
					arg_103_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_4)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect1066ui_story then
				arg_103_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_106_5 = 0
			local var_106_6 = 0.475

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(116151025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 19 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 19)

				if (19 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 19)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151025", "story_v_out_116151.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151025", "story_v_out_116151.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_116151", "116151025", "story_v_out_116151.awb")

						arg_103_1:RecordAudio("116151025", var_106_12)
						arg_103_1:RecordAudio("116151025", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116151", "116151025", "story_v_out_116151.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116151", "116151025", "story_v_out_116151.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play116151026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 116151026
		arg_107_1.duration_ = 3.6

		local var_107_0 = {
			zh = 3.6,
			ja = 3.166
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
				arg_107_0:Play116151027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1033ui_story"]) and arg_107_1.var_.characterEffect1033ui_story == nil then
				arg_107_1.var_.characterEffect1033ui_story = arg_107_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1033ui_story"]) then
				if arg_107_1.var_.characterEffect1033ui_story and not isNil(arg_107_1.actors_["1033ui_story"]) then
					arg_107_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1033ui_story"]) and arg_107_1.var_.characterEffect1033ui_story then
				arg_107_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_110_1 = arg_107_1.actors_["1066ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1066ui_story == nil then
				arg_107_1.var_.characterEffect1066ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1066ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1066ui_story then
				arg_107_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_110_4 = 0
			local var_110_5 = 0.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(116151026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 17 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 17)

				if (17 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 17)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151026", "story_v_out_116151.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151026", "story_v_out_116151.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_116151", "116151026", "story_v_out_116151.awb")

						arg_107_1:RecordAudio("116151026", var_110_11)
						arg_107_1:RecordAudio("116151026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_116151", "116151026", "story_v_out_116151.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_116151", "116151026", "story_v_out_116151.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play116151027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116151027
		arg_111_1.duration_ = 8.23

		local var_111_0 = {
			zh = 8.233,
			ja = 7.866
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
				arg_111_0:Play116151028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_114_0 = arg_111_1.actors_["1033ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1033ui_story == nil then
				arg_111_1.var_.characterEffect1033ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_1 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 and not isNil(var_114_0) then
				if arg_111_1.var_.characterEffect1033ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1033ui_story then
				arg_111_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_114_3 = arg_111_1.actors_["1066ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect1066ui_story == nil then
				arg_111_1.var_.characterEffect1066ui_story = var_114_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_4 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 and not isNil(var_114_3) then
				if arg_111_1.var_.characterEffect1066ui_story and not isNil(var_114_3) then
					arg_111_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_4)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect1066ui_story then
				arg_111_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_114_5 = 0
			local var_114_6 = 0.95

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(116151027)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 38 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 38)

				if (38 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 38)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151027", "story_v_out_116151.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151027", "story_v_out_116151.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_116151", "116151027", "story_v_out_116151.awb")

						arg_111_1:RecordAudio("116151027", var_114_12)
						arg_111_1:RecordAudio("116151027", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_116151", "116151027", "story_v_out_116151.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_116151", "116151027", "story_v_out_116151.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_13 and arg_111_1.time_ < var_114_5 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play116151028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116151028
		arg_115_1.duration_ = 10.37

		local var_115_0 = {
			zh = 8.433,
			ja = 10.366
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
				arg_115_0:Play116151029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_118_0 = 0
			local var_118_1 = 0.95

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(116151028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 38 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 38)

				if (38 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 38)) > 0 and var_118_1 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151028", "story_v_out_116151.awb") ~= 0 then
					local var_118_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151028", "story_v_out_116151.awb") / 1000

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end

					if var_118_2.prefab_name ~= "" and arg_115_1.actors_[var_118_2.prefab_name] ~= nil then
						local var_118_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_2.prefab_name].transform, "story_v_out_116151", "116151028", "story_v_out_116151.awb")

						arg_115_1:RecordAudio("116151028", var_118_7)
						arg_115_1:RecordAudio("116151028", var_118_7)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116151", "116151028", "story_v_out_116151.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116151", "116151028", "story_v_out_116151.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play116151029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116151029
		arg_119_1.duration_ = 12.9

		local var_119_0 = {
			zh = 8.3,
			ja = 12.9
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
				arg_119_0:Play116151030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_0 = 0
			local var_122_1 = 1

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(116151029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 40 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_3) / 40)

				if (40 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_3) / 40)) > 0 and var_122_1 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151029", "story_v_out_116151.awb") ~= 0 then
					local var_122_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151029", "story_v_out_116151.awb") / 1000

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end

					if var_122_2.prefab_name ~= "" and arg_119_1.actors_[var_122_2.prefab_name] ~= nil then
						local var_122_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_2.prefab_name].transform, "story_v_out_116151", "116151029", "story_v_out_116151.awb")

						arg_119_1:RecordAudio("116151029", var_122_7)
						arg_119_1:RecordAudio("116151029", var_122_7)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_116151", "116151029", "story_v_out_116151.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_116151", "116151029", "story_v_out_116151.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play116151030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116151030
		arg_123_1.duration_ = 6.8

		local var_123_0 = {
			zh = 6.666,
			ja = 6.8
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
				arg_123_0:Play116151031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			local var_126_0 = 0
			local var_126_1 = 0.825

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(116151030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 33 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 33)

				if (33 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 33)) > 0 and var_126_1 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151030", "story_v_out_116151.awb") ~= 0 then
					local var_126_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151030", "story_v_out_116151.awb") / 1000

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end

					if var_126_2.prefab_name ~= "" and arg_123_1.actors_[var_126_2.prefab_name] ~= nil then
						local var_126_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_2.prefab_name].transform, "story_v_out_116151", "116151030", "story_v_out_116151.awb")

						arg_123_1:RecordAudio("116151030", var_126_7)
						arg_123_1:RecordAudio("116151030", var_126_7)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_116151", "116151030", "story_v_out_116151.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_116151", "116151030", "story_v_out_116151.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play116151031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116151031
		arg_127_1.duration_ = 8.07

		local var_127_0 = {
			zh = 3.7,
			ja = 8.066
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
				arg_127_0:Play116151032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1033ui_story"]) and arg_127_1.var_.characterEffect1033ui_story == nil then
				arg_127_1.var_.characterEffect1033ui_story = arg_127_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1033ui_story"]) then
				if arg_127_1.var_.characterEffect1033ui_story and not isNil(arg_127_1.actors_["1033ui_story"]) then
					arg_127_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1033ui_story"]) and arg_127_1.var_.characterEffect1033ui_story then
				arg_127_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["1066ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1066ui_story == nil then
				arg_127_1.var_.characterEffect1066ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1066ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1066ui_story then
				arg_127_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_130_4 = 0
			local var_130_5 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(116151031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 14 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 14)

				if (14 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 14)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151031", "story_v_out_116151.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151031", "story_v_out_116151.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_116151", "116151031", "story_v_out_116151.awb")

						arg_127_1:RecordAudio("116151031", var_130_11)
						arg_127_1:RecordAudio("116151031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_116151", "116151031", "story_v_out_116151.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_116151", "116151031", "story_v_out_116151.awb")
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
	Play116151032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116151032
		arg_131_1.duration_ = 14.03

		local var_131_0 = {
			zh = 12.233,
			ja = 14.033
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
				arg_131_0:Play116151033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_134_0 = 0
			local var_134_1 = 1.425

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(116151032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 57 <= 0 and var_134_1 or var_134_1 * (utf8.len(var_134_3) / 57)

				if (57 <= 0 and var_134_1 or var_134_1 * (utf8.len(var_134_3) / 57)) > 0 and var_134_1 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151032", "story_v_out_116151.awb") ~= 0 then
					local var_134_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151032", "story_v_out_116151.awb") / 1000

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end

					if var_134_2.prefab_name ~= "" and arg_131_1.actors_[var_134_2.prefab_name] ~= nil then
						local var_134_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_2.prefab_name].transform, "story_v_out_116151", "116151032", "story_v_out_116151.awb")

						arg_131_1:RecordAudio("116151032", var_134_7)
						arg_131_1:RecordAudio("116151032", var_134_7)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_116151", "116151032", "story_v_out_116151.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_116151", "116151032", "story_v_out_116151.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play116151033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116151033
		arg_135_1.duration_ = 2

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116151034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_138_0 = arg_135_1.actors_["1033ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1033ui_story == nil then
				arg_135_1.var_.characterEffect1033ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_1 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 and not isNil(var_138_0) then
				if arg_135_1.var_.characterEffect1033ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1033ui_story then
				arg_135_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_138_3 = arg_135_1.actors_["1066ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_3) and arg_135_1.var_.characterEffect1066ui_story == nil then
				arg_135_1.var_.characterEffect1066ui_story = var_138_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_4 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 and not isNil(var_138_3) then
				if arg_135_1.var_.characterEffect1066ui_story and not isNil(var_138_3) then
					arg_135_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_4)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 and not isNil(var_138_3) and arg_135_1.var_.characterEffect1066ui_story then
				arg_135_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_138_5 = 0
			local var_138_6 = 0.15

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(116151033)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 6 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 6)

				if (6 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 6)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151033", "story_v_out_116151.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151033", "story_v_out_116151.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_116151", "116151033", "story_v_out_116151.awb")

						arg_135_1:RecordAudio("116151033", var_138_12)
						arg_135_1:RecordAudio("116151033", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_116151", "116151033", "story_v_out_116151.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_116151", "116151033", "story_v_out_116151.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116151034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116151034
		arg_139_1.duration_ = 15.47

		local var_139_0 = {
			zh = 13.033,
			ja = 15.466
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
				arg_139_0:Play116151035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1033ui_story"]) and arg_139_1.var_.characterEffect1033ui_story == nil then
				arg_139_1.var_.characterEffect1033ui_story = arg_139_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1033ui_story"]) then
				if arg_139_1.var_.characterEffect1033ui_story and not isNil(arg_139_1.actors_["1033ui_story"]) then
					arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1033ui_story"]) and arg_139_1.var_.characterEffect1033ui_story then
				arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_142_1 = arg_139_1.actors_["1066ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1066ui_story == nil then
				arg_139_1.var_.characterEffect1066ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1066ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1066ui_story then
				arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_142_4 = 0
			local var_142_5 = 1.575

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(116151034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 63 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 63)

				if (63 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 63)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151034", "story_v_out_116151.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151034", "story_v_out_116151.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_116151", "116151034", "story_v_out_116151.awb")

						arg_139_1:RecordAudio("116151034", var_142_11)
						arg_139_1:RecordAudio("116151034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_116151", "116151034", "story_v_out_116151.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_116151", "116151034", "story_v_out_116151.awb")
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

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play116151035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116151035
		arg_143_1.duration_ = 7.93

		local var_143_0 = {
			zh = 7.933,
			ja = 4.233
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
				arg_143_0:Play116151036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_146_0 = 0
			local var_146_1 = 0.925

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(116151035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 37 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 37)

				if (37 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 37)) > 0 and var_146_1 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151035", "story_v_out_116151.awb") ~= 0 then
					local var_146_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151035", "story_v_out_116151.awb") / 1000

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end

					if var_146_2.prefab_name ~= "" and arg_143_1.actors_[var_146_2.prefab_name] ~= nil then
						local var_146_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_2.prefab_name].transform, "story_v_out_116151", "116151035", "story_v_out_116151.awb")

						arg_143_1:RecordAudio("116151035", var_146_7)
						arg_143_1:RecordAudio("116151035", var_146_7)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116151", "116151035", "story_v_out_116151.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116151", "116151035", "story_v_out_116151.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116151036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116151036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116151037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1066ui_story"]) and arg_147_1.var_.characterEffect1066ui_story == nil then
				arg_147_1.var_.characterEffect1066ui_story = arg_147_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1066ui_story"]) then
				if arg_147_1.var_.characterEffect1066ui_story and not isNil(arg_147_1.actors_["1066ui_story"]) then
					arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1066ui_story"]) and arg_147_1.var_.characterEffect1066ui_story then
				arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:AudioAction("play", "effect", "se_story_16", "se_story_16_jili", "")
			end

			local var_150_2 = 0
			local var_150_3 = 0.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(116151036).content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 12 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_4) / 12)

				if (12 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_4) / 12)) > 0 and var_150_3 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_7 and arg_147_1.time_ < var_150_2 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play116151037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116151037
		arg_151_1.duration_ = 3.03

		local var_151_0 = {
			zh = 3.033,
			ja = 2.466
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
				arg_151_0:Play116151038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1066ui_story"]) and arg_151_1.var_.characterEffect1066ui_story == nil then
				arg_151_1.var_.characterEffect1066ui_story = arg_151_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1066ui_story"]) then
				if arg_151_1.var_.characterEffect1066ui_story and not isNil(arg_151_1.actors_["1066ui_story"]) then
					arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1066ui_story"]) and arg_151_1.var_.characterEffect1066ui_story then
				arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_154_2 = 0
			local var_154_3 = 0.25

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(116151037)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 10 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 10)

				if (10 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 10)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151037", "story_v_out_116151.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_116151", "116151037", "story_v_out_116151.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_116151", "116151037", "story_v_out_116151.awb")

						arg_151_1:RecordAudio("116151037", var_154_9)
						arg_151_1:RecordAudio("116151037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_116151", "116151037", "story_v_out_116151.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_116151", "116151037", "story_v_out_116151.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116151038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116151038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play116151039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1066ui_story"]) and arg_155_1.var_.characterEffect1066ui_story == nil then
				arg_155_1.var_.characterEffect1066ui_story = arg_155_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1066ui_story"]) then
				if arg_155_1.var_.characterEffect1066ui_story and not isNil(arg_155_1.actors_["1066ui_story"]) then
					arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1066ui_story"]) and arg_155_1.var_.characterEffect1066ui_story then
				arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(116151038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 22 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 22)

				if (22 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 22)) > 0 and var_158_2 < var_158_5 then
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

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play116151039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116151039
		arg_159_1.duration_ = 4

		local var_159_0 = {
			zh = 3.233,
			ja = 4
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
				arg_159_0:Play116151040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_162_0 = arg_159_1.actors_["1033ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1033ui_story == nil then
				arg_159_1.var_.characterEffect1033ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_1 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 and not isNil(var_162_0) then
				if arg_159_1.var_.characterEffect1033ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1033ui_story then
				arg_159_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_2")
			end

			local var_162_3 = 0
			local var_162_4 = 0.375

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:GetWordFromCfg(116151039)
				local var_162_6 = arg_159_1:FormatText(var_162_5.content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 15 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 15)

				if (15 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 15)) > 0 and var_162_4 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151039", "story_v_out_116151.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_116151", "116151039", "story_v_out_116151.awb") / 1000

					if var_162_9 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_3
					end

					if var_162_5.prefab_name ~= "" and arg_159_1.actors_[var_162_5.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_5.prefab_name].transform, "story_v_out_116151", "116151039", "story_v_out_116151.awb")

						arg_159_1:RecordAudio("116151039", var_162_10)
						arg_159_1:RecordAudio("116151039", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_116151", "116151039", "story_v_out_116151.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_116151", "116151039", "story_v_out_116151.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_11 and arg_159_1.time_ < var_162_3 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play116151040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116151040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play116151041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1033ui_story = arg_163_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).z)
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles = arg_163_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).z)
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles = arg_163_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1066ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1066ui_story = var_166_1.localPosition
			end

			local var_166_2 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_2)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(0, 100, 0)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			local var_166_3 = manager.ui.mainCamera.transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.shakeOldPos = var_166_3.localPosition
			end

			local var_166_4 = 0.6

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				local var_166_5, var_166_6 = math.modf((arg_163_1.time_ - 0) / 0.066)

				var_166_3.localPosition = Vector3.New(var_166_6 * 0.13, var_166_6 * 0.13, var_166_6 * 0.13) + arg_163_1.var_.shakeOldPos
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_3.localPosition = arg_163_1.var_.shakeOldPos
			end

			local var_166_7 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_7 + 0.6 and arg_163_1.time_ < var_166_7 + 0.6 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "effect", "se_story_15", "se_story_15_blast03", "")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_166_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_11 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_11

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_11
						arg_163_1.bgmTxt2_.text = var_166_11
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.075 < arg_163_1.time_ and arg_163_1.time_ <= 0.075 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_166_14 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_14 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_14

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_14
						arg_163_1.bgmTxt2_.text = var_166_14
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_15 = 0
			local var_166_16 = 0.075

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_17 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(116151040).content)

				arg_163_1.text_.text = var_166_17

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_19 = 3 <= 0 and var_166_16 or var_166_16 * (utf8.len(var_166_17) / 3)

				if (3 <= 0 and var_166_16 or var_166_16 * (utf8.len(var_166_17) / 3)) > 0 and var_166_16 < var_166_19 then
					arg_163_1.talkMaxDuration = var_166_19

					if var_166_19 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_19 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_17
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_20 and arg_163_1.time_ < var_166_15 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play116151041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116151041
		arg_169_1.duration_ = 2.7

		local var_169_0 = {
			zh = 1.7,
			ja = 2.7
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
				arg_169_0:Play116151042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.15

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(116151041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 6 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 6)

				if (6 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 6)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151041", "story_v_out_116151.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_116151", "116151041", "story_v_out_116151.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_116151", "116151041", "story_v_out_116151.awb")

						arg_169_1:RecordAudio("116151041", var_172_6)
						arg_169_1:RecordAudio("116151041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_116151", "116151041", "story_v_out_116151.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_116151", "116151041", "story_v_out_116151.awb")
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
	Play116151042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116151042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116151043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.45

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(116151042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 18 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 18)

				if (18 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 18)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116151043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116151043
		arg_177_1.duration_ = 3.37

		local var_177_0 = {
			zh = 3.366,
			ja = 3.033
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
				arg_177_0:Play116151044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1066ui_story = arg_177_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1066ui_story"].transform.position).z)
				arg_177_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1066ui_story"].transform.localEulerAngles = arg_177_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_177_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1066ui_story"].transform.position).z)
				arg_177_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1066ui_story"].transform.localEulerAngles = arg_177_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_180_1 = arg_177_1.actors_["1066ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1066ui_story == nil then
				arg_177_1.var_.characterEffect1066ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1066ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1066ui_story then
				arg_177_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_180_4 = 0
			local var_180_5 = 0.275

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(116151043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 11 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 11)

				if (11 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 11)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151043", "story_v_out_116151.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151043", "story_v_out_116151.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_116151", "116151043", "story_v_out_116151.awb")

						arg_177_1:RecordAudio("116151043", var_180_11)
						arg_177_1:RecordAudio("116151043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_116151", "116151043", "story_v_out_116151.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_116151", "116151043", "story_v_out_116151.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play116151044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116151044
		arg_181_1.duration_ = 5.97

		local var_181_0 = {
			zh = 3.066,
			ja = 5.966
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
				arg_181_0:Play116151045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1066ui_story"]) and arg_181_1.var_.characterEffect1066ui_story == nil then
				arg_181_1.var_.characterEffect1066ui_story = arg_181_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1066ui_story"]) then
				if arg_181_1.var_.characterEffect1066ui_story and not isNil(arg_181_1.actors_["1066ui_story"]) then
					arg_181_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1066ui_story"]) and arg_181_1.var_.characterEffect1066ui_story then
				arg_181_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_184_1 = arg_181_1.actors_["1033ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1033ui_story = var_184_1.localPosition
			end

			local var_184_2 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 then
				var_184_1.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_181_1.time_ - 0) / var_184_2)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 then
				var_184_1.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_184_3 = arg_181_1.actors_["1033ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_3) and arg_181_1.var_.characterEffect1033ui_story == nil then
				arg_181_1.var_.characterEffect1033ui_story = var_184_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_4 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 and not isNil(var_184_3) then
				if arg_181_1.var_.characterEffect1033ui_story and not isNil(var_184_3) then
					arg_181_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 and not isNil(var_184_3) and arg_181_1.var_.characterEffect1033ui_story then
				arg_181_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_184_6 = 0
			local var_184_7 = 0.3

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(116151044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 12 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 12)

				if (12 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 12)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151044", "story_v_out_116151.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_116151", "116151044", "story_v_out_116151.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_116151", "116151044", "story_v_out_116151.awb")

						arg_181_1:RecordAudio("116151044", var_184_13)
						arg_181_1:RecordAudio("116151044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_116151", "116151044", "story_v_out_116151.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_116151", "116151044", "story_v_out_116151.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play116151045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116151045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116151046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1033ui_story = arg_185_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1033ui_story"].transform.position).z)
				arg_185_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1033ui_story"].transform.localEulerAngles = arg_185_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1033ui_story"].transform.position).z)
				arg_185_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1033ui_story"].transform.localEulerAngles = arg_185_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1066ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1066ui_story = var_188_1.localPosition
			end

			local var_188_2 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 then
				var_188_1.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_2)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 then
				var_188_1.localPosition = Vector3.New(0, 100, 0)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			local var_188_3 = 0
			local var_188_4 = 0.925

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_5 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(116151045).content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 37 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 37)

				if (37 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 37)) > 0 and var_188_4 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_8 and arg_185_1.time_ < var_188_3 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play116151046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116151046
		arg_189_1.duration_ = 4.93

		local var_189_0 = {
			zh = 3.666,
			ja = 4.933
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
				arg_189_0:Play116151047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.45

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(116151046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 18 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 18)

				if (18 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 18)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151046", "story_v_out_116151.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_116151", "116151046", "story_v_out_116151.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_116151", "116151046", "story_v_out_116151.awb")

						arg_189_1:RecordAudio("116151046", var_192_6)
						arg_189_1:RecordAudio("116151046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116151", "116151046", "story_v_out_116151.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116151", "116151046", "story_v_out_116151.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116151047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116151047
		arg_193_1.duration_ = 2.3

		local var_193_0 = {
			zh = 1.666,
			ja = 2.3
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
				arg_193_0:Play116151048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_196_0 = 0.6

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				local var_196_1, var_196_2 = math.modf((arg_193_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_196_2 * 0.13, var_196_2 * 0.13, var_196_2 * 0.13) + arg_193_1.var_.shakeOldPos
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				manager.ui.mainCamera.transform.localPosition = arg_193_1.var_.shakeOldPos
			end

			local var_196_3 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_3 + 0.6 and arg_193_1.time_ < var_196_3 + 0.6 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_4 = 0
			local var_196_5 = 0.2

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_6 = arg_193_1:GetWordFromCfg(116151047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 8 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 8)

				if (8 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 8)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151047", "story_v_out_116151.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151047", "story_v_out_116151.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_116151", "116151047", "story_v_out_116151.awb")

						arg_193_1:RecordAudio("116151047", var_196_11)
						arg_193_1:RecordAudio("116151047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116151", "116151047", "story_v_out_116151.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116151", "116151047", "story_v_out_116151.awb")
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

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116151048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116151048
		arg_197_1.duration_ = 7

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116151049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_0 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				local var_200_1 = Color.New(1, 1, 1)

				var_200_1.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.mask_.color = var_200_1
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				local var_200_2 = Color.New(1, 1, 1)

				arg_197_1.mask_.enabled = false
				var_200_2.a = 0
				arg_197_1.mask_.color = var_200_2
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_magic", "")
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_4 = 1.999999999999
			local var_200_5 = 0.75

			if 1.999999999999 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_6 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_6:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(116151048).content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 30 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 30)

				if (30 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 30)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9
					var_200_4 = var_200_4 + 0.3

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = var_200_4 + 0.3
			local var_200_11 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_10) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116151049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116151049
		arg_203_1.duration_ = 2.13

		local var_203_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_203_0:Play116151050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1033ui_story = arg_203_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1033ui_story"].transform.position).z)
				arg_203_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1033ui_story"].transform.localEulerAngles = arg_203_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_203_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1033ui_story"].transform.position).z)
				arg_203_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1033ui_story"].transform.localEulerAngles = arg_203_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_206_1 = arg_203_1.actors_["1033ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1033ui_story == nil then
				arg_203_1.var_.characterEffect1033ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1033ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1033ui_story then
				arg_203_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_206_4 = 0
			local var_206_5 = 0.1

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(116151049)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 4 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 4)

				if (4 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 4)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151049", "story_v_out_116151.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151049", "story_v_out_116151.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_116151", "116151049", "story_v_out_116151.awb")

						arg_203_1:RecordAudio("116151049", var_206_11)
						arg_203_1:RecordAudio("116151049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_116151", "116151049", "story_v_out_116151.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_116151", "116151049", "story_v_out_116151.awb")
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
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play116151050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116151050
		arg_207_1.duration_ = 3.23

		local var_207_0 = {
			zh = 3.166,
			ja = 3.233
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
				arg_207_0:Play116151051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1066ui_story = arg_207_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1066ui_story"].transform.position).z)
				arg_207_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1066ui_story"].transform.localEulerAngles = arg_207_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_207_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1066ui_story"].transform.position).z)
				arg_207_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1066ui_story"].transform.localEulerAngles = arg_207_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_210_1 = arg_207_1.actors_["1066ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1066ui_story == nil then
				arg_207_1.var_.characterEffect1066ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1066ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1066ui_story then
				arg_207_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["1033ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1033ui_story == nil then
				arg_207_1.var_.characterEffect1033ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_5 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 and not isNil(var_210_4) then
				if arg_207_1.var_.characterEffect1033ui_story and not isNil(var_210_4) then
					arg_207_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_5)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1033ui_story then
				arg_207_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_210_6 = 0
			local var_210_7 = 0.325

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(116151050)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 13 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 13)

				if (13 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 13)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151050", "story_v_out_116151.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_116151", "116151050", "story_v_out_116151.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_116151", "116151050", "story_v_out_116151.awb")

						arg_207_1:RecordAudio("116151050", var_210_13)
						arg_207_1:RecordAudio("116151050", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116151", "116151050", "story_v_out_116151.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116151", "116151050", "story_v_out_116151.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play116151051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116151051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play116151052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1033ui_story = arg_211_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).z)
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles = arg_211_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).z)
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles = arg_211_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1066ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1066ui_story = var_214_1.localPosition
			end

			local var_214_2 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 then
				var_214_1.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_2)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 then
				var_214_1.localPosition = Vector3.New(0, 100, 0)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			local var_214_3 = 0
			local var_214_4 = 0.975

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(116151051).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 39 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 39)

				if (39 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 39)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play116151052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116151052
		arg_215_1.duration_ = 3.4

		local var_215_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_215_0:Play116151053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_218_0 = 0.6

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				local var_218_1, var_218_2 = math.modf((arg_215_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_218_2 * 0.13, var_218_2 * 0.13, var_218_2 * 0.13) + arg_215_1.var_.shakeOldPos
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				manager.ui.mainCamera.transform.localPosition = arg_215_1.var_.shakeOldPos
			end

			local var_218_3 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_3 + 0.6 and arg_215_1.time_ < var_218_3 + 0.6 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_4 = 0
			local var_218_5 = 0.275

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_6 = arg_215_1:GetWordFromCfg(116151052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 11 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 11)

				if (11 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 11)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151052", "story_v_out_116151.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151052", "story_v_out_116151.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_116151", "116151052", "story_v_out_116151.awb")

						arg_215_1:RecordAudio("116151052", var_218_11)
						arg_215_1:RecordAudio("116151052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_116151", "116151052", "story_v_out_116151.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_116151", "116151052", "story_v_out_116151.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play116151053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116151053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play116151054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story_16", "se_story_16_energy", "")
			end

			local var_222_1 = 0
			local var_222_2 = 1.15

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(116151053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 46 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 46)

				if (46 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 46)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play116151054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116151054
		arg_223_1.duration_ = 7

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play116151055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.SK0111 == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0111")
				var_226_0.name = "SK0111"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.SK0111 = var_226_0
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.SK0111

				arg_223_1.bgs_.SK0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "SK0111" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_5 = 2

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_5 then
				local var_226_6 = Color.New(1, 1, 1)

				var_226_6.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_4) / var_226_5)
				arg_223_1.mask_.color = var_226_6
			end

			if arg_223_1.time_ >= var_226_4 + var_226_5 and arg_223_1.time_ < var_226_4 + var_226_5 + arg_226_0 then
				local var_226_7 = Color.New(1, 1, 1)

				arg_223_1.mask_.enabled = false
				var_226_7.a = 0
				arg_223_1.mask_.color = var_226_7
			end

			local var_226_8 = arg_223_1.bgs_.SK0111.transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPosSK0111 = var_226_8.localPosition
			end

			local var_226_9 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_9 then
				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosSK0111, Vector3.New(0, 1, 9), (arg_223_1.time_ - 0) / var_226_9)
			end

			if arg_223_1.time_ >= 0 + var_226_9 and arg_223_1.time_ < 0 + var_226_9 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(0, 1, 9)
			end

			local var_226_10 = arg_223_1.bgs_.SK0111.transform

			if 0.034 < arg_223_1.time_ and arg_223_1.time_ <= 0.034 + arg_226_0 then
				arg_223_1.var_.moveOldPosSK0111 = var_226_10.localPosition
			end

			local var_226_11 = 4

			if 0.034 <= arg_223_1.time_ and arg_223_1.time_ < 0.034 + var_226_11 then
				var_226_10.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosSK0111, Vector3.New(0, 1, 10), (arg_223_1.time_ - 0.034) / var_226_11)
			end

			if arg_223_1.time_ >= 0.034 + var_226_11 and arg_223_1.time_ < 0.034 + var_226_11 + arg_226_0 then
				var_226_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_226_12 = manager.ui.mainCamera.transform

			if 1.86666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 1.86666666666667 + arg_226_0 then
				arg_223_1.var_.shakeOldPosSK0111 = var_226_12.localPosition
			end

			local var_226_13 = 0.6

			if 1.86666666666667 <= arg_223_1.time_ and arg_223_1.time_ < 1.86666666666667 + var_226_13 then
				local var_226_14, var_226_15 = math.modf((arg_223_1.time_ - 1.86666666666667) / 0.066)

				var_226_12.localPosition = Vector3.New(var_226_15 * 0.13, var_226_15 * 0.13, var_226_15 * 0.13) + arg_223_1.var_.shakeOldPosSK0111
			end

			if arg_223_1.time_ >= 1.86666666666667 + var_226_13 and arg_223_1.time_ < 1.86666666666667 + var_226_13 + arg_226_0 then
				var_226_12.localPosition = arg_223_1.var_.shakeOldPosSK0111
			end

			local var_226_16 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_16 + 2.034 and arg_223_1.time_ < var_226_16 + 2.034 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			if 1.86666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 1.86666666666667 + arg_226_0 then
				arg_223_1:AudioAction("play", "effect", "se_story_16", "se_story_16_energy02", "")
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_18 = 2
			local var_226_19 = 0.1

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_18 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_20 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_20:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_21 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(116151054).content)

				arg_223_1.text_.text = var_226_21

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_23 = 4 <= 0 and var_226_19 or var_226_19 * (utf8.len(var_226_21) / 4)

				if (4 <= 0 and var_226_19 or var_226_19 * (utf8.len(var_226_21) / 4)) > 0 and var_226_19 < var_226_23 then
					arg_223_1.talkMaxDuration = var_226_23
					var_226_18 = var_226_18 + 0.3

					if var_226_23 + var_226_18 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_18
					end
				end

				arg_223_1.text_.text = var_226_21
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_24 = var_226_18 + 0.3
			local var_226_25 = math.max(var_226_19, arg_223_1.talkMaxDuration)

			if var_226_18 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_24 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_24) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_24 + var_226_25 and arg_223_1.time_ < var_226_24 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play116151055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 116151055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play116151056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.375

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(116151055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 15 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 15)

				if (15 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 15)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play116151056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 116151056
		arg_233_1.duration_ = 4.67

		local var_233_0 = {
			zh = 4.133,
			ja = 4.666
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
				arg_233_0:Play116151057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.325

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:GetWordFromCfg(116151056)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 13 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 13)

				if (13 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 13)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151056", "story_v_out_116151.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_116151", "116151056", "story_v_out_116151.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_116151", "116151056", "story_v_out_116151.awb")

						arg_233_1:RecordAudio("116151056", var_236_6)
						arg_233_1:RecordAudio("116151056", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_116151", "116151056", "story_v_out_116151.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_116151", "116151056", "story_v_out_116151.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play116151057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 116151057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play116151058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.325

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(116151057).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 53 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 53)

				if (53 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 53)) > 0 and var_240_0 < var_240_3 then
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
	Play116151058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 116151058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play116151059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1.575

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(116151058).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 63 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 63)

				if (63 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 63)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play116151059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 116151059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play116151060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.725

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(116151059).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 29 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 29)

				if (29 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 29)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play116151060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116151060
		arg_249_1.duration_ = 2.53

		local var_249_0 = {
			zh = 2.5,
			ja = 2.533
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play116151061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.175

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:GetWordFromCfg(116151060)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 7 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 7)

				if (7 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 7)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151060", "story_v_out_116151.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_116151", "116151060", "story_v_out_116151.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_116151", "116151060", "story_v_out_116151.awb")

						arg_249_1:RecordAudio("116151060", var_252_6)
						arg_249_1:RecordAudio("116151060", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116151", "116151060", "story_v_out_116151.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116151", "116151060", "story_v_out_116151.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play116151061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116151061
		arg_253_1.duration_ = 9

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play116151062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 2 < arg_253_1.time_ and arg_253_1.time_ <= 2 + arg_256_0 then
				if arg_253_0.sceneSettingEffect_ then
					arg_253_1.sceneSettingEffect_.enabled = false
				end

				arg_253_1.sceneSettingGo_:SetActive(true)

				local var_256_0 = arg_253_1.bgs_.I05f

				arg_253_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_256_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_1 = var_256_0:GetComponent("SpriteRenderer")

				if var_256_1 and var_256_1.sprite then
					local var_256_2 = 2 * (var_256_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_256_0.transform.localScale = Vector3.New(var_256_2 / var_256_1.sprite.bounds.size.y < var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x and var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x or var_256_2 / var_256_1.sprite.bounds.size.y, var_256_2 / var_256_1.sprite.bounds.size.y < var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x and var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x or var_256_2 / var_256_1.sprite.bounds.size.y, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "I05f" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_3 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_4 = 2

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_4 then
				local var_256_5 = Color.New(0, 0, 0)

				var_256_5.a = Mathf.Lerp(0, 1, (arg_253_1.time_ - var_256_3) / var_256_4)
				arg_253_1.mask_.color = var_256_5
			end

			if arg_253_1.time_ >= var_256_3 + var_256_4 and arg_253_1.time_ < var_256_3 + var_256_4 + arg_256_0 then
				local var_256_6 = Color.New(0, 0, 0)

				var_256_6.a = 1
				arg_253_1.mask_.color = var_256_6
			end

			local var_256_7 = 2

			if 2 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_8 = 2

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_8 then
				local var_256_9 = Color.New(0, 0, 0)

				var_256_9.a = Mathf.Lerp(1, 0, (arg_253_1.time_ - var_256_7) / var_256_8)
				arg_253_1.mask_.color = var_256_9
			end

			if arg_253_1.time_ >= var_256_7 + var_256_8 and arg_253_1.time_ < var_256_7 + var_256_8 + arg_256_0 then
				local var_256_10 = Color.New(0, 0, 0)

				arg_253_1.mask_.enabled = false
				var_256_10.a = 0
				arg_253_1.mask_.color = var_256_10
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_11 = 4
			local var_256_12 = 0.525

			if 4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_11 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_13 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_13:setOnUpdate(LuaHelper.FloatAction(function(arg_257_0)
					arg_253_1.dialogCg_.alpha = arg_257_0
				end))
				var_256_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_14 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(116151061).content)

				arg_253_1.text_.text = var_256_14

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_16 = 21 <= 0 and var_256_12 or var_256_12 * (utf8.len(var_256_14) / 21)

				if (21 <= 0 and var_256_12 or var_256_12 * (utf8.len(var_256_14) / 21)) > 0 and var_256_12 < var_256_16 then
					arg_253_1.talkMaxDuration = var_256_16
					var_256_11 = var_256_11 + 0.3

					if var_256_16 + var_256_11 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_11
					end
				end

				arg_253_1.text_.text = var_256_14
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_17 = var_256_11 + 0.3
			local var_256_18 = math.max(var_256_12, arg_253_1.talkMaxDuration)

			if var_256_11 + 0.3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_17 + var_256_18 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_17) / var_256_18

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_17 + var_256_18 and arg_253_1.time_ < var_256_17 + var_256_18 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play116151062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116151062
		arg_259_1.duration_ = 5.27

		local var_259_0 = {
			zh = 3.833,
			ja = 5.266
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play116151063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1066ui_story = arg_259_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1066ui_story"].transform.position).z)
				arg_259_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1066ui_story"].transform.localEulerAngles = arg_259_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_259_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1066ui_story"].transform.position).z)
				arg_259_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1066ui_story"].transform.localEulerAngles = arg_259_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_262_1 = arg_259_1.actors_["1066ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1066ui_story == nil then
				arg_259_1.var_.characterEffect1066ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1066ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1066ui_story then
				arg_259_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_262_4 = 0
			local var_262_5 = 0.5

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(116151062)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 20 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 20)

				if (20 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 20)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151062", "story_v_out_116151.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151062", "story_v_out_116151.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_116151", "116151062", "story_v_out_116151.awb")

						arg_259_1:RecordAudio("116151062", var_262_11)
						arg_259_1:RecordAudio("116151062", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_116151", "116151062", "story_v_out_116151.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_116151", "116151062", "story_v_out_116151.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play116151063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116151063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play116151064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1066ui_story = arg_263_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).z)
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles = arg_263_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).z)
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles = arg_263_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_266_1 = 0
			local var_266_2 = 0.675

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(116151063).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 27 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 27)

				if (27 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 27)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play116151064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116151064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play116151065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.95

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(116151064).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 38 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 38)

				if (38 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 38)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play116151065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116151065
		arg_271_1.duration_ = 7.43

		local var_271_0 = {
			zh = 4.833,
			ja = 7.433
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play116151066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1033ui_story = arg_271_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1033ui_story"].transform.position).z)
				arg_271_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1033ui_story"].transform.localEulerAngles = arg_271_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_271_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1033ui_story"].transform.position).z)
				arg_271_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1033ui_story"].transform.localEulerAngles = arg_271_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_274_1 = arg_271_1.actors_["1033ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1033ui_story == nil then
				arg_271_1.var_.characterEffect1033ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1033ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1033ui_story then
				arg_271_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_274_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_271_1.bgmTxt_.text ~= var_274_6 and arg_271_1.bgmTxt_.text ~= "" then
						if arg_271_1.bgmTxt2_.text ~= "" then
							arg_271_1.bgmTxt_.text = arg_271_1.bgmTxt2_.text
						end

						arg_271_1.bgmTxt2_.text = var_274_6

						arg_271_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_271_1.bgmTxt_.text = var_274_6
						arg_271_1.bgmTxt2_.text = var_274_6
					end

					if arg_271_1.bgmTimer then
						arg_271_1.bgmTimer:Stop()

						arg_271_1.bgmTimer = nil
					end

					if arg_271_1.settingData.show_music_name == 1 then
						arg_271_1.musicController:SetSelectedState("show")
						arg_271_1.musicAnimator_:Play("open", 0, 0)

						if arg_271_1.settingData.music_time ~= 0 then
							arg_271_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_271_1.settingData.music_time), function()
								if arg_271_1 == nil or isNil(arg_271_1.bgmTxt_) then
									return
								end

								arg_271_1.musicController:SetSelectedState("hide")
								arg_271_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_271_1.time_ and arg_271_1.time_ <= 0.333333333333333 + arg_274_0 then
				arg_271_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_274_9 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_271_1.bgmTxt_.text ~= var_274_9 and arg_271_1.bgmTxt_.text ~= "" then
						if arg_271_1.bgmTxt2_.text ~= "" then
							arg_271_1.bgmTxt_.text = arg_271_1.bgmTxt2_.text
						end

						arg_271_1.bgmTxt2_.text = var_274_9

						arg_271_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_271_1.bgmTxt_.text = var_274_9
						arg_271_1.bgmTxt2_.text = var_274_9
					end

					if arg_271_1.bgmTimer then
						arg_271_1.bgmTimer:Stop()

						arg_271_1.bgmTimer = nil
					end

					if arg_271_1.settingData.show_music_name == 1 then
						arg_271_1.musicController:SetSelectedState("show")
						arg_271_1.musicAnimator_:Play("open", 0, 0)

						if arg_271_1.settingData.music_time ~= 0 then
							arg_271_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_271_1.settingData.music_time), function()
								if arg_271_1 == nil or isNil(arg_271_1.bgmTxt_) then
									return
								end

								arg_271_1.musicController:SetSelectedState("hide")
								arg_271_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_274_10 = 0
			local var_274_11 = 0.6

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_12 = arg_271_1:GetWordFromCfg(116151065)
				local var_274_13 = arg_271_1:FormatText(var_274_12.content)

				arg_271_1.text_.text = var_274_13

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_15 = 24 <= 0 and var_274_11 or var_274_11 * (utf8.len(var_274_13) / 24)

				if (24 <= 0 and var_274_11 or var_274_11 * (utf8.len(var_274_13) / 24)) > 0 and var_274_11 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15

					if var_274_15 + var_274_10 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_10
					end
				end

				arg_271_1.text_.text = var_274_13
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151065", "story_v_out_116151.awb") ~= 0 then
					local var_274_16 = manager.audio:GetVoiceLength("story_v_out_116151", "116151065", "story_v_out_116151.awb") / 1000

					if var_274_16 + var_274_10 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_16 + var_274_10
					end

					if var_274_12.prefab_name ~= "" and arg_271_1.actors_[var_274_12.prefab_name] ~= nil then
						local var_274_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_12.prefab_name].transform, "story_v_out_116151", "116151065", "story_v_out_116151.awb")

						arg_271_1:RecordAudio("116151065", var_274_17)
						arg_271_1:RecordAudio("116151065", var_274_17)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116151", "116151065", "story_v_out_116151.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116151", "116151065", "story_v_out_116151.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_18 = math.max(var_274_11, arg_271_1.talkMaxDuration)

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_18 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_10) / var_274_18

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_10 + var_274_18 and arg_271_1.time_ < var_274_10 + var_274_18 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play116151066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 116151066
		arg_277_1.duration_ = 6.73

		local var_277_0 = {
			zh = 4.133,
			ja = 6.733
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
				arg_277_0:Play116151067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1066ui_story = arg_277_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1066ui_story"].transform.position).z)
				arg_277_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1066ui_story"].transform.localEulerAngles = arg_277_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_277_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1066ui_story"].transform.position).z)
				arg_277_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1066ui_story"].transform.localEulerAngles = arg_277_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_280_1 = arg_277_1.actors_["1066ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1066ui_story == nil then
				arg_277_1.var_.characterEffect1066ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1066ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1066ui_story then
				arg_277_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["1033ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1033ui_story == nil then
				arg_277_1.var_.characterEffect1033ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_5 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 and not isNil(var_280_4) then
				if arg_277_1.var_.characterEffect1033ui_story and not isNil(var_280_4) then
					arg_277_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_5)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1033ui_story then
				arg_277_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_280_6 = 0
			local var_280_7 = 0.6

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(116151066)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 24 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 24)

				if (24 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 24)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151066", "story_v_out_116151.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_116151", "116151066", "story_v_out_116151.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_116151", "116151066", "story_v_out_116151.awb")

						arg_277_1:RecordAudio("116151066", var_280_13)
						arg_277_1:RecordAudio("116151066", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_116151", "116151066", "story_v_out_116151.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_116151", "116151066", "story_v_out_116151.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play116151067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 116151067
		arg_281_1.duration_ = 12.1

		local var_281_0 = {
			zh = 12.1,
			ja = 9.666
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
				arg_281_0:Play116151068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_284_0 = arg_281_1.actors_["1033ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1033ui_story == nil then
				arg_281_1.var_.characterEffect1033ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_1 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 and not isNil(var_284_0) then
				if arg_281_1.var_.characterEffect1033ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1033ui_story then
				arg_281_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_284_3 = arg_281_1.actors_["1066ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1066ui_story == nil then
				arg_281_1.var_.characterEffect1066ui_story = var_284_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_4 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 and not isNil(var_284_3) then
				if arg_281_1.var_.characterEffect1066ui_story and not isNil(var_284_3) then
					arg_281_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_4)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1066ui_story then
				arg_281_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_284_5 = 0
			local var_284_6 = 1.525

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(116151067)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 61 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 61)

				if (61 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 61)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151067", "story_v_out_116151.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151067", "story_v_out_116151.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_116151", "116151067", "story_v_out_116151.awb")

						arg_281_1:RecordAudio("116151067", var_284_12)
						arg_281_1:RecordAudio("116151067", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_116151", "116151067", "story_v_out_116151.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_116151", "116151067", "story_v_out_116151.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play116151068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 116151068
		arg_285_1.duration_ = 4.53

		local var_285_0 = {
			zh = 2.266,
			ja = 4.533
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play116151069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_288_0 = arg_285_1.actors_["1066ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1066ui_story == nil then
				arg_285_1.var_.characterEffect1066ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_1 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 and not isNil(var_288_0) then
				if arg_285_1.var_.characterEffect1066ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1066ui_story then
				arg_285_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_288_3 = arg_285_1.actors_["1033ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_3) and arg_285_1.var_.characterEffect1033ui_story == nil then
				arg_285_1.var_.characterEffect1033ui_story = var_288_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_4 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 and not isNil(var_288_3) then
				if arg_285_1.var_.characterEffect1033ui_story and not isNil(var_288_3) then
					arg_285_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_4)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 and not isNil(var_288_3) and arg_285_1.var_.characterEffect1033ui_story then
				arg_285_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_288_5 = 0
			local var_288_6 = 0.25

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(116151068)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 10 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 10)

				if (10 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 10)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151068", "story_v_out_116151.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151068", "story_v_out_116151.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_116151", "116151068", "story_v_out_116151.awb")

						arg_285_1:RecordAudio("116151068", var_288_12)
						arg_285_1:RecordAudio("116151068", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_116151", "116151068", "story_v_out_116151.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_116151", "116151068", "story_v_out_116151.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play116151069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 116151069
		arg_289_1.duration_ = 14.9

		local var_289_0 = {
			zh = 8.866,
			ja = 14.9
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
				arg_289_0:Play116151070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_292_0 = arg_289_1.actors_["1033ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1033ui_story == nil then
				arg_289_1.var_.characterEffect1033ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_1 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 and not isNil(var_292_0) then
				if arg_289_1.var_.characterEffect1033ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1033ui_story then
				arg_289_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_292_3 = arg_289_1.actors_["1066ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect1066ui_story == nil then
				arg_289_1.var_.characterEffect1066ui_story = var_292_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_4 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 and not isNil(var_292_3) then
				if arg_289_1.var_.characterEffect1066ui_story and not isNil(var_292_3) then
					arg_289_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_4)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect1066ui_story then
				arg_289_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_292_5 = 0
			local var_292_6 = 0.85

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_7 = arg_289_1:GetWordFromCfg(116151069)
				local var_292_8 = arg_289_1:FormatText(var_292_7.content)

				arg_289_1.text_.text = var_292_8

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 34 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 34)

				if (34 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 34)) > 0 and var_292_6 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_8
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151069", "story_v_out_116151.awb") ~= 0 then
					local var_292_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151069", "story_v_out_116151.awb") / 1000

					if var_292_11 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_5
					end

					if var_292_7.prefab_name ~= "" and arg_289_1.actors_[var_292_7.prefab_name] ~= nil then
						local var_292_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_7.prefab_name].transform, "story_v_out_116151", "116151069", "story_v_out_116151.awb")

						arg_289_1:RecordAudio("116151069", var_292_12)
						arg_289_1:RecordAudio("116151069", var_292_12)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_116151", "116151069", "story_v_out_116151.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_116151", "116151069", "story_v_out_116151.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_13 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_13 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_13

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_13 and arg_289_1.time_ < var_292_5 + var_292_13 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play116151070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 116151070
		arg_293_1.duration_ = 9.33

		local var_293_0 = {
			zh = 9.333,
			ja = 5.066
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
				arg_293_0:Play116151071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_296_0 = 0
			local var_296_1 = 1.05

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(116151070)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 42 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 42)

				if (42 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 42)) > 0 and var_296_1 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151070", "story_v_out_116151.awb") ~= 0 then
					local var_296_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151070", "story_v_out_116151.awb") / 1000

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end

					if var_296_2.prefab_name ~= "" and arg_293_1.actors_[var_296_2.prefab_name] ~= nil then
						local var_296_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_2.prefab_name].transform, "story_v_out_116151", "116151070", "story_v_out_116151.awb")

						arg_293_1:RecordAudio("116151070", var_296_7)
						arg_293_1:RecordAudio("116151070", var_296_7)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_116151", "116151070", "story_v_out_116151.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_116151", "116151070", "story_v_out_116151.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play116151071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116151071
		arg_297_1.duration_ = 3.97

		local var_297_0 = {
			zh = 3.6,
			ja = 3.966
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
				arg_297_0:Play116151072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_300_0 = arg_297_1.actors_["1066ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1066ui_story == nil then
				arg_297_1.var_.characterEffect1066ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_1 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 and not isNil(var_300_0) then
				if arg_297_1.var_.characterEffect1066ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1066ui_story then
				arg_297_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_300_3 = arg_297_1.actors_["1033ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_3) and arg_297_1.var_.characterEffect1033ui_story == nil then
				arg_297_1.var_.characterEffect1033ui_story = var_300_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_4 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 and not isNil(var_300_3) then
				if arg_297_1.var_.characterEffect1033ui_story and not isNil(var_300_3) then
					arg_297_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_4)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 and not isNil(var_300_3) and arg_297_1.var_.characterEffect1033ui_story then
				arg_297_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_300_5 = 0
			local var_300_6 = 0.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_7 = arg_297_1:GetWordFromCfg(116151071)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 20 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 20)

				if (20 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 20)) > 0 and var_300_6 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151071", "story_v_out_116151.awb") ~= 0 then
					local var_300_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151071", "story_v_out_116151.awb") / 1000

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_116151", "116151071", "story_v_out_116151.awb")

						arg_297_1:RecordAudio("116151071", var_300_12)
						arg_297_1:RecordAudio("116151071", var_300_12)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_116151", "116151071", "story_v_out_116151.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_116151", "116151071", "story_v_out_116151.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_13 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_13 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_13

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_13 and arg_297_1.time_ < var_300_5 + var_300_13 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play116151072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 116151072
		arg_301_1.duration_ = 5.87

		local var_301_0 = {
			zh = 5.866,
			ja = 4.266
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
				arg_301_0:Play116151073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_304_0 = arg_301_1.actors_["1033ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1033ui_story == nil then
				arg_301_1.var_.characterEffect1033ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_1 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 and not isNil(var_304_0) then
				if arg_301_1.var_.characterEffect1033ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1033ui_story then
				arg_301_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_304_3 = arg_301_1.actors_["1066ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_3) and arg_301_1.var_.characterEffect1066ui_story == nil then
				arg_301_1.var_.characterEffect1066ui_story = var_304_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_4 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 and not isNil(var_304_3) then
				if arg_301_1.var_.characterEffect1066ui_story and not isNil(var_304_3) then
					arg_301_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_4)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 and not isNil(var_304_3) and arg_301_1.var_.characterEffect1066ui_story then
				arg_301_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_304_5 = 0
			local var_304_6 = 0.6

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_7 = arg_301_1:GetWordFromCfg(116151072)
				local var_304_8 = arg_301_1:FormatText(var_304_7.content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 24 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 24)

				if (24 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 24)) > 0 and var_304_6 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_5
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151072", "story_v_out_116151.awb") ~= 0 then
					local var_304_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151072", "story_v_out_116151.awb") / 1000

					if var_304_11 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_5
					end

					if var_304_7.prefab_name ~= "" and arg_301_1.actors_[var_304_7.prefab_name] ~= nil then
						local var_304_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_7.prefab_name].transform, "story_v_out_116151", "116151072", "story_v_out_116151.awb")

						arg_301_1:RecordAudio("116151072", var_304_12)
						arg_301_1:RecordAudio("116151072", var_304_12)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_116151", "116151072", "story_v_out_116151.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_116151", "116151072", "story_v_out_116151.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_6, arg_301_1.talkMaxDuration)

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_5) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_5 + var_304_13 and arg_301_1.time_ < var_304_5 + var_304_13 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play116151073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 116151073
		arg_305_1.duration_ = 4.57

		local var_305_0 = {
			zh = 4.2,
			ja = 4.566
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play116151074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_308_0 = arg_305_1.actors_["1066ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1066ui_story == nil then
				arg_305_1.var_.characterEffect1066ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_1 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 and not isNil(var_308_0) then
				if arg_305_1.var_.characterEffect1066ui_story and not isNil(var_308_0) then
					arg_305_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1066ui_story then
				arg_305_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_308_3 = arg_305_1.actors_["1033ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_3) and arg_305_1.var_.characterEffect1033ui_story == nil then
				arg_305_1.var_.characterEffect1033ui_story = var_308_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_4 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 and not isNil(var_308_3) then
				if arg_305_1.var_.characterEffect1033ui_story and not isNil(var_308_3) then
					arg_305_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_4)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 and not isNil(var_308_3) and arg_305_1.var_.characterEffect1033ui_story then
				arg_305_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_308_5 = 0
			local var_308_6 = 0.5

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:GetWordFromCfg(116151073)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 20 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 20)

				if (20 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 20)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151073", "story_v_out_116151.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151073", "story_v_out_116151.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_116151", "116151073", "story_v_out_116151.awb")

						arg_305_1:RecordAudio("116151073", var_308_12)
						arg_305_1:RecordAudio("116151073", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_116151", "116151073", "story_v_out_116151.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_116151", "116151073", "story_v_out_116151.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_13 and arg_305_1.time_ < var_308_5 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play116151074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 116151074
		arg_309_1.duration_ = 6.87

		local var_309_0 = {
			zh = 2.333,
			ja = 6.866
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
				arg_309_0:Play116151075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_312_0 = arg_309_1.actors_["1033ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1033ui_story == nil then
				arg_309_1.var_.characterEffect1033ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_1 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 and not isNil(var_312_0) then
				if arg_309_1.var_.characterEffect1033ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1033ui_story then
				arg_309_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_312_3 = arg_309_1.actors_["1066ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_3) and arg_309_1.var_.characterEffect1066ui_story == nil then
				arg_309_1.var_.characterEffect1066ui_story = var_312_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_4 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 and not isNil(var_312_3) then
				if arg_309_1.var_.characterEffect1066ui_story and not isNil(var_312_3) then
					arg_309_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_4)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 and not isNil(var_312_3) and arg_309_1.var_.characterEffect1066ui_story then
				arg_309_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_312_5 = 0
			local var_312_6 = 0.35

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(116151074)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 14 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 14)

				if (14 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 14)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151074", "story_v_out_116151.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151074", "story_v_out_116151.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_116151", "116151074", "story_v_out_116151.awb")

						arg_309_1:RecordAudio("116151074", var_312_12)
						arg_309_1:RecordAudio("116151074", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_116151", "116151074", "story_v_out_116151.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_116151", "116151074", "story_v_out_116151.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_13 and arg_309_1.time_ < var_312_5 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play116151075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 116151075
		arg_313_1.duration_ = 12.17

		local var_313_0 = {
			zh = 7.533,
			ja = 12.166
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
				arg_313_0:Play116151076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_316_0 = 0
			local var_316_1 = 0.925

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(116151075)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 37 <= 0 and var_316_1 or var_316_1 * (utf8.len(var_316_3) / 37)

				if (37 <= 0 and var_316_1 or var_316_1 * (utf8.len(var_316_3) / 37)) > 0 and var_316_1 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151075", "story_v_out_116151.awb") ~= 0 then
					local var_316_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151075", "story_v_out_116151.awb") / 1000

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end

					if var_316_2.prefab_name ~= "" and arg_313_1.actors_[var_316_2.prefab_name] ~= nil then
						local var_316_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_2.prefab_name].transform, "story_v_out_116151", "116151075", "story_v_out_116151.awb")

						arg_313_1:RecordAudio("116151075", var_316_7)
						arg_313_1:RecordAudio("116151075", var_316_7)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_116151", "116151075", "story_v_out_116151.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_116151", "116151075", "story_v_out_116151.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play116151076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 116151076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play116151077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1033ui_story"]) and arg_317_1.var_.characterEffect1033ui_story == nil then
				arg_317_1.var_.characterEffect1033ui_story = arg_317_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1033ui_story"]) then
				if arg_317_1.var_.characterEffect1033ui_story and not isNil(arg_317_1.actors_["1033ui_story"]) then
					arg_317_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1033ui_story"]) and arg_317_1.var_.characterEffect1033ui_story then
				arg_317_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.775

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(116151076).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 31 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 31)

				if (31 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 31)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play116151077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 116151077
		arg_321_1.duration_ = 3.27

		local var_321_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play116151078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1033ui_story"]) and arg_321_1.var_.characterEffect1033ui_story == nil then
				arg_321_1.var_.characterEffect1033ui_story = arg_321_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1033ui_story"]) then
				if arg_321_1.var_.characterEffect1033ui_story and not isNil(arg_321_1.actors_["1033ui_story"]) then
					arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1033ui_story"]) and arg_321_1.var_.characterEffect1033ui_story then
				arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_324_2 = 0
			local var_324_3 = 0.125

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(116151077)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 5 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 5)

				if (5 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 5)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151077", "story_v_out_116151.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_116151", "116151077", "story_v_out_116151.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_out_116151", "116151077", "story_v_out_116151.awb")

						arg_321_1:RecordAudio("116151077", var_324_9)
						arg_321_1:RecordAudio("116151077", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_116151", "116151077", "story_v_out_116151.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_116151", "116151077", "story_v_out_116151.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play116151078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 116151078
		arg_325_1.duration_ = 7.97

		local var_325_0 = {
			zh = 6.366,
			ja = 7.966
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
				arg_325_0:Play116151079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_328_0 = arg_325_1.actors_["1066ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1066ui_story == nil then
				arg_325_1.var_.characterEffect1066ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_1 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_1 and not isNil(var_328_0) then
				if arg_325_1.var_.characterEffect1066ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_1 and arg_325_1.time_ < 0 + var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1066ui_story then
				arg_325_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_328_3 = arg_325_1.actors_["1033ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_3) and arg_325_1.var_.characterEffect1033ui_story == nil then
				arg_325_1.var_.characterEffect1033ui_story = var_328_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_4 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 and not isNil(var_328_3) then
				if arg_325_1.var_.characterEffect1033ui_story and not isNil(var_328_3) then
					arg_325_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_4)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 and not isNil(var_328_3) and arg_325_1.var_.characterEffect1033ui_story then
				arg_325_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_328_5 = 0
			local var_328_6 = 0.65

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_7 = arg_325_1:GetWordFromCfg(116151078)
				local var_328_8 = arg_325_1:FormatText(var_328_7.content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 26 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 26)

				if (26 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 26)) > 0 and var_328_6 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151078", "story_v_out_116151.awb") ~= 0 then
					local var_328_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151078", "story_v_out_116151.awb") / 1000

					if var_328_11 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_5
					end

					if var_328_7.prefab_name ~= "" and arg_325_1.actors_[var_328_7.prefab_name] ~= nil then
						local var_328_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_7.prefab_name].transform, "story_v_out_116151", "116151078", "story_v_out_116151.awb")

						arg_325_1:RecordAudio("116151078", var_328_12)
						arg_325_1:RecordAudio("116151078", var_328_12)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_116151", "116151078", "story_v_out_116151.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_116151", "116151078", "story_v_out_116151.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_13 and arg_325_1.time_ < var_328_5 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play116151079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 116151079
		arg_329_1.duration_ = 6.8

		local var_329_0 = {
			zh = 6.8,
			ja = 5.3
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
				arg_329_0:Play116151080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_332_0 = arg_329_1.actors_["1033ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1033ui_story == nil then
				arg_329_1.var_.characterEffect1033ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_1 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_1 and not isNil(var_332_0) then
				if arg_329_1.var_.characterEffect1033ui_story and not isNil(var_332_0) then
					arg_329_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_1 and arg_329_1.time_ < 0 + var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1033ui_story then
				arg_329_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_332_3 = arg_329_1.actors_["1066ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_3) and arg_329_1.var_.characterEffect1066ui_story == nil then
				arg_329_1.var_.characterEffect1066ui_story = var_332_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_4 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 and not isNil(var_332_3) then
				if arg_329_1.var_.characterEffect1066ui_story and not isNil(var_332_3) then
					arg_329_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_4)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 and not isNil(var_332_3) and arg_329_1.var_.characterEffect1066ui_story then
				arg_329_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			local var_332_5 = 0
			local var_332_6 = 0.825

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_7 = arg_329_1:GetWordFromCfg(116151079)
				local var_332_8 = arg_329_1:FormatText(var_332_7.content)

				arg_329_1.text_.text = var_332_8

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 33 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 33)

				if (33 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 33)) > 0 and var_332_6 < var_332_10 then
					arg_329_1.talkMaxDuration = var_332_10

					if var_332_10 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_5
					end
				end

				arg_329_1.text_.text = var_332_8
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151079", "story_v_out_116151.awb") ~= 0 then
					local var_332_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151079", "story_v_out_116151.awb") / 1000

					if var_332_11 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_11 + var_332_5
					end

					if var_332_7.prefab_name ~= "" and arg_329_1.actors_[var_332_7.prefab_name] ~= nil then
						local var_332_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_7.prefab_name].transform, "story_v_out_116151", "116151079", "story_v_out_116151.awb")

						arg_329_1:RecordAudio("116151079", var_332_12)
						arg_329_1:RecordAudio("116151079", var_332_12)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_116151", "116151079", "story_v_out_116151.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_116151", "116151079", "story_v_out_116151.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_6, arg_329_1.talkMaxDuration)

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_5) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_5 + var_332_13 and arg_329_1.time_ < var_332_5 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play116151080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 116151080
		arg_333_1.duration_ = 9.2

		local var_333_0 = {
			zh = 9.2,
			ja = 7.9
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play116151081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_336_0 = arg_333_1.actors_["1066ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1066ui_story == nil then
				arg_333_1.var_.characterEffect1066ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_1 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 and not isNil(var_336_0) then
				if arg_333_1.var_.characterEffect1066ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1066ui_story then
				arg_333_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_336_3 = arg_333_1.actors_["1033ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_3) and arg_333_1.var_.characterEffect1033ui_story == nil then
				arg_333_1.var_.characterEffect1033ui_story = var_336_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_4 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 and not isNil(var_336_3) then
				if arg_333_1.var_.characterEffect1033ui_story and not isNil(var_336_3) then
					arg_333_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_4)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 and not isNil(var_336_3) and arg_333_1.var_.characterEffect1033ui_story then
				arg_333_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_336_5 = 0
			local var_336_6 = 1.1

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(116151080)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 44 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 44)

				if (44 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 44)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151080", "story_v_out_116151.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_116151", "116151080", "story_v_out_116151.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_116151", "116151080", "story_v_out_116151.awb")

						arg_333_1:RecordAudio("116151080", var_336_12)
						arg_333_1:RecordAudio("116151080", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_116151", "116151080", "story_v_out_116151.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_116151", "116151080", "story_v_out_116151.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_13 and arg_333_1.time_ < var_336_5 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play116151081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 116151081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play116151082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1066ui_story = arg_337_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1066ui_story"].transform.position).z)
				arg_337_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1066ui_story"].transform.localEulerAngles = arg_337_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1066ui_story"].transform.position).z)
				arg_337_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1066ui_story"].transform.localEulerAngles = arg_337_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1033ui_story"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1033ui_story = var_340_1.localPosition
			end

			local var_340_2 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 then
				var_340_1.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_2)
				var_340_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_1.position).x, (manager.ui.mainCamera.transform.position - var_340_1.position).y, (manager.ui.mainCamera.transform.position - var_340_1.position).z)
				var_340_1.localEulerAngles.z = 0
				var_340_1.localEulerAngles.x = 0
				var_340_1.localEulerAngles = var_340_1.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 then
				var_340_1.localPosition = Vector3.New(0, 100, 0)
				var_340_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_1.position).x, (manager.ui.mainCamera.transform.position - var_340_1.position).y, (manager.ui.mainCamera.transform.position - var_340_1.position).z)
				var_340_1.localEulerAngles.z = 0
				var_340_1.localEulerAngles.x = 0
				var_340_1.localEulerAngles = var_340_1.localEulerAngles
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot03", "")
			end

			local var_340_4 = 0
			local var_340_5 = 0.3

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(116151081).content)

				arg_337_1.text_.text = var_340_6

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_8 = 12 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 12)

				if (12 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 12)) > 0 and var_340_5 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_6
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_9 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_9 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_9

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_9 and arg_337_1.time_ < var_340_4 + var_340_9 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play116151082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 116151082
		arg_341_1.duration_ = 6.57

		local var_341_0 = {
			zh = 4.566,
			ja = 6.566
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play116151083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1066ui_story = arg_341_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1066ui_story"].transform.position).z)
				arg_341_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1066ui_story"].transform.localEulerAngles = arg_341_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_341_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1066ui_story"].transform.position).z)
				arg_341_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1066ui_story"].transform.localEulerAngles = arg_341_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_344_1 = arg_341_1.actors_["1066ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1066ui_story == nil then
				arg_341_1.var_.characterEffect1066ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1066ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1066ui_story then
				arg_341_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_344_4 = 0
			local var_344_5 = 0.5

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(116151082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 20 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 20)

				if (20 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 20)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151082", "story_v_out_116151.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_116151", "116151082", "story_v_out_116151.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_116151", "116151082", "story_v_out_116151.awb")

						arg_341_1:RecordAudio("116151082", var_344_11)
						arg_341_1:RecordAudio("116151082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_116151", "116151082", "story_v_out_116151.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_116151", "116151082", "story_v_out_116151.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play116151083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 116151083
		arg_345_1.duration_ = 7.13

		local var_345_0 = {
			zh = 7.133,
			ja = 7.033
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play116151084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_348_0 = 0
			local var_348_1 = 0.825

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_2 = arg_345_1:GetWordFromCfg(116151083)
				local var_348_3 = arg_345_1:FormatText(var_348_2.content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 33 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_3) / 33)

				if (33 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_3) / 33)) > 0 and var_348_1 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151083", "story_v_out_116151.awb") ~= 0 then
					local var_348_6 = manager.audio:GetVoiceLength("story_v_out_116151", "116151083", "story_v_out_116151.awb") / 1000

					if var_348_6 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_0
					end

					if var_348_2.prefab_name ~= "" and arg_345_1.actors_[var_348_2.prefab_name] ~= nil then
						local var_348_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_2.prefab_name].transform, "story_v_out_116151", "116151083", "story_v_out_116151.awb")

						arg_345_1:RecordAudio("116151083", var_348_7)
						arg_345_1:RecordAudio("116151083", var_348_7)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_116151", "116151083", "story_v_out_116151.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_116151", "116151083", "story_v_out_116151.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_8 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_8 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_8

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_8 and arg_345_1.time_ < var_348_0 + var_348_8 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play116151084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 116151084
		arg_349_1.duration_ = 3.63

		local var_349_0 = {
			zh = 3.633,
			ja = 2.833
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play116151085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1033ui_story = arg_349_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1033ui_story"].transform.position).z)
				arg_349_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1033ui_story"].transform.localEulerAngles = arg_349_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_349_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1033ui_story"].transform.position).z)
				arg_349_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1033ui_story"].transform.localEulerAngles = arg_349_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_352_1 = arg_349_1.actors_["1033ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1033ui_story == nil then
				arg_349_1.var_.characterEffect1033ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1033ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1033ui_story then
				arg_349_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_352_4 = arg_349_1.actors_["1066ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1066ui_story == nil then
				arg_349_1.var_.characterEffect1066ui_story = var_352_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_5 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_5 and not isNil(var_352_4) then
				if arg_349_1.var_.characterEffect1066ui_story and not isNil(var_352_4) then
					arg_349_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_5)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_5 and arg_349_1.time_ < 0 + var_352_5 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1066ui_story then
				arg_349_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_352_6 = 0
			local var_352_7 = 0.4

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_8 = arg_349_1:GetWordFromCfg(116151084)
				local var_352_9 = arg_349_1:FormatText(var_352_8.content)

				arg_349_1.text_.text = var_352_9

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 16 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_9) / 16)

				if (16 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_9) / 16)) > 0 and var_352_7 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_9
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116151", "116151084", "story_v_out_116151.awb") ~= 0 then
					local var_352_12 = manager.audio:GetVoiceLength("story_v_out_116151", "116151084", "story_v_out_116151.awb") / 1000

					if var_352_12 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_6
					end

					if var_352_8.prefab_name ~= "" and arg_349_1.actors_[var_352_8.prefab_name] ~= nil then
						local var_352_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_8.prefab_name].transform, "story_v_out_116151", "116151084", "story_v_out_116151.awb")

						arg_349_1:RecordAudio("116151084", var_352_13)
						arg_349_1:RecordAudio("116151084", var_352_13)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_116151", "116151084", "story_v_out_116151.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_116151", "116151084", "story_v_out_116151.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play116151085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 116151085
		arg_353_1.duration_ = 7.57

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play116151086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1033ui_story = arg_353_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1033ui_story"].transform.position).z)
				arg_353_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1033ui_story"].transform.localEulerAngles = arg_353_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1033ui_story"].transform.position).z)
				arg_353_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1033ui_story"].transform.localEulerAngles = arg_353_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1066ui_story"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1066ui_story = var_356_1.localPosition
			end

			local var_356_2 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 then
				var_356_1.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_2)
				var_356_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_1.position).x, (manager.ui.mainCamera.transform.position - var_356_1.position).y, (manager.ui.mainCamera.transform.position - var_356_1.position).z)
				var_356_1.localEulerAngles.z = 0
				var_356_1.localEulerAngles.x = 0
				var_356_1.localEulerAngles = var_356_1.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 then
				var_356_1.localPosition = Vector3.New(0, 100, 0)
				var_356_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_1.position).x, (manager.ui.mainCamera.transform.position - var_356_1.position).y, (manager.ui.mainCamera.transform.position - var_356_1.position).z)
				var_356_1.localEulerAngles.z = 0
				var_356_1.localEulerAngles.x = 0
				var_356_1.localEulerAngles = var_356_1.localEulerAngles
			end

			local var_356_3 = manager.ui.mainCamera.transform

			if 0.5 < arg_353_1.time_ and arg_353_1.time_ <= 0.5 + arg_356_0 then
				arg_353_1.var_.shakeOldPos = var_356_3.localPosition
			end

			local var_356_4 = 0.6

			if 0.5 <= arg_353_1.time_ and arg_353_1.time_ < 0.5 + var_356_4 then
				local var_356_5, var_356_6 = math.modf((arg_353_1.time_ - 0.5) / 0.066)

				var_356_3.localPosition = Vector3.New(var_356_6 * 0.13, var_356_6 * 0.13, var_356_6 * 0.13) + arg_353_1.var_.shakeOldPos
			end

			if arg_353_1.time_ >= 0.5 + var_356_4 and arg_353_1.time_ < 0.5 + var_356_4 + arg_356_0 then
				var_356_3.localPosition = arg_353_1.var_.shakeOldPos
			end

			local var_356_7 = 0.5

			if 0.5 < arg_353_1.time_ and arg_353_1.time_ <= var_356_7 + arg_356_0 then
				arg_353_1.allBtn_.enabled = false
			end

			if arg_353_1.time_ >= var_356_7 + 0.6 and arg_353_1.time_ < var_356_7 + 0.6 + arg_356_0 then
				arg_353_1.allBtn_.enabled = true
			end

			if 0.5 < arg_353_1.time_ and arg_353_1.time_ <= 0.5 + arg_356_0 then
				local var_356_8 = arg_353_1.bgs_.I05f:GetComponent("SpriteRenderer")

				if var_356_8 then
					arg_353_1.var_.alphaOldValueI05f = var_356_8.color.a
					arg_353_1.var_.alphaMatValueI05f = var_356_8
				end

				arg_353_1.var_.alphaOldValueI05f = 1
			end

			local var_356_9 = 2.066667

			if 0.5 <= arg_353_1.time_ and arg_353_1.time_ < 0.5 + var_356_9 then
				if arg_353_1.var_.alphaMatValueI05f then
					arg_353_1.var_.alphaMatValueI05f.color.a = Mathf.Lerp(arg_353_1.var_.alphaOldValueI05f, 0, (arg_353_1.time_ - 0.5) / var_356_9)
					arg_353_1.var_.alphaMatValueI05f.color = arg_353_1.var_.alphaMatValueI05f.color
				end
			end

			if arg_353_1.time_ >= 0.5 + var_356_9 and arg_353_1.time_ < 0.5 + var_356_9 + arg_356_0 and arg_353_1.var_.alphaMatValueI05f then
				arg_353_1.var_.alphaMatValueI05f.color.a = 0
				arg_353_1.var_.alphaMatValueI05f.color = arg_353_1.var_.alphaMatValueI05f.color
			end

			local var_356_10 = 0

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 then
				arg_353_1.allBtn_.enabled = false
			end

			if arg_353_1.time_ >= var_356_10 + 0.833333333333333 and arg_353_1.time_ < var_356_10 + 0.833333333333333 + arg_356_0 then
				arg_353_1.allBtn_.enabled = true
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_11 = 2.566667
			local var_356_12 = 0.575

			if 2.566667 < arg_353_1.time_ and arg_353_1.time_ <= var_356_11 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_13 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_13:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_353_1.dialogCg_.alpha = arg_357_0
				end))
				var_356_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_14 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(116151085).content)

				arg_353_1.text_.text = var_356_14

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_16 = 23 <= 0 and var_356_12 or var_356_12 * (utf8.len(var_356_14) / 23)

				if (23 <= 0 and var_356_12 or var_356_12 * (utf8.len(var_356_14) / 23)) > 0 and var_356_12 < var_356_16 then
					arg_353_1.talkMaxDuration = var_356_16
					var_356_11 = var_356_11 + 0.3

					if var_356_16 + var_356_11 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_16 + var_356_11
					end
				end

				arg_353_1.text_.text = var_356_14
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_17 = var_356_11 + 0.3
			local var_356_18 = math.max(var_356_12, arg_353_1.talkMaxDuration)

			if var_356_11 + 0.3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_17 + var_356_18 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_17) / var_356_18

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_17 + var_356_18 and arg_353_1.time_ < var_356_17 + var_356_18 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play116151086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 116151086
		arg_359_1.duration_ = 1

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play116151087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.fswbg_:SetActive(true)
				arg_359_1.dialog_:SetActive(false)

				arg_359_1.fswtw_.percent = 0
				arg_359_1.fswt_.text = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(116151086).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.fswt_)

				arg_359_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_359_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_359_1.fswtw_:SetDirty()

				arg_359_1.typewritterCharCountI18N = 0

				SetActive(arg_359_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_359_1:ShowNextGo(false)
			end

			local var_362_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.var_.oldValueTypewriter = arg_359_1.fswtw_.percent

				SetActive(arg_359_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_359_1:ShowNextGo(false)
			end

			local var_362_1 = 2
			local var_362_2 = 0.133333333333333
			local var_362_3, var_362_4 = arg_359_1:GetPercentByPara(arg_359_1:FormatText(arg_359_1:GetWordFromCfg(116151086).content), 1)

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				local var_362_5 = var_362_1 <= 0 and var_362_2 or var_362_2 * ((var_362_4 - arg_359_1.typewritterCharCountI18N) / var_362_1)

				if (var_362_1 <= 0 and var_362_2 or var_362_2 * ((var_362_4 - arg_359_1.typewritterCharCountI18N) / var_362_1)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_0
					end
				end
			end

			local var_362_6 = math.max(0.133333333333333, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_6 then
				arg_359_1.fswtw_.percent = Mathf.Lerp(arg_359_1.var_.oldValueTypewriter, var_362_3, (arg_359_1.time_ - var_362_0) / var_362_6)
				arg_359_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_359_1.fswtw_:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_6 and arg_359_1.time_ < var_362_0 + var_362_6 + arg_362_0 then
				arg_359_1.fswtw_.percent = var_362_3

				arg_359_1.fswtw_:SetDirty()
				arg_359_1:ShowNextGo(true)

				arg_359_1.typewritterCharCountI18N = var_362_4
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				local var_362_7 = arg_359_1.fswbg_.transform:Find("textbox/adapt/content") or arg_359_1.fswbg_.transform:Find("textbox/content")
				local var_362_8 = arg_359_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_362_9 = var_362_7:GetComponent("RectTransform")

				var_362_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_362_9.offsetMin = Vector2.New(0, 0)
				var_362_9.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_16", "se_story_16_blast", "")
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play116151087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 116151087
		arg_363_1.duration_ = 1

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play116151088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.fswbg_:SetActive(true)
				arg_363_1.dialog_:SetActive(false)

				arg_363_1.fswtw_.percent = 0
				arg_363_1.fswt_.text = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(116151087).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.fswt_)

				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_363_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_363_1.fswtw_:SetDirty()

				arg_363_1.typewritterCharCountI18N = 0

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.var_.oldValueTypewriter = arg_363_1.fswtw_.percent

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_1 = 12
			local var_366_2 = 0.8
			local var_366_3, var_366_4 = arg_363_1:GetPercentByPara(arg_363_1:FormatText(arg_363_1:GetWordFromCfg(116151087).content), 1)

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				local var_366_5 = var_366_1 <= 0 and var_366_2 or var_366_2 * ((var_366_4 - arg_363_1.typewritterCharCountI18N) / var_366_1)

				if (var_366_1 <= 0 and var_366_2 or var_366_2 * ((var_366_4 - arg_363_1.typewritterCharCountI18N) / var_366_1)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_0
					end
				end
			end

			local var_366_6 = math.max(0.8, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_6 then
				arg_363_1.fswtw_.percent = Mathf.Lerp(arg_363_1.var_.oldValueTypewriter, var_366_3, (arg_363_1.time_ - var_366_0) / var_366_6)
				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_363_1.fswtw_:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_6 and arg_363_1.time_ < var_366_0 + var_366_6 + arg_366_0 then
				arg_363_1.fswtw_.percent = var_366_3

				arg_363_1.fswtw_:SetDirty()
				arg_363_1:ShowNextGo(true)

				arg_363_1.typewritterCharCountI18N = var_366_4
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play116151088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 116151088
		arg_367_1.duration_ = 1

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play116151089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.fswbg_:SetActive(true)
				arg_367_1.dialog_:SetActive(false)

				arg_367_1.fswtw_.percent = 0
				arg_367_1.fswt_.text = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(116151088).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.fswt_)

				arg_367_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_367_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_367_1.fswtw_:SetDirty()

				arg_367_1.typewritterCharCountI18N = 0

				SetActive(arg_367_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_367_1:ShowNextGo(false)
			end

			local var_370_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.var_.oldValueTypewriter = arg_367_1.fswtw_.percent

				SetActive(arg_367_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_367_1:ShowNextGo(false)
			end

			local var_370_1 = 4
			local var_370_2 = 0.266666666666667
			local var_370_3, var_370_4 = arg_367_1:GetPercentByPara(arg_367_1:FormatText(arg_367_1:GetWordFromCfg(116151088).content), 1)

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0

				local var_370_5 = var_370_1 <= 0 and var_370_2 or var_370_2 * ((var_370_4 - arg_367_1.typewritterCharCountI18N) / var_370_1)

				if (var_370_1 <= 0 and var_370_2 or var_370_2 * ((var_370_4 - arg_367_1.typewritterCharCountI18N) / var_370_1)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_0
					end
				end
			end

			local var_370_6 = math.max(0.266666666666667, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_6 then
				arg_367_1.fswtw_.percent = Mathf.Lerp(arg_367_1.var_.oldValueTypewriter, var_370_3, (arg_367_1.time_ - var_370_0) / var_370_6)
				arg_367_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_367_1.fswtw_:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_6 and arg_367_1.time_ < var_370_0 + var_370_6 + arg_370_0 then
				arg_367_1.fswtw_.percent = var_370_3

				arg_367_1.fswtw_:SetDirty()
				arg_367_1:ShowNextGo(true)

				arg_367_1.typewritterCharCountI18N = var_370_4
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play116151089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 116151089
		arg_371_1.duration_ = 1

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
			arg_371_1.auto_ = false
		end

		function arg_371_1.playNext_(arg_373_0)
			arg_371_1.onStoryFinished_()
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.fswbg_:SetActive(true)
				arg_371_1.dialog_:SetActive(false)

				arg_371_1.fswtw_.percent = 0
				arg_371_1.fswt_.text = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(116151089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.fswt_)

				arg_371_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_371_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_371_1.fswtw_:SetDirty()

				arg_371_1.typewritterCharCountI18N = 0

				SetActive(arg_371_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_371_1:ShowNextGo(false)
			end

			local var_374_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.var_.oldValueTypewriter = arg_371_1.fswtw_.percent

				SetActive(arg_371_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_371_1:ShowNextGo(false)
			end

			local var_374_1 = 12
			local var_374_2 = 0.8
			local var_374_3, var_374_4 = arg_371_1:GetPercentByPara(arg_371_1:FormatText(arg_371_1:GetWordFromCfg(116151089).content), 1)

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				local var_374_5 = var_374_1 <= 0 and var_374_2 or var_374_2 * ((var_374_4 - arg_371_1.typewritterCharCountI18N) / var_374_1)

				if (var_374_1 <= 0 and var_374_2 or var_374_2 * ((var_374_4 - arg_371_1.typewritterCharCountI18N) / var_374_1)) > 0 and var_374_2 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_0
					end
				end
			end

			local var_374_6 = math.max(0.8, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_6 then
				arg_371_1.fswtw_.percent = Mathf.Lerp(arg_371_1.var_.oldValueTypewriter, var_374_3, (arg_371_1.time_ - var_374_0) / var_374_6)
				arg_371_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_371_1.fswtw_:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_6 and arg_371_1.time_ < var_374_0 + var_374_6 + arg_374_0 then
				arg_371_1.fswtw_.percent = var_374_3

				arg_371_1.fswtw_:SetDirty()
				arg_371_1:ShowNextGo(true)

				arg_371_1.typewritterCharCountI18N = var_374_4
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05a",
		"TextureConfig/Background/I05f",
		"TextureConfig/Background/SK0111"
	},
	voices = {
		"story_v_out_116151.awb"
	}
}
