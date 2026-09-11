return {
	Play325071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325071001
		arg_1_1.duration_ = 6.53

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_jianchi", "bgm_activity_4_8_story_jianchi", "bgm_activity_4_8_story_jianchi.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_4_8_story_jianchi", "bgm_activity_4_8_story_jianchi")

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

			local var_4_14 = 1.53333333333333
			local var_4_15 = 1.175

			if 1.53333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325071001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 47 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 47)

				if (47 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 47)) > 0 and var_4_15 < var_4_19 then
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
	Play325071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.5

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325071002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 60 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 60)

				if (60 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 60)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325071003
		arg_12_1.duration_ = 8.13

		local var_12_0 = {
			zh = 6.433,
			ja = 8.133
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
				arg_12_0:Play325071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1077ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1077ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1077ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1077ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1077ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1077ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = var_15_3.localPosition

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(false)
				end
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_12_1.time_ - 0) / var_15_5)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles

				local var_15_6 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_6 then
					var_15_6:EnableDynamicBone(true)
				end
			end

			local var_15_7 = arg_12_1.actors_["1077ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_8 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 and not isNil(var_15_7) then
				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_7) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_10 = 0
			local var_15_11 = 0.6

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(325071003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 24 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 24)

				if (24 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 24)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071003", "story_v_out_325071.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_325071", "325071003", "story_v_out_325071.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_325071", "325071003", "story_v_out_325071.awb")

						arg_12_1:RecordAudio("325071003", var_15_17)
						arg_12_1:RecordAudio("325071003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325071", "325071003", "story_v_out_325071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325071", "325071003", "story_v_out_325071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play325071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325071004
		arg_16_1.duration_ = 5.63

		local var_16_0 = {
			zh = 5.633,
			ja = 5.566
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
				arg_16_0:Play325071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:GetWordFromCfg(325071004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 24 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 24)

				if (24 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 24)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071004", "story_v_out_325071.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_325071", "325071004", "story_v_out_325071.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_325071", "325071004", "story_v_out_325071.awb")

						arg_16_1:RecordAudio("325071004", var_19_6)
						arg_16_1:RecordAudio("325071004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325071", "325071004", "story_v_out_325071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325071", "325071004", "story_v_out_325071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325071005
		arg_20_1.duration_ = 8.34

		local var_20_0 = {
			zh = 6.441666666666,
			ja = 8.341666666666
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
				arg_20_0:Play325071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 1.93333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 1.93333333333333 + arg_23_0 then
				local var_23_0 = arg_20_1.bgs_.J23h

				arg_20_1.bgs_.J23h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_1 = var_23_0:GetComponent("SpriteRenderer")

				if var_23_1 and var_23_1.sprite then
					local var_23_2 = 2 * (var_23_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_0.transform.localScale = Vector3.New(var_23_2 / var_23_1.sprite.bounds.size.y < var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x and var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x or var_23_2 / var_23_1.sprite.bounds.size.y, var_23_2 / var_23_1.sprite.bounds.size.y < var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x and var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x or var_23_2 / var_23_1.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "J23h" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_3 = 1.93333333333333

			if 1.93333333333333 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_3 + 0.3 and arg_20_1.time_ < var_23_3 + 0.3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_4 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_5 = 1.93333333333333

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_5 then
				local var_23_6 = Color.New(0, 0, 0)

				var_23_6.a = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_4) / var_23_5)
				arg_20_1.mask_.color = var_23_6
			end

			if arg_20_1.time_ >= var_23_4 + var_23_5 and arg_20_1.time_ < var_23_4 + var_23_5 + arg_23_0 then
				local var_23_7 = Color.New(0, 0, 0)

				var_23_7.a = 1
				arg_20_1.mask_.color = var_23_7
			end

			local var_23_8 = 1.93333333333333

			if 1.93333333333333 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_9 = 2

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_9 then
				local var_23_10 = Color.New(0, 0, 0)

				var_23_10.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_8) / var_23_9)
				arg_20_1.mask_.color = var_23_10
			end

			if arg_20_1.time_ >= var_23_8 + var_23_9 and arg_20_1.time_ < var_23_8 + var_23_9 + arg_23_0 then
				local var_23_11 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_11.a = 0
				arg_20_1.mask_.color = var_23_11
			end

			local var_23_12 = arg_20_1.actors_["1077ui_story"].transform

			if 1.93333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 1.93333333333333 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = var_23_12.localPosition

				local var_23_13 = GameObjectTools.GetOrAddComponent(var_23_12.gameObject, typeof(DynamicBoneHelper))

				if var_23_13 then
					var_23_13:EnableDynamicBone(false)
				end
			end

			local var_23_14 = 0.001

			if 1.93333333333333 <= arg_20_1.time_ and arg_20_1.time_ < 1.93333333333333 + var_23_14 then
				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 1.93333333333333) / var_23_14)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles
			end

			if arg_20_1.time_ >= 1.93333333333333 + var_23_14 and arg_20_1.time_ < 1.93333333333333 + var_23_14 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(0, 100, 0)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles

				local var_23_15 = GameObjectTools.GetOrAddComponent(var_23_12.gameObject, typeof(DynamicBoneHelper))

				if var_23_15 then
					var_23_15:EnableDynamicBone(true)
				end
			end

			local var_23_16 = arg_20_1.actors_["1077ui_story"]

			if 1.93333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 1.93333333333333 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_17 = 0.200000002980232

			if 1.93333333333333 <= arg_20_1.time_ and arg_20_1.time_ < 1.93333333333333 + var_23_17 and not isNil(var_23_16) then
				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_16) then
					arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 1.93333333333333) / var_23_17)
				end
			end

			if arg_20_1.time_ >= 1.93333333333333 + var_23_17 and arg_20_1.time_ < 1.93333333333333 + var_23_17 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1077ui_story then
				arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_23_18 = 1.93333333333333

			arg_20_1.isInRecall_ = false

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1.screenFilterGo_:SetActive(true)

				arg_20_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_23_2, iter_23_3 in pairs(arg_20_1.actors_) do
					for iter_23_4, iter_23_5 in ipairs((iter_23_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_23_5.color = iter_23_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_23_19 = 0.034000001847744

			if var_23_18 <= arg_20_1.time_ and arg_20_1.time_ < var_23_18 + var_23_19 then
				arg_20_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_18) / var_23_19)
			end

			if arg_20_1.time_ >= var_23_18 + var_23_19 and arg_20_1.time_ < var_23_18 + var_23_19 + arg_23_0 then
				arg_20_1.screenFilterEffect_.weight = 1
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_20 = 3.241666666666
			local var_23_21 = 0.325

			if 3.241666666666 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_22 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_22:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_20_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_23_23 = arg_20_1:GetWordFromCfg(325071005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 13 <= 0 and var_23_21 or var_23_21 * (utf8.len(var_23_24) / 13)

				if (13 <= 0 and var_23_21 or var_23_21 * (utf8.len(var_23_24) / 13)) > 0 and var_23_21 < var_23_26 then
					arg_20_1.talkMaxDuration = var_23_26
					var_23_20 = var_23_20 + 0.3

					if var_23_26 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_26 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071005", "story_v_out_325071.awb") ~= 0 then
					local var_23_27 = manager.audio:GetVoiceLength("story_v_out_325071", "325071005", "story_v_out_325071.awb") / 1000

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_325071", "325071005", "story_v_out_325071.awb")

						arg_20_1:RecordAudio("325071005", var_23_28)
						arg_20_1:RecordAudio("325071005", var_23_28)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325071", "325071005", "story_v_out_325071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325071", "325071005", "story_v_out_325071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_29 = var_23_20 + 0.3
			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_29 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_29) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_29 + var_23_30 and arg_20_1.time_ < var_23_29 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325071006
		arg_26_1.duration_ = 6.07

		local var_26_0 = {
			zh = 6.066,
			ja = 5.666
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1077ui_story = arg_26_1.actors_["1077ui_story"].transform.localPosition

				local var_29_0 = GameObjectTools.GetOrAddComponent(arg_26_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_29_0 then
					var_29_0:EnableDynamicBone(false)
				end
			end

			local var_29_1 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_1 then
				arg_26_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_26_1.time_ - 0) / var_29_1)
				arg_26_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1077ui_story"].transform.position).z)
				arg_26_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["1077ui_story"].transform.localEulerAngles = arg_26_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_1 and arg_26_1.time_ < 0 + var_29_1 + arg_29_0 then
				arg_26_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_26_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1077ui_story"].transform.position).z)
				arg_26_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["1077ui_story"].transform.localEulerAngles = arg_26_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_29_2 = GameObjectTools.GetOrAddComponent(arg_26_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_29_2 then
					var_29_2:EnableDynamicBone(true)
				end
			end

			local var_29_3 = arg_26_1.actors_["1077ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_3) and arg_26_1.var_.characterEffect1077ui_story == nil then
				arg_26_1.var_.characterEffect1077ui_story = var_29_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_4 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 and not isNil(var_29_3) then
				if arg_26_1.var_.characterEffect1077ui_story and not isNil(var_29_3) then
					arg_26_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 and not isNil(var_29_3) and arg_26_1.var_.characterEffect1077ui_story then
				arg_26_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_29_6 = 0
			local var_29_7 = 0.625

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_8 = arg_26_1:GetWordFromCfg(325071006)
				local var_29_9 = arg_26_1:FormatText(var_29_8.content)

				arg_26_1.text_.text = var_29_9

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 25 <= 0 and var_29_7 or var_29_7 * (utf8.len(var_29_9) / 25)

				if (25 <= 0 and var_29_7 or var_29_7 * (utf8.len(var_29_9) / 25)) > 0 and var_29_7 < var_29_11 then
					arg_26_1.talkMaxDuration = var_29_11

					if var_29_11 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_11 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_9
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071006", "story_v_out_325071.awb") ~= 0 then
					local var_29_12 = manager.audio:GetVoiceLength("story_v_out_325071", "325071006", "story_v_out_325071.awb") / 1000

					if var_29_12 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_6
					end

					if var_29_8.prefab_name ~= "" and arg_26_1.actors_[var_29_8.prefab_name] ~= nil then
						local var_29_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_8.prefab_name].transform, "story_v_out_325071", "325071006", "story_v_out_325071.awb")

						arg_26_1:RecordAudio("325071006", var_29_13)
						arg_26_1:RecordAudio("325071006", var_29_13)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_325071", "325071006", "story_v_out_325071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_325071", "325071006", "story_v_out_325071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_14 and arg_26_1.time_ < var_29_6 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play325071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325071007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play325071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1077ui_story"]) and arg_30_1.var_.characterEffect1077ui_story == nil then
				arg_30_1.var_.characterEffect1077ui_story = arg_30_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1077ui_story"]) then
				if arg_30_1.var_.characterEffect1077ui_story and not isNil(arg_30_1.actors_["1077ui_story"]) then
					arg_30_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_0)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1077ui_story"]) and arg_30_1.var_.characterEffect1077ui_story then
				arg_30_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_33_1 = 0
			local var_33_2 = 1.075

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(325071007).content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 43 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 43)

				if (43 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 43)) > 0 and var_33_2 < var_33_5 then
					arg_30_1.talkMaxDuration = var_33_5

					if var_33_5 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_6 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_6 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_6

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_6 and arg_30_1.time_ < var_33_1 + var_33_6 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play325071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325071008
		arg_34_1.duration_ = 6.13

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1077ui_story"]) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = arg_34_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1077ui_story"]) then
				if arg_34_1.var_.characterEffect1077ui_story and not isNil(arg_34_1.actors_["1077ui_story"]) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1077ui_story"]) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_37_2 = 0
			local var_37_3 = 0.65

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:GetWordFromCfg(325071008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 26 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 26)

				if (26 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 26)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071008", "story_v_out_325071.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_325071", "325071008", "story_v_out_325071.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_325071", "325071008", "story_v_out_325071.awb")

						arg_34_1:RecordAudio("325071008", var_37_9)
						arg_34_1:RecordAudio("325071008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_325071", "325071008", "story_v_out_325071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_325071", "325071008", "story_v_out_325071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_10 and arg_34_1.time_ < var_37_2 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play325071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325071009
		arg_38_1.duration_ = 12.77

		local var_38_0 = {
			zh = 9.766,
			ja = 12.766
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1077ui_story"]) and arg_38_1.var_.characterEffect1077ui_story == nil then
				arg_38_1.var_.characterEffect1077ui_story = arg_38_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1077ui_story"]) then
				if arg_38_1.var_.characterEffect1077ui_story and not isNil(arg_38_1.actors_["1077ui_story"]) then
					arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1077ui_story"]) and arg_38_1.var_.characterEffect1077ui_story then
				arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.975

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_38_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_41_3 = arg_38_1:GetWordFromCfg(325071009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_6 = 39 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_4) / 39)

				if (39 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_4) / 39)) > 0 and var_41_2 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071009", "story_v_out_325071.awb") ~= 0 then
					local var_41_7 = manager.audio:GetVoiceLength("story_v_out_325071", "325071009", "story_v_out_325071.awb") / 1000

					if var_41_7 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_1
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_325071", "325071009", "story_v_out_325071.awb")

						arg_38_1:RecordAudio("325071009", var_41_8)
						arg_38_1:RecordAudio("325071009", var_41_8)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325071", "325071009", "story_v_out_325071.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325071", "325071009", "story_v_out_325071.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_9 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_9 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_9

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_9 and arg_38_1.time_ < var_41_1 + var_41_9 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play325071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325071010
		arg_42_1.duration_ = 14.3

		local var_42_0 = {
			zh = 6.4,
			ja = 14.3
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1077ui_story"]) and arg_42_1.var_.characterEffect1077ui_story == nil then
				arg_42_1.var_.characterEffect1077ui_story = arg_42_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1077ui_story"]) then
				if arg_42_1.var_.characterEffect1077ui_story and not isNil(arg_42_1.actors_["1077ui_story"]) then
					arg_42_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1077ui_story"]) and arg_42_1.var_.characterEffect1077ui_story then
				arg_42_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_45_2 = 0
			local var_45_3 = 0.775

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(325071010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 31 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 31)

				if (31 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 31)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071010", "story_v_out_325071.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_325071", "325071010", "story_v_out_325071.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_325071", "325071010", "story_v_out_325071.awb")

						arg_42_1:RecordAudio("325071010", var_45_9)
						arg_42_1:RecordAudio("325071010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325071", "325071010", "story_v_out_325071.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325071", "325071010", "story_v_out_325071.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_10 and arg_42_1.time_ < var_45_2 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325071011
		arg_46_1.duration_ = 12.3

		local var_46_0 = {
			zh = 6.533,
			ja = 12.3
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1077ui_story"]) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = arg_46_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1077ui_story"]) then
				if arg_46_1.var_.characterEffect1077ui_story and not isNil(arg_46_1.actors_["1077ui_story"]) then
					arg_46_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1077ui_story"]) and arg_46_1.var_.characterEffect1077ui_story then
				arg_46_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 0.75

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_46_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_49_3 = arg_46_1:GetWordFromCfg(325071011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 30 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_4) / 30)

				if (30 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_4) / 30)) > 0 and var_49_2 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071011", "story_v_out_325071.awb") ~= 0 then
					local var_49_7 = manager.audio:GetVoiceLength("story_v_out_325071", "325071011", "story_v_out_325071.awb") / 1000

					if var_49_7 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_1
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_325071", "325071011", "story_v_out_325071.awb")

						arg_46_1:RecordAudio("325071011", var_49_8)
						arg_46_1:RecordAudio("325071011", var_49_8)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325071", "325071011", "story_v_out_325071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325071", "325071011", "story_v_out_325071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_9 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_9 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_9

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_9 and arg_46_1.time_ < var_49_1 + var_49_9 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play325071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325071012
		arg_50_1.duration_ = 9.5

		local var_50_0 = {
			zh = 3.4,
			ja = 9.5
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
				arg_50_0:Play325071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.35

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_50_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_53_1 = arg_50_1:GetWordFromCfg(325071012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 14 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 14)

				if (14 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 14)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071012", "story_v_out_325071.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_325071", "325071012", "story_v_out_325071.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_325071", "325071012", "story_v_out_325071.awb")

						arg_50_1:RecordAudio("325071012", var_53_6)
						arg_50_1:RecordAudio("325071012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325071", "325071012", "story_v_out_325071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325071", "325071012", "story_v_out_325071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325071013
		arg_54_1.duration_ = 9.3

		local var_54_0 = {
			zh = 6.866,
			ja = 9.3
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
				arg_54_0:Play325071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = arg_54_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) then
				if arg_54_1.var_.characterEffect1077ui_story and not isNil(arg_54_1.actors_["1077ui_story"]) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1077ui_story"]) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_57_2 = 0
			local var_57_3 = 0.7

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(325071013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 28 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 28)

				if (28 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 28)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071013", "story_v_out_325071.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_325071", "325071013", "story_v_out_325071.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_325071", "325071013", "story_v_out_325071.awb")

						arg_54_1:RecordAudio("325071013", var_57_9)
						arg_54_1:RecordAudio("325071013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325071", "325071013", "story_v_out_325071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325071", "325071013", "story_v_out_325071.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325071014
		arg_58_1.duration_ = 7.47

		local var_58_0 = {
			zh = 5.3,
			ja = 7.466
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
				arg_58_0:Play325071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_0 = 0
			local var_61_1 = 0.725

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(325071014)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 29 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_3) / 29)

				if (29 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_3) / 29)) > 0 and var_61_1 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071014", "story_v_out_325071.awb") ~= 0 then
					local var_61_6 = manager.audio:GetVoiceLength("story_v_out_325071", "325071014", "story_v_out_325071.awb") / 1000

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end

					if var_61_2.prefab_name ~= "" and arg_58_1.actors_[var_61_2.prefab_name] ~= nil then
						local var_61_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_2.prefab_name].transform, "story_v_out_325071", "325071014", "story_v_out_325071.awb")

						arg_58_1:RecordAudio("325071014", var_61_7)
						arg_58_1:RecordAudio("325071014", var_61_7)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325071", "325071014", "story_v_out_325071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325071", "325071014", "story_v_out_325071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_8 and arg_58_1.time_ < var_61_0 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325071015
		arg_62_1.duration_ = 8.23

		local var_62_0 = {
			zh = 5.866,
			ja = 8.233
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
				arg_62_0:Play325071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = arg_62_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) then
				if arg_62_1.var_.characterEffect1077ui_story and not isNil(arg_62_1.actors_["1077ui_story"]) then
					arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1077ui_story"]) and arg_62_1.var_.characterEffect1077ui_story then
				arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.475

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_62_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_65_3 = arg_62_1:GetWordFromCfg(325071015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 19 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 19)

				if (19 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 19)) > 0 and var_65_2 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071015", "story_v_out_325071.awb") ~= 0 then
					local var_65_7 = manager.audio:GetVoiceLength("story_v_out_325071", "325071015", "story_v_out_325071.awb") / 1000

					if var_65_7 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_1
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_325071", "325071015", "story_v_out_325071.awb")

						arg_62_1:RecordAudio("325071015", var_65_8)
						arg_62_1:RecordAudio("325071015", var_65_8)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325071", "325071015", "story_v_out_325071.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325071", "325071015", "story_v_out_325071.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_9 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_9 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_9

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_9 and arg_62_1.time_ < var_65_1 + var_65_9 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325071016
		arg_66_1.duration_ = 11.1

		local var_66_0 = {
			zh = 8.89933333333333,
			ja = 11.0993333333333
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
				arg_66_0:Play325071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = arg_66_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) then
				if arg_66_1.var_.characterEffect1077ui_story and not isNil(arg_66_1.actors_["1077ui_story"]) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1077ui_story"]) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_69_2 = 1.1

			arg_66_1.isInRecall_ = false

			if var_69_2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.screenFilterGo_:SetActive(false)

				for iter_69_0, iter_69_1 in pairs(arg_66_1.actors_) do
					for iter_69_2, iter_69_3 in ipairs((iter_69_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_69_3.color = iter_69_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_69_3 = 0.034000001847744

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_3 then
				arg_66_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_2) / var_69_3)
			end

			if arg_66_1.time_ >= var_69_2 + var_69_3 and arg_66_1.time_ < var_69_2 + var_69_3 + arg_69_0 then
				arg_66_1.screenFilterEffect_.weight = 0
			end

			if 1.1 < arg_66_1.time_ and arg_66_1.time_ <= 1.1 + arg_69_0 then
				local var_69_4 = arg_66_1.bgs_.J23h

				arg_66_1.bgs_.J23h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_5 = var_69_4:GetComponent("SpriteRenderer")

				if var_69_5 and var_69_5.sprite then
					local var_69_6 = 2 * (var_69_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_4.transform.localScale = Vector3.New(var_69_6 / var_69_5.sprite.bounds.size.y < var_69_6 * manager.ui.mainCameraCom_.aspect / var_69_5.sprite.bounds.size.x and var_69_6 * manager.ui.mainCameraCom_.aspect / var_69_5.sprite.bounds.size.x or var_69_6 / var_69_5.sprite.bounds.size.y, var_69_6 / var_69_5.sprite.bounds.size.y < var_69_6 * manager.ui.mainCameraCom_.aspect / var_69_5.sprite.bounds.size.x and var_69_6 * manager.ui.mainCameraCom_.aspect / var_69_5.sprite.bounds.size.x or var_69_6 / var_69_5.sprite.bounds.size.y, 0)
				end

				for iter_69_4, iter_69_5 in pairs(arg_66_1.bgs_) do
					if iter_69_4 ~= "J23h" then
						iter_69_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_7 = 1.1

			if 1.1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_7 + 0.3 and arg_66_1.time_ < var_69_7 + 0.3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_8 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_9 = 1.1

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_9 then
				local var_69_10 = Color.New(0, 0, 0)

				var_69_10.a = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_8) / var_69_9)
				arg_66_1.mask_.color = var_69_10
			end

			if arg_66_1.time_ >= var_69_8 + var_69_9 and arg_66_1.time_ < var_69_8 + var_69_9 + arg_69_0 then
				local var_69_11 = Color.New(0, 0, 0)

				var_69_11.a = 1
				arg_66_1.mask_.color = var_69_11
			end

			local var_69_12 = 1.1

			if 1.1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_13 = 2

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_13 then
				local var_69_14 = Color.New(0, 0, 0)

				var_69_14.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_12) / var_69_13)
				arg_66_1.mask_.color = var_69_14
			end

			if arg_66_1.time_ >= var_69_12 + var_69_13 and arg_66_1.time_ < var_69_12 + var_69_13 + arg_69_0 then
				local var_69_15 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_15.a = 0
				arg_66_1.mask_.color = var_69_15
			end

			local var_69_16 = arg_66_1.actors_["1077ui_story"].transform

			if 1.1 < arg_66_1.time_ and arg_66_1.time_ <= 1.1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_16.localPosition

				local var_69_17 = GameObjectTools.GetOrAddComponent(var_69_16.gameObject, typeof(DynamicBoneHelper))

				if var_69_17 then
					var_69_17:EnableDynamicBone(false)
				end
			end

			local var_69_18 = 0.001

			if 1.1 <= arg_66_1.time_ and arg_66_1.time_ < 1.1 + var_69_18 then
				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 1.1) / var_69_18)
				var_69_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_16.position).x, (manager.ui.mainCamera.transform.position - var_69_16.position).y, (manager.ui.mainCamera.transform.position - var_69_16.position).z)
				var_69_16.localEulerAngles.z = 0
				var_69_16.localEulerAngles.x = 0
				var_69_16.localEulerAngles = var_69_16.localEulerAngles
			end

			if arg_66_1.time_ >= 1.1 + var_69_18 and arg_66_1.time_ < 1.1 + var_69_18 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(0, 100, 0)
				var_69_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_16.position).x, (manager.ui.mainCamera.transform.position - var_69_16.position).y, (manager.ui.mainCamera.transform.position - var_69_16.position).z)
				var_69_16.localEulerAngles.z = 0
				var_69_16.localEulerAngles.x = 0
				var_69_16.localEulerAngles = var_69_16.localEulerAngles

				local var_69_19 = GameObjectTools.GetOrAddComponent(var_69_16.gameObject, typeof(DynamicBoneHelper))

				if var_69_19 then
					var_69_19:EnableDynamicBone(true)
				end
			end

			local var_69_20 = arg_66_1.actors_["1077ui_story"].transform

			if 2.73333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 2.73333333333333 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_20.localPosition

				local var_69_21 = GameObjectTools.GetOrAddComponent(var_69_20.gameObject, typeof(DynamicBoneHelper))

				if var_69_21 then
					var_69_21:EnableDynamicBone(false)
				end
			end

			local var_69_22 = 0.001

			if 2.73333333333333 <= arg_66_1.time_ and arg_66_1.time_ < 2.73333333333333 + var_69_22 then
				var_69_20.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_66_1.time_ - 2.73333333333333) / var_69_22)
				var_69_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_20.position).x, (manager.ui.mainCamera.transform.position - var_69_20.position).y, (manager.ui.mainCamera.transform.position - var_69_20.position).z)
				var_69_20.localEulerAngles.z = 0
				var_69_20.localEulerAngles.x = 0
				var_69_20.localEulerAngles = var_69_20.localEulerAngles
			end

			if arg_66_1.time_ >= 2.73333333333333 + var_69_22 and arg_66_1.time_ < 2.73333333333333 + var_69_22 + arg_69_0 then
				var_69_20.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_69_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_20.position).x, (manager.ui.mainCamera.transform.position - var_69_20.position).y, (manager.ui.mainCamera.transform.position - var_69_20.position).z)
				var_69_20.localEulerAngles.z = 0
				var_69_20.localEulerAngles.x = 0
				var_69_20.localEulerAngles = var_69_20.localEulerAngles

				local var_69_23 = GameObjectTools.GetOrAddComponent(var_69_20.gameObject, typeof(DynamicBoneHelper))

				if var_69_23 then
					var_69_23:EnableDynamicBone(true)
				end
			end

			local var_69_24 = arg_66_1.actors_["1077ui_story"]

			if 2.73333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 2.73333333333333 + arg_69_0 and not isNil(var_69_24) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_25 = 0.200000002980232

			if 2.73333333333333 <= arg_66_1.time_ and arg_66_1.time_ < 2.73333333333333 + var_69_25 and not isNil(var_69_24) then
				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_24) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 2.73333333333333 + var_69_25 and arg_66_1.time_ < 2.73333333333333 + var_69_25 + arg_69_0 and not isNil(var_69_24) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 2.73333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 2.73333333333333 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 2.73333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 2.73333333333333 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_27 = 2.73333333333333
			local var_69_28 = 0.8

			if 2.73333333333333 < arg_66_1.time_ and arg_66_1.time_ <= var_69_27 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_29 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_29:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_30 = arg_66_1:GetWordFromCfg(325071016)
				local var_69_31 = arg_66_1:FormatText(var_69_30.content)

				arg_66_1.text_.text = var_69_31

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_33 = 32 <= 0 and var_69_28 or var_69_28 * (utf8.len(var_69_31) / 32)

				if (32 <= 0 and var_69_28 or var_69_28 * (utf8.len(var_69_31) / 32)) > 0 and var_69_28 < var_69_33 then
					arg_66_1.talkMaxDuration = var_69_33
					var_69_27 = var_69_27 + 0.3

					if var_69_33 + var_69_27 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_33 + var_69_27
					end
				end

				arg_66_1.text_.text = var_69_31
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071016", "story_v_out_325071.awb") ~= 0 then
					local var_69_34 = manager.audio:GetVoiceLength("story_v_out_325071", "325071016", "story_v_out_325071.awb") / 1000

					if var_69_34 + var_69_27 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_34 + var_69_27
					end

					if var_69_30.prefab_name ~= "" and arg_66_1.actors_[var_69_30.prefab_name] ~= nil then
						local var_69_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_30.prefab_name].transform, "story_v_out_325071", "325071016", "story_v_out_325071.awb")

						arg_66_1:RecordAudio("325071016", var_69_35)
						arg_66_1:RecordAudio("325071016", var_69_35)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325071", "325071016", "story_v_out_325071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325071", "325071016", "story_v_out_325071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_36 = var_69_27 + 0.3
			local var_69_37 = math.max(var_69_28, arg_66_1.talkMaxDuration)

			if var_69_27 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_36 + var_69_37 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_36) / var_69_37

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_36 + var_69_37 and arg_66_1.time_ < var_69_36 + var_69_37 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play325071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325071017
		arg_72_1.duration_ = 4.4

		local var_72_0 = {
			zh = 3.1,
			ja = 4.4
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_0 = 0
			local var_75_1 = 0.4

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(325071017)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 16 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 16)

				if (16 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 16)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071017", "story_v_out_325071.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_325071", "325071017", "story_v_out_325071.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_325071", "325071017", "story_v_out_325071.awb")

						arg_72_1:RecordAudio("325071017", var_75_7)
						arg_72_1:RecordAudio("325071017", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325071", "325071017", "story_v_out_325071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325071", "325071017", "story_v_out_325071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325071018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325071018
		arg_76_1.duration_ = 8

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325071019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.bgs_.ST2010 == nil then
				local var_79_0 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2010")
				var_79_0.name = "ST2010"
				var_79_0.transform.parent = arg_76_1.stage_.transform
				var_79_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_.ST2010 = var_79_0
			end

			if 1.56666666666667 < arg_76_1.time_ and arg_76_1.time_ <= 1.56666666666667 + arg_79_0 then
				local var_79_1 = arg_76_1.bgs_.ST2010

				arg_76_1.bgs_.ST2010.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_2 = var_79_1:GetComponent("SpriteRenderer")

				if var_79_2 and var_79_2.sprite then
					local var_79_3 = 2 * (var_79_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_1.transform.localScale = Vector3.New(var_79_3 / var_79_2.sprite.bounds.size.y < var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x and var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x or var_79_3 / var_79_2.sprite.bounds.size.y, var_79_3 / var_79_2.sprite.bounds.size.y < var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x and var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x or var_79_3 / var_79_2.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST2010" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_4 = 1.56666666666667

			if 1.56666666666667 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			if arg_76_1.time_ >= var_79_4 + 0.3 and arg_76_1.time_ < var_79_4 + 0.3 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_5 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_6 = 1.56666666666667

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 then
				local var_79_7 = Color.New(0, 0, 0)

				var_79_7.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_5) / var_79_6)
				arg_76_1.mask_.color = var_79_7
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 then
				local var_79_8 = Color.New(0, 0, 0)

				var_79_8.a = 1
				arg_76_1.mask_.color = var_79_8
			end

			local var_79_9 = 1.56666666666667

			if 1.56666666666667 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_10 = 2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 then
				local var_79_11 = Color.New(0, 0, 0)

				var_79_11.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_9) / var_79_10)
				arg_76_1.mask_.color = var_79_11
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 then
				local var_79_12 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_12.a = 0
				arg_76_1.mask_.color = var_79_12
			end

			local var_79_13 = arg_76_1.actors_["1077ui_story"].transform

			if 1.56666666666667 < arg_76_1.time_ and arg_76_1.time_ <= 1.56666666666667 + arg_79_0 then
				arg_76_1.var_.moveOldPos1077ui_story = var_79_13.localPosition

				local var_79_14 = GameObjectTools.GetOrAddComponent(var_79_13.gameObject, typeof(DynamicBoneHelper))

				if var_79_14 then
					var_79_14:EnableDynamicBone(false)
				end
			end

			local var_79_15 = 0.001

			if 1.56666666666667 <= arg_76_1.time_ and arg_76_1.time_ < 1.56666666666667 + var_79_15 then
				var_79_13.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 1.56666666666667) / var_79_15)
				var_79_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_13.position).x, (manager.ui.mainCamera.transform.position - var_79_13.position).y, (manager.ui.mainCamera.transform.position - var_79_13.position).z)
				var_79_13.localEulerAngles.z = 0
				var_79_13.localEulerAngles.x = 0
				var_79_13.localEulerAngles = var_79_13.localEulerAngles
			end

			if arg_76_1.time_ >= 1.56666666666667 + var_79_15 and arg_76_1.time_ < 1.56666666666667 + var_79_15 + arg_79_0 then
				var_79_13.localPosition = Vector3.New(0, 100, 0)
				var_79_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_13.position).x, (manager.ui.mainCamera.transform.position - var_79_13.position).y, (manager.ui.mainCamera.transform.position - var_79_13.position).z)
				var_79_13.localEulerAngles.z = 0
				var_79_13.localEulerAngles.x = 0
				var_79_13.localEulerAngles = var_79_13.localEulerAngles

				local var_79_16 = GameObjectTools.GetOrAddComponent(var_79_13.gameObject, typeof(DynamicBoneHelper))

				if var_79_16 then
					var_79_16:EnableDynamicBone(true)
				end
			end

			local var_79_17 = arg_76_1.actors_["1077ui_story"]

			if 1.56666666666667 < arg_76_1.time_ and arg_76_1.time_ <= 1.56666666666667 + arg_79_0 and not isNil(var_79_17) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = var_79_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_18 = 0.200000002980232

			if 1.56666666666667 <= arg_76_1.time_ and arg_76_1.time_ < 1.56666666666667 + var_79_18 and not isNil(var_79_17) then
				if arg_76_1.var_.characterEffect1077ui_story and not isNil(var_79_17) then
					arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 1.56666666666667) / var_79_18)
				end
			end

			if arg_76_1.time_ >= 1.56666666666667 + var_79_18 and arg_76_1.time_ < 1.56666666666667 + var_79_18 + arg_79_0 and not isNil(var_79_17) and arg_76_1.var_.characterEffect1077ui_story then
				arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_79_19 = 1.56666666666667

			arg_76_1.isInRecall_ = false

			if var_79_19 < arg_76_1.time_ and arg_76_1.time_ <= var_79_19 + arg_79_0 then
				arg_76_1.screenFilterGo_:SetActive(false)

				for iter_79_2, iter_79_3 in pairs(arg_76_1.actors_) do
					for iter_79_4, iter_79_5 in ipairs((iter_79_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_79_5.color = iter_79_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_79_20 = 0.034000001847744

			if var_79_19 <= arg_76_1.time_ and arg_76_1.time_ < var_79_19 + var_79_20 then
				arg_76_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_19) / var_79_20)
			end

			if arg_76_1.time_ >= var_79_19 + var_79_20 and arg_76_1.time_ < var_79_19 + var_79_20 + arg_79_0 then
				arg_76_1.screenFilterEffect_.weight = 0
			end

			if 0.1 < arg_76_1.time_ and arg_76_1.time_ <= 0.1 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_140", "se_story_140_metal", "")
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_22 = 3
			local var_79_23 = 0.925

			if 3 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_24 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_24:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_25 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(325071018).content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_27 = 37 <= 0 and var_79_23 or var_79_23 * (utf8.len(var_79_25) / 37)

				if (37 <= 0 and var_79_23 or var_79_23 * (utf8.len(var_79_25) / 37)) > 0 and var_79_23 < var_79_27 then
					arg_76_1.talkMaxDuration = var_79_27
					var_79_22 = var_79_22 + 0.3

					if var_79_27 + var_79_22 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_27 + var_79_22
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_28 = var_79_22 + 0.3
			local var_79_29 = math.max(var_79_23, arg_76_1.talkMaxDuration)

			if var_79_22 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_28 + var_79_29 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_28) / var_79_29

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_28 + var_79_29 and arg_76_1.time_ < var_79_28 + var_79_29 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play325071019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325071019
		arg_82_1.duration_ = 6.7

		local var_82_0 = {
			zh = 5.3,
			ja = 6.7
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
				arg_82_0:Play325071020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1077ui_story = arg_82_1.actors_["1077ui_story"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1077ui_story"].transform.position).z)
				arg_82_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1077ui_story"].transform.localEulerAngles = arg_82_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_82_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1077ui_story"].transform.position).z)
				arg_82_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1077ui_story"].transform.localEulerAngles = arg_82_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["1077ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1077ui_story == nil then
				arg_82_1.var_.characterEffect1077ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect1077ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1077ui_story then
				arg_82_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_85_6 = 0
			local var_85_7 = 0.5

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(325071019)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 20 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 20)

				if (20 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 20)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071019", "story_v_out_325071.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_325071", "325071019", "story_v_out_325071.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_325071", "325071019", "story_v_out_325071.awb")

						arg_82_1:RecordAudio("325071019", var_85_13)
						arg_82_1:RecordAudio("325071019", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325071", "325071019", "story_v_out_325071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325071", "325071019", "story_v_out_325071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play325071020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325071020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325071021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1077ui_story = arg_86_1.actors_["1077ui_story"].transform.localPosition

				local var_89_0 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_0 then
					var_89_0:EnableDynamicBone(false)
				end
			end

			local var_89_1 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_1 then
				arg_86_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_1)
				arg_86_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1077ui_story"].transform.position).z)
				arg_86_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1077ui_story"].transform.localEulerAngles = arg_86_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_1 and arg_86_1.time_ < 0 + var_89_1 + arg_89_0 then
				arg_86_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1077ui_story"].transform.position).z)
				arg_86_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1077ui_story"].transform.localEulerAngles = arg_86_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_89_2 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(true)
				end
			end

			local var_89_3 = arg_86_1.actors_["1077ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect1077ui_story == nil then
				arg_86_1.var_.characterEffect1077ui_story = var_89_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_4 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 and not isNil(var_89_3) then
				if arg_86_1.var_.characterEffect1077ui_story and not isNil(var_89_3) then
					arg_86_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_4)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect1077ui_story then
				arg_86_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_86_1.time_ and arg_86_1.time_ <= 0.2 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_map", "")
			end

			local var_89_6 = 0
			local var_89_7 = 1

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(325071020).content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 40 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_8) / 40)

				if (40 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_8) / 40)) > 0 and var_89_7 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_11 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_11 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_11

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_11 and arg_86_1.time_ < var_89_6 + var_89_11 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play325071021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325071021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325071022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.825

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(325071021).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 33 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 33)

				if (33 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 33)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325071022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325071022
		arg_94_1.duration_ = 3.37

		local var_94_0 = {
			zh = 3,
			ja = 3.366
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
			arg_94_1.auto_ = false
		end

		function arg_94_1.playNext_(arg_96_0)
			arg_94_1.onStoryFinished_()
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1077ui_story = arg_94_1.actors_["1077ui_story"].transform.localPosition

				local var_97_0 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_0 then
					var_97_0:EnableDynamicBone(false)
				end
			end

			local var_97_1 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 then
				arg_94_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_94_1.time_ - 0) / var_97_1)
				arg_94_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).z)
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles = arg_94_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 then
				arg_94_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_94_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).z)
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles = arg_94_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_97_2 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(true)
				end
			end

			local var_97_3 = arg_94_1.actors_["1077ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_97_7 = 0
			local var_97_8 = 0.2

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_9 = arg_94_1:GetWordFromCfg(325071022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_12 = 8 <= 0 and var_97_8 or var_97_8 * (utf8.len(var_97_10) / 8)

				if (8 <= 0 and var_97_8 or var_97_8 * (utf8.len(var_97_10) / 8)) > 0 and var_97_8 < var_97_12 then
					arg_94_1.talkMaxDuration = var_97_12

					if var_97_12 + var_97_7 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_7
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071022", "story_v_out_325071.awb") ~= 0 then
					local var_97_13 = manager.audio:GetVoiceLength("story_v_out_325071", "325071022", "story_v_out_325071.awb") / 1000

					if var_97_13 + var_97_7 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_7
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_325071", "325071022", "story_v_out_325071.awb")

						arg_94_1:RecordAudio("325071022", var_97_14)
						arg_94_1:RecordAudio("325071022", var_97_14)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325071", "325071022", "story_v_out_325071.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325071", "325071022", "story_v_out_325071.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_15 = math.max(var_97_8, arg_94_1.talkMaxDuration)

			if var_97_7 <= arg_94_1.time_ and arg_94_1.time_ < var_97_7 + var_97_15 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_7) / var_97_15

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_7 + var_97_15 and arg_94_1.time_ < var_97_7 + var_97_15 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J23h",
		"TextureConfig/Background/ST2010"
	},
	voices = {
		"story_v_out_325071.awb"
	}
}
