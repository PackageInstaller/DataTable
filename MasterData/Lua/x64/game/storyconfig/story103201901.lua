return {
	Play320191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320191001
		arg_1_1.duration_ = 14.5

		local var_1_0 = {
			zh = 9.5,
			ja = 14.5
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
				arg_1_0:Play320191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L07j == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07j")
				var_4_0.name = "L07j"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L07j = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L07j

				arg_1_1.bgs_.L07j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L07j" then
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry")

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
			local var_4_16 = 1.075

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1060].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(320191001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 43 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 43)

				if (43 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 43)) > 0 and var_4_16 < var_4_21 then
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

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191001", "story_v_out_320191.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_320191", "320191001", "story_v_out_320191.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_320191", "320191001", "story_v_out_320191.awb")

						arg_1_1:RecordAudio("320191001", var_4_23)
						arg_1_1:RecordAudio("320191001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320191", "320191001", "story_v_out_320191.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320191", "320191001", "story_v_out_320191.awb")
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
	Play320191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320191002
		arg_9_1.duration_ = 2.5

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 2.5
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
				arg_9_0:Play320191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1056ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1056ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1056ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1056ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1056ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1056ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1, -5.75)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1056ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1056ui_story == nil then
				arg_9_1.var_.characterEffect1056ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1056ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1056ui_story then
				arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(320191002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 7 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 7)

				if (7 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 7)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191002", "story_v_out_320191.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_320191", "320191002", "story_v_out_320191.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_320191", "320191002", "story_v_out_320191.awb")

						arg_9_1:RecordAudio("320191002", var_12_15)
						arg_9_1:RecordAudio("320191002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320191", "320191002", "story_v_out_320191.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320191", "320191002", "story_v_out_320191.awb")
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
				actorName = "1056ui_story",
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
	Play320191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320191003
		arg_13_1.duration_ = 10.27

		local var_13_0 = {
			zh = 10.266,
			ja = 9.7
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
				arg_13_0:Play320191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1056ui_story"]) and arg_13_1.var_.characterEffect1056ui_story == nil then
				arg_13_1.var_.characterEffect1056ui_story = arg_13_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1056ui_story"]) then
				if arg_13_1.var_.characterEffect1056ui_story and not isNil(arg_13_1.actors_["1056ui_story"]) then
					arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1056ui_story"]) and arg_13_1.var_.characterEffect1056ui_story then
				arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 1.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1060].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(320191003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 47 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 47)

				if (47 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 47)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191003", "story_v_out_320191.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191003", "story_v_out_320191.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_320191", "320191003", "story_v_out_320191.awb")

						arg_13_1:RecordAudio("320191003", var_16_8)
						arg_13_1:RecordAudio("320191003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320191", "320191003", "story_v_out_320191.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320191", "320191003", "story_v_out_320191.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play320191004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320191004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 4.3,
			ja = 4.1
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
				arg_17_0:Play320191005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) and arg_17_1.var_.characterEffect1056ui_story == nil then
				arg_17_1.var_.characterEffect1056ui_story = arg_17_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) then
				if arg_17_1.var_.characterEffect1056ui_story and not isNil(arg_17_1.actors_["1056ui_story"]) then
					arg_17_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) and arg_17_1.var_.characterEffect1056ui_story then
				arg_17_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(320191004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 22 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 22)

				if (22 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 22)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191004", "story_v_out_320191.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191004", "story_v_out_320191.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_320191", "320191004", "story_v_out_320191.awb")

						arg_17_1:RecordAudio("320191004", var_20_9)
						arg_17_1:RecordAudio("320191004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320191", "320191004", "story_v_out_320191.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320191", "320191004", "story_v_out_320191.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play320191005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320191005
		arg_21_1.duration_ = 14.5

		local var_21_0 = {
			zh = 13.7,
			ja = 14.5
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
				arg_21_0:Play320191006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1056ui_story"]) and arg_21_1.var_.characterEffect1056ui_story == nil then
				arg_21_1.var_.characterEffect1056ui_story = arg_21_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1056ui_story"]) then
				if arg_21_1.var_.characterEffect1056ui_story and not isNil(arg_21_1.actors_["1056ui_story"]) then
					arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1056ui_story"]) and arg_21_1.var_.characterEffect1056ui_story then
				arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1060].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(320191005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 61 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 61)

				if (61 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 61)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191005", "story_v_out_320191.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191005", "story_v_out_320191.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_320191", "320191005", "story_v_out_320191.awb")

						arg_21_1:RecordAudio("320191005", var_24_8)
						arg_21_1:RecordAudio("320191005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320191", "320191005", "story_v_out_320191.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320191", "320191005", "story_v_out_320191.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320191006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320191006
		arg_25_1.duration_ = 5.93

		local var_25_0 = {
			zh = 2.59933333333333,
			ja = 5.93333333333333
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
				arg_25_0:Play320191007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1056ui_story = arg_25_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1056ui_story"].transform.position).z)
				arg_25_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1056ui_story"].transform.localEulerAngles = arg_25_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_25_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1056ui_story"].transform.position).z)
				arg_25_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1056ui_story"].transform.localEulerAngles = arg_25_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1056ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1056ui_story == nil then
				arg_25_1.var_.characterEffect1056ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1056ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1056ui_story then
				arg_25_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_4 = 0.533333333333333
			local var_28_5 = 0.225

			if 0.533333333333333 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_6 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_6:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(320191006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_8) / 9)

				if (9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_8) / 9)) > 0 and var_28_5 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10
					var_28_4 = var_28_4 + 0.3

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191006", "story_v_out_320191.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_320191", "320191006", "story_v_out_320191.awb") / 1000

					if var_28_11 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_4
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_320191", "320191006", "story_v_out_320191.awb")

						arg_25_1:RecordAudio("320191006", var_28_12)
						arg_25_1:RecordAudio("320191006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320191", "320191006", "story_v_out_320191.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320191", "320191006", "story_v_out_320191.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = var_28_4 + 0.3
			local var_28_14 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_13) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_13 + var_28_14 and arg_25_1.time_ < var_28_13 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320191007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 320191007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play320191008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1056ui_story = arg_31_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1056ui_story"].transform.position).z)
				arg_31_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1056ui_story"].transform.localEulerAngles = arg_31_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1056ui_story"].transform.position).z)
				arg_31_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1056ui_story"].transform.localEulerAngles = arg_31_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_34_1 = 0
			local var_34_2 = 0.775

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(320191007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 31 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 31)

				if (31 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 31)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play320191008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 320191008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play320191009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.475

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(320191008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 59 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 59)

				if (59 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 59)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play320191009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 320191009
		arg_39_1.duration_ = 3.43

		local var_39_0 = {
			zh = 2.266,
			ja = 3.433
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
				arg_39_0:Play320191010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.3

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(320191009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 12 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 12)

				if (12 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 12)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191009", "story_v_out_320191.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191009", "story_v_out_320191.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_320191", "320191009", "story_v_out_320191.awb")

						arg_39_1:RecordAudio("320191009", var_42_6)
						arg_39_1:RecordAudio("320191009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_320191", "320191009", "story_v_out_320191.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_320191", "320191009", "story_v_out_320191.awb")
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
	Play320191010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 320191010
		arg_43_1.duration_ = 14.27

		local var_43_0 = {
			zh = 11.799666666666,
			ja = 14.266666666666
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
				arg_43_0:Play320191011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.bgs_.L07k == nil then
				local var_46_0 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07k")
				var_46_0.name = "L07k"
				var_46_0.transform.parent = arg_43_1.stage_.transform
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_.L07k = var_46_0
			end

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				local var_46_1 = arg_43_1.bgs_.L07k

				arg_43_1.bgs_.L07k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_2 = var_46_1:GetComponent("SpriteRenderer")

				if var_46_2 and var_46_2.sprite then
					local var_46_3 = 2 * (var_46_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_1.transform.localScale = Vector3.New(var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "L07k" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_4 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_4 + 0.3 and arg_43_1.time_ < var_46_4 + 0.3 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_5 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_6 = 2

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 then
				local var_46_7 = Color.New(0, 0, 0)

				var_46_7.a = Mathf.Lerp(0, 1, (arg_43_1.time_ - var_46_5) / var_46_6)
				arg_43_1.mask_.color = var_46_7
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 then
				local var_46_8 = Color.New(0, 0, 0)

				var_46_8.a = 1
				arg_43_1.mask_.color = var_46_8
			end

			local var_46_9 = 2

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_10 = 1.56666666666667

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_10 then
				local var_46_11 = Color.New(0, 0, 0)

				var_46_11.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_9) / var_46_10)
				arg_43_1.mask_.color = var_46_11
			end

			if arg_43_1.time_ >= var_46_9 + var_46_10 and arg_43_1.time_ < var_46_9 + var_46_10 + arg_46_0 then
				local var_46_12 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_12.a = 0
				arg_43_1.mask_.color = var_46_12
			end

			local var_46_13 = arg_43_1.actors_["1056ui_story"].transform

			if 1.96666666666667 < arg_43_1.time_ and arg_43_1.time_ <= 1.96666666666667 + arg_46_0 then
				arg_43_1.var_.moveOldPos1056ui_story = var_46_13.localPosition
			end

			local var_46_14 = 0.001

			if 1.96666666666667 <= arg_43_1.time_ and arg_43_1.time_ < 1.96666666666667 + var_46_14 then
				var_46_13.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 1.96666666666667) / var_46_14)
				var_46_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_13.position).x, (manager.ui.mainCamera.transform.position - var_46_13.position).y, (manager.ui.mainCamera.transform.position - var_46_13.position).z)
				var_46_13.localEulerAngles.z = 0
				var_46_13.localEulerAngles.x = 0
				var_46_13.localEulerAngles = var_46_13.localEulerAngles
			end

			if arg_43_1.time_ >= 1.96666666666667 + var_46_14 and arg_43_1.time_ < 1.96666666666667 + var_46_14 + arg_46_0 then
				var_46_13.localPosition = Vector3.New(0, 100, 0)
				var_46_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_13.position).x, (manager.ui.mainCamera.transform.position - var_46_13.position).y, (manager.ui.mainCamera.transform.position - var_46_13.position).z)
				var_46_13.localEulerAngles.z = 0
				var_46_13.localEulerAngles.x = 0
				var_46_13.localEulerAngles = var_46_13.localEulerAngles
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_15 = 3.566666666666
			local var_46_16 = 0.975

			if 3.566666666666 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_17 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_17:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1061].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_18 = arg_43_1:GetWordFromCfg(320191010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_21 = 39 <= 0 and var_46_16 or var_46_16 * (utf8.len(var_46_19) / 39)

				if (39 <= 0 and var_46_16 or var_46_16 * (utf8.len(var_46_19) / 39)) > 0 and var_46_16 < var_46_21 then
					arg_43_1.talkMaxDuration = var_46_21
					var_46_15 = var_46_15 + 0.3

					if var_46_21 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_21 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191010", "story_v_out_320191.awb") ~= 0 then
					local var_46_22 = manager.audio:GetVoiceLength("story_v_out_320191", "320191010", "story_v_out_320191.awb") / 1000

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_320191", "320191010", "story_v_out_320191.awb")

						arg_43_1:RecordAudio("320191010", var_46_23)
						arg_43_1:RecordAudio("320191010", var_46_23)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_320191", "320191010", "story_v_out_320191.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_320191", "320191010", "story_v_out_320191.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_24 = var_46_15 + 0.3
			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_24 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_24) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_24 + var_46_25 and arg_43_1.time_ < var_46_24 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play320191011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320191011
		arg_49_1.duration_ = 12.27

		local var_49_0 = {
			zh = 11.466,
			ja = 12.266
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
				arg_49_0:Play320191012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.375

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1061].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(320191011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 55 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 55)

				if (55 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 55)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191011", "story_v_out_320191.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191011", "story_v_out_320191.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_320191", "320191011", "story_v_out_320191.awb")

						arg_49_1:RecordAudio("320191011", var_52_6)
						arg_49_1:RecordAudio("320191011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320191", "320191011", "story_v_out_320191.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320191", "320191011", "story_v_out_320191.awb")
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
	Play320191012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320191012
		arg_53_1.duration_ = 13.6

		local var_53_0 = {
			zh = 12.666,
			ja = 13.6
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
				arg_53_0:Play320191013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1061].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(320191012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 51 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 51)

				if (51 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 51)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191012", "story_v_out_320191.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191012", "story_v_out_320191.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_320191", "320191012", "story_v_out_320191.awb")

						arg_53_1:RecordAudio("320191012", var_56_6)
						arg_53_1:RecordAudio("320191012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320191", "320191012", "story_v_out_320191.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320191", "320191012", "story_v_out_320191.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320191013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320191013
		arg_57_1.duration_ = 12.87

		local var_57_0 = {
			zh = 7.333,
			ja = 12.866
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
				arg_57_0:Play320191014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1061].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(320191013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 34 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 34)

				if (34 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 34)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191013", "story_v_out_320191.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191013", "story_v_out_320191.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_320191", "320191013", "story_v_out_320191.awb")

						arg_57_1:RecordAudio("320191013", var_60_6)
						arg_57_1:RecordAudio("320191013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320191", "320191013", "story_v_out_320191.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320191", "320191013", "story_v_out_320191.awb")
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
	Play320191014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320191014
		arg_61_1.duration_ = 6.73

		local var_61_0 = {
			zh = 3.6,
			ja = 6.733
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
				arg_61_0:Play320191015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.225

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1061].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(320191014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 9 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 9)

				if (9 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 9)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191014", "story_v_out_320191.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191014", "story_v_out_320191.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_320191", "320191014", "story_v_out_320191.awb")

						arg_61_1:RecordAudio("320191014", var_64_6)
						arg_61_1:RecordAudio("320191014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320191", "320191014", "story_v_out_320191.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320191", "320191014", "story_v_out_320191.awb")
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
	Play320191015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320191015
		arg_65_1.duration_ = 15.85

		local var_65_0 = {
			zh = 10.1833333333333,
			ja = 15.8493333333333
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
				arg_65_0:Play320191016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0.666666666666667 < arg_65_1.time_ and arg_65_1.time_ <= 0.666666666666667 + arg_68_0 then
				local var_68_0 = arg_65_1.bgs_.L07k

				arg_65_1.bgs_.L07k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_1 = var_68_0:GetComponent("SpriteRenderer")

				if var_68_1 and var_68_1.sprite then
					local var_68_2 = 2 * (var_68_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_0.transform.localScale = Vector3.New(var_68_2 / var_68_1.sprite.bounds.size.y < var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x and var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x or var_68_2 / var_68_1.sprite.bounds.size.y, var_68_2 / var_68_1.sprite.bounds.size.y < var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x and var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x or var_68_2 / var_68_1.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "L07k" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_3 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_3 + 0.3 and arg_65_1.time_ < var_68_3 + 0.3 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_4 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_5 = 0.733333333333333

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_5 then
				local var_68_6 = Color.New(0, 0, 0)

				var_68_6.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_4) / var_68_5)
				arg_65_1.mask_.color = var_68_6
			end

			if arg_65_1.time_ >= var_68_4 + var_68_5 and arg_65_1.time_ < var_68_4 + var_68_5 + arg_68_0 then
				local var_68_7 = Color.New(0, 0, 0)

				var_68_7.a = 1
				arg_65_1.mask_.color = var_68_7
			end

			local var_68_8 = 0.733333333333333

			if 0.733333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_9 = 2

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 then
				local var_68_10 = Color.New(0, 0, 0)

				var_68_10.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_8) / var_68_9)
				arg_65_1.mask_.color = var_68_10
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 then
				local var_68_11 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_11.a = 0
				arg_65_1.mask_.color = var_68_11
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_12 = 1.68333333333333
			local var_68_13 = 1.05

			if 1.68333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_14 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_14:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1062].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_15 = arg_65_1:GetWordFromCfg(320191015)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 42 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_16) / 42)

				if (42 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_16) / 42)) > 0 and var_68_13 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18
					var_68_12 = var_68_12 + 0.3

					if var_68_18 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191015", "story_v_out_320191.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_320191", "320191015", "story_v_out_320191.awb") / 1000

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_320191", "320191015", "story_v_out_320191.awb")

						arg_65_1:RecordAudio("320191015", var_68_20)
						arg_65_1:RecordAudio("320191015", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320191", "320191015", "story_v_out_320191.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320191", "320191015", "story_v_out_320191.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = var_68_12 + 0.3
			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_21) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320191016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 320191016
		arg_71_1.duration_ = 16.2

		local var_71_0 = {
			zh = 11.666,
			ja = 16.2
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
				arg_71_0:Play320191017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.525

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1062].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(320191016)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 61 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 61)

				if (61 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 61)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191016", "story_v_out_320191.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191016", "story_v_out_320191.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_320191", "320191016", "story_v_out_320191.awb")

						arg_71_1:RecordAudio("320191016", var_74_6)
						arg_71_1:RecordAudio("320191016", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_320191", "320191016", "story_v_out_320191.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_320191", "320191016", "story_v_out_320191.awb")
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
	Play320191017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 320191017
		arg_75_1.duration_ = 13.43

		local var_75_0 = {
			zh = 12.6,
			ja = 13.433
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
				arg_75_0:Play320191018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.625

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1062].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:GetWordFromCfg(320191017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 65 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 65)

				if (65 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 65)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191017", "story_v_out_320191.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191017", "story_v_out_320191.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_320191", "320191017", "story_v_out_320191.awb")

						arg_75_1:RecordAudio("320191017", var_78_6)
						arg_75_1:RecordAudio("320191017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_320191", "320191017", "story_v_out_320191.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_320191", "320191017", "story_v_out_320191.awb")
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
	Play320191018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 320191018
		arg_79_1.duration_ = 15.7

		local var_79_0 = {
			zh = 9.6,
			ja = 15.7
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
				arg_79_0:Play320191019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.175

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1062].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(320191018)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 47 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 47)

				if (47 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 47)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191018", "story_v_out_320191.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191018", "story_v_out_320191.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_320191", "320191018", "story_v_out_320191.awb")

						arg_79_1:RecordAudio("320191018", var_82_6)
						arg_79_1:RecordAudio("320191018", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_320191", "320191018", "story_v_out_320191.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_320191", "320191018", "story_v_out_320191.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play320191019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 320191019
		arg_83_1.duration_ = 9.2

		local var_83_0 = {
			zh = 7.233,
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
				arg_83_0:Play320191020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.725

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1062].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(320191019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 29 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 29)

				if (29 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 29)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191019", "story_v_out_320191.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191019", "story_v_out_320191.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_320191", "320191019", "story_v_out_320191.awb")

						arg_83_1:RecordAudio("320191019", var_86_6)
						arg_83_1:RecordAudio("320191019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_320191", "320191019", "story_v_out_320191.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_320191", "320191019", "story_v_out_320191.awb")
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
	Play320191020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 320191020
		arg_87_1.duration_ = 7.1

		local var_87_0 = {
			zh = 5.199999999999,
			ja = 7.09966666666667
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
				arg_87_0:Play320191021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.L07f == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07f")
				var_90_0.name = "L07f"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.L07f = var_90_0
			end

			if 1.46666666666667 < arg_87_1.time_ and arg_87_1.time_ <= 1.46666666666667 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.L07f

				arg_87_1.bgs_.L07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "L07f" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			if arg_87_1.time_ >= var_90_4 + 0.3 and arg_87_1.time_ < var_90_4 + 0.3 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_5 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_6 = 1.46666666666667

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = Color.New(0, 0, 0)

				var_90_7.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_5) / var_90_6)
				arg_87_1.mask_.color = var_90_7
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 then
				local var_90_8 = Color.New(0, 0, 0)

				var_90_8.a = 1
				arg_87_1.mask_.color = var_90_8
			end

			local var_90_9 = 1.46666666666667

			if 1.46666666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_10 = 1.93333333631357

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_10 then
				local var_90_11 = Color.New(0, 0, 0)

				var_90_11.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_9) / var_90_10)
				arg_87_1.mask_.color = var_90_11
			end

			if arg_87_1.time_ >= var_90_9 + var_90_10 and arg_87_1.time_ < var_90_9 + var_90_10 + arg_90_0 then
				local var_90_12 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_12.a = 0
				arg_87_1.mask_.color = var_90_12
			end

			local var_90_13 = arg_87_1.actors_["1056ui_story"].transform

			if 3.2 < arg_87_1.time_ and arg_87_1.time_ <= 3.2 + arg_90_0 then
				arg_87_1.var_.moveOldPos1056ui_story = var_90_13.localPosition
			end

			local var_90_14 = 0.001

			if 3.2 <= arg_87_1.time_ and arg_87_1.time_ < 3.2 + var_90_14 then
				var_90_13.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_87_1.time_ - 3.2) / var_90_14)
				var_90_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_13.position).x, (manager.ui.mainCamera.transform.position - var_90_13.position).y, (manager.ui.mainCamera.transform.position - var_90_13.position).z)
				var_90_13.localEulerAngles.z = 0
				var_90_13.localEulerAngles.x = 0
				var_90_13.localEulerAngles = var_90_13.localEulerAngles
			end

			if arg_87_1.time_ >= 3.2 + var_90_14 and arg_87_1.time_ < 3.2 + var_90_14 + arg_90_0 then
				var_90_13.localPosition = Vector3.New(0, -1, -5.75)
				var_90_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_13.position).x, (manager.ui.mainCamera.transform.position - var_90_13.position).y, (manager.ui.mainCamera.transform.position - var_90_13.position).z)
				var_90_13.localEulerAngles.z = 0
				var_90_13.localEulerAngles.x = 0
				var_90_13.localEulerAngles = var_90_13.localEulerAngles
			end

			local var_90_15 = arg_87_1.actors_["1056ui_story"]

			if 3.2 < arg_87_1.time_ and arg_87_1.time_ <= 3.2 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1056ui_story == nil then
				arg_87_1.var_.characterEffect1056ui_story = var_90_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_16 = 0.200000002980232

			if 3.2 <= arg_87_1.time_ and arg_87_1.time_ < 3.2 + var_90_16 and not isNil(var_90_15) then
				if arg_87_1.var_.characterEffect1056ui_story and not isNil(var_90_15) then
					arg_87_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 3.2 + var_90_16 and arg_87_1.time_ < 3.2 + var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1056ui_story then
				arg_87_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 3.2 < arg_87_1.time_ and arg_87_1.time_ <= 3.2 + arg_90_0 then
				arg_87_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 3.2 < arg_87_1.time_ and arg_87_1.time_ <= 3.2 + arg_90_0 then
				arg_87_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_18 = 3.46666666666667
			local var_90_19 = 0.225

			if 3.46666666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_20 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_20:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_21 = arg_87_1:GetWordFromCfg(320191020)
				local var_90_22 = arg_87_1:FormatText(var_90_21.content)

				arg_87_1.text_.text = var_90_22

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_24 = 9 <= 0 and var_90_19 or var_90_19 * (utf8.len(var_90_22) / 9)

				if (9 <= 0 and var_90_19 or var_90_19 * (utf8.len(var_90_22) / 9)) > 0 and var_90_19 < var_90_24 then
					arg_87_1.talkMaxDuration = var_90_24
					var_90_18 = var_90_18 + 0.3

					if var_90_24 + var_90_18 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_24 + var_90_18
					end
				end

				arg_87_1.text_.text = var_90_22
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191020", "story_v_out_320191.awb") ~= 0 then
					local var_90_25 = manager.audio:GetVoiceLength("story_v_out_320191", "320191020", "story_v_out_320191.awb") / 1000

					if var_90_25 + var_90_18 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_25 + var_90_18
					end

					if var_90_21.prefab_name ~= "" and arg_87_1.actors_[var_90_21.prefab_name] ~= nil then
						local var_90_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_21.prefab_name].transform, "story_v_out_320191", "320191020", "story_v_out_320191.awb")

						arg_87_1:RecordAudio("320191020", var_90_26)
						arg_87_1:RecordAudio("320191020", var_90_26)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_320191", "320191020", "story_v_out_320191.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_320191", "320191020", "story_v_out_320191.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_27 = var_90_18 + 0.3
			local var_90_28 = math.max(var_90_19, arg_87_1.talkMaxDuration)

			if var_90_18 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_27 + var_90_28 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_27) / var_90_28

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_27 + var_90_28 and arg_87_1.time_ < var_90_27 + var_90_28 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play320191021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320191021
		arg_93_1.duration_ = 1.4

		local var_93_0 = {
			zh = 1.033,
			ja = 1.4
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play320191022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1056ui_story"]) and arg_93_1.var_.characterEffect1056ui_story == nil then
				arg_93_1.var_.characterEffect1056ui_story = arg_93_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1056ui_story"]) then
				if arg_93_1.var_.characterEffect1056ui_story and not isNil(arg_93_1.actors_["1056ui_story"]) then
					arg_93_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1056ui_story"]) and arg_93_1.var_.characterEffect1056ui_story then
				arg_93_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.075

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(320191021)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 3 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 3)

				if (3 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 3)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191021", "story_v_out_320191.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191021", "story_v_out_320191.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_320191", "320191021", "story_v_out_320191.awb")

						arg_93_1:RecordAudio("320191021", var_96_8)
						arg_93_1:RecordAudio("320191021", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320191", "320191021", "story_v_out_320191.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320191", "320191021", "story_v_out_320191.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play320191022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320191022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320191023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.775

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(320191022).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 31 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 31)

				if (31 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 31)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320191023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320191023
		arg_101_1.duration_ = 8.27

		local var_101_0 = {
			zh = 8,
			ja = 8.266
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320191024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(320191023)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 33 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 33)

				if (33 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 33)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191023", "story_v_out_320191.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191023", "story_v_out_320191.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_320191", "320191023", "story_v_out_320191.awb")

						arg_101_1:RecordAudio("320191023", var_104_6)
						arg_101_1:RecordAudio("320191023", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320191", "320191023", "story_v_out_320191.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320191", "320191023", "story_v_out_320191.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320191024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320191024
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320191025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1056ui_story = arg_105_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1056ui_story"].transform.position).z)
				arg_105_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1056ui_story"].transform.localEulerAngles = arg_105_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_105_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1056ui_story"].transform.position).z)
				arg_105_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1056ui_story"].transform.localEulerAngles = arg_105_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1056ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1056ui_story == nil then
				arg_105_1.var_.characterEffect1056ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1056ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1056ui_story then
				arg_105_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.225

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(320191024)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 9 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 9)

				if (9 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 9)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191024", "story_v_out_320191.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191024", "story_v_out_320191.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_320191", "320191024", "story_v_out_320191.awb")

						arg_105_1:RecordAudio("320191024", var_108_11)
						arg_105_1:RecordAudio("320191024", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320191", "320191024", "story_v_out_320191.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320191", "320191024", "story_v_out_320191.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play320191025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320191025
		arg_109_1.duration_ = 12.3

		local var_109_0 = {
			zh = 11,
			ja = 12.3
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
				arg_109_0:Play320191026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1056ui_story"]) and arg_109_1.var_.characterEffect1056ui_story == nil then
				arg_109_1.var_.characterEffect1056ui_story = arg_109_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1056ui_story"]) then
				if arg_109_1.var_.characterEffect1056ui_story and not isNil(arg_109_1.actors_["1056ui_story"]) then
					arg_109_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1056ui_story"]) and arg_109_1.var_.characterEffect1056ui_story then
				arg_109_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 1.275

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(320191025)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 51 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 51)

				if (51 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 51)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191025", "story_v_out_320191.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191025", "story_v_out_320191.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_320191", "320191025", "story_v_out_320191.awb")

						arg_109_1:RecordAudio("320191025", var_112_8)
						arg_109_1:RecordAudio("320191025", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320191", "320191025", "story_v_out_320191.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320191", "320191025", "story_v_out_320191.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320191026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320191026
		arg_113_1.duration_ = 10.7

		local var_113_0 = {
			zh = 7.633,
			ja = 10.7
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
				arg_113_0:Play320191027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.925

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(320191026)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 37 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 37)

				if (37 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 37)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191026", "story_v_out_320191.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191026", "story_v_out_320191.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_320191", "320191026", "story_v_out_320191.awb")

						arg_113_1:RecordAudio("320191026", var_116_6)
						arg_113_1:RecordAudio("320191026", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320191", "320191026", "story_v_out_320191.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320191", "320191026", "story_v_out_320191.awb")
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
	Play320191027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320191027
		arg_117_1.duration_ = 11.47

		local var_117_0 = {
			zh = 10.933,
			ja = 11.466
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
				arg_117_0:Play320191028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.075

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(320191027)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 43 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 43)

				if (43 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 43)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191027", "story_v_out_320191.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191027", "story_v_out_320191.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_320191", "320191027", "story_v_out_320191.awb")

						arg_117_1:RecordAudio("320191027", var_120_6)
						arg_117_1:RecordAudio("320191027", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_320191", "320191027", "story_v_out_320191.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_320191", "320191027", "story_v_out_320191.awb")
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
	Play320191028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320191028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play320191029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1056ui_story = arg_121_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1056ui_story"].transform.position).z)
				arg_121_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1056ui_story"].transform.localEulerAngles = arg_121_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1056ui_story"].transform.position).z)
				arg_121_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1056ui_story"].transform.localEulerAngles = arg_121_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_124_1 = 0
			local var_124_2 = 0.975

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(320191028).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 39 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 39)

				if (39 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 39)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play320191029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320191029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play320191030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.15

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(320191029).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 46 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 46)

				if (46 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 46)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320191030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320191030
		arg_129_1.duration_ = 6.2

		local var_129_0 = {
			zh = 4.266,
			ja = 6.2
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
				arg_129_0:Play320191031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1056ui_story = arg_129_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1056ui_story"].transform.position).z)
				arg_129_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1056ui_story"].transform.localEulerAngles = arg_129_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1056ui_story"].transform.position).z)
				arg_129_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1056ui_story"].transform.localEulerAngles = arg_129_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1056ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1056ui_story == nil then
				arg_129_1.var_.characterEffect1056ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1056ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_2)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1056ui_story then
				arg_129_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_132_3 = 0
			local var_132_4 = 0.5

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1063].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_5 = arg_129_1:GetWordFromCfg(320191030)
				local var_132_6 = arg_129_1:FormatText(var_132_5.content)

				arg_129_1.text_.text = var_132_6

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_8 = 20 <= 0 and var_132_4 or var_132_4 * (utf8.len(var_132_6) / 20)

				if (20 <= 0 and var_132_4 or var_132_4 * (utf8.len(var_132_6) / 20)) > 0 and var_132_4 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_3 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_3
					end
				end

				arg_129_1.text_.text = var_132_6
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191030", "story_v_out_320191.awb") ~= 0 then
					local var_132_9 = manager.audio:GetVoiceLength("story_v_out_320191", "320191030", "story_v_out_320191.awb") / 1000

					if var_132_9 + var_132_3 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_3
					end

					if var_132_5.prefab_name ~= "" and arg_129_1.actors_[var_132_5.prefab_name] ~= nil then
						local var_132_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_5.prefab_name].transform, "story_v_out_320191", "320191030", "story_v_out_320191.awb")

						arg_129_1:RecordAudio("320191030", var_132_10)
						arg_129_1:RecordAudio("320191030", var_132_10)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320191", "320191030", "story_v_out_320191.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320191", "320191030", "story_v_out_320191.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_4, arg_129_1.talkMaxDuration)

			if var_132_3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_3 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_3) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_3 + var_132_11 and arg_129_1.time_ < var_132_3 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play320191031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320191031
		arg_133_1.duration_ = 8.9

		local var_133_0 = {
			zh = 5.966,
			ja = 8.9
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play320191032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(320191031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 23 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 23)

				if (23 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 23)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191031", "story_v_out_320191.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191031", "story_v_out_320191.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_320191", "320191031", "story_v_out_320191.awb")

						arg_133_1:RecordAudio("320191031", var_136_6)
						arg_133_1:RecordAudio("320191031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320191", "320191031", "story_v_out_320191.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320191", "320191031", "story_v_out_320191.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320191032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320191032
		arg_137_1.duration_ = 3.6

		local var_137_0 = {
			zh = 2.833,
			ja = 3.6
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play320191033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.2

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1064].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(320191032)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 8 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 8)

				if (8 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 8)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191032", "story_v_out_320191.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191032", "story_v_out_320191.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_320191", "320191032", "story_v_out_320191.awb")

						arg_137_1:RecordAudio("320191032", var_140_6)
						arg_137_1:RecordAudio("320191032", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320191", "320191032", "story_v_out_320191.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320191", "320191032", "story_v_out_320191.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320191033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320191033
		arg_141_1.duration_ = 5.2

		local var_141_0 = {
			zh = 4.433,
			ja = 5.2
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play320191034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.5

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(320191033)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 20 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 20)

				if (20 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 20)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191033", "story_v_out_320191.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191033", "story_v_out_320191.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_320191", "320191033", "story_v_out_320191.awb")

						arg_141_1:RecordAudio("320191033", var_144_6)
						arg_141_1:RecordAudio("320191033", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320191", "320191033", "story_v_out_320191.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320191", "320191033", "story_v_out_320191.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320191034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320191034
		arg_145_1.duration_ = 6.2

		local var_145_0 = {
			zh = 6.2,
			ja = 5.766
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320191035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.65

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1064].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(320191034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 26 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 26)

				if (26 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 26)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191034", "story_v_out_320191.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191034", "story_v_out_320191.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_320191", "320191034", "story_v_out_320191.awb")

						arg_145_1:RecordAudio("320191034", var_148_6)
						arg_145_1:RecordAudio("320191034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320191", "320191034", "story_v_out_320191.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320191", "320191034", "story_v_out_320191.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320191035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320191035
		arg_149_1.duration_ = 12.47

		local var_149_0 = {
			zh = 10.766,
			ja = 12.466
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320191036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.325

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1064].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(320191035)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 53 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 53)

				if (53 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 53)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191035", "story_v_out_320191.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191035", "story_v_out_320191.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_320191", "320191035", "story_v_out_320191.awb")

						arg_149_1:RecordAudio("320191035", var_152_6)
						arg_149_1:RecordAudio("320191035", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320191", "320191035", "story_v_out_320191.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320191", "320191035", "story_v_out_320191.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320191036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320191036
		arg_153_1.duration_ = 4.6

		local var_153_0 = {
			zh = 3.933,
			ja = 4.6
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play320191037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.425

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1064].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(320191036)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 17 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 17)

				if (17 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 17)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191036", "story_v_out_320191.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191036", "story_v_out_320191.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_320191", "320191036", "story_v_out_320191.awb")

						arg_153_1:RecordAudio("320191036", var_156_6)
						arg_153_1:RecordAudio("320191036", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320191", "320191036", "story_v_out_320191.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320191", "320191036", "story_v_out_320191.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320191037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320191037
		arg_157_1.duration_ = 1.2

		local var_157_0 = {
			zh = 0.999999999999,
			ja = 1.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320191038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.05

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(320191037)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 2 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 2)

				if (2 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 2)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191037", "story_v_out_320191.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191037", "story_v_out_320191.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_320191", "320191037", "story_v_out_320191.awb")

						arg_157_1:RecordAudio("320191037", var_160_6)
						arg_157_1:RecordAudio("320191037", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320191", "320191037", "story_v_out_320191.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320191", "320191037", "story_v_out_320191.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320191038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320191038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play320191039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.975

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(320191038).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 39 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 39)

				if (39 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 39)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320191039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320191039
		arg_165_1.duration_ = 6.2

		local var_165_0 = {
			zh = 4.766,
			ja = 6.2
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
				arg_165_0:Play320191040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.375

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1064].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(320191039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 15 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 15)

				if (15 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 15)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191039", "story_v_out_320191.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191039", "story_v_out_320191.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_320191", "320191039", "story_v_out_320191.awb")

						arg_165_1:RecordAudio("320191039", var_168_6)
						arg_165_1:RecordAudio("320191039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320191", "320191039", "story_v_out_320191.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320191", "320191039", "story_v_out_320191.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play320191040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320191040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play320191041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.35

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(320191040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 54 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 54)

				if (54 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 54)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320191041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320191041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320191042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.5

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

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(320191041).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 20 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 20)

				if (20 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 20)) > 0 and var_176_0 < var_176_3 then
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
	Play320191042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320191042
		arg_177_1.duration_ = 2

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play320191043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1056ui_story = arg_177_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1056ui_story"].transform.position).z)
				arg_177_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1056ui_story"].transform.localEulerAngles = arg_177_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_177_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1056ui_story"].transform.position).z)
				arg_177_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1056ui_story"].transform.localEulerAngles = arg_177_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1056ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1056ui_story == nil then
				arg_177_1.var_.characterEffect1056ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1056ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1056ui_story then
				arg_177_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(320191042)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 4 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 4)

				if (4 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 4)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191042", "story_v_out_320191.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191042", "story_v_out_320191.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_320191", "320191042", "story_v_out_320191.awb")

						arg_177_1:RecordAudio("320191042", var_180_11)
						arg_177_1:RecordAudio("320191042", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320191", "320191042", "story_v_out_320191.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320191", "320191042", "story_v_out_320191.awb")
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
				actorName = "1056ui_story",
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
	Play320191043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320191043
		arg_181_1.duration_ = 9.63

		local var_181_0 = {
			zh = 9.633,
			ja = 9.3
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
				arg_181_0:Play320191044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1056ui_story"]) and arg_181_1.var_.characterEffect1056ui_story == nil then
				arg_181_1.var_.characterEffect1056ui_story = arg_181_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1056ui_story"]) then
				if arg_181_1.var_.characterEffect1056ui_story and not isNil(arg_181_1.actors_["1056ui_story"]) then
					arg_181_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1056ui_story"]) and arg_181_1.var_.characterEffect1056ui_story then
				arg_181_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.925

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(320191043)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 37 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_4) / 37)

				if (37 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_4) / 37)) > 0 and var_184_2 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191043", "story_v_out_320191.awb") ~= 0 then
					local var_184_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191043", "story_v_out_320191.awb") / 1000

					if var_184_7 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_1
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_320191", "320191043", "story_v_out_320191.awb")

						arg_181_1:RecordAudio("320191043", var_184_8)
						arg_181_1:RecordAudio("320191043", var_184_8)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320191", "320191043", "story_v_out_320191.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320191", "320191043", "story_v_out_320191.awb")
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
	Play320191044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320191044
		arg_185_1.duration_ = 8.07

		local var_185_0 = {
			zh = 6,
			ja = 8.066
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
				arg_185_0:Play320191045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1056ui_story"]) and arg_185_1.var_.characterEffect1056ui_story == nil then
				arg_185_1.var_.characterEffect1056ui_story = arg_185_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1056ui_story"]) then
				if arg_185_1.var_.characterEffect1056ui_story and not isNil(arg_185_1.actors_["1056ui_story"]) then
					arg_185_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1056ui_story"]) and arg_185_1.var_.characterEffect1056ui_story then
				arg_185_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_188_2 = 0
			local var_188_3 = 0.75

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(320191044)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 30 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 30)

				if (30 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 30)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191044", "story_v_out_320191.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191044", "story_v_out_320191.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_320191", "320191044", "story_v_out_320191.awb")

						arg_185_1:RecordAudio("320191044", var_188_9)
						arg_185_1:RecordAudio("320191044", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320191", "320191044", "story_v_out_320191.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320191", "320191044", "story_v_out_320191.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play320191045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320191045
		arg_189_1.duration_ = 12.37

		local var_189_0 = {
			zh = 7.933,
			ja = 12.366
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
				arg_189_0:Play320191046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.95

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(320191045)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 38 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 38)

				if (38 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 38)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191045", "story_v_out_320191.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191045", "story_v_out_320191.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_320191", "320191045", "story_v_out_320191.awb")

						arg_189_1:RecordAudio("320191045", var_192_6)
						arg_189_1:RecordAudio("320191045", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320191", "320191045", "story_v_out_320191.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320191", "320191045", "story_v_out_320191.awb")
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
	Play320191046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320191046
		arg_193_1.duration_ = 9.77

		local var_193_0 = {
			zh = 6.333,
			ja = 9.766
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
				arg_193_0:Play320191047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1056ui_story"]) and arg_193_1.var_.characterEffect1056ui_story == nil then
				arg_193_1.var_.characterEffect1056ui_story = arg_193_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1056ui_story"]) then
				if arg_193_1.var_.characterEffect1056ui_story and not isNil(arg_193_1.actors_["1056ui_story"]) then
					arg_193_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1056ui_story"]) and arg_193_1.var_.characterEffect1056ui_story then
				arg_193_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.775

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(320191046)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 31 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_4) / 31)

				if (31 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_4) / 31)) > 0 and var_196_2 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191046", "story_v_out_320191.awb") ~= 0 then
					local var_196_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191046", "story_v_out_320191.awb") / 1000

					if var_196_7 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_1
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_320191", "320191046", "story_v_out_320191.awb")

						arg_193_1:RecordAudio("320191046", var_196_8)
						arg_193_1:RecordAudio("320191046", var_196_8)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320191", "320191046", "story_v_out_320191.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320191", "320191046", "story_v_out_320191.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_9 and arg_193_1.time_ < var_196_1 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320191047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320191047
		arg_197_1.duration_ = 9.23

		local var_197_0 = {
			zh = 4.866,
			ja = 9.233
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
				arg_197_0:Play320191048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1056ui_story"]) and arg_197_1.var_.characterEffect1056ui_story == nil then
				arg_197_1.var_.characterEffect1056ui_story = arg_197_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1056ui_story"]) then
				if arg_197_1.var_.characterEffect1056ui_story and not isNil(arg_197_1.actors_["1056ui_story"]) then
					arg_197_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1056ui_story"]) and arg_197_1.var_.characterEffect1056ui_story then
				arg_197_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_200_2 = 0
			local var_200_3 = 0.6

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(320191047)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 24 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 24)

				if (24 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 24)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191047", "story_v_out_320191.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191047", "story_v_out_320191.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_320191", "320191047", "story_v_out_320191.awb")

						arg_197_1:RecordAudio("320191047", var_200_9)
						arg_197_1:RecordAudio("320191047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320191", "320191047", "story_v_out_320191.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320191", "320191047", "story_v_out_320191.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play320191048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320191048
		arg_201_1.duration_ = 4.7

		local var_201_0 = {
			zh = 2.7,
			ja = 4.7
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
				arg_201_0:Play320191049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.45

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(320191048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 18 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 18)

				if (18 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 18)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191048", "story_v_out_320191.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191048", "story_v_out_320191.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_320191", "320191048", "story_v_out_320191.awb")

						arg_201_1:RecordAudio("320191048", var_204_6)
						arg_201_1:RecordAudio("320191048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320191", "320191048", "story_v_out_320191.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320191", "320191048", "story_v_out_320191.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play320191049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320191049
		arg_205_1.duration_ = 8.83

		local var_205_0 = {
			zh = 8.366,
			ja = 8.833
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
				arg_205_0:Play320191050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1056ui_story"]) and arg_205_1.var_.characterEffect1056ui_story == nil then
				arg_205_1.var_.characterEffect1056ui_story = arg_205_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1056ui_story"]) then
				if arg_205_1.var_.characterEffect1056ui_story and not isNil(arg_205_1.actors_["1056ui_story"]) then
					arg_205_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1056ui_story"]) and arg_205_1.var_.characterEffect1056ui_story then
				arg_205_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.7

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(320191049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 28 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_4) / 28)

				if (28 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_4) / 28)) > 0 and var_208_2 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191049", "story_v_out_320191.awb") ~= 0 then
					local var_208_7 = manager.audio:GetVoiceLength("story_v_out_320191", "320191049", "story_v_out_320191.awb") / 1000

					if var_208_7 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_1
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_320191", "320191049", "story_v_out_320191.awb")

						arg_205_1:RecordAudio("320191049", var_208_8)
						arg_205_1:RecordAudio("320191049", var_208_8)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320191", "320191049", "story_v_out_320191.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320191", "320191049", "story_v_out_320191.awb")
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
	Play320191050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320191050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play320191051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1056ui_story = arg_209_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1056ui_story"].transform.position).z)
				arg_209_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1056ui_story"].transform.localEulerAngles = arg_209_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1056ui_story"].transform.position).z)
				arg_209_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1056ui_story"].transform.localEulerAngles = arg_209_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_blast_loop", "")
			end

			local var_212_2 = 0
			local var_212_3 = 1.925

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(320191050).content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 77 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 77)

				if (77 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 77)) > 0 and var_212_3 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_7 and arg_209_1.time_ < var_212_2 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320191051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320191051
		arg_213_1.duration_ = 1.67

		local var_213_0 = {
			zh = 1.666,
			ja = 1.4
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
				arg_213_0:Play320191052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.2

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(320191051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 8 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 8)

				if (8 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 8)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191051", "story_v_out_320191.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191051", "story_v_out_320191.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_320191", "320191051", "story_v_out_320191.awb")

						arg_213_1:RecordAudio("320191051", var_216_6)
						arg_213_1:RecordAudio("320191051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320191", "320191051", "story_v_out_320191.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320191", "320191051", "story_v_out_320191.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320191052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320191052
		arg_217_1.duration_ = 3.1

		local var_217_0 = {
			zh = 3.1,
			ja = 2.833
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play320191053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.425

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(320191052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 17 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 17)

				if (17 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 17)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191052", "story_v_out_320191.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191052", "story_v_out_320191.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_320191", "320191052", "story_v_out_320191.awb")

						arg_217_1:RecordAudio("320191052", var_220_6)
						arg_217_1:RecordAudio("320191052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320191", "320191052", "story_v_out_320191.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320191", "320191052", "story_v_out_320191.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play320191053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320191053
		arg_221_1.duration_ = 3.47

		local var_221_0 = {
			zh = 1.3,
			ja = 3.466
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
				arg_221_0:Play320191054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.175

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(320191053)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 7 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 7)

				if (7 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 7)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191053", "story_v_out_320191.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191053", "story_v_out_320191.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_320191", "320191053", "story_v_out_320191.awb")

						arg_221_1:RecordAudio("320191053", var_224_6)
						arg_221_1:RecordAudio("320191053", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320191", "320191053", "story_v_out_320191.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320191", "320191053", "story_v_out_320191.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320191054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320191054
		arg_225_1.duration_ = 6.77

		local var_225_0 = {
			zh = 6.766,
			ja = 4.6
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
				arg_225_0:Play320191055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.875

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(320191054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 35 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 35)

				if (35 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 35)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191054", "story_v_out_320191.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191054", "story_v_out_320191.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_320191", "320191054", "story_v_out_320191.awb")

						arg_225_1:RecordAudio("320191054", var_228_6)
						arg_225_1:RecordAudio("320191054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_320191", "320191054", "story_v_out_320191.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_320191", "320191054", "story_v_out_320191.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320191055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320191055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play320191056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.175

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

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(320191055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 47 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 47)

				if (47 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 47)) > 0 and var_232_0 < var_232_3 then
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
	Play320191056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320191056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320191057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_engine", "")
			end

			local var_236_1 = 0
			local var_236_2 = 0.975

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(320191056).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 39 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 39)

				if (39 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 39)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play320191057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320191057
		arg_237_1.duration_ = 10.1

		local var_237_0 = {
			zh = 7.166,
			ja = 10.1
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play320191058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.bgs_.L02f == nil then
				local var_240_0 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_240_0.name = "L02f"
				var_240_0.transform.parent = arg_237_1.stage_.transform
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_.L02f = var_240_0
			end

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= 2 + arg_240_0 then
				local var_240_1 = arg_237_1.bgs_.L02f

				arg_237_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_240_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_2 = var_240_1:GetComponent("SpriteRenderer")

				if var_240_2 and var_240_2.sprite then
					local var_240_3 = 2 * (var_240_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_240_1.transform.localScale = Vector3.New(var_240_3 / var_240_2.sprite.bounds.size.y < var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x and var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x or var_240_3 / var_240_2.sprite.bounds.size.y, var_240_3 / var_240_2.sprite.bounds.size.y < var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x and var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x or var_240_3 / var_240_2.sprite.bounds.size.y, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "L02f" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_4 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			if arg_237_1.time_ >= var_240_4 + 0.3 and arg_237_1.time_ < var_240_4 + 0.3 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_5 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_6 = 2

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_6 then
				local var_240_7 = Color.New(0, 0, 0)

				var_240_7.a = Mathf.Lerp(0, 1, (arg_237_1.time_ - var_240_5) / var_240_6)
				arg_237_1.mask_.color = var_240_7
			end

			if arg_237_1.time_ >= var_240_5 + var_240_6 and arg_237_1.time_ < var_240_5 + var_240_6 + arg_240_0 then
				local var_240_8 = Color.New(0, 0, 0)

				var_240_8.a = 1
				arg_237_1.mask_.color = var_240_8
			end

			local var_240_9 = 2

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_10 = 2

			if var_240_9 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_10 then
				local var_240_11 = Color.New(0, 0, 0)

				var_240_11.a = Mathf.Lerp(1, 0, (arg_237_1.time_ - var_240_9) / var_240_10)
				arg_237_1.mask_.color = var_240_11
			end

			if arg_237_1.time_ >= var_240_9 + var_240_10 and arg_237_1.time_ < var_240_9 + var_240_10 + arg_240_0 then
				local var_240_12 = Color.New(0, 0, 0)

				arg_237_1.mask_.enabled = false
				var_240_12.a = 0
				arg_237_1.mask_.color = var_240_12
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_240_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_237_1.bgmTxt_.text ~= var_240_15 and arg_237_1.bgmTxt_.text ~= "" then
						if arg_237_1.bgmTxt2_.text ~= "" then
							arg_237_1.bgmTxt_.text = arg_237_1.bgmTxt2_.text
						end

						arg_237_1.bgmTxt2_.text = var_240_15

						arg_237_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_237_1.bgmTxt_.text = var_240_15
						arg_237_1.bgmTxt2_.text = var_240_15
					end

					if arg_237_1.bgmTimer then
						arg_237_1.bgmTimer:Stop()

						arg_237_1.bgmTimer = nil
					end

					if arg_237_1.settingData.show_music_name == 1 then
						arg_237_1.musicController:SetSelectedState("show")
						arg_237_1.musicAnimator_:Play("open", 0, 0)

						if arg_237_1.settingData.music_time ~= 0 then
							arg_237_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_237_1.settingData.music_time), function()
								if arg_237_1 == nil or isNil(arg_237_1.bgmTxt_) then
									return
								end

								arg_237_1.musicController:SetSelectedState("hide")
								arg_237_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.3 < arg_237_1.time_ and arg_237_1.time_ <= 1.3 + arg_240_0 then
				arg_237_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_240_18 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_237_1.bgmTxt_.text ~= var_240_18 and arg_237_1.bgmTxt_.text ~= "" then
						if arg_237_1.bgmTxt2_.text ~= "" then
							arg_237_1.bgmTxt_.text = arg_237_1.bgmTxt2_.text
						end

						arg_237_1.bgmTxt2_.text = var_240_18

						arg_237_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_237_1.bgmTxt_.text = var_240_18
						arg_237_1.bgmTxt2_.text = var_240_18
					end

					if arg_237_1.bgmTimer then
						arg_237_1.bgmTimer:Stop()

						arg_237_1.bgmTimer = nil
					end

					if arg_237_1.settingData.show_music_name == 1 then
						arg_237_1.musicController:SetSelectedState("show")
						arg_237_1.musicAnimator_:Play("open", 0, 0)

						if arg_237_1.settingData.music_time ~= 0 then
							arg_237_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_237_1.settingData.music_time), function()
								if arg_237_1 == nil or isNil(arg_237_1.bgmTxt_) then
									return
								end

								arg_237_1.musicController:SetSelectedState("hide")
								arg_237_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:AudioAction("stop", "effect", "se_story_1210", "se_story_1210_blast_loop", "")
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_20 = 4
			local var_240_21 = 0.25

			if 4 < arg_237_1.time_ and arg_237_1.time_ <= var_240_20 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_22 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_22:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_237_1.dialogCg_.alpha = arg_243_0
				end))
				var_240_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_23 = arg_237_1:GetWordFromCfg(320191057)
				local var_240_24 = arg_237_1:FormatText(var_240_23.content)

				arg_237_1.text_.text = var_240_24

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_26 = 10 <= 0 and var_240_21 or var_240_21 * (utf8.len(var_240_24) / 10)

				if (10 <= 0 and var_240_21 or var_240_21 * (utf8.len(var_240_24) / 10)) > 0 and var_240_21 < var_240_26 then
					arg_237_1.talkMaxDuration = var_240_26
					var_240_20 = var_240_20 + 0.3

					if var_240_26 + var_240_20 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_26 + var_240_20
					end
				end

				arg_237_1.text_.text = var_240_24
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191057", "story_v_out_320191.awb") ~= 0 then
					local var_240_27 = manager.audio:GetVoiceLength("story_v_out_320191", "320191057", "story_v_out_320191.awb") / 1000

					if var_240_27 + var_240_20 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_27 + var_240_20
					end

					if var_240_23.prefab_name ~= "" and arg_237_1.actors_[var_240_23.prefab_name] ~= nil then
						local var_240_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_23.prefab_name].transform, "story_v_out_320191", "320191057", "story_v_out_320191.awb")

						arg_237_1:RecordAudio("320191057", var_240_28)
						arg_237_1:RecordAudio("320191057", var_240_28)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320191", "320191057", "story_v_out_320191.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320191", "320191057", "story_v_out_320191.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_29 = var_240_20 + 0.3
			local var_240_30 = math.max(var_240_21, arg_237_1.talkMaxDuration)

			if var_240_20 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_29 + var_240_30 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_29) / var_240_30

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_29 + var_240_30 and arg_237_1.time_ < var_240_29 + var_240_30 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320191058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320191058
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320191059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.225

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

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(320191058).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 49 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 49)

				if (49 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 49)) > 0 and var_248_0 < var_248_3 then
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
	Play320191059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320191059
		arg_249_1.duration_ = 9.87

		local var_249_0 = {
			zh = 8.433,
			ja = 9.866
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
				arg_249_0:Play320191060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if arg_249_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_252_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_249_1.stage_.transform)

				var_252_0.name = "1156ui_story"
				var_252_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["1156ui_story"] = var_252_0

				local var_252_1 = var_252_0:GetComponentInChildren(typeof(CharacterEffect))

				var_252_1.enabled = true

				local var_252_2 = GameObjectTools.GetOrAddComponent(var_252_0, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(false)
				end

				arg_249_1:ShowWeapon(var_252_1.transform, false)

				arg_249_1.var_["1156ui_story" .. "Animator"] = var_252_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_249_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_249_1.var_["1156ui_story" .. "LipSync"] = var_252_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_252_3 = arg_249_1.actors_["1156ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1156ui_story = var_252_3.localPosition
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_3.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_249_1.time_ - 0) / var_252_4)
				var_252_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_3.position).x, (manager.ui.mainCamera.transform.position - var_252_3.position).y, (manager.ui.mainCamera.transform.position - var_252_3.position).z)
				var_252_3.localEulerAngles.z = 0
				var_252_3.localEulerAngles.x = 0
				var_252_3.localEulerAngles = var_252_3.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_3.localPosition = Vector3.New(0, -1.1, -6.18)
				var_252_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_3.position).x, (manager.ui.mainCamera.transform.position - var_252_3.position).y, (manager.ui.mainCamera.transform.position - var_252_3.position).z)
				var_252_3.localEulerAngles.z = 0
				var_252_3.localEulerAngles.x = 0
				var_252_3.localEulerAngles = var_252_3.localEulerAngles
			end

			local var_252_5 = arg_249_1.actors_["1156ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1156ui_story == nil then
				arg_249_1.var_.characterEffect1156ui_story = var_252_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_6 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.characterEffect1156ui_story and not isNil(var_252_5) then
					arg_249_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1156ui_story then
				arg_249_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0.034000001847744 < arg_249_1.time_ and arg_249_1.time_ <= 0.034000001847744 + arg_252_0 then
				arg_249_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			if 0.034000001847744 < arg_249_1.time_ and arg_249_1.time_ <= 0.034000001847744 + arg_252_0 then
				arg_249_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_252_8 = 0
			local var_252_9 = 0.9

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(320191059)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 36 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 36)

				if (36 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 36)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191059", "story_v_out_320191.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_320191", "320191059", "story_v_out_320191.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_320191", "320191059", "story_v_out_320191.awb")

						arg_249_1:RecordAudio("320191059", var_252_15)
						arg_249_1:RecordAudio("320191059", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320191", "320191059", "story_v_out_320191.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320191", "320191059", "story_v_out_320191.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play320191060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320191060
		arg_253_1.duration_ = 4.7

		local var_253_0 = {
			zh = 4.7,
			ja = 4
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
				arg_253_0:Play320191061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.475

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(320191060)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 19 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 19)

				if (19 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 19)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191060", "story_v_out_320191.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191060", "story_v_out_320191.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_320191", "320191060", "story_v_out_320191.awb")

						arg_253_1:RecordAudio("320191060", var_256_6)
						arg_253_1:RecordAudio("320191060", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_320191", "320191060", "story_v_out_320191.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_320191", "320191060", "story_v_out_320191.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play320191061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320191061
		arg_257_1.duration_ = 2.47

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320191062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 1.33333333333333 < arg_257_1.time_ and arg_257_1.time_ <= 1.33333333333333 + arg_260_0 then
				arg_257_1:AudioAction("play", "effect", "se_story_134_02", "se_story_134_02_leaf", "")
			end

			if 0.034000001847744 < arg_257_1.time_ and arg_257_1.time_ <= 0.034000001847744 + arg_260_0 then
				arg_257_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_2")
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_1 = 0.6
			local var_260_2 = 0.175

			if 0.6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_3 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_3:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(320191061)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 7 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_5) / 7)

				if (7 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_5) / 7)) > 0 and var_260_2 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7
					var_260_1 = var_260_1 + 0.3

					if var_260_7 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191061", "story_v_out_320191.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191061", "story_v_out_320191.awb") / 1000

					if var_260_8 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_1
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_320191", "320191061", "story_v_out_320191.awb")

						arg_257_1:RecordAudio("320191061", var_260_9)
						arg_257_1:RecordAudio("320191061", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320191", "320191061", "story_v_out_320191.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320191", "320191061", "story_v_out_320191.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = var_260_1 + 0.3
			local var_260_11 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_10) / var_260_11

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play320191062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 320191062
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play320191063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1156ui_story = arg_263_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).z)
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles = arg_263_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).z)
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles = arg_263_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_266_1 = 0
			local var_266_2 = 1.125

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

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(320191062).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 45 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 45)

				if (45 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 45)) > 0 and var_266_2 < var_266_5 then
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play320191063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 320191063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play320191064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.075

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

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(320191063).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 43 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 43)

				if (43 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 43)) > 0 and var_270_0 < var_270_3 then
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
	Play320191064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 320191064
		arg_271_1.duration_ = 9.83

		local var_271_0 = {
			zh = 9.833,
			ja = 9.533
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
				arg_271_0:Play320191065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1156ui_story"]) and arg_271_1.var_.characterEffect1156ui_story == nil then
				arg_271_1.var_.characterEffect1156ui_story = arg_271_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1156ui_story"]) then
				if arg_271_1.var_.characterEffect1156ui_story and not isNil(arg_271_1.actors_["1156ui_story"]) then
					arg_271_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1156ui_story"]) and arg_271_1.var_.characterEffect1156ui_story then
				arg_271_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_274_2 = arg_271_1.actors_["1156ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1156ui_story = var_274_2.localPosition
			end

			local var_274_3 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 then
				var_274_2.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_271_1.time_ - 0) / var_274_3)
				var_274_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_2.position).x, (manager.ui.mainCamera.transform.position - var_274_2.position).y, (manager.ui.mainCamera.transform.position - var_274_2.position).z)
				var_274_2.localEulerAngles.z = 0
				var_274_2.localEulerAngles.x = 0
				var_274_2.localEulerAngles = var_274_2.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 then
				var_274_2.localPosition = Vector3.New(0, -1.1, -6.18)
				var_274_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_2.position).x, (manager.ui.mainCamera.transform.position - var_274_2.position).y, (manager.ui.mainCamera.transform.position - var_274_2.position).z)
				var_274_2.localEulerAngles.z = 0
				var_274_2.localEulerAngles.x = 0
				var_274_2.localEulerAngles = var_274_2.localEulerAngles
			end

			local var_274_4 = 0
			local var_274_5 = 0.825

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(320191064)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 33 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 33)

				if (33 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 33)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191064", "story_v_out_320191.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191064", "story_v_out_320191.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_320191", "320191064", "story_v_out_320191.awb")

						arg_271_1:RecordAudio("320191064", var_274_11)
						arg_271_1:RecordAudio("320191064", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_320191", "320191064", "story_v_out_320191.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_320191", "320191064", "story_v_out_320191.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play320191065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 320191065
		arg_275_1.duration_ = 1.53

		local var_275_0 = {
			zh = 1.533,
			ja = 1.333
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play320191066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.1

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(320191065)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 4 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 4)

				if (4 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 4)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191065", "story_v_out_320191.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191065", "story_v_out_320191.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_320191", "320191065", "story_v_out_320191.awb")

						arg_275_1:RecordAudio("320191065", var_278_6)
						arg_275_1:RecordAudio("320191065", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_320191", "320191065", "story_v_out_320191.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_320191", "320191065", "story_v_out_320191.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play320191066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 320191066
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play320191067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1156ui_story = arg_279_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1156ui_story"].transform.position).z)
				arg_279_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1156ui_story"].transform.localEulerAngles = arg_279_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1156ui_story"].transform.position).z)
				arg_279_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1156ui_story"].transform.localEulerAngles = arg_279_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_282_1 = 0
			local var_282_2 = 0.95

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(320191066).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 38 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 38)

				if (38 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 38)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play320191067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 320191067
		arg_283_1.duration_ = 2

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play320191068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1156ui_story"]) and arg_283_1.var_.characterEffect1156ui_story == nil then
				arg_283_1.var_.characterEffect1156ui_story = arg_283_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1156ui_story"]) then
				if arg_283_1.var_.characterEffect1156ui_story and not isNil(arg_283_1.actors_["1156ui_story"]) then
					arg_283_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1156ui_story"]) and arg_283_1.var_.characterEffect1156ui_story then
				arg_283_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_286_2 = arg_283_1.actors_["1156ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1156ui_story = var_286_2.localPosition
			end

			local var_286_3 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 then
				var_286_2.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_283_1.time_ - 0) / var_286_3)
				var_286_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_2.position).x, (manager.ui.mainCamera.transform.position - var_286_2.position).y, (manager.ui.mainCamera.transform.position - var_286_2.position).z)
				var_286_2.localEulerAngles.z = 0
				var_286_2.localEulerAngles.x = 0
				var_286_2.localEulerAngles = var_286_2.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 then
				var_286_2.localPosition = Vector3.New(0, -1.1, -6.18)
				var_286_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_2.position).x, (manager.ui.mainCamera.transform.position - var_286_2.position).y, (manager.ui.mainCamera.transform.position - var_286_2.position).z)
				var_286_2.localEulerAngles.z = 0
				var_286_2.localEulerAngles.x = 0
				var_286_2.localEulerAngles = var_286_2.localEulerAngles
			end

			local var_286_4 = 0
			local var_286_5 = 0.175

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(320191067)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 7 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 7)

				if (7 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 7)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191067", "story_v_out_320191.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191067", "story_v_out_320191.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_320191", "320191067", "story_v_out_320191.awb")

						arg_283_1:RecordAudio("320191067", var_286_11)
						arg_283_1:RecordAudio("320191067", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_320191", "320191067", "story_v_out_320191.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_320191", "320191067", "story_v_out_320191.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play320191068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 320191068
		arg_287_1.duration_ = 17.37

		local var_287_0 = {
			zh = 15.566,
			ja = 17.366
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play320191069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if arg_287_1.bgs_.ST61 == nil then
				local var_290_0 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_290_0.name = "ST61"
				var_290_0.transform.parent = arg_287_1.stage_.transform
				var_290_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_.ST61 = var_290_0
			end

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= 2 + arg_290_0 then
				local var_290_1 = arg_287_1.bgs_.ST61

				arg_287_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_2 = var_290_1:GetComponent("SpriteRenderer")

				if var_290_2 and var_290_2.sprite then
					local var_290_3 = 2 * (var_290_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_1.transform.localScale = Vector3.New(var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "ST61" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_4 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			if arg_287_1.time_ >= var_290_4 + 0.3 and arg_287_1.time_ < var_290_4 + 0.3 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			local var_290_5 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_6 = 2

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_6 then
				local var_290_7 = Color.New(0, 0, 0)

				var_290_7.a = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_5) / var_290_6)
				arg_287_1.mask_.color = var_290_7
			end

			if arg_287_1.time_ >= var_290_5 + var_290_6 and arg_287_1.time_ < var_290_5 + var_290_6 + arg_290_0 then
				local var_290_8 = Color.New(0, 0, 0)

				var_290_8.a = 1
				arg_287_1.mask_.color = var_290_8
			end

			local var_290_9 = 2

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_10 = 1.5

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 then
				local var_290_11 = Color.New(0, 0, 0)

				var_290_11.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_9) / var_290_10)
				arg_287_1.mask_.color = var_290_11
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 then
				local var_290_12 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_12.a = 0
				arg_287_1.mask_.color = var_290_12
			end

			local var_290_13 = arg_287_1.actors_["1156ui_story"].transform

			if 1.96666666666667 < arg_287_1.time_ and arg_287_1.time_ <= 1.96666666666667 + arg_290_0 then
				arg_287_1.var_.moveOldPos1156ui_story = var_290_13.localPosition
			end

			local var_290_14 = 0.001

			if 1.96666666666667 <= arg_287_1.time_ and arg_287_1.time_ < 1.96666666666667 + var_290_14 then
				var_290_13.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 1.96666666666667) / var_290_14)
				var_290_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_13.position).x, (manager.ui.mainCamera.transform.position - var_290_13.position).y, (manager.ui.mainCamera.transform.position - var_290_13.position).z)
				var_290_13.localEulerAngles.z = 0
				var_290_13.localEulerAngles.x = 0
				var_290_13.localEulerAngles = var_290_13.localEulerAngles
			end

			if arg_287_1.time_ >= 1.96666666666667 + var_290_14 and arg_287_1.time_ < 1.96666666666667 + var_290_14 + arg_290_0 then
				var_290_13.localPosition = Vector3.New(0, 100, 0)
				var_290_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_13.position).x, (manager.ui.mainCamera.transform.position - var_290_13.position).y, (manager.ui.mainCamera.transform.position - var_290_13.position).z)
				var_290_13.localEulerAngles.z = 0
				var_290_13.localEulerAngles.x = 0
				var_290_13.localEulerAngles = var_290_13.localEulerAngles
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_290_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_17 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_17

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_17
						arg_287_1.bgmTxt2_.text = var_290_17
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.3 < arg_287_1.time_ and arg_287_1.time_ <= 1.3 + arg_290_0 then
				arg_287_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_290_20 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_20 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_20

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_20
						arg_287_1.bgmTxt2_.text = var_290_20
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_21 = 3.5
			local var_290_22 = 1.55

			if 3.5 < arg_287_1.time_ and arg_287_1.time_ <= var_290_21 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_23 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_23:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_287_1.dialogCg_.alpha = arg_293_0
				end))
				var_290_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_24 = arg_287_1:GetWordFromCfg(320191068)
				local var_290_25 = arg_287_1:FormatText(var_290_24.content)

				arg_287_1.text_.text = var_290_25

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_27 = 62 <= 0 and var_290_22 or var_290_22 * (utf8.len(var_290_25) / 62)

				if (62 <= 0 and var_290_22 or var_290_22 * (utf8.len(var_290_25) / 62)) > 0 and var_290_22 < var_290_27 then
					arg_287_1.talkMaxDuration = var_290_27
					var_290_21 = var_290_21 + 0.3

					if var_290_27 + var_290_21 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_27 + var_290_21
					end
				end

				arg_287_1.text_.text = var_290_25
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191068", "story_v_out_320191.awb") ~= 0 then
					local var_290_28 = manager.audio:GetVoiceLength("story_v_out_320191", "320191068", "story_v_out_320191.awb") / 1000

					if var_290_28 + var_290_21 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_28 + var_290_21
					end

					if var_290_24.prefab_name ~= "" and arg_287_1.actors_[var_290_24.prefab_name] ~= nil then
						local var_290_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_24.prefab_name].transform, "story_v_out_320191", "320191068", "story_v_out_320191.awb")

						arg_287_1:RecordAudio("320191068", var_290_29)
						arg_287_1:RecordAudio("320191068", var_290_29)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_320191", "320191068", "story_v_out_320191.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_320191", "320191068", "story_v_out_320191.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_30 = var_290_21 + 0.3
			local var_290_31 = math.max(var_290_22, arg_287_1.talkMaxDuration)

			if var_290_21 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_30 + var_290_31 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_30) / var_290_31

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_30 + var_290_31 and arg_287_1.time_ < var_290_30 + var_290_31 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play320191069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 320191069
		arg_295_1.duration_ = 12.1

		local var_295_0 = {
			zh = 12.1,
			ja = 8.333
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play320191070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 1.525

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(320191069)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 61 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 61)

				if (61 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 61)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191069", "story_v_out_320191.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191069", "story_v_out_320191.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_320191", "320191069", "story_v_out_320191.awb")

						arg_295_1:RecordAudio("320191069", var_298_6)
						arg_295_1:RecordAudio("320191069", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_320191", "320191069", "story_v_out_320191.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_320191", "320191069", "story_v_out_320191.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play320191070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 320191070
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play320191071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.425

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(320191070).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 57 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 57)

				if (57 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 57)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play320191071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320191071
		arg_303_1.duration_ = 2.9

		local var_303_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play320191072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if arg_303_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_306_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_303_1.stage_.transform)

				var_306_0.name = "1089ui_story"
				var_306_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.actors_["1089ui_story"] = var_306_0

				local var_306_1 = var_306_0:GetComponentInChildren(typeof(CharacterEffect))

				var_306_1.enabled = true

				local var_306_2 = GameObjectTools.GetOrAddComponent(var_306_0, typeof(DynamicBoneHelper))

				if var_306_2 then
					var_306_2:EnableDynamicBone(false)
				end

				arg_303_1:ShowWeapon(var_306_1.transform, false)

				arg_303_1.var_["1089ui_story" .. "Animator"] = var_306_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_303_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_303_1.var_["1089ui_story" .. "LipSync"] = var_306_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_306_3 = arg_303_1.actors_["1089ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1089ui_story = var_306_3.localPosition
			end

			local var_306_4 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				var_306_3.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_303_1.time_ - 0) / var_306_4)
				var_306_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_3.position).x, (manager.ui.mainCamera.transform.position - var_306_3.position).y, (manager.ui.mainCamera.transform.position - var_306_3.position).z)
				var_306_3.localEulerAngles.z = 0
				var_306_3.localEulerAngles.x = 0
				var_306_3.localEulerAngles = var_306_3.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				var_306_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_306_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_3.position).x, (manager.ui.mainCamera.transform.position - var_306_3.position).y, (manager.ui.mainCamera.transform.position - var_306_3.position).z)
				var_306_3.localEulerAngles.z = 0
				var_306_3.localEulerAngles.x = 0
				var_306_3.localEulerAngles = var_306_3.localEulerAngles
			end

			local var_306_5 = arg_303_1.actors_["1089ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.characterEffect1089ui_story == nil then
				arg_303_1.var_.characterEffect1089ui_story = var_306_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_6 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_6 and not isNil(var_306_5) then
				if arg_303_1.var_.characterEffect1089ui_story and not isNil(var_306_5) then
					arg_303_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_6 and arg_303_1.time_ < 0 + var_306_6 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.characterEffect1089ui_story then
				arg_303_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_306_8 = 0
			local var_306_9 = 0.125

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_10 = arg_303_1:GetWordFromCfg(320191071)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 5 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 5)

				if (5 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 5)) > 0 and var_306_9 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191071", "story_v_out_320191.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_320191", "320191071", "story_v_out_320191.awb") / 1000

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end

					if var_306_10.prefab_name ~= "" and arg_303_1.actors_[var_306_10.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_10.prefab_name].transform, "story_v_out_320191", "320191071", "story_v_out_320191.awb")

						arg_303_1:RecordAudio("320191071", var_306_15)
						arg_303_1:RecordAudio("320191071", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_320191", "320191071", "story_v_out_320191.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_320191", "320191071", "story_v_out_320191.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_16 and arg_303_1.time_ < var_306_8 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play320191072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320191072
		arg_307_1.duration_ = 7.3

		local var_307_0 = {
			zh = 7.3,
			ja = 6.466
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play320191073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1089ui_story = arg_307_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1089ui_story"].transform.position).z)
				arg_307_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1089ui_story"].transform.localEulerAngles = arg_307_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_307_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1089ui_story"].transform.position).z)
				arg_307_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1089ui_story"].transform.localEulerAngles = arg_307_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1089ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1089ui_story == nil then
				arg_307_1.var_.characterEffect1089ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1089ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_2)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1089ui_story then
				arg_307_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_310_3 = arg_307_1.actors_["1056ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1056ui_story = var_310_3.localPosition
			end

			local var_310_4 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				var_310_3.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1056ui_story, Vector3.New(-0.7, -1, -5.75), (arg_307_1.time_ - 0) / var_310_4)
				var_310_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_3.position).x, (manager.ui.mainCamera.transform.position - var_310_3.position).y, (manager.ui.mainCamera.transform.position - var_310_3.position).z)
				var_310_3.localEulerAngles.z = 0
				var_310_3.localEulerAngles.x = 0
				var_310_3.localEulerAngles = var_310_3.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				var_310_3.localPosition = Vector3.New(-0.7, -1, -5.75)
				var_310_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_3.position).x, (manager.ui.mainCamera.transform.position - var_310_3.position).y, (manager.ui.mainCamera.transform.position - var_310_3.position).z)
				var_310_3.localEulerAngles.z = 0
				var_310_3.localEulerAngles.x = 0
				var_310_3.localEulerAngles = var_310_3.localEulerAngles
			end

			local var_310_5 = arg_307_1.actors_["1056ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.characterEffect1056ui_story == nil then
				arg_307_1.var_.characterEffect1056ui_story = var_310_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_6 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_6 and not isNil(var_310_5) then
				if arg_307_1.var_.characterEffect1056ui_story and not isNil(var_310_5) then
					arg_307_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_6 and arg_307_1.time_ < 0 + var_310_6 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.characterEffect1056ui_story then
				arg_307_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_8 = 0
			local var_310_9 = 0.9

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(320191072)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_13 = 36 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 36)

				if (36 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 36)) > 0 and var_310_9 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191072", "story_v_out_320191.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_320191", "320191072", "story_v_out_320191.awb") / 1000

					if var_310_14 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_8
					end

					if var_310_10.prefab_name ~= "" and arg_307_1.actors_[var_310_10.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_10.prefab_name].transform, "story_v_out_320191", "320191072", "story_v_out_320191.awb")

						arg_307_1:RecordAudio("320191072", var_310_15)
						arg_307_1:RecordAudio("320191072", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_320191", "320191072", "story_v_out_320191.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_320191", "320191072", "story_v_out_320191.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_16 and arg_307_1.time_ < var_310_8 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play320191073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 320191073
		arg_311_1.duration_ = 6.63

		local var_311_0 = {
			zh = 5.3,
			ja = 6.633
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play320191074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.7

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(320191073)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 28 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 28)

				if (28 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 28)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191073", "story_v_out_320191.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191073", "story_v_out_320191.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_320191", "320191073", "story_v_out_320191.awb")

						arg_311_1:RecordAudio("320191073", var_314_6)
						arg_311_1:RecordAudio("320191073", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_320191", "320191073", "story_v_out_320191.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_320191", "320191073", "story_v_out_320191.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play320191074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 320191074
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play320191075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1056ui_story"]) and arg_315_1.var_.characterEffect1056ui_story == nil then
				arg_315_1.var_.characterEffect1056ui_story = arg_315_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1056ui_story"]) then
				if arg_315_1.var_.characterEffect1056ui_story and not isNil(arg_315_1.actors_["1056ui_story"]) then
					arg_315_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1056ui_story"]) and arg_315_1.var_.characterEffect1056ui_story then
				arg_315_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.925

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(320191074).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 37 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 37)

				if (37 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 37)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play320191075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 320191075
		arg_319_1.duration_ = 6.57

		local var_319_0 = {
			zh = 6.566,
			ja = 6.4
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
				arg_319_0:Play320191076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1056ui_story"]) and arg_319_1.var_.characterEffect1056ui_story == nil then
				arg_319_1.var_.characterEffect1056ui_story = arg_319_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1056ui_story"]) then
				if arg_319_1.var_.characterEffect1056ui_story and not isNil(arg_319_1.actors_["1056ui_story"]) then
					arg_319_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1056ui_story"]) and arg_319_1.var_.characterEffect1056ui_story then
				arg_319_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_322_2 = 0
			local var_322_3 = 0.925

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:GetWordFromCfg(320191075)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 37 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 37)

				if (37 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 37)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191075", "story_v_out_320191.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191075", "story_v_out_320191.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_out_320191", "320191075", "story_v_out_320191.awb")

						arg_319_1:RecordAudio("320191075", var_322_9)
						arg_319_1:RecordAudio("320191075", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_320191", "320191075", "story_v_out_320191.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_320191", "320191075", "story_v_out_320191.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play320191076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 320191076
		arg_323_1.duration_ = 11.93

		local var_323_0 = {
			zh = 6.666,
			ja = 11.933
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
				arg_323_0:Play320191077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1089ui_story = arg_323_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1089ui_story"].transform.position).z)
				arg_323_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1089ui_story"].transform.localEulerAngles = arg_323_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_323_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1089ui_story"].transform.position).z)
				arg_323_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1089ui_story"].transform.localEulerAngles = arg_323_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1089ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1089ui_story == nil then
				arg_323_1.var_.characterEffect1089ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1089ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1089ui_story then
				arg_323_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			local var_326_4 = arg_323_1.actors_["1056ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_4) and arg_323_1.var_.characterEffect1056ui_story == nil then
				arg_323_1.var_.characterEffect1056ui_story = var_326_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_5 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 and not isNil(var_326_4) then
				if arg_323_1.var_.characterEffect1056ui_story and not isNil(var_326_4) then
					arg_323_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_5)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 and not isNil(var_326_4) and arg_323_1.var_.characterEffect1056ui_story then
				arg_323_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_326_6 = 0
			local var_326_7 = 0.775

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(320191076)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 31 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 31)

				if (31 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 31)) > 0 and var_326_7 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191076", "story_v_out_320191.awb") ~= 0 then
					local var_326_12 = manager.audio:GetVoiceLength("story_v_out_320191", "320191076", "story_v_out_320191.awb") / 1000

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end

					if var_326_8.prefab_name ~= "" and arg_323_1.actors_[var_326_8.prefab_name] ~= nil then
						local var_326_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_8.prefab_name].transform, "story_v_out_320191", "320191076", "story_v_out_320191.awb")

						arg_323_1:RecordAudio("320191076", var_326_13)
						arg_323_1:RecordAudio("320191076", var_326_13)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_320191", "320191076", "story_v_out_320191.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_320191", "320191076", "story_v_out_320191.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_14 and arg_323_1.time_ < var_326_6 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play320191077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 320191077
		arg_327_1.duration_ = 11.7

		local var_327_0 = {
			zh = 6.866,
			ja = 11.7
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
				arg_327_0:Play320191078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1056ui_story"]) and arg_327_1.var_.characterEffect1056ui_story == nil then
				arg_327_1.var_.characterEffect1056ui_story = arg_327_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1056ui_story"]) then
				if arg_327_1.var_.characterEffect1056ui_story and not isNil(arg_327_1.actors_["1056ui_story"]) then
					arg_327_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1056ui_story"]) and arg_327_1.var_.characterEffect1056ui_story then
				arg_327_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action10_1")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_330_2 = arg_327_1.actors_["1089ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1089ui_story == nil then
				arg_327_1.var_.characterEffect1089ui_story = var_330_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_3 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.characterEffect1089ui_story and not isNil(var_330_2) then
					arg_327_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_3)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1089ui_story then
				arg_327_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_330_4 = 0
			local var_330_5 = 0.975

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(320191077)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 39 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 39)

				if (39 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 39)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191077", "story_v_out_320191.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191077", "story_v_out_320191.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_320191", "320191077", "story_v_out_320191.awb")

						arg_327_1:RecordAudio("320191077", var_330_11)
						arg_327_1:RecordAudio("320191077", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_320191", "320191077", "story_v_out_320191.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_320191", "320191077", "story_v_out_320191.awb")
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

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play320191078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 320191078
		arg_331_1.duration_ = 11.4

		local var_331_0 = {
			zh = 11.233,
			ja = 11.4
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play320191079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1056ui_story"]) and arg_331_1.var_.characterEffect1056ui_story == nil then
				arg_331_1.var_.characterEffect1056ui_story = arg_331_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1056ui_story"]) then
				if arg_331_1.var_.characterEffect1056ui_story and not isNil(arg_331_1.actors_["1056ui_story"]) then
					arg_331_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1056ui_story"]) and arg_331_1.var_.characterEffect1056ui_story then
				arg_331_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_334_1 = arg_331_1.actors_["1089ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1089ui_story == nil then
				arg_331_1.var_.characterEffect1089ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1089ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1089ui_story then
				arg_331_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_334_4 = 0
			local var_334_5 = 1.3

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(320191078)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 52 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 52)

				if (52 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 52)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191078", "story_v_out_320191.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191078", "story_v_out_320191.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_out_320191", "320191078", "story_v_out_320191.awb")

						arg_331_1:RecordAudio("320191078", var_334_11)
						arg_331_1:RecordAudio("320191078", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_320191", "320191078", "story_v_out_320191.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_320191", "320191078", "story_v_out_320191.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play320191079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 320191079
		arg_335_1.duration_ = 7.4

		local var_335_0 = {
			zh = 7.4,
			ja = 7.333
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
				arg_335_0:Play320191080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.65

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:GetWordFromCfg(320191079)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 26 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 26)

				if (26 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 26)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191079", "story_v_out_320191.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191079", "story_v_out_320191.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_320191", "320191079", "story_v_out_320191.awb")

						arg_335_1:RecordAudio("320191079", var_338_6)
						arg_335_1:RecordAudio("320191079", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_320191", "320191079", "story_v_out_320191.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_320191", "320191079", "story_v_out_320191.awb")
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
	Play320191080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 320191080
		arg_339_1.duration_ = 7.57

		local var_339_0 = {
			zh = 6.966,
			ja = 7.566
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
				arg_339_0:Play320191081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_342_0 = 0
			local var_342_1 = 0.675

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_2 = arg_339_1:GetWordFromCfg(320191080)
				local var_342_3 = arg_339_1:FormatText(var_342_2.content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 27 <= 0 and var_342_1 or var_342_1 * (utf8.len(var_342_3) / 27)

				if (27 <= 0 and var_342_1 or var_342_1 * (utf8.len(var_342_3) / 27)) > 0 and var_342_1 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191080", "story_v_out_320191.awb") ~= 0 then
					local var_342_6 = manager.audio:GetVoiceLength("story_v_out_320191", "320191080", "story_v_out_320191.awb") / 1000

					if var_342_6 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_0
					end

					if var_342_2.prefab_name ~= "" and arg_339_1.actors_[var_342_2.prefab_name] ~= nil then
						local var_342_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_2.prefab_name].transform, "story_v_out_320191", "320191080", "story_v_out_320191.awb")

						arg_339_1:RecordAudio("320191080", var_342_7)
						arg_339_1:RecordAudio("320191080", var_342_7)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_320191", "320191080", "story_v_out_320191.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_320191", "320191080", "story_v_out_320191.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_8 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_8 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_8

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_8 and arg_339_1.time_ < var_342_0 + var_342_8 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play320191081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 320191081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play320191082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1089ui_story"]) and arg_343_1.var_.characterEffect1089ui_story == nil then
				arg_343_1.var_.characterEffect1089ui_story = arg_343_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1089ui_story"]) then
				if arg_343_1.var_.characterEffect1089ui_story and not isNil(arg_343_1.actors_["1089ui_story"]) then
					arg_343_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1089ui_story"]) and arg_343_1.var_.characterEffect1089ui_story then
				arg_343_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_346_1 = arg_343_1.actors_["1089ui_story"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1089ui_story = var_346_1.localPosition
			end

			local var_346_2 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 then
				var_346_1.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_2)
				var_346_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_1.position).x, (manager.ui.mainCamera.transform.position - var_346_1.position).y, (manager.ui.mainCamera.transform.position - var_346_1.position).z)
				var_346_1.localEulerAngles.z = 0
				var_346_1.localEulerAngles.x = 0
				var_346_1.localEulerAngles = var_346_1.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 then
				var_346_1.localPosition = Vector3.New(0, 100, 0)
				var_346_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_1.position).x, (manager.ui.mainCamera.transform.position - var_346_1.position).y, (manager.ui.mainCamera.transform.position - var_346_1.position).z)
				var_346_1.localEulerAngles.z = 0
				var_346_1.localEulerAngles.x = 0
				var_346_1.localEulerAngles = var_346_1.localEulerAngles
			end

			local var_346_3 = arg_343_1.actors_["1056ui_story"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1056ui_story = var_346_3.localPosition
			end

			local var_346_4 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				var_346_3.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_4)
				var_346_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_3.position).x, (manager.ui.mainCamera.transform.position - var_346_3.position).y, (manager.ui.mainCamera.transform.position - var_346_3.position).z)
				var_346_3.localEulerAngles.z = 0
				var_346_3.localEulerAngles.x = 0
				var_346_3.localEulerAngles = var_346_3.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				var_346_3.localPosition = Vector3.New(0, 100, 0)
				var_346_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_3.position).x, (manager.ui.mainCamera.transform.position - var_346_3.position).y, (manager.ui.mainCamera.transform.position - var_346_3.position).z)
				var_346_3.localEulerAngles.z = 0
				var_346_3.localEulerAngles.x = 0
				var_346_3.localEulerAngles = var_346_3.localEulerAngles
			end

			local var_346_5 = 0
			local var_346_6 = 1

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_7 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(320191081).content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 40 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_7) / 40)

				if (40 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_7) / 40)) > 0 and var_346_6 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_10 and arg_343_1.time_ < var_346_5 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320191082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 320191082
		arg_347_1.duration_ = 3.57

		local var_347_0 = {
			zh = 3.5,
			ja = 3.566
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
				arg_347_0:Play320191083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.3

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(320191082)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 12 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 12)

				if (12 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 12)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191082", "story_v_out_320191.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_320191", "320191082", "story_v_out_320191.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_320191", "320191082", "story_v_out_320191.awb")

						arg_347_1:RecordAudio("320191082", var_350_6)
						arg_347_1:RecordAudio("320191082", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_320191", "320191082", "story_v_out_320191.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_320191", "320191082", "story_v_out_320191.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play320191083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 320191083
		arg_351_1.duration_ = 10.8

		local var_351_0 = {
			zh = 10.1663333333333,
			ja = 10.7993333333333
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
				arg_351_0:Play320191084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 1.53333333333333 < arg_351_1.time_ and arg_351_1.time_ <= 1.53333333333333 + arg_354_0 then
				local var_354_0 = arg_351_1.bgs_.ST61

				arg_351_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_354_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_1 = var_354_0:GetComponent("SpriteRenderer")

				if var_354_1 and var_354_1.sprite then
					local var_354_2 = 2 * (var_354_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_354_0.transform.localScale = Vector3.New(var_354_2 / var_354_1.sprite.bounds.size.y < var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x and var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x or var_354_2 / var_354_1.sprite.bounds.size.y, var_354_2 / var_354_1.sprite.bounds.size.y < var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x and var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x or var_354_2 / var_354_1.sprite.bounds.size.y, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "ST61" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_3 = 0

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_3 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			if arg_351_1.time_ >= var_354_3 + 0.3 and arg_351_1.time_ < var_354_3 + 0.3 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_4 = 0

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_5 = 1.53333333333333

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_5 then
				local var_354_6 = Color.New(0, 0, 0)

				var_354_6.a = Mathf.Lerp(0, 1, (arg_351_1.time_ - var_354_4) / var_354_5)
				arg_351_1.mask_.color = var_354_6
			end

			if arg_351_1.time_ >= var_354_4 + var_354_5 and arg_351_1.time_ < var_354_4 + var_354_5 + arg_354_0 then
				local var_354_7 = Color.New(0, 0, 0)

				var_354_7.a = 1
				arg_351_1.mask_.color = var_354_7
			end

			local var_354_8 = 1.53333333333333

			if 1.53333333333333 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_9 = 1.53333333333333

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_9 then
				local var_354_10 = Color.New(0, 0, 0)

				var_354_10.a = Mathf.Lerp(1, 0, (arg_351_1.time_ - var_354_8) / var_354_9)
				arg_351_1.mask_.color = var_354_10
			end

			if arg_351_1.time_ >= var_354_8 + var_354_9 and arg_351_1.time_ < var_354_8 + var_354_9 + arg_354_0 then
				local var_354_11 = Color.New(0, 0, 0)

				arg_351_1.mask_.enabled = false
				var_354_11.a = 0
				arg_351_1.mask_.color = var_354_11
			end

			local var_354_12 = "1061ui_story"

			if arg_351_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_354_13 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_351_1.stage_.transform)

				var_354_13.name = var_354_12
				var_354_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.actors_[var_354_12] = var_354_13

				local var_354_14 = var_354_13:GetComponentInChildren(typeof(CharacterEffect))

				var_354_14.enabled = true

				local var_354_15 = GameObjectTools.GetOrAddComponent(var_354_13, typeof(DynamicBoneHelper))

				if var_354_15 then
					var_354_15:EnableDynamicBone(false)
				end

				arg_351_1:ShowWeapon(var_354_14.transform, false)

				arg_351_1.var_[var_354_12 .. "Animator"] = var_354_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_351_1.var_[var_354_12 .. "Animator"].applyRootMotion = true
				arg_351_1.var_[var_354_12 .. "LipSync"] = var_354_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_354_16 = arg_351_1.actors_["1061ui_story"].transform

			if 2.93333333333333 < arg_351_1.time_ and arg_351_1.time_ <= 2.93333333333333 + arg_354_0 then
				arg_351_1.var_.moveOldPos1061ui_story = var_354_16.localPosition

				arg_351_1:ShowWeapon(arg_351_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_354_17 = 0.001

			if 2.93333333333333 <= arg_351_1.time_ and arg_351_1.time_ < 2.93333333333333 + var_354_17 then
				var_354_16.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_351_1.time_ - 2.93333333333333) / var_354_17)
				var_354_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_16.position).x, (manager.ui.mainCamera.transform.position - var_354_16.position).y, (manager.ui.mainCamera.transform.position - var_354_16.position).z)
				var_354_16.localEulerAngles.z = 0
				var_354_16.localEulerAngles.x = 0
				var_354_16.localEulerAngles = var_354_16.localEulerAngles
			end

			if arg_351_1.time_ >= 2.93333333333333 + var_354_17 and arg_351_1.time_ < 2.93333333333333 + var_354_17 + arg_354_0 then
				var_354_16.localPosition = Vector3.New(0, -1.18, -6.15)
				var_354_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_16.position).x, (manager.ui.mainCamera.transform.position - var_354_16.position).y, (manager.ui.mainCamera.transform.position - var_354_16.position).z)
				var_354_16.localEulerAngles.z = 0
				var_354_16.localEulerAngles.x = 0
				var_354_16.localEulerAngles = var_354_16.localEulerAngles
			end

			local var_354_18 = arg_351_1.actors_["1061ui_story"]

			if 2.93333333333333 < arg_351_1.time_ and arg_351_1.time_ <= 2.93333333333333 + arg_354_0 and not isNil(var_354_18) and arg_351_1.var_.characterEffect1061ui_story == nil then
				arg_351_1.var_.characterEffect1061ui_story = var_354_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_19 = 0.200000002980232

			if 2.93333333333333 <= arg_351_1.time_ and arg_351_1.time_ < 2.93333333333333 + var_354_19 and not isNil(var_354_18) then
				if arg_351_1.var_.characterEffect1061ui_story and not isNil(var_354_18) then
					arg_351_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 2.93333333333333 + var_354_19 and arg_351_1.time_ < 2.93333333333333 + var_354_19 + arg_354_0 and not isNil(var_354_18) and arg_351_1.var_.characterEffect1061ui_story then
				arg_351_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 2.93333333333333 < arg_351_1.time_ and arg_351_1.time_ <= 2.93333333333333 + arg_354_0 then
				arg_351_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 2.93333333333333 < arg_351_1.time_ and arg_351_1.time_ <= 2.93333333333333 + arg_354_0 then
				arg_351_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_21 = 2.93333333333333
			local var_354_22 = 0.6

			if 2.93333333333333 < arg_351_1.time_ and arg_351_1.time_ <= var_354_21 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_23 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_23:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_24 = arg_351_1:GetWordFromCfg(320191083)
				local var_354_25 = arg_351_1:FormatText(var_354_24.content)

				arg_351_1.text_.text = var_354_25

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_27 = 24 <= 0 and var_354_22 or var_354_22 * (utf8.len(var_354_25) / 24)

				if (24 <= 0 and var_354_22 or var_354_22 * (utf8.len(var_354_25) / 24)) > 0 and var_354_22 < var_354_27 then
					arg_351_1.talkMaxDuration = var_354_27
					var_354_21 = var_354_21 + 0.3

					if var_354_27 + var_354_21 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_27 + var_354_21
					end
				end

				arg_351_1.text_.text = var_354_25
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191083", "story_v_out_320191.awb") ~= 0 then
					local var_354_28 = manager.audio:GetVoiceLength("story_v_out_320191", "320191083", "story_v_out_320191.awb") / 1000

					if var_354_28 + var_354_21 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_28 + var_354_21
					end

					if var_354_24.prefab_name ~= "" and arg_351_1.actors_[var_354_24.prefab_name] ~= nil then
						local var_354_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_24.prefab_name].transform, "story_v_out_320191", "320191083", "story_v_out_320191.awb")

						arg_351_1:RecordAudio("320191083", var_354_29)
						arg_351_1:RecordAudio("320191083", var_354_29)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_320191", "320191083", "story_v_out_320191.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_320191", "320191083", "story_v_out_320191.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_30 = var_354_21 + 0.3
			local var_354_31 = math.max(var_354_22, arg_351_1.talkMaxDuration)

			if var_354_21 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_30 + var_354_31 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_30) / var_354_31

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_30 + var_354_31 and arg_351_1.time_ < var_354_30 + var_354_31 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play320191084 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 320191084
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play320191085(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1061ui_story"]) and arg_357_1.var_.characterEffect1061ui_story == nil then
				arg_357_1.var_.characterEffect1061ui_story = arg_357_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1061ui_story"]) then
				if arg_357_1.var_.characterEffect1061ui_story and not isNil(arg_357_1.actors_["1061ui_story"]) then
					arg_357_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1061ui_story"]) and arg_357_1.var_.characterEffect1061ui_story then
				arg_357_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_360_1 = 0
			local var_360_2 = 0.725

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(320191084).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 29 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 29)

				if (29 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 29)) > 0 and var_360_2 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_6 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_6 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_6

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_6 and arg_357_1.time_ < var_360_1 + var_360_6 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play320191085 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 320191085
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play320191086(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.85

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(320191085).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 34 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 34)

				if (34 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 34)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play320191086 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 320191086
		arg_365_1.duration_ = 4.33

		local var_365_0 = {
			zh = 4.333,
			ja = 2.866
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play320191087(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1061ui_story"]) and arg_365_1.var_.characterEffect1061ui_story == nil then
				arg_365_1.var_.characterEffect1061ui_story = arg_365_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1061ui_story"]) then
				if arg_365_1.var_.characterEffect1061ui_story and not isNil(arg_365_1.actors_["1061ui_story"]) then
					arg_365_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1061ui_story"]) and arg_365_1.var_.characterEffect1061ui_story then
				arg_365_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_368_2 = 0
			local var_368_3 = 0.55

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(320191086)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 22 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 22)

				if (22 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 22)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191086", "story_v_out_320191.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191086", "story_v_out_320191.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_out_320191", "320191086", "story_v_out_320191.awb")

						arg_365_1:RecordAudio("320191086", var_368_9)
						arg_365_1:RecordAudio("320191086", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_320191", "320191086", "story_v_out_320191.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_320191", "320191086", "story_v_out_320191.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play320191087 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 320191087
		arg_369_1.duration_ = 1

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"

			SetActive(arg_369_1.choicesGo_, true)

			for iter_370_0, iter_370_1 in ipairs(arg_369_1.choices_) do
				SetActive(iter_370_1.go, iter_370_0 <= 1)
			end

			arg_369_1.choices_[1].txt.text = arg_369_1:FormatText(StoryChoiceCfg[1046].name)
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play320191088(arg_369_1)
			end

			arg_369_1:RecordChoiceLog(320191087, 1046)
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1061ui_story"]) and arg_369_1.var_.characterEffect1061ui_story == nil then
				arg_369_1.var_.characterEffect1061ui_story = arg_369_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1061ui_story"]) then
				if arg_369_1.var_.characterEffect1061ui_story and not isNil(arg_369_1.actors_["1061ui_story"]) then
					arg_369_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1061ui_story"]) and arg_369_1.var_.characterEffect1061ui_story then
				arg_369_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play320191088 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 320191088
		arg_373_1.duration_ = 7.63

		local var_373_0 = {
			zh = 7.6,
			ja = 7.633
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play320191089(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1061ui_story"]) and arg_373_1.var_.characterEffect1061ui_story == nil then
				arg_373_1.var_.characterEffect1061ui_story = arg_373_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1061ui_story"]) then
				if arg_373_1.var_.characterEffect1061ui_story and not isNil(arg_373_1.actors_["1061ui_story"]) then
					arg_373_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1061ui_story"]) and arg_373_1.var_.characterEffect1061ui_story then
				arg_373_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_2 = 0
			local var_376_3 = 0.775

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(320191088)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 31 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 31)

				if (31 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 31)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191088", "story_v_out_320191.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191088", "story_v_out_320191.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_320191", "320191088", "story_v_out_320191.awb")

						arg_373_1:RecordAudio("320191088", var_376_9)
						arg_373_1:RecordAudio("320191088", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_320191", "320191088", "story_v_out_320191.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_320191", "320191088", "story_v_out_320191.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play320191089 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 320191089
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play320191090(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1061ui_story"]) and arg_377_1.var_.characterEffect1061ui_story == nil then
				arg_377_1.var_.characterEffect1061ui_story = arg_377_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1061ui_story"]) then
				if arg_377_1.var_.characterEffect1061ui_story and not isNil(arg_377_1.actors_["1061ui_story"]) then
					arg_377_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1061ui_story"]) and arg_377_1.var_.characterEffect1061ui_story then
				arg_377_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 0.475

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(320191089).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 19 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 19)

				if (19 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 19)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play320191090 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 320191090
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play320191091(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1061ui_story = arg_381_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1061ui_story"].transform.position).z)
				arg_381_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1061ui_story"].transform.localEulerAngles = arg_381_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1061ui_story"].transform.position).z)
				arg_381_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1061ui_story"].transform.localEulerAngles = arg_381_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_384_1 = 0
			local var_384_2 = 1.3

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_3 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(320191090).content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 52 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_3) / 52)

				if (52 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_3) / 52)) > 0 and var_384_2 < var_384_5 then
					arg_381_1.talkMaxDuration = var_384_5

					if var_384_5 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_6 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_6 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_6

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_6 and arg_381_1.time_ < var_384_1 + var_384_6 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play320191091 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 320191091
		arg_385_1.duration_ = 4.6

		local var_385_0 = {
			zh = 1.999999999999,
			ja = 4.6
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play320191092(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1061ui_story = arg_385_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1061ui_story"].transform.position).z)
				arg_385_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1061ui_story"].transform.localEulerAngles = arg_385_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_385_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1061ui_story"].transform.position).z)
				arg_385_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1061ui_story"].transform.localEulerAngles = arg_385_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1061ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1061ui_story == nil then
				arg_385_1.var_.characterEffect1061ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1061ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1061ui_story then
				arg_385_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_2")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_388_4 = 0
			local var_388_5 = 0.125

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(320191091)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 5 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 5)

				if (5 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 5)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191091", "story_v_out_320191.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191091", "story_v_out_320191.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_out_320191", "320191091", "story_v_out_320191.awb")

						arg_385_1:RecordAudio("320191091", var_388_11)
						arg_385_1:RecordAudio("320191091", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_320191", "320191091", "story_v_out_320191.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_320191", "320191091", "story_v_out_320191.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play320191092 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 320191092
		arg_389_1.duration_ = 1

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"

			SetActive(arg_389_1.choicesGo_, true)

			for iter_390_0, iter_390_1 in ipairs(arg_389_1.choices_) do
				SetActive(iter_390_1.go, iter_390_0 <= 1)
			end

			arg_389_1.choices_[1].txt.text = arg_389_1:FormatText(StoryChoiceCfg[1047].name)
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play320191093(arg_389_1)
			end

			arg_389_1:RecordChoiceLog(320191092, 1047)
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1061ui_story"]) and arg_389_1.var_.characterEffect1061ui_story == nil then
				arg_389_1.var_.characterEffect1061ui_story = arg_389_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1061ui_story"]) then
				if arg_389_1.var_.characterEffect1061ui_story and not isNil(arg_389_1.actors_["1061ui_story"]) then
					arg_389_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1061ui_story"]) and arg_389_1.var_.characterEffect1061ui_story then
				arg_389_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play320191093 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 320191093
		arg_393_1.duration_ = 6.87

		local var_393_0 = {
			zh = 6.866,
			ja = 3.866
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play320191094(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1061ui_story"]) and arg_393_1.var_.characterEffect1061ui_story == nil then
				arg_393_1.var_.characterEffect1061ui_story = arg_393_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1061ui_story"]) then
				if arg_393_1.var_.characterEffect1061ui_story and not isNil(arg_393_1.actors_["1061ui_story"]) then
					arg_393_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1061ui_story"]) and arg_393_1.var_.characterEffect1061ui_story then
				arg_393_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_396_2 = 0
			local var_396_3 = 0.8

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:GetWordFromCfg(320191093)
				local var_396_5 = arg_393_1:FormatText(var_396_4.content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 32 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 32)

				if (32 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 32)) > 0 and var_396_3 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191093", "story_v_out_320191.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191093", "story_v_out_320191.awb") / 1000

					if var_396_8 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_2
					end

					if var_396_4.prefab_name ~= "" and arg_393_1.actors_[var_396_4.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_4.prefab_name].transform, "story_v_out_320191", "320191093", "story_v_out_320191.awb")

						arg_393_1:RecordAudio("320191093", var_396_9)
						arg_393_1:RecordAudio("320191093", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_320191", "320191093", "story_v_out_320191.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_320191", "320191093", "story_v_out_320191.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_10 and arg_393_1.time_ < var_396_2 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play320191094 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 320191094
		arg_397_1.duration_ = 4.8

		local var_397_0 = {
			zh = 1.999999999999,
			ja = 4.8
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play320191095(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_0 = 0
			local var_400_1 = 0.225

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(320191094)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 9 <= 0 and var_400_1 or var_400_1 * (utf8.len(var_400_3) / 9)

				if (9 <= 0 and var_400_1 or var_400_1 * (utf8.len(var_400_3) / 9)) > 0 and var_400_1 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191094", "story_v_out_320191.awb") ~= 0 then
					local var_400_6 = manager.audio:GetVoiceLength("story_v_out_320191", "320191094", "story_v_out_320191.awb") / 1000

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end

					if var_400_2.prefab_name ~= "" and arg_397_1.actors_[var_400_2.prefab_name] ~= nil then
						local var_400_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_2.prefab_name].transform, "story_v_out_320191", "320191094", "story_v_out_320191.awb")

						arg_397_1:RecordAudio("320191094", var_400_7)
						arg_397_1:RecordAudio("320191094", var_400_7)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_320191", "320191094", "story_v_out_320191.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_320191", "320191094", "story_v_out_320191.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_8 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_8 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_8

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_8 and arg_397_1.time_ < var_400_0 + var_400_8 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play320191095 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320191095
		arg_401_1.duration_ = 1

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"

			SetActive(arg_401_1.choicesGo_, true)

			for iter_402_0, iter_402_1 in ipairs(arg_401_1.choices_) do
				SetActive(iter_402_1.go, iter_402_0 <= 2)
			end

			arg_401_1.choices_[1].txt.text = arg_401_1:FormatText(StoryChoiceCfg[1048].name)
			arg_401_1.choices_[2].txt.text = arg_401_1:FormatText(StoryChoiceCfg[1049].name)
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play320191096(arg_401_1)
			end

			if arg_403_0 == 2 then
				arg_401_0:Play320191096(arg_401_1)
			end

			arg_401_1:RecordChoiceLog(320191095, 1048, 1049)
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1061ui_story"]) and arg_401_1.var_.characterEffect1061ui_story == nil then
				arg_401_1.var_.characterEffect1061ui_story = arg_401_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1061ui_story"]) then
				if arg_401_1.var_.characterEffect1061ui_story and not isNil(arg_401_1.actors_["1061ui_story"]) then
					arg_401_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1061ui_story"]) and arg_401_1.var_.characterEffect1061ui_story then
				arg_401_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play320191096 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320191096
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320191098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.825

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(320191096).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 33 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 33)

				if (33 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 33)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320191098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320191098
		arg_409_1.duration_ = 9.53

		local var_409_0 = {
			zh = 6.5,
			ja = 9.533
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
				arg_409_0:Play320191099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1061ui_story = arg_409_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1061ui_story"].transform.position).z)
				arg_409_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1061ui_story"].transform.localEulerAngles = arg_409_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_409_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1061ui_story"].transform.position).z)
				arg_409_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1061ui_story"].transform.localEulerAngles = arg_409_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1061ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1061ui_story == nil then
				arg_409_1.var_.characterEffect1061ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect1061ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1061ui_story then
				arg_409_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_4 = 0
			local var_412_5 = 0.675

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:GetWordFromCfg(320191098)
				local var_412_7 = arg_409_1:FormatText(var_412_6.content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 27 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 27)

				if (27 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 27)) > 0 and var_412_5 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191098", "story_v_out_320191.awb") ~= 0 then
					local var_412_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191098", "story_v_out_320191.awb") / 1000

					if var_412_10 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_4
					end

					if var_412_6.prefab_name ~= "" and arg_409_1.actors_[var_412_6.prefab_name] ~= nil then
						local var_412_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_6.prefab_name].transform, "story_v_out_320191", "320191098", "story_v_out_320191.awb")

						arg_409_1:RecordAudio("320191098", var_412_11)
						arg_409_1:RecordAudio("320191098", var_412_11)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_320191", "320191098", "story_v_out_320191.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_320191", "320191098", "story_v_out_320191.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_12 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_12 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_12

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_12 and arg_409_1.time_ < var_412_4 + var_412_12 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play320191099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 320191099
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play320191100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1061ui_story"]) and arg_413_1.var_.characterEffect1061ui_story == nil then
				arg_413_1.var_.characterEffect1061ui_story = arg_413_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1061ui_story"]) then
				if arg_413_1.var_.characterEffect1061ui_story and not isNil(arg_413_1.actors_["1061ui_story"]) then
					arg_413_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1061ui_story"]) and arg_413_1.var_.characterEffect1061ui_story then
				arg_413_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 0.275

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(320191099).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 11 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 11)

				if (11 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 11)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play320191100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 320191100
		arg_417_1.duration_ = 3.47

		local var_417_0 = {
			zh = 2.6,
			ja = 3.466
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
				arg_417_0:Play320191101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1061ui_story"]) and arg_417_1.var_.characterEffect1061ui_story == nil then
				arg_417_1.var_.characterEffect1061ui_story = arg_417_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1061ui_story"]) then
				if arg_417_1.var_.characterEffect1061ui_story and not isNil(arg_417_1.actors_["1061ui_story"]) then
					arg_417_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1061ui_story"]) and arg_417_1.var_.characterEffect1061ui_story then
				arg_417_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_420_2 = 0
			local var_420_3 = 0.225

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_2 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_4 = arg_417_1:GetWordFromCfg(320191100)
				local var_420_5 = arg_417_1:FormatText(var_420_4.content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 9 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 9)

				if (9 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 9)) > 0 and var_420_3 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_2
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191100", "story_v_out_320191.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191100", "story_v_out_320191.awb") / 1000

					if var_420_8 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_2
					end

					if var_420_4.prefab_name ~= "" and arg_417_1.actors_[var_420_4.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_4.prefab_name].transform, "story_v_out_320191", "320191100", "story_v_out_320191.awb")

						arg_417_1:RecordAudio("320191100", var_420_9)
						arg_417_1:RecordAudio("320191100", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_320191", "320191100", "story_v_out_320191.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_320191", "320191100", "story_v_out_320191.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_3, arg_417_1.talkMaxDuration)

			if var_420_2 <= arg_417_1.time_ and arg_417_1.time_ < var_420_2 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_2) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_2 + var_420_10 and arg_417_1.time_ < var_420_2 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play320191101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 320191101
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play320191102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1061ui_story"]) and arg_421_1.var_.characterEffect1061ui_story == nil then
				arg_421_1.var_.characterEffect1061ui_story = arg_421_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1061ui_story"]) then
				if arg_421_1.var_.characterEffect1061ui_story and not isNil(arg_421_1.actors_["1061ui_story"]) then
					arg_421_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1061ui_story"]) and arg_421_1.var_.characterEffect1061ui_story then
				arg_421_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0
			local var_424_2 = 0.8

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(320191101).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 32 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 32)

				if (32 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 32)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play320191102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 320191102
		arg_425_1.duration_ = 5.67

		local var_425_0 = {
			zh = 4.3,
			ja = 5.666
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
				arg_425_0:Play320191103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1061ui_story"]) and arg_425_1.var_.characterEffect1061ui_story == nil then
				arg_425_1.var_.characterEffect1061ui_story = arg_425_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1061ui_story"]) then
				if arg_425_1.var_.characterEffect1061ui_story and not isNil(arg_425_1.actors_["1061ui_story"]) then
					arg_425_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1061ui_story"]) and arg_425_1.var_.characterEffect1061ui_story then
				arg_425_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0.034000001847744 < arg_425_1.time_ and arg_425_1.time_ <= 0.034000001847744 + arg_428_0 then
				arg_425_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_428_2 = 0
			local var_428_3 = 0.575

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_2 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_4 = arg_425_1:GetWordFromCfg(320191102)
				local var_428_5 = arg_425_1:FormatText(var_428_4.content)

				arg_425_1.text_.text = var_428_5

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_7 = 23 <= 0 and var_428_3 or var_428_3 * (utf8.len(var_428_5) / 23)

				if (23 <= 0 and var_428_3 or var_428_3 * (utf8.len(var_428_5) / 23)) > 0 and var_428_3 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_2 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_2
					end
				end

				arg_425_1.text_.text = var_428_5
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191102", "story_v_out_320191.awb") ~= 0 then
					local var_428_8 = manager.audio:GetVoiceLength("story_v_out_320191", "320191102", "story_v_out_320191.awb") / 1000

					if var_428_8 + var_428_2 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_8 + var_428_2
					end

					if var_428_4.prefab_name ~= "" and arg_425_1.actors_[var_428_4.prefab_name] ~= nil then
						local var_428_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_4.prefab_name].transform, "story_v_out_320191", "320191102", "story_v_out_320191.awb")

						arg_425_1:RecordAudio("320191102", var_428_9)
						arg_425_1:RecordAudio("320191102", var_428_9)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_320191", "320191102", "story_v_out_320191.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_320191", "320191102", "story_v_out_320191.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_10 = math.max(var_428_3, arg_425_1.talkMaxDuration)

			if var_428_2 <= arg_425_1.time_ and arg_425_1.time_ < var_428_2 + var_428_10 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_2) / var_428_10

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_2 + var_428_10 and arg_425_1.time_ < var_428_2 + var_428_10 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play320191103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 320191103
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play320191104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1061ui_story = arg_429_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1061ui_story"].transform.position).z)
				arg_429_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1061ui_story"].transform.localEulerAngles = arg_429_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1061ui_story"].transform.position).z)
				arg_429_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1061ui_story"].transform.localEulerAngles = arg_429_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_432_1 = 0
			local var_432_2 = 0.575

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(320191103).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 38 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 38)

				if (38 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 38)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play320191104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 320191104
		arg_433_1.duration_ = 3.47

		local var_433_0 = {
			zh = 3.266,
			ja = 3.466
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
			arg_433_1.auto_ = false
		end

		function arg_433_1.playNext_(arg_435_0)
			arg_433_1.onStoryFinished_()
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1061ui_story = arg_433_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1061ui_story"].transform.position).z)
				arg_433_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1061ui_story"].transform.localEulerAngles = arg_433_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_433_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1061ui_story"].transform.position).z)
				arg_433_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1061ui_story"].transform.localEulerAngles = arg_433_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1061ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1061ui_story == nil then
				arg_433_1.var_.characterEffect1061ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1061ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1061ui_story then
				arg_433_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_436_4 = 0
			local var_436_5 = 0.225

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_6 = arg_433_1:GetWordFromCfg(320191104)
				local var_436_7 = arg_433_1:FormatText(var_436_6.content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 9 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 9)

				if (9 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 9)) > 0 and var_436_5 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_4
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320191", "320191104", "story_v_out_320191.awb") ~= 0 then
					local var_436_10 = manager.audio:GetVoiceLength("story_v_out_320191", "320191104", "story_v_out_320191.awb") / 1000

					if var_436_10 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_4
					end

					if var_436_6.prefab_name ~= "" and arg_433_1.actors_[var_436_6.prefab_name] ~= nil then
						local var_436_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_6.prefab_name].transform, "story_v_out_320191", "320191104", "story_v_out_320191.awb")

						arg_433_1:RecordAudio("320191104", var_436_11)
						arg_433_1:RecordAudio("320191104", var_436_11)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_320191", "320191104", "story_v_out_320191.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_320191", "320191104", "story_v_out_320191.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_12 = math.max(var_436_5, arg_433_1.talkMaxDuration)

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_12 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_4) / var_436_12

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_4 + var_436_12 and arg_433_1.time_ < var_436_4 + var_436_12 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	assets = {
		"TextureConfig/Background/L07j",
		"TextureConfig/Background/L07k",
		"TextureConfig/Background/L07f",
		"TextureConfig/Background/L02f",
		"TextureConfig/Background/ST61"
	},
	voices = {
		"story_v_out_320191.awb"
	}
}
