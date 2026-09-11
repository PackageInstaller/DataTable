return {
	Play325082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325082001
		arg_1_1.duration_ = 6.73

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J29g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J29g")
				var_4_0.name = "J29g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J29g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J29g

				arg_1_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J29g" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 0.7 < arg_1_1.time_ and arg_1_1.time_ <= 0.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_put_down", "")
			end

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_rock", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

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

			local var_4_15 = 1.73333333333333
			local var_4_16 = 0.95

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325082001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 38 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 38)

				if (38 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 38)) > 0 and var_4_16 < var_4_20 then
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325082002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325082002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325082003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.15

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325082002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 46 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 46)

				if (46 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 46)) > 0 and var_11_0 < var_11_3 then
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
	Play325082003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325082003
		arg_12_1.duration_ = 4.37

		local var_12_0 = {
			zh = 4.2,
			ja = 4.366
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
				arg_12_0:Play325082004(arg_12_1)
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
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_5)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, 100, 0)
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
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_15_10 = 0
			local var_15_11 = 0.35

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
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_12 = arg_12_1:GetWordFromCfg(325082003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 14 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 14)

				if (14 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 14)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082003", "story_v_out_325082.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_325082", "325082003", "story_v_out_325082.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_325082", "325082003", "story_v_out_325082.awb")

						arg_12_1:RecordAudio("325082003", var_15_17)
						arg_12_1:RecordAudio("325082003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325082", "325082003", "story_v_out_325082.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325082", "325082003", "story_v_out_325082.awb")
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
	Play325082004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325082004
		arg_16_1.duration_ = 5.73

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325082005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1077ui_story = arg_16_1.actors_["1077ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).z)
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles = arg_16_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).z)
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles = arg_16_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["1077ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_4)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_19_5 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_6 = 0.733333333333333

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 then
				local var_19_7 = Color.New(1, 1, 1)

				var_19_7.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_5) / var_19_6)
				arg_16_1.mask_.color = var_19_7
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 then
				local var_19_8 = Color.New(1, 1, 1)

				arg_16_1.mask_.enabled = false
				var_19_8.a = 0
				arg_16_1.mask_.color = var_19_8
			end

			if 0.5 < arg_16_1.time_ and arg_16_1.time_ <= 0.5 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_ice", "")
			end

			if 0.3 < arg_16_1.time_ and arg_16_1.time_ <= 0.3 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_explosion", "")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_11 = 0.733333333333333
			local var_19_12 = 1.325

			if 0.733333333333333 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_13 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_13:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325082004).content)

				arg_16_1.text_.text = var_19_14

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_16 = 53 <= 0 and var_19_12 or var_19_12 * (utf8.len(var_19_14) / 53)

				if (53 <= 0 and var_19_12 or var_19_12 * (utf8.len(var_19_14) / 53)) > 0 and var_19_12 < var_19_16 then
					arg_16_1.talkMaxDuration = var_19_16
					var_19_11 = var_19_11 + 0.3

					if var_19_16 + var_19_11 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_11
					end
				end

				arg_16_1.text_.text = var_19_14
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_17 = var_19_11 + 0.3
			local var_19_18 = math.max(var_19_12, arg_16_1.talkMaxDuration)

			if var_19_11 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_17) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play325082005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 325082005
		arg_22_1.duration_ = 6.3

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play325082006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_9000

			if 0.433333333333333 < arg_22_1.time_ and arg_22_1.time_ <= 0.433333333333333 + arg_25_0 then
				local var_25_0 = arg_22_1.var_.effect32132

				if not arg_22_1.var_.effect32132 then
					var_25_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_25_0.name = "32132"
					arg_22_1.var_.effect32132 = var_25_0
				else
					var_25_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_25_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_25_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_22_1.time_ and arg_22_1.time_ <= 0.2 + arg_25_0 then
				local var_25_2 = arg_22_1.var_.effect34324

				if not arg_22_1.var_.effect34324 then
					var_25_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_25_2.name = "34324"
					arg_22_1.var_.effect34324 = var_25_2
				else
					var_25_2.transform:SetParent(var_25_9000)
				end

				var_25_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_25_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_25_4 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			if arg_22_1.time_ >= var_25_4 + 1.43333333333333 and arg_22_1.time_ < var_25_4 + 1.43333333333333 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			if 0.3 < arg_22_1.time_ and arg_22_1.time_ <= 0.3 + arg_25_0 then
				arg_22_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_cloth", "")
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_6 = 1.3
			local var_25_7 = 1.55

			if 1.3 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_8 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_8:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_9 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(325082005).content)

				arg_22_1.text_.text = var_25_9

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 62 <= 0 and var_25_7 or var_25_7 * (utf8.len(var_25_9) / 62)

				if (62 <= 0 and var_25_7 or var_25_7 * (utf8.len(var_25_9) / 62)) > 0 and var_25_7 < var_25_11 then
					arg_22_1.talkMaxDuration = var_25_11
					var_25_6 = var_25_6 + 0.3

					if var_25_11 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_11 + var_25_6
					end
				end

				arg_22_1.text_.text = var_25_9
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_12 = var_25_6 + 0.3
			local var_25_13 = math.max(var_25_7, arg_22_1.talkMaxDuration)

			if var_25_6 + 0.3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_12 + var_25_13 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_12) / var_25_13

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_12 + var_25_13 and arg_22_1.time_ < var_25_12 + var_25_13 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play325082006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325082006
		arg_28_1.duration_ = 3.27

		local var_28_0 = {
			zh = 2.366,
			ja = 3.266
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
				arg_28_0:Play325082007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(325082006)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 8 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 8)

				if (8 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 8)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082006", "story_v_out_325082.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082006", "story_v_out_325082.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_325082", "325082006", "story_v_out_325082.awb")

						arg_28_1:RecordAudio("325082006", var_31_6)
						arg_28_1:RecordAudio("325082006", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325082", "325082006", "story_v_out_325082.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325082", "325082006", "story_v_out_325082.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325082007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325082007
		arg_32_1.duration_ = 3

		local var_32_0 = {
			zh = 1.999999999999,
			ja = 3
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
				arg_32_0:Play325082008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1077ui_story = arg_32_1.actors_["1077ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).z)
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles = arg_32_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_32_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).z)
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles = arg_32_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["1077ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_4 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 and not isNil(var_35_3) then
				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_3) then
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_35_6 = 0
			local var_35_7 = 0.125

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(325082007)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 5 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 5)

				if (5 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 5)) > 0 and var_35_7 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082007", "story_v_out_325082.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082007", "story_v_out_325082.awb") / 1000

					if var_35_12 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_6
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_325082", "325082007", "story_v_out_325082.awb")

						arg_32_1:RecordAudio("325082007", var_35_13)
						arg_32_1:RecordAudio("325082007", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325082", "325082007", "story_v_out_325082.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325082", "325082007", "story_v_out_325082.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play325082008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325082008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325082009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1077ui_story = arg_36_1.actors_["1077ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).z)
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles = arg_36_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).z)
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles = arg_36_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = 0
			local var_39_4 = 1.35

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(325082008).content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 54 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_5) / 54)

				if (54 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_5) / 54)) > 0 and var_39_4 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_3
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_4, arg_36_1.talkMaxDuration)

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_3) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_3 + var_39_8 and arg_36_1.time_ < var_39_3 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play325082009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325082009
		arg_40_1.duration_ = 9.13

		local var_40_0 = {
			zh = 5.2,
			ja = 9.133
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
				arg_40_0:Play325082010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.625

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(325082009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 25 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 25)

				if (25 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 25)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082009", "story_v_out_325082.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082009", "story_v_out_325082.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_325082", "325082009", "story_v_out_325082.awb")

						arg_40_1:RecordAudio("325082009", var_43_6)
						arg_40_1:RecordAudio("325082009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325082", "325082009", "story_v_out_325082.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325082", "325082009", "story_v_out_325082.awb")
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
	Play325082010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325082010
		arg_44_1.duration_ = 2.47

		local var_44_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_44_0:Play325082011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1077ui_story = arg_44_1.actors_["1077ui_story"].transform.localPosition

				local var_47_0 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_0 then
					var_47_0:EnableDynamicBone(false)
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_44_1.time_ - 0) / var_47_1)
				arg_44_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).z)
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles = arg_44_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_44_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).z)
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles = arg_44_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(true)
				end
			end

			local var_47_3 = arg_44_1.actors_["1077ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1077ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1077ui_story then
				arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_47_6 = 0
			local var_47_7 = 0.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(325082010)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 5 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 5)

				if (5 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 5)) > 0 and var_47_7 < var_47_11 then
					arg_44_1.talkMaxDuration = var_47_11

					if var_47_11 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082010", "story_v_out_325082.awb") ~= 0 then
					local var_47_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082010", "story_v_out_325082.awb") / 1000

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_325082", "325082010", "story_v_out_325082.awb")

						arg_44_1:RecordAudio("325082010", var_47_13)
						arg_44_1:RecordAudio("325082010", var_47_13)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325082", "325082010", "story_v_out_325082.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325082", "325082010", "story_v_out_325082.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play325082011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325082011
		arg_48_1.duration_ = 4.6

		local var_48_0 = {
			zh = 2.1,
			ja = 4.6
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
				arg_48_0:Play325082012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1077ui_story"]) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = arg_48_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1077ui_story"]) then
				if arg_48_1.var_.characterEffect1077ui_story and not isNil(arg_48_1.actors_["1077ui_story"]) then
					arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1077ui_story"]) and arg_48_1.var_.characterEffect1077ui_story then
				arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.25

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(325082011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 10 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 10)

				if (10 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 10)) > 0 and var_51_2 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082011", "story_v_out_325082.awb") ~= 0 then
					local var_51_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082011", "story_v_out_325082.awb") / 1000

					if var_51_7 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_1
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_325082", "325082011", "story_v_out_325082.awb")

						arg_48_1:RecordAudio("325082011", var_51_8)
						arg_48_1:RecordAudio("325082011", var_51_8)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325082", "325082011", "story_v_out_325082.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325082", "325082011", "story_v_out_325082.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_9 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_9 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_9

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_9 and arg_48_1.time_ < var_51_1 + var_51_9 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325082012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325082012
		arg_52_1.duration_ = 1.53

		local var_52_0 = {
			zh = 1.533,
			ja = 1.133
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
				arg_52_0:Play325082013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1077ui_story"]) and arg_52_1.var_.characterEffect1077ui_story == nil then
				arg_52_1.var_.characterEffect1077ui_story = arg_52_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1077ui_story"]) then
				if arg_52_1.var_.characterEffect1077ui_story and not isNil(arg_52_1.actors_["1077ui_story"]) then
					arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1077ui_story"]) and arg_52_1.var_.characterEffect1077ui_story then
				arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_55_2 = 0
			local var_55_3 = 0.075

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(325082012)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 3 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 3)

				if (3 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 3)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082012", "story_v_out_325082.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082012", "story_v_out_325082.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_325082", "325082012", "story_v_out_325082.awb")

						arg_52_1:RecordAudio("325082012", var_55_9)
						arg_52_1:RecordAudio("325082012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325082", "325082012", "story_v_out_325082.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325082", "325082012", "story_v_out_325082.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325082013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325082013
		arg_56_1.duration_ = 10.5

		local var_56_0 = {
			zh = 9.366,
			ja = 10.5
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
				arg_56_0:Play325082014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = arg_56_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) then
				if arg_56_1.var_.characterEffect1077ui_story and not isNil(arg_56_1.actors_["1077ui_story"]) then
					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) and arg_56_1.var_.characterEffect1077ui_story then
				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.85

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(325082013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 34 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 34)

				if (34 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 34)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082013", "story_v_out_325082.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082013", "story_v_out_325082.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_325082", "325082013", "story_v_out_325082.awb")

						arg_56_1:RecordAudio("325082013", var_59_8)
						arg_56_1:RecordAudio("325082013", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325082", "325082013", "story_v_out_325082.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325082", "325082013", "story_v_out_325082.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325082014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325082014
		arg_60_1.duration_ = 5.43

		local var_60_0 = {
			zh = 5.433,
			ja = 4.5
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
				arg_60_0:Play325082015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.525

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(325082014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 21 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 21)

				if (21 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 21)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082014", "story_v_out_325082.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082014", "story_v_out_325082.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_325082", "325082014", "story_v_out_325082.awb")

						arg_60_1:RecordAudio("325082014", var_63_6)
						arg_60_1:RecordAudio("325082014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325082", "325082014", "story_v_out_325082.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325082", "325082014", "story_v_out_325082.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325082015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325082015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325082016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1077ui_story = arg_64_1.actors_["1077ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1077ui_story"].transform.position).z)
				arg_64_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1077ui_story"].transform.localEulerAngles = arg_64_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1077ui_story"].transform.position).z)
				arg_64_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1077ui_story"].transform.localEulerAngles = arg_64_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = 0
			local var_67_4 = 1.275

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(325082015).content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 51 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 51)

				if (51 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 51)) > 0 and var_67_4 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_8 and arg_64_1.time_ < var_67_3 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play325082016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325082016
		arg_68_1.duration_ = 6.27

		local var_68_0 = {
			zh = 5.9,
			ja = 6.266
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
				arg_68_0:Play325082017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.55

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(325082016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 22 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 22)

				if (22 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 22)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082016", "story_v_out_325082.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082016", "story_v_out_325082.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_325082", "325082016", "story_v_out_325082.awb")

						arg_68_1:RecordAudio("325082016", var_71_6)
						arg_68_1:RecordAudio("325082016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325082", "325082016", "story_v_out_325082.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325082", "325082016", "story_v_out_325082.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325082017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325082017
		arg_72_1.duration_ = 6.07

		local var_72_0 = {
			zh = 3.433,
			ja = 6.066
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
				arg_72_0:Play325082018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1077ui_story = arg_72_1.actors_["1077ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).z)
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles = arg_72_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_72_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).z)
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles = arg_72_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = arg_72_1.actors_["1077ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect1077ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1077ui_story then
				arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_75_6 = 0
			local var_75_7 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
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

				local var_75_8 = arg_72_1:GetWordFromCfg(325082017)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 19 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 19)

				if (19 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 19)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082017", "story_v_out_325082.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082017", "story_v_out_325082.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_325082", "325082017", "story_v_out_325082.awb")

						arg_72_1:RecordAudio("325082017", var_75_13)
						arg_72_1:RecordAudio("325082017", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325082", "325082017", "story_v_out_325082.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325082", "325082017", "story_v_out_325082.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play325082018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325082018
		arg_76_1.duration_ = 3.7

		local var_76_0 = {
			zh = 2.2,
			ja = 3.7
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
				arg_76_0:Play325082019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = arg_76_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) then
				if arg_76_1.var_.characterEffect1077ui_story and not isNil(arg_76_1.actors_["1077ui_story"]) then
					arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) and arg_76_1.var_.characterEffect1077ui_story then
				arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.175

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(325082018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 7 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 7)

				if (7 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 7)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082018", "story_v_out_325082.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082018", "story_v_out_325082.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_325082", "325082018", "story_v_out_325082.awb")

						arg_76_1:RecordAudio("325082018", var_79_8)
						arg_76_1:RecordAudio("325082018", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325082", "325082018", "story_v_out_325082.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325082", "325082018", "story_v_out_325082.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_9 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_9

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_9 and arg_76_1.time_ < var_79_1 + var_79_9 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325082019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325082019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325082020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1077ui_story = arg_80_1.actors_["1077ui_story"].transform.localPosition

				local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_0 then
					var_83_0:EnableDynamicBone(false)
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_1)
				arg_80_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1077ui_story"].transform.position).z)
				arg_80_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1077ui_story"].transform.localEulerAngles = arg_80_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1077ui_story"].transform.position).z)
				arg_80_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1077ui_story"].transform.localEulerAngles = arg_80_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_83_2 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(true)
				end
			end

			local var_83_3 = "1059ui_story"

			if arg_80_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_83_4 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_80_1.stage_.transform)

				var_83_4.name = var_83_3
				var_83_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_[var_83_3] = var_83_4

				local var_83_5 = var_83_4:GetComponentInChildren(typeof(CharacterEffect))

				var_83_5.enabled = true

				local var_83_6 = GameObjectTools.GetOrAddComponent(var_83_4, typeof(DynamicBoneHelper))

				if var_83_6 then
					var_83_6:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_5.transform, false)

				arg_80_1.var_[var_83_3 .. "Animator"] = var_83_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_[var_83_3 .. "Animator"].applyRootMotion = true
				arg_80_1.var_[var_83_3 .. "LipSync"] = var_83_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_7 = arg_80_1.actors_["1059ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1059ui_story = var_83_7.localPosition
			end

			local var_83_8 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_8 then
				var_83_7.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_8)
				var_83_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_7.position).x, (manager.ui.mainCamera.transform.position - var_83_7.position).y, (manager.ui.mainCamera.transform.position - var_83_7.position).z)
				var_83_7.localEulerAngles.z = 0
				var_83_7.localEulerAngles.x = 0
				var_83_7.localEulerAngles = var_83_7.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_8 and arg_80_1.time_ < 0 + var_83_8 + arg_83_0 then
				var_83_7.localPosition = Vector3.New(0, 100, 0)
				var_83_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_7.position).x, (manager.ui.mainCamera.transform.position - var_83_7.position).y, (manager.ui.mainCamera.transform.position - var_83_7.position).z)
				var_83_7.localEulerAngles.z = 0
				var_83_7.localEulerAngles.x = 0
				var_83_7.localEulerAngles = var_83_7.localEulerAngles
			end

			local var_83_9 = arg_80_1.actors_["1059ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_10 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_10 and not isNil(var_83_9) then
				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_10)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_10 and arg_80_1.time_ < 0 + var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_80_1.time_ and arg_80_1.time_ <= 0.3 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_148", "se_story_148_explosion", "")
			end

			local var_83_12 = 0
			local var_83_13 = 0.975

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_14 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(325082019).content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_16 = 39 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_14) / 39)

				if (39 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_14) / 39)) > 0 and var_83_13 < var_83_16 then
					arg_80_1.talkMaxDuration = var_83_16

					if var_83_16 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_17 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_17 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_17

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_17 and arg_80_1.time_ < var_83_12 + var_83_17 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play325082020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325082020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325082021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			if arg_84_1.time_ >= 0 + 1.43333333333333 and arg_84_1.time_ < 0 + 1.43333333333333 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			if 0.3 < arg_84_1.time_ and arg_84_1.time_ <= 0.3 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy01", "")
			end

			if 1 < arg_84_1.time_ and arg_84_1.time_ <= 1 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_cloth", "")
			end

			local var_87_2 = 0
			local var_87_3 = 1.55

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(325082020).content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 62 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 62)

				if (62 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 62)) > 0 and var_87_3 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_7 and arg_84_1.time_ < var_87_2 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 9,
				className = "StoryShakeNode",
				duration = 0.933333333333333,
				startTime = 0.233333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 0.1, 0.1)
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play325082021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325082021
		arg_88_1.duration_ = 2.1

		local var_88_0 = {
			zh = 1,
			ja = 2.1
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325082022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1077ui_story = arg_88_1.actors_["1077ui_story"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1077ui_story"].transform.position).z)
				arg_88_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1077ui_story"].transform.localEulerAngles = arg_88_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_88_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1077ui_story"].transform.position).z)
				arg_88_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1077ui_story"].transform.localEulerAngles = arg_88_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = arg_88_1.actors_["1077ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect1077ui_story == nil then
				arg_88_1.var_.characterEffect1077ui_story = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect1077ui_story and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect1077ui_story then
				arg_88_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_91_6 = 0
			local var_91_7 = 0.125

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(325082021)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 5 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 5)

				if (5 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 5)) > 0 and var_91_7 < var_91_11 then
					arg_88_1.talkMaxDuration = var_91_11

					if var_91_11 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082021", "story_v_out_325082.awb") ~= 0 then
					local var_91_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082021", "story_v_out_325082.awb") / 1000

					if var_91_12 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_6
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_325082", "325082021", "story_v_out_325082.awb")

						arg_88_1:RecordAudio("325082021", var_91_13)
						arg_88_1:RecordAudio("325082021", var_91_13)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325082", "325082021", "story_v_out_325082.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325082", "325082021", "story_v_out_325082.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play325082022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325082022
		arg_92_1.duration_ = 6.37

		local var_92_0 = {
			zh = 5.666,
			ja = 6.366
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325082023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1077ui_story"]) and arg_92_1.var_.characterEffect1077ui_story == nil then
				arg_92_1.var_.characterEffect1077ui_story = arg_92_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1077ui_story"]) then
				if arg_92_1.var_.characterEffect1077ui_story and not isNil(arg_92_1.actors_["1077ui_story"]) then
					arg_92_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1077ui_story"]) and arg_92_1.var_.characterEffect1077ui_story then
				arg_92_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.375

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(325082022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 15 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 15)

				if (15 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 15)) > 0 and var_95_2 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082022", "story_v_out_325082.awb") ~= 0 then
					local var_95_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082022", "story_v_out_325082.awb") / 1000

					if var_95_7 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_1
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_325082", "325082022", "story_v_out_325082.awb")

						arg_92_1:RecordAudio("325082022", var_95_8)
						arg_92_1:RecordAudio("325082022", var_95_8)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325082", "325082022", "story_v_out_325082.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325082", "325082022", "story_v_out_325082.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_9 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_9 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_9

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_9 and arg_92_1.time_ < var_95_1 + var_95_9 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325082023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325082023
		arg_96_1.duration_ = 2

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325082024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1077ui_story"]) and arg_96_1.var_.characterEffect1077ui_story == nil then
				arg_96_1.var_.characterEffect1077ui_story = arg_96_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1077ui_story"]) then
				if arg_96_1.var_.characterEffect1077ui_story and not isNil(arg_96_1.actors_["1077ui_story"]) then
					arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1077ui_story"]) and arg_96_1.var_.characterEffect1077ui_story then
				arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_99_2 = 0
			local var_99_3 = 0.15

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(325082023)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 6 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 6)

				if (6 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 6)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082023", "story_v_out_325082.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082023", "story_v_out_325082.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_325082", "325082023", "story_v_out_325082.awb")

						arg_96_1:RecordAudio("325082023", var_99_9)
						arg_96_1:RecordAudio("325082023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325082", "325082023", "story_v_out_325082.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325082", "325082023", "story_v_out_325082.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325082024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325082024
		arg_100_1.duration_ = 7.1

		local var_100_0 = {
			zh = 6.466,
			ja = 7.1
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325082025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1077ui_story"]) and arg_100_1.var_.characterEffect1077ui_story == nil then
				arg_100_1.var_.characterEffect1077ui_story = arg_100_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1077ui_story"]) then
				if arg_100_1.var_.characterEffect1077ui_story and not isNil(arg_100_1.actors_["1077ui_story"]) then
					arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1077ui_story"]) and arg_100_1.var_.characterEffect1077ui_story then
				arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.55

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(325082024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 22 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 22)

				if (22 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 22)) > 0 and var_103_2 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082024", "story_v_out_325082.awb") ~= 0 then
					local var_103_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082024", "story_v_out_325082.awb") / 1000

					if var_103_7 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_1
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_325082", "325082024", "story_v_out_325082.awb")

						arg_100_1:RecordAudio("325082024", var_103_8)
						arg_100_1:RecordAudio("325082024", var_103_8)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325082", "325082024", "story_v_out_325082.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325082", "325082024", "story_v_out_325082.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_9 and arg_100_1.time_ < var_103_1 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325082025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325082025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325082026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1077ui_story = arg_104_1.actors_["1077ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1077ui_story"].transform.position).z)
				arg_104_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1077ui_story"].transform.localEulerAngles = arg_104_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1077ui_story"].transform.position).z)
				arg_104_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1077ui_story"].transform.localEulerAngles = arg_104_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["1059ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1059ui_story == nil then
				arg_104_1.var_.characterEffect1059ui_story = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect1059ui_story and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_4)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1059ui_story then
				arg_104_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 1 < arg_104_1.time_ and arg_104_1.time_ <= 1 + arg_107_0 then
				arg_104_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy03", "")
			end

			local var_107_6 = 0
			local var_107_7 = 1.35

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(325082025).content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 54 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_8) / 54)

				if (54 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_8) / 54)) > 0 and var_107_7 < var_107_10 then
					arg_104_1.talkMaxDuration = var_107_10

					if var_107_10 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_11 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_11 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_11

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_11 and arg_104_1.time_ < var_107_6 + var_107_11 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play325082026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325082026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325082027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.25

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(325082026).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 50 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 50)

				if (50 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 50)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325082027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325082027
		arg_112_1.duration_ = 2.4

		local var_112_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325082028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1077ui_story = arg_112_1.actors_["1077ui_story"].transform.localPosition

				local var_115_0 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_0 then
					var_115_0:EnableDynamicBone(false)
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_1)
				arg_112_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1077ui_story"].transform.position).z)
				arg_112_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1077ui_story"].transform.localEulerAngles = arg_112_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1077ui_story"].transform.position).z)
				arg_112_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1077ui_story"].transform.localEulerAngles = arg_112_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_115_2 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(true)
				end
			end

			local var_115_3 = arg_112_1.actors_["1077ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1077ui_story == nil then
				arg_112_1.var_.characterEffect1077ui_story = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect1077ui_story and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1077ui_story then
				arg_112_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_115_6 = 0
			local var_115_7 = 0.2

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_8 = arg_112_1:GetWordFromCfg(325082027)
				local var_115_9 = arg_112_1:FormatText(var_115_8.content)

				arg_112_1.text_.text = var_115_9

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 8 <= 0 and var_115_7 or var_115_7 * (utf8.len(var_115_9) / 8)

				if (8 <= 0 and var_115_7 or var_115_7 * (utf8.len(var_115_9) / 8)) > 0 and var_115_7 < var_115_11 then
					arg_112_1.talkMaxDuration = var_115_11

					if var_115_11 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_9
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082027", "story_v_out_325082.awb") ~= 0 then
					local var_115_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082027", "story_v_out_325082.awb") / 1000

					if var_115_12 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_6
					end

					if var_115_8.prefab_name ~= "" and arg_112_1.actors_[var_115_8.prefab_name] ~= nil then
						local var_115_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_8.prefab_name].transform, "story_v_out_325082", "325082027", "story_v_out_325082.awb")

						arg_112_1:RecordAudio("325082027", var_115_13)
						arg_112_1:RecordAudio("325082027", var_115_13)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325082", "325082027", "story_v_out_325082.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325082", "325082027", "story_v_out_325082.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_14 and arg_112_1.time_ < var_115_6 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play325082028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325082028
		arg_116_1.duration_ = 2.1

		local var_116_0 = {
			zh = 1.2,
			ja = 2.1
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325082029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1077ui_story"]) and arg_116_1.var_.characterEffect1077ui_story == nil then
				arg_116_1.var_.characterEffect1077ui_story = arg_116_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1077ui_story"]) then
				if arg_116_1.var_.characterEffect1077ui_story and not isNil(arg_116_1.actors_["1077ui_story"]) then
					arg_116_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1077ui_story"]) and arg_116_1.var_.characterEffect1077ui_story then
				arg_116_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.15

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(325082028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_6 = 6 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_4) / 6)

				if (6 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_4) / 6)) > 0 and var_119_2 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082028", "story_v_out_325082.awb") ~= 0 then
					local var_119_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082028", "story_v_out_325082.awb") / 1000

					if var_119_7 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_1
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_325082", "325082028", "story_v_out_325082.awb")

						arg_116_1:RecordAudio("325082028", var_119_8)
						arg_116_1:RecordAudio("325082028", var_119_8)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325082", "325082028", "story_v_out_325082.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325082", "325082028", "story_v_out_325082.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_9 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_9 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_9

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_9 and arg_116_1.time_ < var_119_1 + var_119_9 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play325082029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325082029
		arg_120_1.duration_ = 3.17

		local var_120_0 = {
			zh = 2.866,
			ja = 3.166
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325082030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1077ui_story"]) and arg_120_1.var_.characterEffect1077ui_story == nil then
				arg_120_1.var_.characterEffect1077ui_story = arg_120_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1077ui_story"]) then
				if arg_120_1.var_.characterEffect1077ui_story and not isNil(arg_120_1.actors_["1077ui_story"]) then
					arg_120_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1077ui_story"]) and arg_120_1.var_.characterEffect1077ui_story then
				arg_120_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_123_2 = 0
			local var_123_3 = 0.4

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_4 = arg_120_1:GetWordFromCfg(325082029)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 16 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 16)

				if (16 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 16)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082029", "story_v_out_325082.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082029", "story_v_out_325082.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_325082", "325082029", "story_v_out_325082.awb")

						arg_120_1:RecordAudio("325082029", var_123_9)
						arg_120_1:RecordAudio("325082029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325082", "325082029", "story_v_out_325082.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325082", "325082029", "story_v_out_325082.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play325082030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325082030
		arg_124_1.duration_ = 1.37

		local var_124_0 = {
			zh = 1.266,
			ja = 1.366
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325082031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1077ui_story"]) and arg_124_1.var_.characterEffect1077ui_story == nil then
				arg_124_1.var_.characterEffect1077ui_story = arg_124_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1077ui_story"]) then
				if arg_124_1.var_.characterEffect1077ui_story and not isNil(arg_124_1.actors_["1077ui_story"]) then
					arg_124_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1077ui_story"]) and arg_124_1.var_.characterEffect1077ui_story then
				arg_124_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.075

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(325082030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 3 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_4) / 3)

				if (3 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_4) / 3)) > 0 and var_127_2 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082030", "story_v_out_325082.awb") ~= 0 then
					local var_127_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082030", "story_v_out_325082.awb") / 1000

					if var_127_7 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_1
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_325082", "325082030", "story_v_out_325082.awb")

						arg_124_1:RecordAudio("325082030", var_127_8)
						arg_124_1:RecordAudio("325082030", var_127_8)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325082", "325082030", "story_v_out_325082.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325082", "325082030", "story_v_out_325082.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_9 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_9 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_9

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_9 and arg_124_1.time_ < var_127_1 + var_127_9 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325082031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325082031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325082032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1077ui_story = arg_128_1.actors_["1077ui_story"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1077ui_story"].transform.position).z)
				arg_128_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1077ui_story"].transform.localEulerAngles = arg_128_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1077ui_story"].transform.position).z)
				arg_128_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1077ui_story"].transform.localEulerAngles = arg_128_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["1059ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1059ui_story == nil then
				arg_128_1.var_.characterEffect1059ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1059ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_4)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1059ui_story then
				arg_128_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_131_5 = 0
			local var_131_6 = 1.275

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(325082031).content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 51 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_7) / 51)

				if (51 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_7) / 51)) > 0 and var_131_6 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_10 and arg_128_1.time_ < var_131_5 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play325082032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325082032
		arg_132_1.duration_ = 5.93

		local var_132_0 = {
			zh = 4.333,
			ja = 5.933
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325082033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.475

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_1 = arg_132_1:GetWordFromCfg(325082032)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 19 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 19)

				if (19 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 19)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082032", "story_v_out_325082.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082032", "story_v_out_325082.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_325082", "325082032", "story_v_out_325082.awb")

						arg_132_1:RecordAudio("325082032", var_135_6)
						arg_132_1:RecordAudio("325082032", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325082", "325082032", "story_v_out_325082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325082", "325082032", "story_v_out_325082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325082033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325082033
		arg_136_1.duration_ = 3.4

		local var_136_0 = {
			zh = 2.666,
			ja = 3.4
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325082034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1077ui_story = arg_136_1.actors_["1077ui_story"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1077ui_story"].transform.position).z)
				arg_136_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1077ui_story"].transform.localEulerAngles = arg_136_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_136_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1077ui_story"].transform.position).z)
				arg_136_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1077ui_story"].transform.localEulerAngles = arg_136_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["1077ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect1077ui_story == nil then
				arg_136_1.var_.characterEffect1077ui_story = var_139_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_4 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 and not isNil(var_139_3) then
				if arg_136_1.var_.characterEffect1077ui_story and not isNil(var_139_3) then
					arg_136_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect1077ui_story then
				arg_136_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_139_6 = 0
			local var_139_7 = 0.375

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(325082033)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 15 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 15)

				if (15 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 15)) > 0 and var_139_7 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082033", "story_v_out_325082.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082033", "story_v_out_325082.awb") / 1000

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end

					if var_139_8.prefab_name ~= "" and arg_136_1.actors_[var_139_8.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_8.prefab_name].transform, "story_v_out_325082", "325082033", "story_v_out_325082.awb")

						arg_136_1:RecordAudio("325082033", var_139_13)
						arg_136_1:RecordAudio("325082033", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_325082", "325082033", "story_v_out_325082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_325082", "325082033", "story_v_out_325082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play325082034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325082034
		arg_140_1.duration_ = 7.23

		local var_140_0 = {
			zh = 4.1,
			ja = 7.233
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325082035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1077ui_story"]) and arg_140_1.var_.characterEffect1077ui_story == nil then
				arg_140_1.var_.characterEffect1077ui_story = arg_140_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1077ui_story"]) then
				if arg_140_1.var_.characterEffect1077ui_story and not isNil(arg_140_1.actors_["1077ui_story"]) then
					arg_140_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1077ui_story"]) and arg_140_1.var_.characterEffect1077ui_story then
				arg_140_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.375

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(325082034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_6 = 15 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 15)

				if (15 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 15)) > 0 and var_143_2 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082034", "story_v_out_325082.awb") ~= 0 then
					local var_143_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082034", "story_v_out_325082.awb") / 1000

					if var_143_7 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_1
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_325082", "325082034", "story_v_out_325082.awb")

						arg_140_1:RecordAudio("325082034", var_143_8)
						arg_140_1:RecordAudio("325082034", var_143_8)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325082", "325082034", "story_v_out_325082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325082", "325082034", "story_v_out_325082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_9 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_9 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_9

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_9 and arg_140_1.time_ < var_143_1 + var_143_9 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325082035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325082035
		arg_144_1.duration_ = 7.4

		local var_144_0 = {
			zh = 5.933,
			ja = 7.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325082036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.7

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:GetWordFromCfg(325082035)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 28 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 28)

				if (28 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 28)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082035", "story_v_out_325082.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082035", "story_v_out_325082.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_325082", "325082035", "story_v_out_325082.awb")

						arg_144_1:RecordAudio("325082035", var_147_6)
						arg_144_1:RecordAudio("325082035", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325082", "325082035", "story_v_out_325082.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325082", "325082035", "story_v_out_325082.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325082036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325082036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325082037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1077ui_story = arg_148_1.actors_["1077ui_story"].transform.localPosition

				local var_151_0 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_0 then
					var_151_0:EnableDynamicBone(false)
				end
			end

			local var_151_1 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_1 then
				arg_148_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_1)
				arg_148_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1077ui_story"].transform.position).z)
				arg_148_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1077ui_story"].transform.localEulerAngles = arg_148_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_1 and arg_148_1.time_ < 0 + var_151_1 + arg_151_0 then
				arg_148_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1077ui_story"].transform.position).z)
				arg_148_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1077ui_story"].transform.localEulerAngles = arg_148_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_151_2 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(true)
				end
			end

			local var_151_3 = arg_148_1.actors_["1059ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_3) and arg_148_1.var_.characterEffect1059ui_story == nil then
				arg_148_1.var_.characterEffect1059ui_story = var_151_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_4 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 and not isNil(var_151_3) then
				if arg_148_1.var_.characterEffect1059ui_story and not isNil(var_151_3) then
					arg_148_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_4)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 and not isNil(var_151_3) and arg_148_1.var_.characterEffect1059ui_story then
				arg_148_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_151_5 = 0
			local var_151_6 = 1.15

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(325082036).content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 46 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_7) / 46)

				if (46 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_7) / 46)) > 0 and var_151_6 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_10 and arg_148_1.time_ < var_151_5 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play325082037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325082037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325082038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 1.3

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(325082037).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 52 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 52)

				if (52 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 52)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325082038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325082038
		arg_156_1.duration_ = 2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325082039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1077ui_story = arg_156_1.actors_["1077ui_story"].transform.localPosition

				local var_159_0 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_0 then
					var_159_0:EnableDynamicBone(false)
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_156_1.time_ - 0) / var_159_1)
				arg_156_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1077ui_story"].transform.position).z)
				arg_156_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1077ui_story"].transform.localEulerAngles = arg_156_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_156_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1077ui_story"].transform.position).z)
				arg_156_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1077ui_story"].transform.localEulerAngles = arg_156_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_159_2 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(true)
				end
			end

			local var_159_3 = arg_156_1.actors_["1077ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect1077ui_story == nil then
				arg_156_1.var_.characterEffect1077ui_story = var_159_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_4 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 and not isNil(var_159_3) then
				if arg_156_1.var_.characterEffect1077ui_story and not isNil(var_159_3) then
					arg_156_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect1077ui_story then
				arg_156_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_159_6 = 0
			local var_159_7 = 0.1

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(325082038)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 4 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 4)

				if (4 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 4)) > 0 and var_159_7 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082038", "story_v_out_325082.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082038", "story_v_out_325082.awb") / 1000

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_325082", "325082038", "story_v_out_325082.awb")

						arg_156_1:RecordAudio("325082038", var_159_13)
						arg_156_1:RecordAudio("325082038", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325082", "325082038", "story_v_out_325082.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325082", "325082038", "story_v_out_325082.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play325082039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325082039
		arg_160_1.duration_ = 6.83

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325082040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_9001
			local var_163_9000

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1077ui_story = arg_160_1.actors_["1077ui_story"].transform.localPosition

				local var_163_0 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_0 then
					var_163_0:EnableDynamicBone(false)
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_1)
				arg_160_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).z)
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles = arg_160_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1077ui_story"].transform.position).z)
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1077ui_story"].transform.localEulerAngles = arg_160_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_163_2 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(true)
				end
			end

			local var_163_3 = arg_160_1.actors_["1077ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1077ui_story == nil then
				arg_160_1.var_.characterEffect1077ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect1077ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_4)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1077ui_story then
				arg_160_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				local var_163_5 = arg_160_1.var_.effect432432

				if not arg_160_1.var_.effect432432 then
					var_163_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), manager.ui.mainCamera.transform)
					var_163_5.name = "432432"
					arg_160_1.var_.effect432432 = var_163_5
				else
					var_163_5.transform:SetParent(var_163_9001)
				end

				var_163_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_163_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_163_5.transform.localScale = Vector3.New(var_163_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_163_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_163_5.transform.localScale.z)
			end

			if 1.16666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 1.16666666666667 + arg_163_0 then
				if arg_160_1.var_.effect432432 then
					Object.Destroy(arg_160_1.var_.effect432432)

					arg_160_1.var_.effect432432 = nil
				end
			end

			if 0.566666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 0.566666666666667 + arg_163_0 then
				local var_163_8 = arg_160_1.var_.effectwewe

				if not arg_160_1.var_.effectwewe then
					var_163_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_163_8.name = "wewe"
					arg_160_1.var_.effectwewe = var_163_8
				else
					var_163_8.transform:SetParent(var_163_9000)
				end

				var_163_8.transform.localPosition = Vector3.New(0, 0, 0.52)
				var_163_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_163_10 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_10 + 2 and arg_160_1.time_ < var_163_10 + 2 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_11 = arg_160_1.bgs_.J29g.transform

			if 0.566666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 0.566666666666667 + arg_163_0 then
				arg_160_1.var_.moveOldPosJ29g = var_163_11.localPosition
			end

			local var_163_12 = 0.1

			if 0.566666666666667 <= arg_160_1.time_ and arg_160_1.time_ < 0.566666666666667 + var_163_12 then
				var_163_11.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPosJ29g, Vector3.New(0, 1, 4), (arg_160_1.time_ - 0.566666666666667) / var_163_12)
			end

			if arg_160_1.time_ >= 0.566666666666667 + var_163_12 and arg_160_1.time_ < 0.566666666666667 + var_163_12 + arg_163_0 then
				var_163_11.localPosition = Vector3.New(0, 1, 4)
			end

			local var_163_13 = arg_160_1.bgs_.J29g.transform

			if 0.666666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 0.666666666666667 + arg_163_0 then
				arg_160_1.var_.moveOldPosJ29g = var_163_13.localPosition
			end

			local var_163_14 = 0.666666666666667

			if 0.666666666666667 <= arg_160_1.time_ and arg_160_1.time_ < 0.666666666666667 + var_163_14 then
				var_163_13.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPosJ29g, Vector3.New(0, 1, 10), (arg_160_1.time_ - 0.666666666666667) / var_163_14)
			end

			if arg_160_1.time_ >= 0.666666666666667 + var_163_14 and arg_160_1.time_ < 0.666666666666667 + var_163_14 + arg_163_0 then
				var_163_13.localPosition = Vector3.New(0, 1, 10)
			end

			if 0.3 < arg_160_1.time_ and arg_160_1.time_ <= 0.3 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_145", "se_story_145_laser", "")
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_16 = 1.83333333333333
			local var_163_17 = 0.925

			if 1.83333333333333 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_18 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_18:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_19 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(325082039).content)

				arg_160_1.text_.text = var_163_19

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_21 = 37 <= 0 and var_163_17 or var_163_17 * (utf8.len(var_163_19) / 37)

				if (37 <= 0 and var_163_17 or var_163_17 * (utf8.len(var_163_19) / 37)) > 0 and var_163_17 < var_163_21 then
					arg_160_1.talkMaxDuration = var_163_21
					var_163_16 = var_163_16 + 0.3

					if var_163_21 + var_163_16 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_21 + var_163_16
					end
				end

				arg_160_1.text_.text = var_163_19
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_22 = var_163_16 + 0.3
			local var_163_23 = math.max(var_163_17, arg_160_1.talkMaxDuration)

			if var_163_16 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_22 + var_163_23 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_22) / var_163_23

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_22 + var_163_23 and arg_160_1.time_ < var_163_22 + var_163_23 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J29g",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.1,
				startTime = 0.566666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 4),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J29g",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.666666666666667,
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 4),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play325082040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325082040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325082041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0.3 < arg_166_1.time_ and arg_166_1.time_ <= 0.3 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep03", "")
			end

			local var_169_1 = 0
			local var_169_2 = 1.35

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(325082040).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 54 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 54)

				if (54 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 54)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325082041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325082041
		arg_170_1.duration_ = 7.5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play325082042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 1.35 < arg_170_1.time_ and arg_170_1.time_ <= 1.35 + arg_173_0 then
				local var_173_0 = arg_170_1.bgs_.J29g

				arg_170_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_173_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_1 = var_173_0:GetComponent("SpriteRenderer")

				if var_173_1 and var_173_1.sprite then
					local var_173_2 = 2 * (var_173_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_173_0.transform.localScale = Vector3.New(var_173_2 / var_173_1.sprite.bounds.size.y < var_173_2 * manager.ui.mainCameraCom_.aspect / var_173_1.sprite.bounds.size.x and var_173_2 * manager.ui.mainCameraCom_.aspect / var_173_1.sprite.bounds.size.x or var_173_2 / var_173_1.sprite.bounds.size.y, var_173_2 / var_173_1.sprite.bounds.size.y < var_173_2 * manager.ui.mainCameraCom_.aspect / var_173_1.sprite.bounds.size.x and var_173_2 * manager.ui.mainCameraCom_.aspect / var_173_1.sprite.bounds.size.x or var_173_2 / var_173_1.sprite.bounds.size.y, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "J29g" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_3 = 1.35

			if 1.35 < arg_170_1.time_ and arg_170_1.time_ <= var_173_3 + arg_173_0 then
				arg_170_1.allBtn_.enabled = false
			end

			if arg_170_1.time_ >= var_173_3 + 0.3 and arg_170_1.time_ < var_173_3 + 0.3 + arg_173_0 then
				arg_170_1.allBtn_.enabled = true
			end

			local var_173_4 = 0

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_5 = 1.35

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_5 then
				local var_173_6 = Color.New(0, 0, 0)

				var_173_6.a = Mathf.Lerp(0, 1, (arg_170_1.time_ - var_173_4) / var_173_5)
				arg_170_1.mask_.color = var_173_6
			end

			if arg_170_1.time_ >= var_173_4 + var_173_5 and arg_170_1.time_ < var_173_4 + var_173_5 + arg_173_0 then
				local var_173_7 = Color.New(0, 0, 0)

				var_173_7.a = 1
				arg_170_1.mask_.color = var_173_7
			end

			local var_173_8 = 1.35

			if 1.35 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_9 = 2

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_9 then
				local var_173_10 = Color.New(0, 0, 0)

				var_173_10.a = Mathf.Lerp(1, 0, (arg_170_1.time_ - var_173_8) / var_173_9)
				arg_170_1.mask_.color = var_173_10
			end

			if arg_170_1.time_ >= var_173_8 + var_173_9 and arg_170_1.time_ < var_173_8 + var_173_9 + arg_173_0 then
				local var_173_11 = Color.New(0, 0, 0)

				arg_170_1.mask_.enabled = false
				var_173_11.a = 0
				arg_170_1.mask_.color = var_173_11
			end

			if 1.8 < arg_170_1.time_ and arg_170_1.time_ <= 1.8 + arg_173_0 then
				arg_170_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep04", "")
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_13 = 2.5
			local var_173_14 = 1.35

			if 2.5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_13 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_15 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_15:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_170_1.dialogCg_.alpha = arg_174_0
				end))
				var_173_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_16 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(325082041).content)

				arg_170_1.text_.text = var_173_16

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_18 = 54 <= 0 and var_173_14 or var_173_14 * (utf8.len(var_173_16) / 54)

				if (54 <= 0 and var_173_14 or var_173_14 * (utf8.len(var_173_16) / 54)) > 0 and var_173_14 < var_173_18 then
					arg_170_1.talkMaxDuration = var_173_18
					var_173_13 = var_173_13 + 0.3

					if var_173_18 + var_173_13 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_18 + var_173_13
					end
				end

				arg_170_1.text_.text = var_173_16
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_19 = var_173_13 + 0.3
			local var_173_20 = math.max(var_173_14, arg_170_1.talkMaxDuration)

			if var_173_13 + 0.3 <= arg_170_1.time_ and arg_170_1.time_ < var_173_19 + var_173_20 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_19) / var_173_20

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_19 + var_173_20 and arg_170_1.time_ < var_173_19 + var_173_20 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play325082042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325082042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325082043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.925

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(325082042).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 37 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 37)

				if (37 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 37)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play325082043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325082043
		arg_180_1.duration_ = 3.8

		local var_180_0 = {
			zh = 1.999999999999,
			ja = 3.8
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325082044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1077ui_story = arg_180_1.actors_["1077ui_story"].transform.localPosition

				local var_183_0 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_0 then
					var_183_0:EnableDynamicBone(false)
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_180_1.time_ - 0) / var_183_1)
				arg_180_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1077ui_story"].transform.position).z)
				arg_180_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1077ui_story"].transform.localEulerAngles = arg_180_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_180_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1077ui_story"].transform.position).z)
				arg_180_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1077ui_story"].transform.localEulerAngles = arg_180_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_183_2 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(true)
				end
			end

			local var_183_3 = arg_180_1.actors_["1077ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect1077ui_story == nil then
				arg_180_1.var_.characterEffect1077ui_story = var_183_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_4 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 and not isNil(var_183_3) then
				if arg_180_1.var_.characterEffect1077ui_story and not isNil(var_183_3) then
					arg_180_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect1077ui_story then
				arg_180_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_183_6 = 0
			local var_183_7 = 0.175

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(325082043)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 7 <= 0 and var_183_7 or var_183_7 * (utf8.len(var_183_9) / 7)

				if (7 <= 0 and var_183_7 or var_183_7 * (utf8.len(var_183_9) / 7)) > 0 and var_183_7 < var_183_11 then
					arg_180_1.talkMaxDuration = var_183_11

					if var_183_11 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082043", "story_v_out_325082.awb") ~= 0 then
					local var_183_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082043", "story_v_out_325082.awb") / 1000

					if var_183_12 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_6
					end

					if var_183_8.prefab_name ~= "" and arg_180_1.actors_[var_183_8.prefab_name] ~= nil then
						local var_183_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_8.prefab_name].transform, "story_v_out_325082", "325082043", "story_v_out_325082.awb")

						arg_180_1:RecordAudio("325082043", var_183_13)
						arg_180_1:RecordAudio("325082043", var_183_13)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325082", "325082043", "story_v_out_325082.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325082", "325082043", "story_v_out_325082.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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

		arg_180_1:InitPlayNodeList()
	end,
	Play325082044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325082044
		arg_184_1.duration_ = 7.33

		local var_184_0 = {
			zh = 7.333,
			ja = 6.066
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325082045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1077ui_story"]) and arg_184_1.var_.characterEffect1077ui_story == nil then
				arg_184_1.var_.characterEffect1077ui_story = arg_184_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1077ui_story"]) then
				if arg_184_1.var_.characterEffect1077ui_story and not isNil(arg_184_1.actors_["1077ui_story"]) then
					arg_184_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1077ui_story"]) and arg_184_1.var_.characterEffect1077ui_story then
				arg_184_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.7

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(325082044)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 28 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_4) / 28)

				if (28 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_4) / 28)) > 0 and var_187_2 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082044", "story_v_out_325082.awb") ~= 0 then
					local var_187_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082044", "story_v_out_325082.awb") / 1000

					if var_187_7 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_1
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_325082", "325082044", "story_v_out_325082.awb")

						arg_184_1:RecordAudio("325082044", var_187_8)
						arg_184_1:RecordAudio("325082044", var_187_8)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325082", "325082044", "story_v_out_325082.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325082", "325082044", "story_v_out_325082.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_9 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_9 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_9

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_9 and arg_184_1.time_ < var_187_1 + var_187_9 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play325082045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325082045
		arg_188_1.duration_ = 2.5

		local var_188_0 = {
			zh = 2.166,
			ja = 2.5
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325082046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1077ui_story"]) and arg_188_1.var_.characterEffect1077ui_story == nil then
				arg_188_1.var_.characterEffect1077ui_story = arg_188_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1077ui_story"]) then
				if arg_188_1.var_.characterEffect1077ui_story and not isNil(arg_188_1.actors_["1077ui_story"]) then
					arg_188_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1077ui_story"]) and arg_188_1.var_.characterEffect1077ui_story then
				arg_188_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_191_2 = 0
			local var_191_3 = 0.175

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(325082045)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 7 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 7)

				if (7 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 7)) > 0 and var_191_3 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082045", "story_v_out_325082.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082045", "story_v_out_325082.awb") / 1000

					if var_191_8 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_2
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_out_325082", "325082045", "story_v_out_325082.awb")

						arg_188_1:RecordAudio("325082045", var_191_9)
						arg_188_1:RecordAudio("325082045", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325082", "325082045", "story_v_out_325082.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325082", "325082045", "story_v_out_325082.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_10 and arg_188_1.time_ < var_191_2 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325082046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325082046
		arg_192_1.duration_ = 5.8

		local var_192_0 = {
			zh = 5.8,
			ja = 5.266
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325082047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1077ui_story"]) and arg_192_1.var_.characterEffect1077ui_story == nil then
				arg_192_1.var_.characterEffect1077ui_story = arg_192_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1077ui_story"]) then
				if arg_192_1.var_.characterEffect1077ui_story and not isNil(arg_192_1.actors_["1077ui_story"]) then
					arg_192_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1077ui_story"]) and arg_192_1.var_.characterEffect1077ui_story then
				arg_192_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_195_1 = 0
			local var_195_2 = 0.55

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(325082046)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_6 = 22 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_4) / 22)

				if (22 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_4) / 22)) > 0 and var_195_2 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082046", "story_v_out_325082.awb") ~= 0 then
					local var_195_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082046", "story_v_out_325082.awb") / 1000

					if var_195_7 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_1
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_325082", "325082046", "story_v_out_325082.awb")

						arg_192_1:RecordAudio("325082046", var_195_8)
						arg_192_1:RecordAudio("325082046", var_195_8)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325082", "325082046", "story_v_out_325082.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325082", "325082046", "story_v_out_325082.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_9 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_9 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_9

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_9 and arg_192_1.time_ < var_195_1 + var_195_9 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325082047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325082047
		arg_196_1.duration_ = 4.3

		local var_196_0 = {
			zh = 2.833,
			ja = 4.3
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325082048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1077ui_story"]) and arg_196_1.var_.characterEffect1077ui_story == nil then
				arg_196_1.var_.characterEffect1077ui_story = arg_196_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1077ui_story"]) then
				if arg_196_1.var_.characterEffect1077ui_story and not isNil(arg_196_1.actors_["1077ui_story"]) then
					arg_196_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1077ui_story"]) and arg_196_1.var_.characterEffect1077ui_story then
				arg_196_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_199_2 = 0
			local var_199_3 = 0.325

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:GetWordFromCfg(325082047)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 13 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 13)

				if (13 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 13)) > 0 and var_199_3 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082047", "story_v_out_325082.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082047", "story_v_out_325082.awb") / 1000

					if var_199_8 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_2
					end

					if var_199_4.prefab_name ~= "" and arg_196_1.actors_[var_199_4.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_4.prefab_name].transform, "story_v_out_325082", "325082047", "story_v_out_325082.awb")

						arg_196_1:RecordAudio("325082047", var_199_9)
						arg_196_1:RecordAudio("325082047", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325082", "325082047", "story_v_out_325082.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325082", "325082047", "story_v_out_325082.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_10 and arg_196_1.time_ < var_199_2 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play325082048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325082048
		arg_200_1.duration_ = 8.5

		local var_200_0 = {
			zh = 4.8,
			ja = 8.5
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325082049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1077ui_story"]) and arg_200_1.var_.characterEffect1077ui_story == nil then
				arg_200_1.var_.characterEffect1077ui_story = arg_200_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1077ui_story"]) then
				if arg_200_1.var_.characterEffect1077ui_story and not isNil(arg_200_1.actors_["1077ui_story"]) then
					arg_200_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1077ui_story"]) and arg_200_1.var_.characterEffect1077ui_story then
				arg_200_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0
			local var_203_2 = 0.55

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(325082048)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_6 = 22 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_4) / 22)

				if (22 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_4) / 22)) > 0 and var_203_2 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_1
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082048", "story_v_out_325082.awb") ~= 0 then
					local var_203_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082048", "story_v_out_325082.awb") / 1000

					if var_203_7 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_1
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_325082", "325082048", "story_v_out_325082.awb")

						arg_200_1:RecordAudio("325082048", var_203_8)
						arg_200_1:RecordAudio("325082048", var_203_8)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325082", "325082048", "story_v_out_325082.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325082", "325082048", "story_v_out_325082.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_9 = math.max(var_203_2, arg_200_1.talkMaxDuration)

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_9 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_1) / var_203_9

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_1 + var_203_9 and arg_200_1.time_ < var_203_1 + var_203_9 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325082049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325082049
		arg_204_1.duration_ = 6.47

		local var_204_0 = {
			zh = 3.766,
			ja = 6.466
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325082050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1077ui_story"]) and arg_204_1.var_.characterEffect1077ui_story == nil then
				arg_204_1.var_.characterEffect1077ui_story = arg_204_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1077ui_story"]) then
				if arg_204_1.var_.characterEffect1077ui_story and not isNil(arg_204_1.actors_["1077ui_story"]) then
					arg_204_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1077ui_story"]) and arg_204_1.var_.characterEffect1077ui_story then
				arg_204_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_207_2 = 0
			local var_207_3 = 0.525

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_4 = arg_204_1:GetWordFromCfg(325082049)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 21 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 21)

				if (21 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 21)) > 0 and var_207_3 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082049", "story_v_out_325082.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082049", "story_v_out_325082.awb") / 1000

					if var_207_8 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_2
					end

					if var_207_4.prefab_name ~= "" and arg_204_1.actors_[var_207_4.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_4.prefab_name].transform, "story_v_out_325082", "325082049", "story_v_out_325082.awb")

						arg_204_1:RecordAudio("325082049", var_207_9)
						arg_204_1:RecordAudio("325082049", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325082", "325082049", "story_v_out_325082.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325082", "325082049", "story_v_out_325082.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_10 and arg_204_1.time_ < var_207_2 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play325082050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325082050
		arg_208_1.duration_ = 4.43

		local var_208_0 = {
			zh = 1.5,
			ja = 4.433
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325082051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1077ui_story"]) and arg_208_1.var_.characterEffect1077ui_story == nil then
				arg_208_1.var_.characterEffect1077ui_story = arg_208_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1077ui_story"]) then
				if arg_208_1.var_.characterEffect1077ui_story and not isNil(arg_208_1.actors_["1077ui_story"]) then
					arg_208_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1077ui_story"]) and arg_208_1.var_.characterEffect1077ui_story then
				arg_208_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 0.175

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(325082050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 7 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 7)

				if (7 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 7)) > 0 and var_211_2 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082050", "story_v_out_325082.awb") ~= 0 then
					local var_211_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082050", "story_v_out_325082.awb") / 1000

					if var_211_7 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_1
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_325082", "325082050", "story_v_out_325082.awb")

						arg_208_1:RecordAudio("325082050", var_211_8)
						arg_208_1:RecordAudio("325082050", var_211_8)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325082", "325082050", "story_v_out_325082.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325082", "325082050", "story_v_out_325082.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_9 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_9 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_9

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_9 and arg_208_1.time_ < var_211_1 + var_211_9 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play325082051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325082051
		arg_212_1.duration_ = 9.3

		local var_212_0 = {
			zh = 6.566,
			ja = 9.3
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325082052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1077ui_story"]) and arg_212_1.var_.characterEffect1077ui_story == nil then
				arg_212_1.var_.characterEffect1077ui_story = arg_212_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1077ui_story"]) then
				if arg_212_1.var_.characterEffect1077ui_story and not isNil(arg_212_1.actors_["1077ui_story"]) then
					arg_212_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1077ui_story"]) and arg_212_1.var_.characterEffect1077ui_story then
				arg_212_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_215_2 = 0
			local var_215_3 = 0.775

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_4 = arg_212_1:GetWordFromCfg(325082051)
				local var_215_5 = arg_212_1:FormatText(var_215_4.content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 31 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 31)

				if (31 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 31)) > 0 and var_215_3 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082051", "story_v_out_325082.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082051", "story_v_out_325082.awb") / 1000

					if var_215_8 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_2
					end

					if var_215_4.prefab_name ~= "" and arg_212_1.actors_[var_215_4.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_4.prefab_name].transform, "story_v_out_325082", "325082051", "story_v_out_325082.awb")

						arg_212_1:RecordAudio("325082051", var_215_9)
						arg_212_1:RecordAudio("325082051", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325082", "325082051", "story_v_out_325082.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325082", "325082051", "story_v_out_325082.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_10 and arg_212_1.time_ < var_215_2 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325082052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325082052
		arg_216_1.duration_ = 6.4

		local var_216_0 = {
			zh = 4.266,
			ja = 6.4
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325082053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1077ui_story"]) and arg_216_1.var_.characterEffect1077ui_story == nil then
				arg_216_1.var_.characterEffect1077ui_story = arg_216_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1077ui_story"]) then
				if arg_216_1.var_.characterEffect1077ui_story and not isNil(arg_216_1.actors_["1077ui_story"]) then
					arg_216_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1077ui_story"]) and arg_216_1.var_.characterEffect1077ui_story then
				arg_216_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.425

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:GetWordFromCfg(325082052)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_6 = 17 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_4) / 17)

				if (17 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_4) / 17)) > 0 and var_219_2 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082052", "story_v_out_325082.awb") ~= 0 then
					local var_219_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082052", "story_v_out_325082.awb") / 1000

					if var_219_7 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_1
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_325082", "325082052", "story_v_out_325082.awb")

						arg_216_1:RecordAudio("325082052", var_219_8)
						arg_216_1:RecordAudio("325082052", var_219_8)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_325082", "325082052", "story_v_out_325082.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_325082", "325082052", "story_v_out_325082.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_9 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_9 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_9

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_9 and arg_216_1.time_ < var_219_1 + var_219_9 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play325082053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325082053
		arg_220_1.duration_ = 3.53

		local var_220_0 = {
			zh = 2.1,
			ja = 3.533
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325082054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1077ui_story"]) and arg_220_1.var_.characterEffect1077ui_story == nil then
				arg_220_1.var_.characterEffect1077ui_story = arg_220_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1077ui_story"]) then
				if arg_220_1.var_.characterEffect1077ui_story and not isNil(arg_220_1.actors_["1077ui_story"]) then
					arg_220_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1077ui_story"]) and arg_220_1.var_.characterEffect1077ui_story then
				arg_220_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_223_2 = 0
			local var_223_3 = 0.25

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_4 = arg_220_1:GetWordFromCfg(325082053)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_7 = 10 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 10)

				if (10 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 10)) > 0 and var_223_3 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082053", "story_v_out_325082.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082053", "story_v_out_325082.awb") / 1000

					if var_223_8 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_2
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_325082", "325082053", "story_v_out_325082.awb")

						arg_220_1:RecordAudio("325082053", var_223_9)
						arg_220_1:RecordAudio("325082053", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325082", "325082053", "story_v_out_325082.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325082", "325082053", "story_v_out_325082.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_10 and arg_220_1.time_ < var_223_2 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play325082054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325082054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325082055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1077ui_story = arg_224_1.actors_["1077ui_story"].transform.localPosition

				local var_227_0 = GameObjectTools.GetOrAddComponent(arg_224_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_227_0 then
					var_227_0:EnableDynamicBone(false)
				end
			end

			local var_227_1 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 then
				arg_224_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_224_1.time_ - 0) / var_227_1)
				arg_224_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1077ui_story"].transform.position).z)
				arg_224_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1077ui_story"].transform.localEulerAngles = arg_224_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 then
				arg_224_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1077ui_story"].transform.position).z)
				arg_224_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1077ui_story"].transform.localEulerAngles = arg_224_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_227_2 = GameObjectTools.GetOrAddComponent(arg_224_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(true)
				end
			end

			local var_227_3 = 0
			local var_227_4 = 1.25

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_3 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_5 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(325082054).content)

				arg_224_1.text_.text = var_227_5

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_7 = 50 <= 0 and var_227_4 or var_227_4 * (utf8.len(var_227_5) / 50)

				if (50 <= 0 and var_227_4 or var_227_4 * (utf8.len(var_227_5) / 50)) > 0 and var_227_4 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_3 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_3
					end
				end

				arg_224_1.text_.text = var_227_5
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_4, arg_224_1.talkMaxDuration)

			if var_227_3 <= arg_224_1.time_ and arg_224_1.time_ < var_227_3 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_3) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_3 + var_227_8 and arg_224_1.time_ < var_227_3 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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

		arg_224_1:InitPlayNodeList()
	end,
	Play325082055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325082055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325082056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.625

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(325082055).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 25 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 25)

				if (25 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 25)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325082056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325082056
		arg_232_1.duration_ = 8.57

		local var_232_0 = {
			zh = 6.633,
			ja = 8.566
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325082057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.5

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_1 = arg_232_1:GetWordFromCfg(325082056)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 20 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 20)

				if (20 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 20)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082056", "story_v_out_325082.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082056", "story_v_out_325082.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_325082", "325082056", "story_v_out_325082.awb")

						arg_232_1:RecordAudio("325082056", var_235_6)
						arg_232_1:RecordAudio("325082056", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_325082", "325082056", "story_v_out_325082.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_325082", "325082056", "story_v_out_325082.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play325082057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 325082057
		arg_236_1.duration_ = 6.9

		local var_236_0 = {
			zh = 1.6,
			ja = 6.9
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play325082058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1077ui_story = arg_236_1.actors_["1077ui_story"].transform.localPosition

				local var_239_0 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_0 then
					var_239_0:EnableDynamicBone(false)
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_236_1.time_ - 0) / var_239_1)
				arg_236_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1077ui_story"].transform.position).z)
				arg_236_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1077ui_story"].transform.localEulerAngles = arg_236_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_236_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1077ui_story"].transform.position).z)
				arg_236_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1077ui_story"].transform.localEulerAngles = arg_236_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_239_2 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(true)
				end
			end

			local var_239_3 = arg_236_1.actors_["1077ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect1077ui_story == nil then
				arg_236_1.var_.characterEffect1077ui_story = var_239_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_4 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 and not isNil(var_239_3) then
				if arg_236_1.var_.characterEffect1077ui_story and not isNil(var_239_3) then
					arg_236_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect1077ui_story then
				arg_236_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_239_6 = 0
			local var_239_7 = 0.175

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_8 = arg_236_1:GetWordFromCfg(325082057)
				local var_239_9 = arg_236_1:FormatText(var_239_8.content)

				arg_236_1.text_.text = var_239_9

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 7 <= 0 and var_239_7 or var_239_7 * (utf8.len(var_239_9) / 7)

				if (7 <= 0 and var_239_7 or var_239_7 * (utf8.len(var_239_9) / 7)) > 0 and var_239_7 < var_239_11 then
					arg_236_1.talkMaxDuration = var_239_11

					if var_239_11 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_11 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_9
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082057", "story_v_out_325082.awb") ~= 0 then
					local var_239_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082057", "story_v_out_325082.awb") / 1000

					if var_239_12 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_12 + var_239_6
					end

					if var_239_8.prefab_name ~= "" and arg_236_1.actors_[var_239_8.prefab_name] ~= nil then
						local var_239_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_8.prefab_name].transform, "story_v_out_325082", "325082057", "story_v_out_325082.awb")

						arg_236_1:RecordAudio("325082057", var_239_13)
						arg_236_1:RecordAudio("325082057", var_239_13)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_325082", "325082057", "story_v_out_325082.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_325082", "325082057", "story_v_out_325082.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play325082058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 325082058
		arg_240_1.duration_ = 10.3

		local var_240_0 = {
			zh = 5.2,
			ja = 10.3
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play325082059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1077ui_story"]) and arg_240_1.var_.characterEffect1077ui_story == nil then
				arg_240_1.var_.characterEffect1077ui_story = arg_240_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1077ui_story"]) then
				if arg_240_1.var_.characterEffect1077ui_story and not isNil(arg_240_1.actors_["1077ui_story"]) then
					arg_240_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1077ui_story"]) and arg_240_1.var_.characterEffect1077ui_story then
				arg_240_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 0.525

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(325082058)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_6 = 21 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_4) / 21)

				if (21 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_4) / 21)) > 0 and var_243_2 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082058", "story_v_out_325082.awb") ~= 0 then
					local var_243_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082058", "story_v_out_325082.awb") / 1000

					if var_243_7 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_1
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_325082", "325082058", "story_v_out_325082.awb")

						arg_240_1:RecordAudio("325082058", var_243_8)
						arg_240_1:RecordAudio("325082058", var_243_8)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_325082", "325082058", "story_v_out_325082.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_325082", "325082058", "story_v_out_325082.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_9 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_9 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_9

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_9 and arg_240_1.time_ < var_243_1 + var_243_9 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play325082059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 325082059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play325082060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1077ui_story = arg_244_1.actors_["1077ui_story"].transform.localPosition

				local var_247_0 = GameObjectTools.GetOrAddComponent(arg_244_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_247_0 then
					var_247_0:EnableDynamicBone(false)
				end
			end

			local var_247_1 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 then
				arg_244_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_1)
				arg_244_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1077ui_story"].transform.position).z)
				arg_244_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1077ui_story"].transform.localEulerAngles = arg_244_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 then
				arg_244_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1077ui_story"].transform.position).z)
				arg_244_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1077ui_story"].transform.localEulerAngles = arg_244_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_247_2 = GameObjectTools.GetOrAddComponent(arg_244_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_247_2 then
					var_247_2:EnableDynamicBone(true)
				end
			end

			local var_247_3 = arg_244_1.actors_["1059ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect1059ui_story == nil then
				arg_244_1.var_.characterEffect1059ui_story = var_247_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_4 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 and not isNil(var_247_3) then
				if arg_244_1.var_.characterEffect1059ui_story and not isNil(var_247_3) then
					arg_244_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_4)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect1059ui_story then
				arg_244_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_247_5 = 0
			local var_247_6 = 0.975

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(325082059).content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 39 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 39)

				if (39 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 39)) > 0 and var_247_6 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_10 and arg_244_1.time_ < var_247_5 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play325082060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 325082060
		arg_248_1.duration_ = 8.73

		local var_248_0 = {
			zh = 5.8,
			ja = 8.733
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play325082061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1077ui_story = arg_248_1.actors_["1077ui_story"].transform.localPosition

				local var_251_0 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_0 then
					var_251_0:EnableDynamicBone(false)
				end
			end

			local var_251_1 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				arg_248_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_248_1.time_ - 0) / var_251_1)
				arg_248_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1077ui_story"].transform.position).z)
				arg_248_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1077ui_story"].transform.localEulerAngles = arg_248_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 then
				arg_248_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_248_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1077ui_story"].transform.position).z)
				arg_248_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1077ui_story"].transform.localEulerAngles = arg_248_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_251_2 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(true)
				end
			end

			local var_251_3 = arg_248_1.actors_["1077ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_3) and arg_248_1.var_.characterEffect1077ui_story == nil then
				arg_248_1.var_.characterEffect1077ui_story = var_251_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_4 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 and not isNil(var_251_3) then
				if arg_248_1.var_.characterEffect1077ui_story and not isNil(var_251_3) then
					arg_248_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 and not isNil(var_251_3) and arg_248_1.var_.characterEffect1077ui_story then
				arg_248_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_251_6 = 0
			local var_251_7 = 0.775

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_8 = arg_248_1:GetWordFromCfg(325082060)
				local var_251_9 = arg_248_1:FormatText(var_251_8.content)

				arg_248_1.text_.text = var_251_9

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 31 <= 0 and var_251_7 or var_251_7 * (utf8.len(var_251_9) / 31)

				if (31 <= 0 and var_251_7 or var_251_7 * (utf8.len(var_251_9) / 31)) > 0 and var_251_7 < var_251_11 then
					arg_248_1.talkMaxDuration = var_251_11

					if var_251_11 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_9
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082060", "story_v_out_325082.awb") ~= 0 then
					local var_251_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082060", "story_v_out_325082.awb") / 1000

					if var_251_12 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_6
					end

					if var_251_8.prefab_name ~= "" and arg_248_1.actors_[var_251_8.prefab_name] ~= nil then
						local var_251_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_8.prefab_name].transform, "story_v_out_325082", "325082060", "story_v_out_325082.awb")

						arg_248_1:RecordAudio("325082060", var_251_13)
						arg_248_1:RecordAudio("325082060", var_251_13)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_325082", "325082060", "story_v_out_325082.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_325082", "325082060", "story_v_out_325082.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_14 and arg_248_1.time_ < var_251_6 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play325082061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 325082061
		arg_252_1.duration_ = 6.93

		local var_252_0 = {
			zh = 4.733,
			ja = 6.933
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play325082062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1077ui_story"]) and arg_252_1.var_.characterEffect1077ui_story == nil then
				arg_252_1.var_.characterEffect1077ui_story = arg_252_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1077ui_story"]) then
				if arg_252_1.var_.characterEffect1077ui_story and not isNil(arg_252_1.actors_["1077ui_story"]) then
					arg_252_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1077ui_story"]) and arg_252_1.var_.characterEffect1077ui_story then
				arg_252_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 0.55

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(325082061)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 22 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 22)

				if (22 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 22)) > 0 and var_255_2 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082061", "story_v_out_325082.awb") ~= 0 then
					local var_255_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082061", "story_v_out_325082.awb") / 1000

					if var_255_7 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_1
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_325082", "325082061", "story_v_out_325082.awb")

						arg_252_1:RecordAudio("325082061", var_255_8)
						arg_252_1:RecordAudio("325082061", var_255_8)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_325082", "325082061", "story_v_out_325082.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_325082", "325082061", "story_v_out_325082.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_9 and arg_252_1.time_ < var_255_1 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play325082062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 325082062
		arg_256_1.duration_ = 6.9

		local var_256_0 = {
			zh = 3.8,
			ja = 6.9
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play325082063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.4

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:GetWordFromCfg(325082062)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 16 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 16)

				if (16 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 16)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082062", "story_v_out_325082.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082062", "story_v_out_325082.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_325082", "325082062", "story_v_out_325082.awb")

						arg_256_1:RecordAudio("325082062", var_259_6)
						arg_256_1:RecordAudio("325082062", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_325082", "325082062", "story_v_out_325082.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_325082", "325082062", "story_v_out_325082.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play325082063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 325082063
		arg_260_1.duration_ = 6.3

		local var_260_0 = {
			zh = 5.833,
			ja = 6.3
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play325082064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1077ui_story"]) and arg_260_1.var_.characterEffect1077ui_story == nil then
				arg_260_1.var_.characterEffect1077ui_story = arg_260_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1077ui_story"]) then
				if arg_260_1.var_.characterEffect1077ui_story and not isNil(arg_260_1.actors_["1077ui_story"]) then
					arg_260_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1077ui_story"]) and arg_260_1.var_.characterEffect1077ui_story then
				arg_260_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_263_2 = 0
			local var_263_3 = 0.8

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_4 = arg_260_1:GetWordFromCfg(325082063)
				local var_263_5 = arg_260_1:FormatText(var_263_4.content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 32 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 32)

				if (32 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 32)) > 0 and var_263_3 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082063", "story_v_out_325082.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082063", "story_v_out_325082.awb") / 1000

					if var_263_8 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_2
					end

					if var_263_4.prefab_name ~= "" and arg_260_1.actors_[var_263_4.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_4.prefab_name].transform, "story_v_out_325082", "325082063", "story_v_out_325082.awb")

						arg_260_1:RecordAudio("325082063", var_263_9)
						arg_260_1:RecordAudio("325082063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_325082", "325082063", "story_v_out_325082.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_325082", "325082063", "story_v_out_325082.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_10 and arg_260_1.time_ < var_263_2 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play325082064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 325082064
		arg_264_1.duration_ = 16.97

		local var_264_0 = {
			zh = 11.2,
			ja = 16.966
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play325082065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1077ui_story"]) and arg_264_1.var_.characterEffect1077ui_story == nil then
				arg_264_1.var_.characterEffect1077ui_story = arg_264_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1077ui_story"]) then
				if arg_264_1.var_.characterEffect1077ui_story and not isNil(arg_264_1.actors_["1077ui_story"]) then
					arg_264_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_0)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1077ui_story"]) and arg_264_1.var_.characterEffect1077ui_story then
				arg_264_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_267_1 = 0
			local var_267_2 = 1.375

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(325082064)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_6 = 55 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_4) / 55)

				if (55 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_4) / 55)) > 0 and var_267_2 < var_267_6 then
					arg_264_1.talkMaxDuration = var_267_6

					if var_267_6 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_6 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082064", "story_v_out_325082.awb") ~= 0 then
					local var_267_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082064", "story_v_out_325082.awb") / 1000

					if var_267_7 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_1
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_325082", "325082064", "story_v_out_325082.awb")

						arg_264_1:RecordAudio("325082064", var_267_8)
						arg_264_1:RecordAudio("325082064", var_267_8)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_325082", "325082064", "story_v_out_325082.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_325082", "325082064", "story_v_out_325082.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_9 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_9 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_9

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_9 and arg_264_1.time_ < var_267_1 + var_267_9 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play325082065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 325082065
		arg_268_1.duration_ = 4.7

		local var_268_0 = {
			zh = 3.566,
			ja = 4.7
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play325082066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1077ui_story"]) and arg_268_1.var_.characterEffect1077ui_story == nil then
				arg_268_1.var_.characterEffect1077ui_story = arg_268_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1077ui_story"]) then
				if arg_268_1.var_.characterEffect1077ui_story and not isNil(arg_268_1.actors_["1077ui_story"]) then
					arg_268_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1077ui_story"]) and arg_268_1.var_.characterEffect1077ui_story then
				arg_268_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_271_2 = 0
			local var_271_3 = 0.45

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_4 = arg_268_1:GetWordFromCfg(325082065)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 18 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 18)

				if (18 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 18)) > 0 and var_271_3 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082065", "story_v_out_325082.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082065", "story_v_out_325082.awb") / 1000

					if var_271_8 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_2
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_out_325082", "325082065", "story_v_out_325082.awb")

						arg_268_1:RecordAudio("325082065", var_271_9)
						arg_268_1:RecordAudio("325082065", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_325082", "325082065", "story_v_out_325082.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_325082", "325082065", "story_v_out_325082.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_10 and arg_268_1.time_ < var_271_2 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play325082066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 325082066
		arg_272_1.duration_ = 17.33

		local var_272_0 = {
			zh = 8.633,
			ja = 17.333
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play325082067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1077ui_story"]) and arg_272_1.var_.characterEffect1077ui_story == nil then
				arg_272_1.var_.characterEffect1077ui_story = arg_272_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1077ui_story"]) then
				if arg_272_1.var_.characterEffect1077ui_story and not isNil(arg_272_1.actors_["1077ui_story"]) then
					arg_272_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_0)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1077ui_story"]) and arg_272_1.var_.characterEffect1077ui_story then
				arg_272_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_275_1 = 0
			local var_275_2 = 0.975

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(325082066)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_6 = 39 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_4) / 39)

				if (39 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_4) / 39)) > 0 and var_275_2 < var_275_6 then
					arg_272_1.talkMaxDuration = var_275_6

					if var_275_6 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_6 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082066", "story_v_out_325082.awb") ~= 0 then
					local var_275_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082066", "story_v_out_325082.awb") / 1000

					if var_275_7 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_1
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_325082", "325082066", "story_v_out_325082.awb")

						arg_272_1:RecordAudio("325082066", var_275_8)
						arg_272_1:RecordAudio("325082066", var_275_8)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_325082", "325082066", "story_v_out_325082.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_325082", "325082066", "story_v_out_325082.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_9 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_9 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_9

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_9 and arg_272_1.time_ < var_275_1 + var_275_9 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play325082067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325082067
		arg_276_1.duration_ = 5.67

		local var_276_0 = {
			zh = 3.3,
			ja = 5.666
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325082068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1077ui_story"]) and arg_276_1.var_.characterEffect1077ui_story == nil then
				arg_276_1.var_.characterEffect1077ui_story = arg_276_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1077ui_story"]) then
				if arg_276_1.var_.characterEffect1077ui_story and not isNil(arg_276_1.actors_["1077ui_story"]) then
					arg_276_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1077ui_story"]) and arg_276_1.var_.characterEffect1077ui_story then
				arg_276_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_279_2 = 0
			local var_279_3 = 0.45

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(325082067)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 18 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 18)

				if (18 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 18)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082067", "story_v_out_325082.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082067", "story_v_out_325082.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_out_325082", "325082067", "story_v_out_325082.awb")

						arg_276_1:RecordAudio("325082067", var_279_9)
						arg_276_1:RecordAudio("325082067", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_325082", "325082067", "story_v_out_325082.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_325082", "325082067", "story_v_out_325082.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_3, arg_276_1.talkMaxDuration)

			if var_279_2 <= arg_276_1.time_ and arg_276_1.time_ < var_279_2 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_2) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_2 + var_279_10 and arg_276_1.time_ < var_279_2 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play325082068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325082068
		arg_280_1.duration_ = 16.17

		local var_280_0 = {
			zh = 8.133,
			ja = 16.166
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play325082069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1077ui_story"]) and arg_280_1.var_.characterEffect1077ui_story == nil then
				arg_280_1.var_.characterEffect1077ui_story = arg_280_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1077ui_story"]) then
				if arg_280_1.var_.characterEffect1077ui_story and not isNil(arg_280_1.actors_["1077ui_story"]) then
					arg_280_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1077ui_story"]) and arg_280_1.var_.characterEffect1077ui_story then
				arg_280_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 1.05

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(325082068)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 42 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 42)

				if (42 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 42)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082068", "story_v_out_325082.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082068", "story_v_out_325082.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_325082", "325082068", "story_v_out_325082.awb")

						arg_280_1:RecordAudio("325082068", var_283_8)
						arg_280_1:RecordAudio("325082068", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325082", "325082068", "story_v_out_325082.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325082", "325082068", "story_v_out_325082.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play325082069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325082069
		arg_284_1.duration_ = 14.7

		local var_284_0 = {
			zh = 9.7,
			ja = 14.7
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play325082070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 1.1

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(325082069)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 44 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 44)

				if (44 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 44)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082069", "story_v_out_325082.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082069", "story_v_out_325082.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_325082", "325082069", "story_v_out_325082.awb")

						arg_284_1:RecordAudio("325082069", var_287_6)
						arg_284_1:RecordAudio("325082069", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325082", "325082069", "story_v_out_325082.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325082", "325082069", "story_v_out_325082.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play325082070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325082070
		arg_288_1.duration_ = 2

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play325082071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1077ui_story"]) and arg_288_1.var_.characterEffect1077ui_story == nil then
				arg_288_1.var_.characterEffect1077ui_story = arg_288_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1077ui_story"]) then
				if arg_288_1.var_.characterEffect1077ui_story and not isNil(arg_288_1.actors_["1077ui_story"]) then
					arg_288_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1077ui_story"]) and arg_288_1.var_.characterEffect1077ui_story then
				arg_288_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_291_2 = 0
			local var_291_3 = 0.1

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:GetWordFromCfg(325082070)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 4 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 4)

				if (4 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 4)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082070", "story_v_out_325082.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082070", "story_v_out_325082.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_out_325082", "325082070", "story_v_out_325082.awb")

						arg_288_1:RecordAudio("325082070", var_291_9)
						arg_288_1:RecordAudio("325082070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_325082", "325082070", "story_v_out_325082.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_325082", "325082070", "story_v_out_325082.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play325082071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 325082071
		arg_292_1.duration_ = 9.8

		local var_292_0 = {
			zh = 5.8,
			ja = 9.8
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play325082072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1059ui_story"]) and arg_292_1.var_.characterEffect1059ui_story == nil then
				arg_292_1.var_.characterEffect1059ui_story = arg_292_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1059ui_story"]) then
				if arg_292_1.var_.characterEffect1059ui_story and not isNil(arg_292_1.actors_["1059ui_story"]) then
					arg_292_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1059ui_story"]) and arg_292_1.var_.characterEffect1059ui_story then
				arg_292_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_295_2 = arg_292_1.actors_["1077ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect1077ui_story == nil then
				arg_292_1.var_.characterEffect1077ui_story = var_295_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_3 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 and not isNil(var_295_2) then
				if arg_292_1.var_.characterEffect1077ui_story and not isNil(var_295_2) then
					arg_292_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_3)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect1077ui_story then
				arg_292_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_295_4 = 0
			local var_295_5 = 0.55

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_6 = arg_292_1:GetWordFromCfg(325082071)
				local var_295_7 = arg_292_1:FormatText(var_295_6.content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 22 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 22)

				if (22 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 22)) > 0 and var_295_5 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082071", "story_v_out_325082.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_out_325082", "325082071", "story_v_out_325082.awb") / 1000

					if var_295_10 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_4
					end

					if var_295_6.prefab_name ~= "" and arg_292_1.actors_[var_295_6.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_6.prefab_name].transform, "story_v_out_325082", "325082071", "story_v_out_325082.awb")

						arg_292_1:RecordAudio("325082071", var_295_11)
						arg_292_1:RecordAudio("325082071", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_325082", "325082071", "story_v_out_325082.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_325082", "325082071", "story_v_out_325082.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_12 and arg_292_1.time_ < var_295_4 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play325082072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 325082072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play325082073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1059ui_story = arg_296_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1059ui_story"].transform.position).z)
				arg_296_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1059ui_story"].transform.localEulerAngles = arg_296_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1059ui_story"].transform.position).z)
				arg_296_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1059ui_story"].transform.localEulerAngles = arg_296_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1077ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1077ui_story = var_299_1.localPosition

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_1.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end
			end

			local var_299_3 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 then
				var_299_1.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_3)
				var_299_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_1.position).x, (manager.ui.mainCamera.transform.position - var_299_1.position).y, (manager.ui.mainCamera.transform.position - var_299_1.position).z)
				var_299_1.localEulerAngles.z = 0
				var_299_1.localEulerAngles.x = 0
				var_299_1.localEulerAngles = var_299_1.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 then
				var_299_1.localPosition = Vector3.New(0, 100, 0)
				var_299_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_1.position).x, (manager.ui.mainCamera.transform.position - var_299_1.position).y, (manager.ui.mainCamera.transform.position - var_299_1.position).z)
				var_299_1.localEulerAngles.z = 0
				var_299_1.localEulerAngles.x = 0
				var_299_1.localEulerAngles = var_299_1.localEulerAngles

				local var_299_4 = GameObjectTools.GetOrAddComponent(var_299_1.gameObject, typeof(DynamicBoneHelper))

				if var_299_4 then
					var_299_4:EnableDynamicBone(true)
				end
			end

			local var_299_5 = arg_296_1.actors_["1059ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect1059ui_story == nil then
				arg_296_1.var_.characterEffect1059ui_story = var_299_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_6 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 and not isNil(var_299_5) then
				if arg_296_1.var_.characterEffect1059ui_story and not isNil(var_299_5) then
					arg_296_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_6)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect1059ui_story then
				arg_296_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_299_7 = 0
			local var_299_8 = 1.225

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_7 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_9 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(325082072).content)

				arg_296_1.text_.text = var_299_9

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 49 <= 0 and var_299_8 or var_299_8 * (utf8.len(var_299_9) / 49)

				if (49 <= 0 and var_299_8 or var_299_8 * (utf8.len(var_299_9) / 49)) > 0 and var_299_8 < var_299_11 then
					arg_296_1.talkMaxDuration = var_299_11

					if var_299_11 + var_299_7 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_7
					end
				end

				arg_296_1.text_.text = var_299_9
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_8, arg_296_1.talkMaxDuration)

			if var_299_7 <= arg_296_1.time_ and arg_296_1.time_ < var_299_7 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_7) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_7 + var_299_12 and arg_296_1.time_ < var_299_7 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_296_1:InitPlayNodeList()
	end,
	Play325082073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 325082073
		arg_300_1.duration_ = 8.63

		local var_300_0 = {
			zh = 5.7,
			ja = 8.633
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play325082074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1077ui_story = arg_300_1.actors_["1077ui_story"].transform.localPosition

				local var_303_0 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_0 then
					var_303_0:EnableDynamicBone(false)
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_300_1.time_ - 0) / var_303_1)
				arg_300_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1077ui_story"].transform.position).z)
				arg_300_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1077ui_story"].transform.localEulerAngles = arg_300_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_300_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1077ui_story"].transform.position).z)
				arg_300_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1077ui_story"].transform.localEulerAngles = arg_300_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_303_2 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(true)
				end
			end

			local var_303_3 = arg_300_1.actors_["1077ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1077ui_story == nil then
				arg_300_1.var_.characterEffect1077ui_story = var_303_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_4 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 and not isNil(var_303_3) then
				if arg_300_1.var_.characterEffect1077ui_story and not isNil(var_303_3) then
					arg_300_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1077ui_story then
				arg_300_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_303_6 = 0
			local var_303_7 = 0.625

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(325082073)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 25 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 25)

				if (25 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 25)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082073", "story_v_out_325082.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_out_325082", "325082073", "story_v_out_325082.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_325082", "325082073", "story_v_out_325082.awb")

						arg_300_1:RecordAudio("325082073", var_303_13)
						arg_300_1:RecordAudio("325082073", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_325082", "325082073", "story_v_out_325082.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_325082", "325082073", "story_v_out_325082.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play325082074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 325082074
		arg_304_1.duration_ = 9.4

		local var_304_0 = {
			zh = 6.033,
			ja = 9.4
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play325082075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1077ui_story"]) and arg_304_1.var_.characterEffect1077ui_story == nil then
				arg_304_1.var_.characterEffect1077ui_story = arg_304_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1077ui_story"]) then
				if arg_304_1.var_.characterEffect1077ui_story and not isNil(arg_304_1.actors_["1077ui_story"]) then
					arg_304_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1077ui_story"]) and arg_304_1.var_.characterEffect1077ui_story then
				arg_304_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.625

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(325082074)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_6 = 25 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 25)

				if (25 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 25)) > 0 and var_307_2 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082074", "story_v_out_325082.awb") ~= 0 then
					local var_307_7 = manager.audio:GetVoiceLength("story_v_out_325082", "325082074", "story_v_out_325082.awb") / 1000

					if var_307_7 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_1
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_325082", "325082074", "story_v_out_325082.awb")

						arg_304_1:RecordAudio("325082074", var_307_8)
						arg_304_1:RecordAudio("325082074", var_307_8)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_325082", "325082074", "story_v_out_325082.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_325082", "325082074", "story_v_out_325082.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_9 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_9 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_9

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_9 and arg_304_1.time_ < var_307_1 + var_307_9 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play325082075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 325082075
		arg_308_1.duration_ = 8.43

		local var_308_0 = {
			zh = 3.266,
			ja = 8.433
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play325082076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.275

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_1 = arg_308_1:GetWordFromCfg(325082075)
				local var_311_2 = arg_308_1:FormatText(var_311_1.content)

				arg_308_1.text_.text = var_311_2

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 11 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 11)

				if (11 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 11)) > 0 and var_311_0 < var_311_4 then
					arg_308_1.talkMaxDuration = var_311_4

					if var_311_4 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_4 + 0
					end
				end

				arg_308_1.text_.text = var_311_2
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082075", "story_v_out_325082.awb") ~= 0 then
					local var_311_5 = manager.audio:GetVoiceLength("story_v_out_325082", "325082075", "story_v_out_325082.awb") / 1000

					if var_311_5 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + 0
					end

					if var_311_1.prefab_name ~= "" and arg_308_1.actors_[var_311_1.prefab_name] ~= nil then
						local var_311_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_1.prefab_name].transform, "story_v_out_325082", "325082075", "story_v_out_325082.awb")

						arg_308_1:RecordAudio("325082075", var_311_6)
						arg_308_1:RecordAudio("325082075", var_311_6)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_325082", "325082075", "story_v_out_325082.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_325082", "325082075", "story_v_out_325082.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play325082076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 325082076
		arg_312_1.duration_ = 3.1

		local var_312_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play325082077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1077ui_story"]) and arg_312_1.var_.characterEffect1077ui_story == nil then
				arg_312_1.var_.characterEffect1077ui_story = arg_312_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1077ui_story"]) then
				if arg_312_1.var_.characterEffect1077ui_story and not isNil(arg_312_1.actors_["1077ui_story"]) then
					arg_312_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1077ui_story"]) and arg_312_1.var_.characterEffect1077ui_story then
				arg_312_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_315_2 = 0
			local var_315_3 = 0.15

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_2 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_4 = arg_312_1:GetWordFromCfg(325082076)
				local var_315_5 = arg_312_1:FormatText(var_315_4.content)

				arg_312_1.text_.text = var_315_5

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_7 = 6 <= 0 and var_315_3 or var_315_3 * (utf8.len(var_315_5) / 6)

				if (6 <= 0 and var_315_3 or var_315_3 * (utf8.len(var_315_5) / 6)) > 0 and var_315_3 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_2 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_2
					end
				end

				arg_312_1.text_.text = var_315_5
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082076", "story_v_out_325082.awb") ~= 0 then
					local var_315_8 = manager.audio:GetVoiceLength("story_v_out_325082", "325082076", "story_v_out_325082.awb") / 1000

					if var_315_8 + var_315_2 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_8 + var_315_2
					end

					if var_315_4.prefab_name ~= "" and arg_312_1.actors_[var_315_4.prefab_name] ~= nil then
						local var_315_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_4.prefab_name].transform, "story_v_out_325082", "325082076", "story_v_out_325082.awb")

						arg_312_1:RecordAudio("325082076", var_315_9)
						arg_312_1:RecordAudio("325082076", var_315_9)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_325082", "325082076", "story_v_out_325082.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_325082", "325082076", "story_v_out_325082.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_3, arg_312_1.talkMaxDuration)

			if var_315_2 <= arg_312_1.time_ and arg_312_1.time_ < var_315_2 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_2) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_2 + var_315_10 and arg_312_1.time_ < var_315_2 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play325082077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 325082077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play325082078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1077ui_story = arg_316_1.actors_["1077ui_story"].transform.localPosition

				local var_319_0 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_319_0 then
					var_319_0:EnableDynamicBone(false)
				end
			end

			local var_319_1 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_1 then
				arg_316_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_316_1.time_ - 0) / var_319_1)
				arg_316_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1077ui_story"].transform.position).z)
				arg_316_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1077ui_story"].transform.localEulerAngles = arg_316_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_1 and arg_316_1.time_ < 0 + var_319_1 + arg_319_0 then
				arg_316_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1077ui_story"].transform.position).z)
				arg_316_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1077ui_story"].transform.localEulerAngles = arg_316_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_319_2 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_319_2 then
					var_319_2:EnableDynamicBone(true)
				end
			end

			local var_319_3 = arg_316_1.actors_["1059ui_story"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1059ui_story = var_319_3.localPosition
			end

			local var_319_4 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				var_319_3.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_316_1.time_ - 0) / var_319_4)
				var_319_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_3.position).x, (manager.ui.mainCamera.transform.position - var_319_3.position).y, (manager.ui.mainCamera.transform.position - var_319_3.position).z)
				var_319_3.localEulerAngles.z = 0
				var_319_3.localEulerAngles.x = 0
				var_319_3.localEulerAngles = var_319_3.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				var_319_3.localPosition = Vector3.New(0, 100, 0)
				var_319_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_3.position).x, (manager.ui.mainCamera.transform.position - var_319_3.position).y, (manager.ui.mainCamera.transform.position - var_319_3.position).z)
				var_319_3.localEulerAngles.z = 0
				var_319_3.localEulerAngles.x = 0
				var_319_3.localEulerAngles = var_319_3.localEulerAngles
			end

			local var_319_5 = arg_316_1.actors_["1077ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.characterEffect1077ui_story == nil then
				arg_316_1.var_.characterEffect1077ui_story = var_319_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_6 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_6 and not isNil(var_319_5) then
				if arg_316_1.var_.characterEffect1077ui_story and not isNil(var_319_5) then
					arg_316_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_6)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_6 and arg_316_1.time_ < 0 + var_319_6 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.characterEffect1077ui_story then
				arg_316_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_319_7 = 0
			local var_319_8 = 1.375

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_7 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(325082077).content)

				arg_316_1.text_.text = var_319_9

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 55 <= 0 and var_319_8 or var_319_8 * (utf8.len(var_319_9) / 55)

				if (55 <= 0 and var_319_8 or var_319_8 * (utf8.len(var_319_9) / 55)) > 0 and var_319_8 < var_319_11 then
					arg_316_1.talkMaxDuration = var_319_11

					if var_319_11 + var_319_7 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_11 + var_319_7
					end
				end

				arg_316_1.text_.text = var_319_9
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_12 = math.max(var_319_8, arg_316_1.talkMaxDuration)

			if var_319_7 <= arg_316_1.time_ and arg_316_1.time_ < var_319_7 + var_319_12 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_7) / var_319_12

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_7 + var_319_12 and arg_316_1.time_ < var_319_7 + var_319_12 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play325082078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 325082078
		arg_320_1.duration_ = 8.43

		local var_320_0 = {
			zh = 5.366,
			ja = 8.433
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
			arg_320_1.auto_ = false
		end

		function arg_320_1.playNext_(arg_322_0)
			arg_320_1.onStoryFinished_()
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1077ui_story = arg_320_1.actors_["1077ui_story"].transform.localPosition

				local var_323_0 = GameObjectTools.GetOrAddComponent(arg_320_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_323_0 then
					var_323_0:EnableDynamicBone(false)
				end
			end

			local var_323_1 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_1 then
				arg_320_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_320_1.time_ - 0) / var_323_1)
				arg_320_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1077ui_story"].transform.position).z)
				arg_320_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1077ui_story"].transform.localEulerAngles = arg_320_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_1 and arg_320_1.time_ < 0 + var_323_1 + arg_323_0 then
				arg_320_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_320_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1077ui_story"].transform.position).z)
				arg_320_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1077ui_story"].transform.localEulerAngles = arg_320_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_323_2 = GameObjectTools.GetOrAddComponent(arg_320_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_323_2 then
					var_323_2:EnableDynamicBone(true)
				end
			end

			local var_323_3 = arg_320_1.actors_["1077ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_3) and arg_320_1.var_.characterEffect1077ui_story == nil then
				arg_320_1.var_.characterEffect1077ui_story = var_323_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_4 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 and not isNil(var_323_3) then
				if arg_320_1.var_.characterEffect1077ui_story and not isNil(var_323_3) then
					arg_320_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 and not isNil(var_323_3) and arg_320_1.var_.characterEffect1077ui_story then
				arg_320_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_323_7 = 0
			local var_323_8 = 0.6

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_7 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_9 = arg_320_1:GetWordFromCfg(325082078)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_12 = 24 <= 0 and var_323_8 or var_323_8 * (utf8.len(var_323_10) / 24)

				if (24 <= 0 and var_323_8 or var_323_8 * (utf8.len(var_323_10) / 24)) > 0 and var_323_8 < var_323_12 then
					arg_320_1.talkMaxDuration = var_323_12

					if var_323_12 + var_323_7 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_12 + var_323_7
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325082", "325082078", "story_v_out_325082.awb") ~= 0 then
					local var_323_13 = manager.audio:GetVoiceLength("story_v_out_325082", "325082078", "story_v_out_325082.awb") / 1000

					if var_323_13 + var_323_7 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_7
					end

					if var_323_9.prefab_name ~= "" and arg_320_1.actors_[var_323_9.prefab_name] ~= nil then
						local var_323_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_9.prefab_name].transform, "story_v_out_325082", "325082078", "story_v_out_325082.awb")

						arg_320_1:RecordAudio("325082078", var_323_14)
						arg_320_1:RecordAudio("325082078", var_323_14)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_325082", "325082078", "story_v_out_325082.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_325082", "325082078", "story_v_out_325082.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_15 = math.max(var_323_8, arg_320_1.talkMaxDuration)

			if var_323_7 <= arg_320_1.time_ and arg_320_1.time_ < var_323_7 + var_323_15 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_7) / var_323_15

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_7 + var_323_15 and arg_320_1.time_ < var_323_7 + var_323_15 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
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

		arg_320_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J29g"
	},
	voices = {
		"story_v_out_325082.awb"
	}
}
