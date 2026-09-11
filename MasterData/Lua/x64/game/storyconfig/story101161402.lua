return {
	Play116142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116142001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST07b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_4_0.name = "ST07b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST07b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.ST07b

				arg_1_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST07b" then
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder", "")
			end

			local var_4_9 = 1.4

			if 1.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_10 = 0.6

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				local var_4_11 = Color.New(1, 1, 1)

				var_4_11.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_9) / var_4_10)
				arg_1_1.mask_.color = var_4_11
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				local var_4_12 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_12.a = 0
				arg_1_1.mask_.color = var_4_12
			end

			local var_4_13 = manager.ui.mainCamera.transform

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_13.localPosition
			end

			local var_4_14 = 0.8666668

			if 1.26666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.26666666666667 + var_4_14 then
				local var_4_15, var_4_16 = math.modf((arg_1_1.time_ - 1.26666666666667) / 0.066)

				var_4_13.localPosition = Vector3.New(var_4_16 * 0.13, var_4_16 * 0.13, var_4_16 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.26666666666667 + var_4_14 and arg_1_1.time_ < 1.26666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_17 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_17 + 0.133333466666667 and arg_1_1.time_ < var_4_17 + 0.133333466666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 2.2 < arg_1_1.time_ and arg_1_1.time_ <= 2.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "OG", "bgm_activity_1_6_story_intense.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "OG")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			local var_4_27 = 2
			local var_4_28 = 1.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116142001).content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 45 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 45)

				if (45 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 45)) > 0 and var_4_28 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_27 = var_4_27 + 0.3

					if var_4_32 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_27 + 0.3
			local var_4_34 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116142002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116142002
		arg_10_1.duration_ = 2.87

		local var_10_0 = {
			zh = 2.866,
			ja = 1.999999999999
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116142003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_13_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_10_1.stage_.transform)

				var_13_0.name = "1028ui_story"
				var_13_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_10_1.actors_["1028ui_story"] = var_13_0

				local var_13_1 = var_13_0:GetComponentInChildren(typeof(CharacterEffect))

				var_13_1.enabled = true

				local var_13_2 = GameObjectTools.GetOrAddComponent(var_13_0, typeof(DynamicBoneHelper))

				if var_13_2 then
					var_13_2:EnableDynamicBone(false)
				end

				arg_10_1:ShowWeapon(var_13_1.transform, false)

				arg_10_1.var_["1028ui_story" .. "Animator"] = var_13_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_10_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_10_1.var_["1028ui_story" .. "LipSync"] = var_13_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_13_3 = arg_10_1.actors_["1028ui_story"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1028ui_story = var_13_3.localPosition
			end

			local var_13_4 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				var_13_3.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1028ui_story, Vector3.New(-0.7, -0.9, -5.9), (arg_10_1.time_ - 0) / var_13_4)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				var_13_3.localPosition = Vector3.New(-0.7, -0.9, -5.9)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_13_5 = arg_10_1.actors_["1028ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect1028ui_story == nil then
				arg_10_1.var_.characterEffect1028ui_story = var_13_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_6 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_6 and not isNil(var_13_5) then
				if arg_10_1.var_.characterEffect1028ui_story and not isNil(var_13_5) then
					arg_10_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_6 and arg_10_1.time_ < 0 + var_13_6 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect1028ui_story then
				arg_10_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_13_8 = 0
			local var_13_9 = 0.1

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_10 = arg_10_1:GetWordFromCfg(116142002)
				local var_13_11 = arg_10_1:FormatText(var_13_10.content)

				arg_10_1.text_.text = var_13_11

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 4 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 4)

				if (4 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 4)) > 0 and var_13_9 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_11
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142002", "story_v_out_116142.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_116142", "116142002", "story_v_out_116142.awb") / 1000

					if var_13_14 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_8
					end

					if var_13_10.prefab_name ~= "" and arg_10_1.actors_[var_13_10.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_10.prefab_name].transform, "story_v_out_116142", "116142002", "story_v_out_116142.awb")

						arg_10_1:RecordAudio("116142002", var_13_15)
						arg_10_1:RecordAudio("116142002", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_116142", "116142002", "story_v_out_116142.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_116142", "116142002", "story_v_out_116142.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_9, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_8) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_16 and arg_10_1.time_ < var_13_8 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116142003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116142003
		arg_14_1.duration_ = 8.03

		local var_14_0 = {
			zh = 6.866,
			ja = 8.033
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116142004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_17_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_14_1.stage_.transform)

				var_17_0.name = "1059ui_story"
				var_17_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.actors_["1059ui_story"] = var_17_0

				local var_17_1 = var_17_0:GetComponentInChildren(typeof(CharacterEffect))

				var_17_1.enabled = true

				local var_17_2 = GameObjectTools.GetOrAddComponent(var_17_0, typeof(DynamicBoneHelper))

				if var_17_2 then
					var_17_2:EnableDynamicBone(false)
				end

				arg_14_1:ShowWeapon(var_17_1.transform, false)

				arg_14_1.var_["1059ui_story" .. "Animator"] = var_17_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_14_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_14_1.var_["1059ui_story" .. "LipSync"] = var_17_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_17_3 = arg_14_1.actors_["1059ui_story"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos1059ui_story = var_17_3.localPosition
			end

			local var_17_4 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				var_17_3.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_14_1.time_ - 0) / var_17_4)
				var_17_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_3.position).x, (manager.ui.mainCamera.transform.position - var_17_3.position).y, (manager.ui.mainCamera.transform.position - var_17_3.position).z)
				var_17_3.localEulerAngles.z = 0
				var_17_3.localEulerAngles.x = 0
				var_17_3.localEulerAngles = var_17_3.localEulerAngles
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				var_17_3.localPosition = Vector3.New(0.7, -1.05, -6)
				var_17_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_3.position).x, (manager.ui.mainCamera.transform.position - var_17_3.position).y, (manager.ui.mainCamera.transform.position - var_17_3.position).z)
				var_17_3.localEulerAngles.z = 0
				var_17_3.localEulerAngles.x = 0
				var_17_3.localEulerAngles = var_17_3.localEulerAngles
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_17_5 = arg_14_1.actors_["1059ui_story"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_5) and arg_14_1.var_.characterEffect1059ui_story == nil then
				arg_14_1.var_.characterEffect1059ui_story = var_17_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_6 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_6 and not isNil(var_17_5) then
				if arg_14_1.var_.characterEffect1059ui_story and not isNil(var_17_5) then
					arg_14_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= 0 + var_17_6 and arg_14_1.time_ < 0 + var_17_6 + arg_17_0 and not isNil(var_17_5) and arg_14_1.var_.characterEffect1059ui_story then
				arg_14_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_17_8 = arg_14_1.actors_["1028ui_story"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_8) and arg_14_1.var_.characterEffect1028ui_story == nil then
				arg_14_1.var_.characterEffect1028ui_story = var_17_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_9 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_9 and not isNil(var_17_8) then
				if arg_14_1.var_.characterEffect1028ui_story and not isNil(var_17_8) then
					arg_14_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_14_1.time_ - 0) / var_17_9)
				end
			end

			if arg_14_1.time_ >= 0 + var_17_9 and arg_14_1.time_ < 0 + var_17_9 + arg_17_0 and not isNil(var_17_8) and arg_14_1.var_.characterEffect1028ui_story then
				arg_14_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_17_10 = 0
			local var_17_11 = 0.925

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_12 = arg_14_1:GetWordFromCfg(116142003)
				local var_17_13 = arg_14_1:FormatText(var_17_12.content)

				arg_14_1.text_.text = var_17_13

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_15 = 36 <= 0 and var_17_11 or var_17_11 * (utf8.len(var_17_13) / 36)

				if (36 <= 0 and var_17_11 or var_17_11 * (utf8.len(var_17_13) / 36)) > 0 and var_17_11 < var_17_15 then
					arg_14_1.talkMaxDuration = var_17_15

					if var_17_15 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_15 + var_17_10
					end
				end

				arg_14_1.text_.text = var_17_13
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142003", "story_v_out_116142.awb") ~= 0 then
					local var_17_16 = manager.audio:GetVoiceLength("story_v_out_116142", "116142003", "story_v_out_116142.awb") / 1000

					if var_17_16 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_16 + var_17_10
					end

					if var_17_12.prefab_name ~= "" and arg_14_1.actors_[var_17_12.prefab_name] ~= nil then
						local var_17_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_12.prefab_name].transform, "story_v_out_116142", "116142003", "story_v_out_116142.awb")

						arg_14_1:RecordAudio("116142003", var_17_17)
						arg_14_1:RecordAudio("116142003", var_17_17)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116142", "116142003", "story_v_out_116142.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116142", "116142003", "story_v_out_116142.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_18 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_18 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_10) / var_17_18

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_10 + var_17_18 and arg_14_1.time_ < var_17_10 + var_17_18 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116142004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116142004
		arg_18_1.duration_ = 4.43

		local var_18_0 = {
			zh = 4.433,
			ja = 2.833
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116142005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_21_0 = 0
			local var_21_1 = 0.5

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(116142004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 20 <= 0 and var_21_1 or var_21_1 * (utf8.len(var_21_3) / 20)

				if (20 <= 0 and var_21_1 or var_21_1 * (utf8.len(var_21_3) / 20)) > 0 and var_21_1 < var_21_5 then
					arg_18_1.talkMaxDuration = var_21_5

					if var_21_5 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142004", "story_v_out_116142.awb") ~= 0 then
					local var_21_6 = manager.audio:GetVoiceLength("story_v_out_116142", "116142004", "story_v_out_116142.awb") / 1000

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end

					if var_21_2.prefab_name ~= "" and arg_18_1.actors_[var_21_2.prefab_name] ~= nil then
						local var_21_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_2.prefab_name].transform, "story_v_out_116142", "116142004", "story_v_out_116142.awb")

						arg_18_1:RecordAudio("116142004", var_21_7)
						arg_18_1:RecordAudio("116142004", var_21_7)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116142", "116142004", "story_v_out_116142.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116142", "116142004", "story_v_out_116142.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_8 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_8 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_8

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_8 and arg_18_1.time_ < var_21_0 + var_21_8 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play116142005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116142005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116142006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1059ui_story = arg_22_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_25_0 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 then
				arg_22_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 0) / var_25_0)
				arg_22_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1059ui_story"].transform.position).z)
				arg_22_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["1059ui_story"].transform.localEulerAngles = arg_22_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 then
				arg_22_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1059ui_story"].transform.position).z)
				arg_22_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["1059ui_story"].transform.localEulerAngles = arg_22_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_25_1 = arg_22_1.actors_["1028ui_story"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1028ui_story = var_25_1.localPosition
			end

			local var_25_2 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_2 then
				var_25_1.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 0) / var_25_2)
				var_25_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_1.position).x, (manager.ui.mainCamera.transform.position - var_25_1.position).y, (manager.ui.mainCamera.transform.position - var_25_1.position).z)
				var_25_1.localEulerAngles.z = 0
				var_25_1.localEulerAngles.x = 0
				var_25_1.localEulerAngles = var_25_1.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_2 and arg_22_1.time_ < 0 + var_25_2 + arg_25_0 then
				var_25_1.localPosition = Vector3.New(0, 100, 0)
				var_25_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_1.position).x, (manager.ui.mainCamera.transform.position - var_25_1.position).y, (manager.ui.mainCamera.transform.position - var_25_1.position).z)
				var_25_1.localEulerAngles.z = 0
				var_25_1.localEulerAngles.x = 0
				var_25_1.localEulerAngles = var_25_1.localEulerAngles
			end

			local var_25_3 = 0
			local var_25_4 = 0.7

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_3 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_5 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(116142005).content)

				arg_22_1.text_.text = var_25_5

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_7 = 28 <= 0 and var_25_4 or var_25_4 * (utf8.len(var_25_5) / 28)

				if (28 <= 0 and var_25_4 or var_25_4 * (utf8.len(var_25_5) / 28)) > 0 and var_25_4 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_3 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_3
					end
				end

				arg_22_1.text_.text = var_25_5
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_8 = math.max(var_25_4, arg_22_1.talkMaxDuration)

			if var_25_3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_3 + var_25_8 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_3) / var_25_8

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_3 + var_25_8 and arg_22_1.time_ < var_25_3 + var_25_8 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play116142006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116142006
		arg_26_1.duration_ = 4.8

		local var_26_0 = {
			zh = 2.4,
			ja = 4.8
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
				arg_26_0:Play116142007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_29_0 = 0.6

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 then
				local var_29_1, var_29_2 = math.modf((arg_26_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_29_2 * 0.13, var_29_2 * 0.13, var_29_2 * 0.13) + arg_26_1.var_.shakeOldPos
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 then
				manager.ui.mainCamera.transform.localPosition = arg_26_1.var_.shakeOldPos
			end

			local var_29_3 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= var_29_3 + 0.6 and arg_26_1.time_ < var_29_3 + 0.6 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_4 = 0
			local var_29_5 = 0.175

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_6 = arg_26_1:GetWordFromCfg(116142006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 7 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 7)

				if (7 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 7)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142006", "story_v_out_116142.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_116142", "116142006", "story_v_out_116142.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_116142", "116142006", "story_v_out_116142.awb")

						arg_26_1:RecordAudio("116142006", var_29_11)
						arg_26_1:RecordAudio("116142006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116142", "116142006", "story_v_out_116142.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116142", "116142006", "story_v_out_116142.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_12 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_12 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_12

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_12 and arg_26_1.time_ < var_29_4 + var_29_12 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116142007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116142007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116142008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.325

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(116142007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 13 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 13)

				if (13 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 13)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play116142008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116142008
		arg_34_1.duration_ = 2.8

		local var_34_0 = {
			zh = 2.8,
			ja = 2.366
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116142009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_37_0 = arg_34_1.actors_["1059ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1059ui_story == nil then
				arg_34_1.var_.characterEffect1059ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_1 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_1 and not isNil(var_37_0) then
				if arg_34_1.var_.characterEffect1059ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_1 and arg_34_1.time_ < 0 + var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1059ui_story then
				arg_34_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_37_3 = arg_34_1.actors_["1059ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1059ui_story = var_37_3.localPosition
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_3.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_34_1.time_ - 0) / var_37_4)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_3.localPosition = Vector3.New(0, -1.05, -6)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			local var_37_5 = 0
			local var_37_6 = 0.225

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:GetWordFromCfg(116142008)
				local var_37_8 = arg_34_1:FormatText(var_37_7.content)

				arg_34_1.text_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_10 = 9 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_8) / 9)

				if (9 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_8) / 9)) > 0 and var_37_6 < var_37_10 then
					arg_34_1.talkMaxDuration = var_37_10

					if var_37_10 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_5
					end
				end

				arg_34_1.text_.text = var_37_8
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142008", "story_v_out_116142.awb") ~= 0 then
					local var_37_11 = manager.audio:GetVoiceLength("story_v_out_116142", "116142008", "story_v_out_116142.awb") / 1000

					if var_37_11 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_5
					end

					if var_37_7.prefab_name ~= "" and arg_34_1.actors_[var_37_7.prefab_name] ~= nil then
						local var_37_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_7.prefab_name].transform, "story_v_out_116142", "116142008", "story_v_out_116142.awb")

						arg_34_1:RecordAudio("116142008", var_37_12)
						arg_34_1:RecordAudio("116142008", var_37_12)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_116142", "116142008", "story_v_out_116142.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_116142", "116142008", "story_v_out_116142.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_13 = math.max(var_37_6, arg_34_1.talkMaxDuration)

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_13 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_5) / var_37_13

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_5 + var_37_13 and arg_34_1.time_ < var_37_5 + var_37_13 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play116142009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116142009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116142010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1059ui_story"]) and arg_38_1.var_.characterEffect1059ui_story == nil then
				arg_38_1.var_.characterEffect1059ui_story = arg_38_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1059ui_story"]) then
				if arg_38_1.var_.characterEffect1059ui_story and not isNil(arg_38_1.actors_["1059ui_story"]) then
					arg_38_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1059ui_story"]) and arg_38_1.var_.characterEffect1059ui_story then
				arg_38_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.975

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(116142009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 39 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 39)

				if (39 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 39)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play116142010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116142010
		arg_42_1.duration_ = 9.2

		local var_42_0 = {
			zh = 7.866,
			ja = 9.2
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
				arg_42_0:Play116142011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_45_0 = arg_42_1.actors_["1059ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1059ui_story == nil then
				arg_42_1.var_.characterEffect1059ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_1 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 and not isNil(var_45_0) then
				if arg_42_1.var_.characterEffect1059ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1059ui_story then
				arg_42_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_45_3 = 0
			local var_45_4 = 0.775

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_5 = arg_42_1:GetWordFromCfg(116142010)
				local var_45_6 = arg_42_1:FormatText(var_45_5.content)

				arg_42_1.text_.text = var_45_6

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_8 = 31 <= 0 and var_45_4 or var_45_4 * (utf8.len(var_45_6) / 31)

				if (31 <= 0 and var_45_4 or var_45_4 * (utf8.len(var_45_6) / 31)) > 0 and var_45_4 < var_45_8 then
					arg_42_1.talkMaxDuration = var_45_8

					if var_45_8 + var_45_3 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_3
					end
				end

				arg_42_1.text_.text = var_45_6
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142010", "story_v_out_116142.awb") ~= 0 then
					local var_45_9 = manager.audio:GetVoiceLength("story_v_out_116142", "116142010", "story_v_out_116142.awb") / 1000

					if var_45_9 + var_45_3 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_3
					end

					if var_45_5.prefab_name ~= "" and arg_42_1.actors_[var_45_5.prefab_name] ~= nil then
						local var_45_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_5.prefab_name].transform, "story_v_out_116142", "116142010", "story_v_out_116142.awb")

						arg_42_1:RecordAudio("116142010", var_45_10)
						arg_42_1:RecordAudio("116142010", var_45_10)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_116142", "116142010", "story_v_out_116142.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_116142", "116142010", "story_v_out_116142.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_11 = math.max(var_45_4, arg_42_1.talkMaxDuration)

			if var_45_3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_3 + var_45_11 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_3) / var_45_11

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_3 + var_45_11 and arg_42_1.time_ < var_45_3 + var_45_11 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116142011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116142011
		arg_46_1.duration_ = 6.3

		local var_46_0 = {
			zh = 6.3,
			ja = 6.2
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
				arg_46_0:Play116142012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1059ui_story"]) and arg_46_1.var_.characterEffect1059ui_story == nil then
				arg_46_1.var_.characterEffect1059ui_story = arg_46_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1059ui_story"]) then
				if arg_46_1.var_.characterEffect1059ui_story and not isNil(arg_46_1.actors_["1059ui_story"]) then
					arg_46_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1059ui_story"]) and arg_46_1.var_.characterEffect1059ui_story then
				arg_46_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 0.75

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:GetWordFromCfg(116142011)
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

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142011", "story_v_out_116142.awb") ~= 0 then
					local var_49_7 = manager.audio:GetVoiceLength("story_v_out_116142", "116142011", "story_v_out_116142.awb") / 1000

					if var_49_7 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_1
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_116142", "116142011", "story_v_out_116142.awb")

						arg_46_1:RecordAudio("116142011", var_49_8)
						arg_46_1:RecordAudio("116142011", var_49_8)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116142", "116142011", "story_v_out_116142.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116142", "116142011", "story_v_out_116142.awb")
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
	Play116142012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116142012
		arg_50_1.duration_ = 4.3

		local var_50_0 = {
			zh = 4.3,
			ja = 3.3
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
				arg_50_0:Play116142013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_53_0 = arg_50_1.actors_["1059ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1059ui_story == nil then
				arg_50_1.var_.characterEffect1059ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_1 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 and not isNil(var_53_0) then
				if arg_50_1.var_.characterEffect1059ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1059ui_story then
				arg_50_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_53_3 = 0
			local var_53_4 = 0.375

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_5 = arg_50_1:GetWordFromCfg(116142012)
				local var_53_6 = arg_50_1:FormatText(var_53_5.content)

				arg_50_1.text_.text = var_53_6

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_8 = 15 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_6) / 15)

				if (15 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_6) / 15)) > 0 and var_53_4 < var_53_8 then
					arg_50_1.talkMaxDuration = var_53_8

					if var_53_8 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_3
					end
				end

				arg_50_1.text_.text = var_53_6
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142012", "story_v_out_116142.awb") ~= 0 then
					local var_53_9 = manager.audio:GetVoiceLength("story_v_out_116142", "116142012", "story_v_out_116142.awb") / 1000

					if var_53_9 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_3
					end

					if var_53_5.prefab_name ~= "" and arg_50_1.actors_[var_53_5.prefab_name] ~= nil then
						local var_53_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_5.prefab_name].transform, "story_v_out_116142", "116142012", "story_v_out_116142.awb")

						arg_50_1:RecordAudio("116142012", var_53_10)
						arg_50_1:RecordAudio("116142012", var_53_10)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_116142", "116142012", "story_v_out_116142.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_116142", "116142012", "story_v_out_116142.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_11 = math.max(var_53_4, arg_50_1.talkMaxDuration)

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_11 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_3) / var_53_11

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_3 + var_53_11 and arg_50_1.time_ < var_53_3 + var_53_11 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play116142013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116142013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116142014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1059ui_story = arg_54_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1059ui_story"].transform.position).z)
				arg_54_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1059ui_story"].transform.localEulerAngles = arg_54_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1059ui_story"].transform.position).z)
				arg_54_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1059ui_story"].transform.localEulerAngles = arg_54_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_57_2 = manager.ui.mainCamera.transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.shakeOldPos = var_57_2.localPosition
			end

			local var_57_3 = 0.6

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 then
				local var_57_4, var_57_5 = math.modf((arg_54_1.time_ - 0) / 0.066)

				var_57_2.localPosition = Vector3.New(var_57_5 * 0.13, var_57_5 * 0.13, var_57_5 * 0.13) + arg_54_1.var_.shakeOldPos
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 then
				var_57_2.localPosition = arg_54_1.var_.shakeOldPos
			end

			local var_57_6 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.allBtn_.enabled = false
			end

			if arg_54_1.time_ >= var_57_6 + 0.6 and arg_54_1.time_ < var_57_6 + 0.6 + arg_57_0 then
				arg_54_1.allBtn_.enabled = true
			end

			local var_57_7 = 0
			local var_57_8 = 0.075

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_9 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(116142013).content)

				arg_54_1.text_.text = var_57_9

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 3 <= 0 and var_57_8 or var_57_8 * (utf8.len(var_57_9) / 3)

				if (3 <= 0 and var_57_8 or var_57_8 * (utf8.len(var_57_9) / 3)) > 0 and var_57_8 < var_57_11 then
					arg_54_1.talkMaxDuration = var_57_11

					if var_57_11 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_7
					end
				end

				arg_54_1.text_.text = var_57_9
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_8, arg_54_1.talkMaxDuration)

			if var_57_7 <= arg_54_1.time_ and arg_54_1.time_ < var_57_7 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_7) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_7 + var_57_12 and arg_54_1.time_ < var_57_7 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play116142014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 116142014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play116142015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.95

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_1 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(116142014).content)

				arg_58_1.text_.text = var_61_1

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_3 = 38 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 38)

				if (38 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 38)) > 0 and var_61_0 < var_61_3 then
					arg_58_1.talkMaxDuration = var_61_3

					if var_61_3 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_3 + 0
					end
				end

				arg_58_1.text_.text = var_61_1
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_4 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_4

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play116142015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116142015
		arg_62_1.duration_ = 9.07

		local var_62_0 = {
			zh = 9.066,
			ja = 5.8
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
				arg_62_0:Play116142016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.55

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(116142015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 22 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 22)

				if (22 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 22)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142015", "story_v_out_116142.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_116142", "116142015", "story_v_out_116142.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_116142", "116142015", "story_v_out_116142.awb")

						arg_62_1:RecordAudio("116142015", var_65_6)
						arg_62_1:RecordAudio("116142015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_116142", "116142015", "story_v_out_116142.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_116142", "116142015", "story_v_out_116142.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play116142016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116142016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116142017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = arg_66_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).z)
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles = arg_66_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).z)
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles = arg_66_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_69_2 = manager.ui.mainCamera.transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.shakeOldPos = var_69_2.localPosition
			end

			local var_69_3 = 1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 then
				local var_69_4, var_69_5 = math.modf((arg_66_1.time_ - 0) / 0.066)

				var_69_2.localPosition = Vector3.New(var_69_5 * 0.13, var_69_5 * 0.13, var_69_5 * 0.13) + arg_66_1.var_.shakeOldPos
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 then
				var_69_2.localPosition = arg_66_1.var_.shakeOldPos
			end

			local var_69_6 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_6 + 1 and arg_66_1.time_ < var_69_6 + 1 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_7 = 0
			local var_69_8 = 0.075

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(116142016).content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 3 <= 0 and var_69_8 or var_69_8 * (utf8.len(var_69_9) / 3)

				if (3 <= 0 and var_69_8 or var_69_8 * (utf8.len(var_69_9) / 3)) > 0 and var_69_8 < var_69_11 then
					arg_66_1.talkMaxDuration = var_69_11

					if var_69_11 + var_69_7 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_7
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_8, arg_66_1.talkMaxDuration)

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_7) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_7 + var_69_12 and arg_66_1.time_ < var_69_7 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play116142017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116142017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116142018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.85

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(116142017).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 34 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 34)

				if (34 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 34)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116142018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116142018
		arg_74_1.duration_ = 11.5

		local var_74_0 = {
			zh = 7.233,
			ja = 11.5
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
				arg_74_0:Play116142019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.725

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:GetWordFromCfg(116142018)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 29 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 29)

				if (29 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 29)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142018", "story_v_out_116142.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_116142", "116142018", "story_v_out_116142.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_116142", "116142018", "story_v_out_116142.awb")

						arg_74_1:RecordAudio("116142018", var_77_6)
						arg_74_1:RecordAudio("116142018", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116142", "116142018", "story_v_out_116142.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116142", "116142018", "story_v_out_116142.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116142019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116142019
		arg_78_1.duration_ = 6.5

		local var_78_0 = {
			zh = 5.033,
			ja = 6.5
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
				arg_78_0:Play116142020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.7

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(116142019)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 28 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 28)

				if (28 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 28)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142019", "story_v_out_116142.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_116142", "116142019", "story_v_out_116142.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_116142", "116142019", "story_v_out_116142.awb")

						arg_78_1:RecordAudio("116142019", var_81_6)
						arg_78_1:RecordAudio("116142019", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_116142", "116142019", "story_v_out_116142.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_116142", "116142019", "story_v_out_116142.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116142020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116142020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116142021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.925

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(116142020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 37 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 37)

				if (37 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 37)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116142021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116142021
		arg_86_1.duration_ = 6.27

		local var_86_0 = {
			zh = 6.266,
			ja = 5.5
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116142022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.375

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(116142021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 15 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 15)

				if (15 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 15)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142021", "story_v_out_116142.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_116142", "116142021", "story_v_out_116142.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_116142", "116142021", "story_v_out_116142.awb")

						arg_86_1:RecordAudio("116142021", var_89_6)
						arg_86_1:RecordAudio("116142021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_116142", "116142021", "story_v_out_116142.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_116142", "116142021", "story_v_out_116142.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116142022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116142022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116142023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:AudioAction("play", "effect", "se_story_16", "se_story_16_arch", "")
			end

			local var_93_1 = 0
			local var_93_2 = 0.975

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(116142022).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 39 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 39)

				if (39 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 39)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116142023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116142023
		arg_94_1.duration_ = 7.23

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116142024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.bgs_.STwhite == nil then
				local var_97_0 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_97_0.name = "STwhite"
				var_97_0.transform.parent = arg_94_1.stage_.transform
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_.STwhite = var_97_0
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				local var_97_1 = arg_94_1.bgs_.STwhite

				arg_94_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_2 = var_97_1:GetComponent("SpriteRenderer")

				if var_97_2 and var_97_2.sprite then
					local var_97_3 = 2 * (var_97_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_1.transform.localScale = Vector3.New(var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "STwhite" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_4 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_5 = 2

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_5 then
				local var_97_6 = Color.New(1, 1, 1)

				var_97_6.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_4) / var_97_5)
				arg_94_1.mask_.color = var_97_6
			end

			if arg_94_1.time_ >= var_97_4 + var_97_5 and arg_94_1.time_ < var_97_4 + var_97_5 + arg_97_0 then
				local var_97_7 = Color.New(1, 1, 1)

				arg_94_1.mask_.enabled = false
				var_97_7.a = 0
				arg_94_1.mask_.color = var_97_7
			end

			local var_97_8 = arg_94_1.bgs_.STwhite.transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPosSTwhite = var_97_8.localPosition
				var_97_8.localScale = Vector3.New(12, 12, 12)
			end

			local var_97_9 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_9 then
				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_94_1.time_ - 0) / var_97_9)
			end

			if arg_94_1.time_ >= 0 + var_97_9 and arg_94_1.time_ < 0 + var_97_9 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_10 = 2.23333333333333
			local var_97_11 = 0.35

			if 2.23333333333333 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_12 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_12:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_13 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(116142023).content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 14 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 14)

				if (14 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 14)) > 0 and var_97_11 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15
					var_97_10 = var_97_10 + 0.3

					if var_97_15 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_10
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = var_97_10 + 0.3
			local var_97_17 = math.max(var_97_11, arg_94_1.talkMaxDuration)

			if var_97_10 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_17 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_16) / var_97_17

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_16 + var_97_17 and arg_94_1.time_ < var_97_16 + var_97_17 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play116142024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116142024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
			arg_100_1.auto_ = false
		end

		function arg_100_1.playNext_(arg_102_0)
			arg_100_1.onStoryFinished_()
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.525

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(116142024).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 21 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 21)

				if (21 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 21)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116142.awb"
	}
}
