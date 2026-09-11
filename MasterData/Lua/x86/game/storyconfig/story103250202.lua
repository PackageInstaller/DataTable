return {
	Play325022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325022001
		arg_1_1.duration_ = 6.57

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2011 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2011")
				var_4_0.name = "ST2011"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2011 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2011

				arg_1_1.bgs_.ST2011.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2011" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_kushulin", "bgm_activity_5_1_story_kushulin", "bgm_activity_5_1_story_kushulin.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_1_story_kushulin", "bgm_activity_5_1_story_kushulin")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 1.56666666666667
			local var_4_14 = 0.65

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325022001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 26 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 26)

				if (26 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 26)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
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
	Play325022002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325022002
		arg_8_1.duration_ = 10.53

		local var_8_0 = {
			zh = 6.6,
			ja = 10.533
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
				arg_8_0:Play325022003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.725

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(325022002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 29)

				if (29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 29)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022002", "story_v_out_325022.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_325022", "325022002", "story_v_out_325022.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_325022", "325022002", "story_v_out_325022.awb")

						arg_8_1:RecordAudio("325022002", var_11_6)
						arg_8_1:RecordAudio("325022002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325022", "325022002", "story_v_out_325022.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325022", "325022002", "story_v_out_325022.awb")
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
	Play325022003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325022003
		arg_12_1.duration_ = 14.43

		local var_12_0 = {
			zh = 9.9,
			ja = 14.433
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
				arg_12_0:Play325022004(arg_12_1)
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
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_15_10 = 0
			local var_15_11 = 1

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

				local var_15_12 = arg_12_1:GetWordFromCfg(325022003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 40 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 40)

				if (40 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 40)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022003", "story_v_out_325022.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_325022", "325022003", "story_v_out_325022.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_325022", "325022003", "story_v_out_325022.awb")

						arg_12_1:RecordAudio("325022003", var_15_17)
						arg_12_1:RecordAudio("325022003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325022", "325022003", "story_v_out_325022.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325022", "325022003", "story_v_out_325022.awb")
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
	Play325022004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325022004
		arg_16_1.duration_ = 4

		local var_16_0 = {
			zh = 3.233,
			ja = 4
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
				arg_16_0:Play325022005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1077ui_story"]) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = arg_16_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1077ui_story"]) then
				if arg_16_1.var_.characterEffect1077ui_story and not isNil(arg_16_1.actors_["1077ui_story"]) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1077ui_story"]) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.25

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(325022004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 10 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 10)

				if (10 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 10)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022004", "story_v_out_325022.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022004", "story_v_out_325022.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_325022", "325022004", "story_v_out_325022.awb")

						arg_16_1:RecordAudio("325022004", var_19_8)
						arg_16_1:RecordAudio("325022004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325022", "325022004", "story_v_out_325022.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325022", "325022004", "story_v_out_325022.awb")
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
	Play325022005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325022005
		arg_20_1.duration_ = 8.47

		local var_20_0 = {
			zh = 3.766,
			ja = 8.466
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
				arg_20_0:Play325022006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = arg_20_1.actors_["1077ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).z)
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles = arg_20_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_20_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).z)
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles = arg_20_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = "1069ui_story"

			if arg_20_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_23_4 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_20_1.stage_.transform)

				var_23_4.name = var_23_3
				var_23_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_3] = var_23_4

				local var_23_5 = var_23_4:GetComponentInChildren(typeof(CharacterEffect))

				var_23_5.enabled = true

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_4, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_5.transform, false)

				arg_20_1.var_[var_23_3 .. "Animator"] = var_23_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_3 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_3 .. "LipSync"] = var_23_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_7 = arg_20_1.actors_["1069ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1069ui_story = var_23_7.localPosition
			end

			local var_23_8 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 then
				var_23_7.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_20_1.time_ - 0) / var_23_8)
				var_23_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_7.position).x, (manager.ui.mainCamera.transform.position - var_23_7.position).y, (manager.ui.mainCamera.transform.position - var_23_7.position).z)
				var_23_7.localEulerAngles.z = 0
				var_23_7.localEulerAngles.x = 0
				var_23_7.localEulerAngles = var_23_7.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 then
				var_23_7.localPosition = Vector3.New(0.7, -1, -6)
				var_23_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_7.position).x, (manager.ui.mainCamera.transform.position - var_23_7.position).y, (manager.ui.mainCamera.transform.position - var_23_7.position).z)
				var_23_7.localEulerAngles.z = 0
				var_23_7.localEulerAngles.x = 0
				var_23_7.localEulerAngles = var_23_7.localEulerAngles
			end

			local var_23_9 = arg_20_1.actors_["1069ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1069ui_story == nil then
				arg_20_1.var_.characterEffect1069ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_10 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_10 and not isNil(var_23_9) then
				if arg_20_1.var_.characterEffect1069ui_story and not isNil(var_23_9) then
					arg_20_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_10 and arg_20_1.time_ < 0 + var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1069ui_story then
				arg_20_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_12 = 0
			local var_23_13 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(325022005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 19 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 19)

				if (19 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 19)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022005", "story_v_out_325022.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_325022", "325022005", "story_v_out_325022.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_325022", "325022005", "story_v_out_325022.awb")

						arg_20_1:RecordAudio("325022005", var_23_19)
						arg_20_1:RecordAudio("325022005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325022", "325022005", "story_v_out_325022.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325022", "325022005", "story_v_out_325022.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_20 and arg_20_1.time_ < var_23_12 + var_23_20 + arg_23_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325022006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325022006
		arg_24_1.duration_ = 7.1

		local var_24_0 = {
			zh = 2.933,
			ja = 7.1
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
				arg_24_0:Play325022007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1077ui_story"]) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = arg_24_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1077ui_story"]) then
				if arg_24_1.var_.characterEffect1077ui_story and not isNil(arg_24_1.actors_["1077ui_story"]) then
					arg_24_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1077ui_story"]) and arg_24_1.var_.characterEffect1077ui_story then
				arg_24_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1069ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1069ui_story == nil then
				arg_24_1.var_.characterEffect1069ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1069ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1069ui_story then
				arg_24_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_27_4 = 0
			local var_27_5 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(325022006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 11 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 11)

				if (11 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 11)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022006", "story_v_out_325022.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_325022", "325022006", "story_v_out_325022.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_325022", "325022006", "story_v_out_325022.awb")

						arg_24_1:RecordAudio("325022006", var_27_11)
						arg_24_1:RecordAudio("325022006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325022", "325022006", "story_v_out_325022.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325022", "325022006", "story_v_out_325022.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325022007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325022007
		arg_28_1.duration_ = 13.8

		local var_28_0 = {
			zh = 10.266,
			ja = 13.8
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
				arg_28_0:Play325022008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1069ui_story"]) and arg_28_1.var_.characterEffect1069ui_story == nil then
				arg_28_1.var_.characterEffect1069ui_story = arg_28_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1069ui_story"]) then
				if arg_28_1.var_.characterEffect1069ui_story and not isNil(arg_28_1.actors_["1069ui_story"]) then
					arg_28_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1069ui_story"]) and arg_28_1.var_.characterEffect1069ui_story then
				arg_28_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1077ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action6_1")
			end

			local var_31_4 = 0
			local var_31_5 = 1.025

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(325022007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 41 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 41)

				if (41 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 41)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022007", "story_v_out_325022.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_325022", "325022007", "story_v_out_325022.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_325022", "325022007", "story_v_out_325022.awb")

						arg_28_1:RecordAudio("325022007", var_31_11)
						arg_28_1:RecordAudio("325022007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325022", "325022007", "story_v_out_325022.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325022", "325022007", "story_v_out_325022.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325022008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325022008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325022009(arg_32_1)
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
				arg_32_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).z)
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles = arg_32_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1077ui_story"].transform.position).z)
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1077ui_story"].transform.localEulerAngles = arg_32_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["1069ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1069ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0, 100, 0)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["1069ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1069ui_story == nil then
				arg_32_1.var_.characterEffect1069ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect1069ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_6)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1069ui_story then
				arg_32_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_35_7 = 0
			local var_35_8 = 0.925

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325022008).content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 37 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_9) / 37)

				if (37 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_9) / 37)) > 0 and var_35_8 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_7
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_7) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_7 + var_35_12 and arg_32_1.time_ < var_35_7 + var_35_12 + arg_35_0 then
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
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play325022009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325022009
		arg_36_1.duration_ = 9.1

		local var_36_0 = {
			zh = 6.966,
			ja = 9.1
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
				arg_36_0:Play325022010(arg_36_1)
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
				arg_36_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).z)
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles = arg_36_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_36_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1077ui_story"].transform.position).z)
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1077ui_story"].transform.localEulerAngles = arg_36_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["1077ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect1077ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1077ui_story then
				arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_39_6 = 0
			local var_39_7 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(325022009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 34 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 34)

				if (34 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 34)) > 0 and var_39_7 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022009", "story_v_out_325022.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_325022", "325022009", "story_v_out_325022.awb") / 1000

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_325022", "325022009", "story_v_out_325022.awb")

						arg_36_1:RecordAudio("325022009", var_39_13)
						arg_36_1:RecordAudio("325022009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325022", "325022009", "story_v_out_325022.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325022", "325022009", "story_v_out_325022.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
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
	Play325022010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325022010
		arg_40_1.duration_ = 17.3

		local var_40_0 = {
			zh = 8.233,
			ja = 17.3
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
				arg_40_0:Play325022011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1077ui_story"]) and arg_40_1.var_.characterEffect1077ui_story == nil then
				arg_40_1.var_.characterEffect1077ui_story = arg_40_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1077ui_story"]) then
				if arg_40_1.var_.characterEffect1077ui_story and not isNil(arg_40_1.actors_["1077ui_story"]) then
					arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1077ui_story"]) and arg_40_1.var_.characterEffect1077ui_story then
				arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.775

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(325022010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 31 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 31)

				if (31 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 31)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022010", "story_v_out_325022.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022010", "story_v_out_325022.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_325022", "325022010", "story_v_out_325022.awb")

						arg_40_1:RecordAudio("325022010", var_43_8)
						arg_40_1:RecordAudio("325022010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325022", "325022010", "story_v_out_325022.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325022", "325022010", "story_v_out_325022.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_9 and arg_40_1.time_ < var_43_1 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325022011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325022011
		arg_44_1.duration_ = 9.2

		local var_44_0 = {
			zh = 7.466,
			ja = 9.2
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
				arg_44_0:Play325022012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = arg_44_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) then
				if arg_44_1.var_.characterEffect1077ui_story and not isNil(arg_44_1.actors_["1077ui_story"]) then
					arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) and arg_44_1.var_.characterEffect1077ui_story then
				arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_47_2 = 0
			local var_47_3 = 0.85

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
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

				local var_47_4 = arg_44_1:GetWordFromCfg(325022011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 34 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 34)

				if (34 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 34)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022011", "story_v_out_325022.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_325022", "325022011", "story_v_out_325022.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_325022", "325022011", "story_v_out_325022.awb")

						arg_44_1:RecordAudio("325022011", var_47_9)
						arg_44_1:RecordAudio("325022011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325022", "325022011", "story_v_out_325022.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325022", "325022011", "story_v_out_325022.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325022012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325022012
		arg_48_1.duration_ = 5.9

		local var_48_0 = {
			zh = 2.533,
			ja = 5.9
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
				arg_48_0:Play325022013(arg_48_1)
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
			local var_51_2 = 0.2

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(325022012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 8 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 8)

				if (8 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 8)) > 0 and var_51_2 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022012", "story_v_out_325022.awb") ~= 0 then
					local var_51_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022012", "story_v_out_325022.awb") / 1000

					if var_51_7 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_1
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_325022", "325022012", "story_v_out_325022.awb")

						arg_48_1:RecordAudio("325022012", var_51_8)
						arg_48_1:RecordAudio("325022012", var_51_8)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325022", "325022012", "story_v_out_325022.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325022", "325022012", "story_v_out_325022.awb")
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
	Play325022013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325022013
		arg_52_1.duration_ = 4.63

		local var_52_0 = {
			zh = 3.866,
			ja = 4.633
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
				arg_52_0:Play325022014(arg_52_1)
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
			local var_55_3 = 0.375

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

				local var_55_4 = arg_52_1:GetWordFromCfg(325022013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 15 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 15)

				if (15 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 15)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022013", "story_v_out_325022.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_325022", "325022013", "story_v_out_325022.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_325022", "325022013", "story_v_out_325022.awb")

						arg_52_1:RecordAudio("325022013", var_55_9)
						arg_52_1:RecordAudio("325022013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325022", "325022013", "story_v_out_325022.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325022", "325022013", "story_v_out_325022.awb")
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
	Play325022014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325022014
		arg_56_1.duration_ = 7.97

		local var_56_0 = {
			zh = 6.866,
			ja = 7.966
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
				arg_56_0:Play325022015(arg_56_1)
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
			local var_59_2 = 0.55

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(325022014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 22 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 22)

				if (22 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 22)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022014", "story_v_out_325022.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022014", "story_v_out_325022.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_325022", "325022014", "story_v_out_325022.awb")

						arg_56_1:RecordAudio("325022014", var_59_8)
						arg_56_1:RecordAudio("325022014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325022", "325022014", "story_v_out_325022.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325022", "325022014", "story_v_out_325022.awb")
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
	Play325022015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325022015
		arg_60_1.duration_ = 10.5

		local var_60_0 = {
			zh = 3.8,
			ja = 10.5
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
				arg_60_0:Play325022016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.35

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(325022015)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 14 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 14)

				if (14 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 14)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022015", "story_v_out_325022.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_325022", "325022015", "story_v_out_325022.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_325022", "325022015", "story_v_out_325022.awb")

						arg_60_1:RecordAudio("325022015", var_63_6)
						arg_60_1:RecordAudio("325022015", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325022", "325022015", "story_v_out_325022.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325022", "325022015", "story_v_out_325022.awb")
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
	Play325022016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325022016
		arg_64_1.duration_ = 3.1

		local var_64_0 = {
			zh = 2.266,
			ja = 3.1
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
				arg_64_0:Play325022017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1077ui_story"]) and arg_64_1.var_.characterEffect1077ui_story == nil then
				arg_64_1.var_.characterEffect1077ui_story = arg_64_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1077ui_story"]) then
				if arg_64_1.var_.characterEffect1077ui_story and not isNil(arg_64_1.actors_["1077ui_story"]) then
					arg_64_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1077ui_story"]) and arg_64_1.var_.characterEffect1077ui_story then
				arg_64_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_67_2 = 0
			local var_67_3 = 0.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(325022016)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 10 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 10)

				if (10 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 10)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022016", "story_v_out_325022.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_325022", "325022016", "story_v_out_325022.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_325022", "325022016", "story_v_out_325022.awb")

						arg_64_1:RecordAudio("325022016", var_67_9)
						arg_64_1:RecordAudio("325022016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325022", "325022016", "story_v_out_325022.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325022", "325022016", "story_v_out_325022.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325022017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325022017
		arg_68_1.duration_ = 9.37

		local var_68_0 = {
			zh = 4.433,
			ja = 9.366
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
				arg_68_0:Play325022018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) and arg_68_1.var_.characterEffect1077ui_story == nil then
				arg_68_1.var_.characterEffect1077ui_story = arg_68_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) then
				if arg_68_1.var_.characterEffect1077ui_story and not isNil(arg_68_1.actors_["1077ui_story"]) then
					arg_68_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) and arg_68_1.var_.characterEffect1077ui_story then
				arg_68_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.375

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(325022017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 15 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_4) / 15)

				if (15 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_4) / 15)) > 0 and var_71_2 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022017", "story_v_out_325022.awb") ~= 0 then
					local var_71_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022017", "story_v_out_325022.awb") / 1000

					if var_71_7 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_1
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_325022", "325022017", "story_v_out_325022.awb")

						arg_68_1:RecordAudio("325022017", var_71_8)
						arg_68_1:RecordAudio("325022017", var_71_8)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325022", "325022017", "story_v_out_325022.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325022", "325022017", "story_v_out_325022.awb")
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
	Play325022018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325022018
		arg_72_1.duration_ = 10.9

		local var_72_0 = {
			zh = 6.566,
			ja = 10.9
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
				arg_72_0:Play325022019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1077ui_story"]) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = arg_72_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1077ui_story"]) then
				if arg_72_1.var_.characterEffect1077ui_story and not isNil(arg_72_1.actors_["1077ui_story"]) then
					arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1077ui_story"]) and arg_72_1.var_.characterEffect1077ui_story then
				arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.85

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
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

				local var_75_4 = arg_72_1:GetWordFromCfg(325022018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 34 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 34)

				if (34 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 34)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022018", "story_v_out_325022.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_325022", "325022018", "story_v_out_325022.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_325022", "325022018", "story_v_out_325022.awb")

						arg_72_1:RecordAudio("325022018", var_75_9)
						arg_72_1:RecordAudio("325022018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325022", "325022018", "story_v_out_325022.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325022", "325022018", "story_v_out_325022.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325022019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325022019
		arg_76_1.duration_ = 6.1

		local var_76_0 = {
			zh = 3.433,
			ja = 6.1
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
				arg_76_0:Play325022020(arg_76_1)
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
			local var_79_2 = 0.25

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(325022019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 10 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 10)

				if (10 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 10)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022019", "story_v_out_325022.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022019", "story_v_out_325022.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_325022", "325022019", "story_v_out_325022.awb")

						arg_76_1:RecordAudio("325022019", var_79_8)
						arg_76_1:RecordAudio("325022019", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325022", "325022019", "story_v_out_325022.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325022", "325022019", "story_v_out_325022.awb")
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
	Play325022020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325022020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325022021(arg_80_1)
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

			if 0.1 < arg_80_1.time_ and arg_80_1.time_ <= 0.1 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_148", "se_story_148_cloth", "")
			end

			local var_83_4 = 0
			local var_83_5 = 0.65

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(325022020).content)

				arg_80_1.text_.text = var_83_6

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_8 = 26 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_6) / 26)

				if (26 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_6) / 26)) > 0 and var_83_5 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_6
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_9 and arg_80_1.time_ < var_83_4 + var_83_9 + arg_83_0 then
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
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play325022021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325022021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325022022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.725

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(325022021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 29 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 29)

				if (29 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 29)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325022022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325022022
		arg_88_1.duration_ = 5.67

		local var_88_0 = {
			zh = 3.1,
			ja = 5.666
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
			arg_88_1.auto_ = false
		end

		function arg_88_1.playNext_(arg_90_0)
			arg_88_1.onStoryFinished_()
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_91_1 = 0
			local var_91_2 = 0.2

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(325022022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_6 = 8 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 8)

				if (8 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 8)) > 0 and var_91_2 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325022", "325022022", "story_v_out_325022.awb") ~= 0 then
					local var_91_7 = manager.audio:GetVoiceLength("story_v_out_325022", "325022022", "story_v_out_325022.awb") / 1000

					if var_91_7 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_1
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_325022", "325022022", "story_v_out_325022.awb")

						arg_88_1:RecordAudio("325022022", var_91_8)
						arg_88_1:RecordAudio("325022022", var_91_8)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325022", "325022022", "story_v_out_325022.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325022", "325022022", "story_v_out_325022.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_9 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_9 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_9

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_9 and arg_88_1.time_ < var_91_1 + var_91_9 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2011"
	},
	voices = {
		"story_v_out_325022.awb"
	}
}
