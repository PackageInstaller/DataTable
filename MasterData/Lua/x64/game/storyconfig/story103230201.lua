return {
	Play323021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323021001
		arg_1_1.duration_ = 11.8

		local var_1_0 = {
			zh = 9.5,
			ja = 11.8
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
				arg_1_0:Play323021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J13f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13f")
				var_4_0.name = "J13f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J13f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J13f

				arg_1_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J13f" then
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

			local var_4_8 = "1071ui_story"

			if arg_1_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1071ui_story"].transform

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1071ui_story = var_4_12.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1071ui_story" .. "Animator"].transform, false)
			end

			local var_4_13 = 0.001

			if 1.83333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.83333333333333 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_1_1.time_ - 1.83333333333333) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.83333333333333 + var_4_13 and arg_1_1.time_ < 1.83333333333333 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.05, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1071ui_story"]

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1071ui_story == nil then
				arg_1_1.var_.characterEffect1071ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.83333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.83333333333333 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1071ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.83333333333333 + var_4_15 and arg_1_1.time_ < 1.83333333333333 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1071ui_story then
				arg_1_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 1.3 < arg_1_1.time_ and arg_1_1.time_ <= 1.3 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.825

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(323021001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 33 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 33)

				if (33 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 33)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021001", "story_v_out_323021.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_323021", "323021001", "story_v_out_323021.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_323021", "323021001", "story_v_out_323021.awb")

						arg_1_1:RecordAudio("323021001", var_4_32)
						arg_1_1:RecordAudio("323021001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323021", "323021001", "story_v_out_323021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323021", "323021001", "story_v_out_323021.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play323021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323021002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1071ui_story"]) and arg_9_1.var_.characterEffect1071ui_story == nil then
				arg_9_1.var_.characterEffect1071ui_story = arg_9_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1071ui_story"]) then
				if arg_9_1.var_.characterEffect1071ui_story and not isNil(arg_9_1.actors_["1071ui_story"]) then
					arg_9_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1071ui_story"]) and arg_9_1.var_.characterEffect1071ui_story then
				arg_9_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323021002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 14 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 14)

				if (14 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 14)) > 0 and var_12_2 < var_12_5 then
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
	Play323021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323021003
		arg_13_1.duration_ = 3.83

		local var_13_0 = {
			zh = 2.8,
			ja = 3.833
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
				arg_13_0:Play323021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1071ui_story"]) and arg_13_1.var_.characterEffect1071ui_story == nil then
				arg_13_1.var_.characterEffect1071ui_story = arg_13_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1071ui_story"]) then
				if arg_13_1.var_.characterEffect1071ui_story and not isNil(arg_13_1.actors_["1071ui_story"]) then
					arg_13_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1071ui_story"]) and arg_13_1.var_.characterEffect1071ui_story then
				arg_13_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_16_2 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_2 + 1.3 and arg_13_1.time_ < var_16_2 + 1.3 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_3 = 1
			local var_16_4 = 0.2

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_5 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_5:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(323021003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 8 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_7) / 8)

				if (8 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_7) / 8)) > 0 and var_16_4 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9
					var_16_3 = var_16_3 + 0.3

					if var_16_9 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021003", "story_v_out_323021.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_323021", "323021003", "story_v_out_323021.awb") / 1000

					if var_16_10 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_3
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_323021", "323021003", "story_v_out_323021.awb")

						arg_13_1:RecordAudio("323021003", var_16_11)
						arg_13_1:RecordAudio("323021003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_323021", "323021003", "story_v_out_323021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_323021", "323021003", "story_v_out_323021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = var_16_3 + 0.3
			local var_16_13 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play323021004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 323021004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play323021005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1071ui_story = arg_19_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1071ui_story"].transform.position).z)
				arg_19_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1071ui_story"].transform.localEulerAngles = arg_19_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1071ui_story"].transform.position).z)
				arg_19_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1071ui_story"].transform.localEulerAngles = arg_19_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1071ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1071ui_story == nil then
				arg_19_1.var_.characterEffect1071ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1071ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_2)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1071ui_story then
				arg_19_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_22_3 = 0
			local var_22_4 = 0.725

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_5 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(323021004).content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 29 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 29)

				if (29 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 29)) > 0 and var_22_4 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_3
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_4, arg_19_1.talkMaxDuration)

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_3) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_3 + var_22_8 and arg_19_1.time_ < var_22_3 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play323021005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 323021005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play323021006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(323021005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 58 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 58)

				if (58 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 58)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play323021006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 323021006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play323021007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.875

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(323021006).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 35 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 35)

				if (35 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 35)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play323021007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 323021007
		arg_31_1.duration_ = 6

		local var_31_0 = {
			zh = 4.7,
			ja = 6
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
				arg_31_0:Play323021008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1071ui_story = arg_31_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1071ui_story"].transform.position).z)
				arg_31_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1071ui_story"].transform.localEulerAngles = arg_31_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_31_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1071ui_story"].transform.position).z)
				arg_31_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1071ui_story"].transform.localEulerAngles = arg_31_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1071ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1071ui_story == nil then
				arg_31_1.var_.characterEffect1071ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1071ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1071ui_story then
				arg_31_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_34_4 = 0
			local var_34_5 = 0.5

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(323021007)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 20 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 20)

				if (20 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 20)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021007", "story_v_out_323021.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_323021", "323021007", "story_v_out_323021.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_323021", "323021007", "story_v_out_323021.awb")

						arg_31_1:RecordAudio("323021007", var_34_11)
						arg_31_1:RecordAudio("323021007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_323021", "323021007", "story_v_out_323021.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_323021", "323021007", "story_v_out_323021.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play323021008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 323021008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play323021009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1071ui_story"]) and arg_35_1.var_.characterEffect1071ui_story == nil then
				arg_35_1.var_.characterEffect1071ui_story = arg_35_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1071ui_story"]) then
				if arg_35_1.var_.characterEffect1071ui_story and not isNil(arg_35_1.actors_["1071ui_story"]) then
					arg_35_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1071ui_story"]) and arg_35_1.var_.characterEffect1071ui_story then
				arg_35_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_38_1 = 0
			local var_38_2 = 0.15

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(323021008).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 6 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 6)

				if (6 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 6)) > 0 and var_38_2 < var_38_5 then
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
	Play323021009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 323021009
		arg_39_1.duration_ = 3.9

		local var_39_0 = {
			zh = 3.333,
			ja = 3.9
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
				arg_39_0:Play323021010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1071ui_story"]) and arg_39_1.var_.characterEffect1071ui_story == nil then
				arg_39_1.var_.characterEffect1071ui_story = arg_39_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1071ui_story"]) then
				if arg_39_1.var_.characterEffect1071ui_story and not isNil(arg_39_1.actors_["1071ui_story"]) then
					arg_39_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1071ui_story"]) and arg_39_1.var_.characterEffect1071ui_story then
				arg_39_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_42_2 = 0
			local var_42_3 = 0.275

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_4 = arg_39_1:GetWordFromCfg(323021009)
				local var_42_5 = arg_39_1:FormatText(var_42_4.content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 11 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 11)

				if (11 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 11)) > 0 and var_42_3 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021009", "story_v_out_323021.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021009", "story_v_out_323021.awb") / 1000

					if var_42_8 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_2
					end

					if var_42_4.prefab_name ~= "" and arg_39_1.actors_[var_42_4.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_4.prefab_name].transform, "story_v_out_323021", "323021009", "story_v_out_323021.awb")

						arg_39_1:RecordAudio("323021009", var_42_9)
						arg_39_1:RecordAudio("323021009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_323021", "323021009", "story_v_out_323021.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_323021", "323021009", "story_v_out_323021.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_3, arg_39_1.talkMaxDuration)

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_2) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_2 + var_42_10 and arg_39_1.time_ < var_42_2 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play323021010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 323021010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play323021011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1071ui_story"]) and arg_43_1.var_.characterEffect1071ui_story == nil then
				arg_43_1.var_.characterEffect1071ui_story = arg_43_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1071ui_story"]) then
				if arg_43_1.var_.characterEffect1071ui_story and not isNil(arg_43_1.actors_["1071ui_story"]) then
					arg_43_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1071ui_story"]) and arg_43_1.var_.characterEffect1071ui_story then
				arg_43_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.9

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(323021010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 36 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 36)

				if (36 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 36)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play323021011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 323021011
		arg_47_1.duration_ = 3.97

		local var_47_0 = {
			zh = 2.833,
			ja = 3.966
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
				arg_47_0:Play323021012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1071ui_story"]) and arg_47_1.var_.characterEffect1071ui_story == nil then
				arg_47_1.var_.characterEffect1071ui_story = arg_47_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1071ui_story"]) then
				if arg_47_1.var_.characterEffect1071ui_story and not isNil(arg_47_1.actors_["1071ui_story"]) then
					arg_47_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1071ui_story"]) and arg_47_1.var_.characterEffect1071ui_story then
				arg_47_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_50_2 = 0
			local var_50_3 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:GetWordFromCfg(323021011)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 9 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 9)

				if (9 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 9)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021011", "story_v_out_323021.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021011", "story_v_out_323021.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_323021", "323021011", "story_v_out_323021.awb")

						arg_47_1:RecordAudio("323021011", var_50_9)
						arg_47_1:RecordAudio("323021011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_323021", "323021011", "story_v_out_323021.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_323021", "323021011", "story_v_out_323021.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play323021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 323021012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play323021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1071ui_story"]) and arg_51_1.var_.characterEffect1071ui_story == nil then
				arg_51_1.var_.characterEffect1071ui_story = arg_51_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1071ui_story"]) then
				if arg_51_1.var_.characterEffect1071ui_story and not isNil(arg_51_1.actors_["1071ui_story"]) then
					arg_51_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1071ui_story"]) and arg_51_1.var_.characterEffect1071ui_story then
				arg_51_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 1.175

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(323021012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 47 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 47)

				if (47 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 47)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play323021013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 323021013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play323021014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.325

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(323021013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 13 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 13)

				if (13 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 13)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play323021014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 323021014
		arg_59_1.duration_ = 2.8

		local var_59_0 = {
			zh = 2.366,
			ja = 2.8
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
				arg_59_0:Play323021015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1071ui_story"]) and arg_59_1.var_.characterEffect1071ui_story == nil then
				arg_59_1.var_.characterEffect1071ui_story = arg_59_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1071ui_story"]) then
				if arg_59_1.var_.characterEffect1071ui_story and not isNil(arg_59_1.actors_["1071ui_story"]) then
					arg_59_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1071ui_story"]) and arg_59_1.var_.characterEffect1071ui_story then
				arg_59_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_62_2 = 0
			local var_62_3 = 0.2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(323021014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 8 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 8)

				if (8 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 8)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021014", "story_v_out_323021.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021014", "story_v_out_323021.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_323021", "323021014", "story_v_out_323021.awb")

						arg_59_1:RecordAudio("323021014", var_62_9)
						arg_59_1:RecordAudio("323021014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_323021", "323021014", "story_v_out_323021.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_323021", "323021014", "story_v_out_323021.awb")
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
	Play323021015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 323021015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play323021016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1071ui_story"]) and arg_63_1.var_.characterEffect1071ui_story == nil then
				arg_63_1.var_.characterEffect1071ui_story = arg_63_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1071ui_story"]) then
				if arg_63_1.var_.characterEffect1071ui_story and not isNil(arg_63_1.actors_["1071ui_story"]) then
					arg_63_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1071ui_story"]) and arg_63_1.var_.characterEffect1071ui_story then
				arg_63_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 1.1

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(323021015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 44 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 44)

				if (44 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 44)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play323021016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 323021016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play323021017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.65

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(323021016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 26 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 26)

				if (26 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 26)) > 0 and var_70_0 < var_70_3 then
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
	Play323021017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 323021017
		arg_71_1.duration_ = 4.6

		local var_71_0 = {
			zh = 3.066,
			ja = 4.6
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
				arg_71_0:Play323021018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1071ui_story"]) and arg_71_1.var_.characterEffect1071ui_story == nil then
				arg_71_1.var_.characterEffect1071ui_story = arg_71_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1071ui_story"]) then
				if arg_71_1.var_.characterEffect1071ui_story and not isNil(arg_71_1.actors_["1071ui_story"]) then
					arg_71_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1071ui_story"]) and arg_71_1.var_.characterEffect1071ui_story then
				arg_71_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_74_2 = 0
			local var_74_3 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_4 = arg_71_1:GetWordFromCfg(323021017)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 16 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 16)

				if (16 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 16)) > 0 and var_74_3 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021017", "story_v_out_323021.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021017", "story_v_out_323021.awb") / 1000

					if var_74_8 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_2
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_323021", "323021017", "story_v_out_323021.awb")

						arg_71_1:RecordAudio("323021017", var_74_9)
						arg_71_1:RecordAudio("323021017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_323021", "323021017", "story_v_out_323021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_323021", "323021017", "story_v_out_323021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_10 and arg_71_1.time_ < var_74_2 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play323021018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 323021018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play323021019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1071ui_story"]) and arg_75_1.var_.characterEffect1071ui_story == nil then
				arg_75_1.var_.characterEffect1071ui_story = arg_75_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1071ui_story"]) then
				if arg_75_1.var_.characterEffect1071ui_story and not isNil(arg_75_1.actors_["1071ui_story"]) then
					arg_75_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1071ui_story"]) and arg_75_1.var_.characterEffect1071ui_story then
				arg_75_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.325

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(323021018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 13 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 13)

				if (13 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 13)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play323021019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 323021019
		arg_79_1.duration_ = 12.1

		local var_79_0 = {
			zh = 7.533,
			ja = 12.1
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
				arg_79_0:Play323021020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1071ui_story"]) and arg_79_1.var_.characterEffect1071ui_story == nil then
				arg_79_1.var_.characterEffect1071ui_story = arg_79_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1071ui_story"]) then
				if arg_79_1.var_.characterEffect1071ui_story and not isNil(arg_79_1.actors_["1071ui_story"]) then
					arg_79_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1071ui_story"]) and arg_79_1.var_.characterEffect1071ui_story then
				arg_79_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_82_2 = 0
			local var_82_3 = 1.025

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(323021019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 41 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 41)

				if (41 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 41)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021019", "story_v_out_323021.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021019", "story_v_out_323021.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_323021", "323021019", "story_v_out_323021.awb")

						arg_79_1:RecordAudio("323021019", var_82_9)
						arg_79_1:RecordAudio("323021019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_323021", "323021019", "story_v_out_323021.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_323021", "323021019", "story_v_out_323021.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play323021020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 323021020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play323021021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1071ui_story"]) and arg_83_1.var_.characterEffect1071ui_story == nil then
				arg_83_1.var_.characterEffect1071ui_story = arg_83_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1071ui_story"]) then
				if arg_83_1.var_.characterEffect1071ui_story and not isNil(arg_83_1.actors_["1071ui_story"]) then
					arg_83_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1071ui_story"]) and arg_83_1.var_.characterEffect1071ui_story then
				arg_83_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_86_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_83_1.bgmTxt_.text ~= var_86_3 and arg_83_1.bgmTxt_.text ~= "" then
						if arg_83_1.bgmTxt2_.text ~= "" then
							arg_83_1.bgmTxt_.text = arg_83_1.bgmTxt2_.text
						end

						arg_83_1.bgmTxt2_.text = var_86_3

						arg_83_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_83_1.bgmTxt_.text = var_86_3
						arg_83_1.bgmTxt2_.text = var_86_3
					end

					if arg_83_1.bgmTimer then
						arg_83_1.bgmTimer:Stop()

						arg_83_1.bgmTimer = nil
					end

					if arg_83_1.settingData.show_music_name == 1 then
						arg_83_1.musicController:SetSelectedState("show")
						arg_83_1.musicAnimator_:Play("open", 0, 0)

						if arg_83_1.settingData.music_time ~= 0 then
							arg_83_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_83_1.settingData.music_time), function()
								if arg_83_1 == nil or isNil(arg_83_1.bgmTxt_) then
									return
								end

								arg_83_1.musicController:SetSelectedState("hide")
								arg_83_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_86_4 = 0
			local var_86_5 = 0.375

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_6 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(323021020).content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 15 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 15)

				if (15 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 15)) > 0 and var_86_5 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_9 and arg_83_1.time_ < var_86_4 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play323021021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 323021021
		arg_88_1.duration_ = 8.77

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play323021022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if arg_88_1.bgs_.ST12 == nil then
				local var_91_0 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_91_0.name = "ST12"
				var_91_0.transform.parent = arg_88_1.stage_.transform
				var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_.ST12 = var_91_0
			end

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				local var_91_1 = arg_88_1.bgs_.ST12

				arg_88_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_2 = var_91_1:GetComponent("SpriteRenderer")

				if var_91_2 and var_91_2.sprite then
					local var_91_3 = 2 * (var_91_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_1.transform.localScale = Vector3.New(var_91_3 / var_91_2.sprite.bounds.size.y < var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x and var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x or var_91_3 / var_91_2.sprite.bounds.size.y, var_91_3 / var_91_2.sprite.bounds.size.y < var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x and var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x or var_91_3 / var_91_2.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "ST12" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_4 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= var_91_4 + 0.3 and arg_88_1.time_ < var_91_4 + 0.3 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_5 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_6 = 2

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 then
				local var_91_7 = Color.New(0, 0, 0)

				var_91_7.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_5) / var_91_6)
				arg_88_1.mask_.color = var_91_7
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 then
				local var_91_8 = Color.New(0, 0, 0)

				var_91_8.a = 1
				arg_88_1.mask_.color = var_91_8
			end

			local var_91_9 = 2

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_10 = 2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 then
				local var_91_11 = Color.New(0, 0, 0)

				var_91_11.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_9) / var_91_10)
				arg_88_1.mask_.color = var_91_11
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 then
				local var_91_12 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_12.a = 0
				arg_88_1.mask_.color = var_91_12
			end

			local var_91_13 = arg_88_1.actors_["1071ui_story"].transform

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				arg_88_1.var_.moveOldPos1071ui_story = var_91_13.localPosition
			end

			local var_91_14 = 0.001

			if 2 <= arg_88_1.time_ and arg_88_1.time_ < 2 + var_91_14 then
				var_91_13.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 2) / var_91_14)
				var_91_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_13.position).x, (manager.ui.mainCamera.transform.position - var_91_13.position).y, (manager.ui.mainCamera.transform.position - var_91_13.position).z)
				var_91_13.localEulerAngles.z = 0
				var_91_13.localEulerAngles.x = 0
				var_91_13.localEulerAngles = var_91_13.localEulerAngles
			end

			if arg_88_1.time_ >= 2 + var_91_14 and arg_88_1.time_ < 2 + var_91_14 + arg_91_0 then
				var_91_13.localPosition = Vector3.New(0, 100, 0)
				var_91_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_13.position).x, (manager.ui.mainCamera.transform.position - var_91_13.position).y, (manager.ui.mainCamera.transform.position - var_91_13.position).z)
				var_91_13.localEulerAngles.z = 0
				var_91_13.localEulerAngles.x = 0
				var_91_13.localEulerAngles = var_91_13.localEulerAngles
			end

			local var_91_15 = 2

			arg_88_1.isInRecall_ = false

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.screenFilterGo_:SetActive(true)

				arg_88_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_91_2, iter_91_3 in pairs(arg_88_1.actors_) do
					for iter_91_4, iter_91_5 in ipairs((iter_91_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_91_5.color = iter_91_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_91_16 = 0.034000001847744

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_16 then
				arg_88_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_15) / var_91_16)
			end

			if arg_88_1.time_ >= var_91_15 + var_91_16 and arg_88_1.time_ < var_91_15 + var_91_16 + arg_91_0 then
				arg_88_1.screenFilterEffect_.weight = 1
			end

			if 0.3 < arg_88_1.time_ and arg_88_1.time_ <= 0.3 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_91_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_19 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_19

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_19
						arg_88_1.bgmTxt2_.text = var_91_19
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.73333333333333 < arg_88_1.time_ and arg_88_1.time_ <= 1.73333333333333 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_91_22 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_22 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_22

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_22
						arg_88_1.bgmTxt2_.text = var_91_22
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_88_1.time_ and arg_88_1.time_ <= 0.3 + arg_91_0 then
				arg_88_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if 1.73333333333333 < arg_88_1.time_ and arg_88_1.time_ <= 1.73333333333333 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_25 = 3.766666666666
			local var_91_26 = 0.475

			if 3.766666666666 < arg_88_1.time_ and arg_88_1.time_ <= var_91_25 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_27 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_27:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_88_1.dialogCg_.alpha = arg_94_0
				end))
				var_91_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_28 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(323021021).content)

				arg_88_1.text_.text = var_91_28

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_30 = 19 <= 0 and var_91_26 or var_91_26 * (utf8.len(var_91_28) / 19)

				if (19 <= 0 and var_91_26 or var_91_26 * (utf8.len(var_91_28) / 19)) > 0 and var_91_26 < var_91_30 then
					arg_88_1.talkMaxDuration = var_91_30
					var_91_25 = var_91_25 + 0.3

					if var_91_30 + var_91_25 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_30 + var_91_25
					end
				end

				arg_88_1.text_.text = var_91_28
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_31 = var_91_25 + 0.3
			local var_91_32 = math.max(var_91_26, arg_88_1.talkMaxDuration)

			if var_91_25 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_31 + var_91_32 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_31) / var_91_32

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_31 + var_91_32 and arg_88_1.time_ < var_91_31 + var_91_32 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play323021022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 323021022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play323021023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 1.275

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(323021022).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 51 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 51)

				if (51 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 51)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play323021023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 323021023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play323021024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 1.4 < arg_100_1.time_ and arg_100_1.time_ <= 1.4 + arg_103_0 then
				arg_100_1:AudioAction("play", "effect", "se_story_143", "se_story_143_knock", "")
			end

			local var_103_1 = 0
			local var_103_2 = 1.525

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(323021023).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 61 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 61)

				if (61 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 61)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play323021024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 323021024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play323021025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.075

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_104_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(323021024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 3 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 3)

				if (3 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 3)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play323021025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 323021025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play323021026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0.1 < arg_108_1.time_ and arg_108_1.time_ <= 0.1 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			local var_111_1 = 0
			local var_111_2 = 1.1

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(323021025).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 44 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 44)

				if (44 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 44)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play323021026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 323021026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play323021027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.25

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(323021026).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 10 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 10)

				if (10 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 10)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play323021027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 323021027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play323021028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.05

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_116_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(323021027).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 2 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 2)

				if (2 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 2)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play323021028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 323021028
		arg_120_1.duration_ = 2.03

		local var_120_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_120_0:Play323021029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_123_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_120_1.stage_.transform)

				var_123_0.name = "1019ui_story"
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["1019ui_story"] = var_123_0

				local var_123_1 = var_123_0:GetComponentInChildren(typeof(CharacterEffect))

				var_123_1.enabled = true

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end

				arg_120_1:ShowWeapon(var_123_1.transform, false)

				arg_120_1.var_["1019ui_story" .. "Animator"] = var_123_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_120_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_120_1.var_["1019ui_story" .. "LipSync"] = var_123_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_123_3 = arg_120_1.actors_["1019ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = var_123_3.localPosition
			end

			local var_123_4 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				var_123_3.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_120_1.time_ - 0) / var_123_4)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				var_123_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			local var_123_5 = arg_120_1.actors_["1019ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_5) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_6 and not isNil(var_123_5) then
				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_5) then
					arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_6 and arg_120_1.time_ < 0 + var_123_6 + arg_123_0 and not isNil(var_123_5) and arg_120_1.var_.characterEffect1019ui_story then
				arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_8 = 0
			local var_123_9 = 0.125

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(323021028)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_13 = 5 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 5)

				if (5 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 5)) > 0 and var_123_9 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_8
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021028", "story_v_out_323021.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_323021", "323021028", "story_v_out_323021.awb") / 1000

					if var_123_14 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_8
					end

					if var_123_10.prefab_name ~= "" and arg_120_1.actors_[var_123_10.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_10.prefab_name].transform, "story_v_out_323021", "323021028", "story_v_out_323021.awb")

						arg_120_1:RecordAudio("323021028", var_123_15)
						arg_120_1:RecordAudio("323021028", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_323021", "323021028", "story_v_out_323021.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_323021", "323021028", "story_v_out_323021.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_9, arg_120_1.talkMaxDuration)

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_8) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_8 + var_123_16 and arg_120_1.time_ < var_123_8 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play323021029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 323021029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play323021030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) and arg_124_1.var_.characterEffect1019ui_story == nil then
				arg_124_1.var_.characterEffect1019ui_story = arg_124_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) then
				if arg_124_1.var_.characterEffect1019ui_story and not isNil(arg_124_1.actors_["1019ui_story"]) then
					arg_124_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) and arg_124_1.var_.characterEffect1019ui_story then
				arg_124_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.125

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_124_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(323021029).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 5 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 5)

				if (5 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 5)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play323021030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 323021030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play323021031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1019ui_story = arg_128_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1019ui_story"].transform.position).z)
				arg_128_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1019ui_story"].transform.localEulerAngles = arg_128_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1019ui_story"].transform.position).z)
				arg_128_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1019ui_story"].transform.localEulerAngles = arg_128_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_131_1 = 0
			local var_131_2 = 0.65

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(323021030).content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 26 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 26)

				if (26 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 26)) > 0 and var_131_2 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_6 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_6 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_6

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_6 and arg_128_1.time_ < var_131_1 + var_131_6 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play323021031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 323021031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play323021032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 1.75

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(323021031).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 70 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 70)

				if (70 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 70)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play323021032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 323021032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play323021033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.35

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_136_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(323021032).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 14 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 14)

				if (14 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 14)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play323021033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 323021033
		arg_140_1.duration_ = 4.3

		local var_140_0 = {
			zh = 2.8,
			ja = 4.3
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
				arg_140_0:Play323021034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1019ui_story = arg_140_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).z)
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles = arg_140_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_140_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).z)
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles = arg_140_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["1019ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1019ui_story == nil then
				arg_140_1.var_.characterEffect1019ui_story = var_143_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 and not isNil(var_143_1) then
				if arg_140_1.var_.characterEffect1019ui_story and not isNil(var_143_1) then
					arg_140_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1019ui_story then
				arg_140_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_143_4 = 0
			local var_143_5 = 0.425

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(323021033)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 17 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 17)

				if (17 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 17)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021033", "story_v_out_323021.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_323021", "323021033", "story_v_out_323021.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_323021", "323021033", "story_v_out_323021.awb")

						arg_140_1:RecordAudio("323021033", var_143_11)
						arg_140_1:RecordAudio("323021033", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_323021", "323021033", "story_v_out_323021.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_323021", "323021033", "story_v_out_323021.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play323021034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 323021034
		arg_144_1.duration_ = 7.97

		local var_144_0 = {
			zh = 7.266,
			ja = 7.966
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
				arg_144_0:Play323021035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.85

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(323021034)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 34 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 34)

				if (34 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 34)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021034", "story_v_out_323021.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021034", "story_v_out_323021.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_323021", "323021034", "story_v_out_323021.awb")

						arg_144_1:RecordAudio("323021034", var_147_6)
						arg_144_1:RecordAudio("323021034", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_323021", "323021034", "story_v_out_323021.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_323021", "323021034", "story_v_out_323021.awb")
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
	Play323021035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 323021035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play323021036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = arg_148_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) then
				if arg_148_1.var_.characterEffect1019ui_story and not isNil(arg_148_1.actors_["1019ui_story"]) then
					arg_148_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) and arg_148_1.var_.characterEffect1019ui_story then
				arg_148_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.225

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_148_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(323021035).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 9 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 9)

				if (9 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 9)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_6 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_6 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_6

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_6 and arg_148_1.time_ < var_151_1 + var_151_6 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play323021036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 323021036
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play323021037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1019ui_story = arg_152_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1019ui_story"].transform.position).z)
				arg_152_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1019ui_story"].transform.localEulerAngles = arg_152_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1019ui_story"].transform.position).z)
				arg_152_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1019ui_story"].transform.localEulerAngles = arg_152_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0.034000001847744 < arg_152_1.time_ and arg_152_1.time_ <= 0.034000001847744 + arg_155_0 then
				arg_152_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_mute", "")
			end

			local var_155_2 = 0
			local var_155_3 = 1.025

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(323021036).content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_6 = 41 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_4) / 41)

				if (41 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_4) / 41)) > 0 and var_155_3 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_7 and arg_152_1.time_ < var_155_2 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play323021037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 323021037
		arg_156_1.duration_ = 4.03

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play323021038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_9000

			if arg_156_1.bgs_.STblack == nil then
				local var_159_0 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_159_0.name = "STblack"
				var_159_0.transform.parent = arg_156_1.stage_.transform
				var_159_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_.STblack = var_159_0
			end

			if 1 < arg_156_1.time_ and arg_156_1.time_ <= 1 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.STblack

				arg_156_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_2 = var_159_1:GetComponent("SpriteRenderer")

				if var_159_2 and var_159_2.sprite then
					local var_159_3 = 2 * (var_159_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_1.transform.localScale = Vector3.New(var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "STblack" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_4 = 1

			if 1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_4 + 0.3 and arg_156_1.time_ < var_159_4 + 0.3 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_5 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_6 = 1

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 then
				local var_159_7 = Color.New(0, 0, 0)

				var_159_7.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_5) / var_159_6)
				arg_156_1.mask_.color = var_159_7
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 then
				local var_159_8 = Color.New(0, 0, 0)

				var_159_8.a = 1
				arg_156_1.mask_.color = var_159_8
			end

			local var_159_9 = 1

			if 1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_10 = 2

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_10 then
				local var_159_11 = Color.New(0, 0, 0)

				var_159_11.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_9) / var_159_10)
				arg_156_1.mask_.color = var_159_11
			end

			if arg_156_1.time_ >= var_159_9 + var_159_10 and arg_156_1.time_ < var_159_9 + var_159_10 + arg_159_0 then
				local var_159_12 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_12.a = 0
				arg_156_1.mask_.color = var_159_12
			end

			if 1.5 < arg_156_1.time_ and arg_156_1.time_ <= 1.5 + arg_159_0 then
				local var_159_13 = arg_156_1.var_.effect4535

				if not arg_156_1.var_.effect4535 then
					var_159_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_159_13.name = "4535"
					arg_156_1.var_.effect4535 = var_159_13
				else
					var_159_13.transform:SetParent(var_159_9000)
				end

				var_159_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_159_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_159_13.transform.localScale = Vector3.New(var_159_13.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_159_13.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_159_13.transform.localScale.z)
			end

			if 2.76666666666667 < arg_156_1.time_ and arg_156_1.time_ <= 2.76666666666667 + arg_159_0 then
				if arg_156_1.var_.effect4535 then
					Object.Destroy(arg_156_1.var_.effect4535)

					arg_156_1.var_.effect4535 = nil
				end
			end

			local var_159_16 = 1

			arg_156_1.isInRecall_ = false

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.screenFilterGo_:SetActive(false)

				for iter_159_2, iter_159_3 in pairs(arg_156_1.actors_) do
					for iter_159_4, iter_159_5 in ipairs((iter_159_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_159_5.color = iter_159_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_159_17 = 0.0666666666666667

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_17 then
				arg_156_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_16) / var_159_17)
			end

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 then
				arg_156_1.screenFilterEffect_.weight = 0
			end

			if 0.2 < arg_156_1.time_ and arg_156_1.time_ <= 0.2 + arg_159_0 then
				arg_156_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_159_19 = 1
			local var_159_20 = manager.audio:GetVoiceLength("story_v_out_323021", "323021037", "0") / 1000

			if var_159_20 > 0 and 1 < var_159_20 and var_159_20 + var_159_19 > arg_156_1.duration_ then
				arg_156_1.duration_ = var_159_20 + var_159_19
			end

			if var_159_19 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1:AudioAction("play", "voice", "story_v_out_323021", "323021037", "0")
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 323021037,
				charCount = 10,
				enableLayoutChange = true,
				duration = 0.666666666666667,
				groupID = "222",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(245, 170),
					offsetMax = Vector2.New(-128.6, -143.2),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play323021038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 323021038
		arg_160_1.duration_ = 1.3

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play323021039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = manager.audio:GetVoiceLength("story_v_out_323021", "323021038", "0") / 1000

			if var_163_0 > 0 and 1 < var_163_0 and var_163_0 + 0.3 > arg_160_1.duration_ then
				arg_160_1.duration_ = var_163_0 + 0.3
			end

			if 0.3 < arg_160_1.time_ and arg_160_1.time_ <= 0.3 + arg_163_0 then
				arg_160_1:AudioAction("play", "voice", "story_v_out_323021", "323021038", "0")
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 323021038,
				charCount = 15,
				enableLayoutChange = true,
				duration = 1,
				groupID = "222",
				startTime = 0.3,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(115.8, 24.3),
					offsetMax = Vector2.New(-128.6, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play323021039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 323021039
		arg_164_1.duration_ = 3.13

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play323021040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_9000

			if 0.6 < arg_164_1.time_ and arg_164_1.time_ <= 0.6 + arg_167_0 then
				local var_167_0 = arg_164_1.var_.effectqqqq

				if not arg_164_1.var_.effectqqqq then
					var_167_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_167_0.name = "qqqq"
					arg_164_1.var_.effectqqqq = var_167_0
				else
					var_167_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_167_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_167_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_167_0.transform.localScale = Vector3.New(var_167_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_167_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_167_0.transform.localScale.z)
			end

			if 1.6 < arg_164_1.time_ and arg_164_1.time_ <= 1.6 + arg_167_0 then
				local var_167_2 = arg_164_1.var_.effectqqqq1

				if not arg_164_1.var_.effectqqqq1 then
					var_167_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_167_2.name = "qqqq1"
					arg_164_1.var_.effectqqqq1 = var_167_2
				else
					var_167_2.transform:SetParent(var_167_9000)
				end

				var_167_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_167_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_167_2.transform.localScale = Vector3.New(var_167_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_167_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_167_2.transform.localScale.z)
			end

			if 1.6 < arg_164_1.time_ and arg_164_1.time_ <= 1.6 + arg_167_0 then
				if arg_164_1.var_.effectqqqq then
					Object.Destroy(arg_164_1.var_.effectqqqq)

					arg_164_1.var_.effectqqqq = nil
				end
			end

			if 2.36666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 2.36666666666667 + arg_167_0 then
				if arg_164_1.var_.effectqqqq1 then
					Object.Destroy(arg_164_1.var_.effectqqqq1)

					arg_164_1.var_.effectqqqq1 = nil
				end
			end

			local var_167_6 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= var_167_6 + 1.9 and arg_164_1.time_ < var_167_6 + 1.9 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_7 = 0.3
			local var_167_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021039", "0") / 1000

			if var_167_8 > 0 and 1 < var_167_8 and var_167_8 + var_167_7 > arg_164_1.duration_ then
				arg_164_1.duration_ = var_167_8 + var_167_7
			end

			if var_167_7 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 then
				arg_164_1:AudioAction("play", "voice", "story_v_out_323021", "323021039", "0")
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 323021039,
				charCount = 16,
				enableLayoutChange = true,
				duration = 1.06666666666667,
				groupID = "222",
				startTime = 0.3,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(115.8, 24.3),
					offsetMax = Vector2.New(-128.6, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play323021040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 323021040
		arg_168_1.duration_ = 7.93

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play323021041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 1.26666666666667 < arg_168_1.time_ and arg_168_1.time_ <= 1.26666666666667 + arg_171_0 then
				local var_171_0 = arg_168_1.bgs_.ST12

				arg_168_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_171_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_171_1 = var_171_0:GetComponent("SpriteRenderer")

				if var_171_1 and var_171_1.sprite then
					local var_171_2 = 2 * (var_171_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_171_0.transform.localScale = Vector3.New(var_171_2 / var_171_1.sprite.bounds.size.y < var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x and var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x or var_171_2 / var_171_1.sprite.bounds.size.y, var_171_2 / var_171_1.sprite.bounds.size.y < var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x and var_171_2 * manager.ui.mainCameraCom_.aspect / var_171_1.sprite.bounds.size.x or var_171_2 / var_171_1.sprite.bounds.size.y, 0)
				end

				for iter_171_0, iter_171_1 in pairs(arg_168_1.bgs_) do
					if iter_171_0 ~= "ST12" then
						iter_171_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_171_3 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			if arg_168_1.time_ >= var_171_3 + 0.3 and arg_168_1.time_ < var_171_3 + 0.3 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_4 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_5 = 1.26666666666667

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_5 then
				local var_171_6 = Color.New(0, 0, 0)

				var_171_6.a = Mathf.Lerp(0, 1, (arg_168_1.time_ - var_171_4) / var_171_5)
				arg_168_1.mask_.color = var_171_6
			end

			if arg_168_1.time_ >= var_171_4 + var_171_5 and arg_168_1.time_ < var_171_4 + var_171_5 + arg_171_0 then
				local var_171_7 = Color.New(0, 0, 0)

				var_171_7.a = 1
				arg_168_1.mask_.color = var_171_7
			end

			local var_171_8 = 1.26666666666667

			if 1.26666666666667 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_9 = 1.84166666666667

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_9 then
				local var_171_10 = Color.New(0, 0, 0)

				var_171_10.a = Mathf.Lerp(1, 0, (arg_168_1.time_ - var_171_8) / var_171_9)
				arg_168_1.mask_.color = var_171_10
			end

			if arg_168_1.time_ >= var_171_8 + var_171_9 and arg_168_1.time_ < var_171_8 + var_171_9 + arg_171_0 then
				local var_171_11 = Color.New(0, 0, 0)

				arg_168_1.mask_.enabled = false
				var_171_11.a = 0
				arg_168_1.mask_.color = var_171_11
			end

			if 1 < arg_168_1.time_ and arg_168_1.time_ <= 1 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_171_13 = 1.23266666481892

			arg_168_1.isInRecall_ = false

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1.screenFilterGo_:SetActive(true)

				arg_168_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_171_2, iter_171_3 in pairs(arg_168_1.actors_) do
					for iter_171_4, iter_171_5 in ipairs((iter_171_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_171_5.color = iter_171_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_171_14 = 0.034000001847744

			if var_171_13 <= arg_168_1.time_ and arg_168_1.time_ < var_171_13 + var_171_14 then
				arg_168_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_168_1.time_ - var_171_13) / var_171_14)
			end

			if arg_168_1.time_ >= var_171_13 + var_171_14 and arg_168_1.time_ < var_171_13 + var_171_14 + arg_171_0 then
				arg_168_1.screenFilterEffect_.weight = 1
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_15 = 2.93333333333333
			local var_171_16 = 0.175

			if 2.93333333333333 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_17 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_17:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_168_1.dialogCg_.alpha = arg_172_0
				end))
				var_171_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_168_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_171_18 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(323021040).content)

				arg_168_1.text_.text = var_171_18

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_20 = 7 <= 0 and var_171_16 or var_171_16 * (utf8.len(var_171_18) / 7)

				if (7 <= 0 and var_171_16 or var_171_16 * (utf8.len(var_171_18) / 7)) > 0 and var_171_16 < var_171_20 then
					arg_168_1.talkMaxDuration = var_171_20
					var_171_15 = var_171_15 + 0.3

					if var_171_20 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_15
					end
				end

				arg_168_1.text_.text = var_171_18
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_21 = var_171_15 + 0.3
			local var_171_22 = math.max(var_171_16, arg_168_1.talkMaxDuration)

			if var_171_15 + 0.3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_21 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_21) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_21 + var_171_22 and arg_168_1.time_ < var_171_21 + var_171_22 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				groupID = "323021037",
				duration = 0.666666666666667,
				className = "StoryTextGroupNode",
				startTime = 1.26666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play323021041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 323021041
		arg_174_1.duration_ = 6.13

		local var_174_0 = {
			zh = 6.1,
			ja = 6.133
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play323021042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1019ui_story = arg_174_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1019ui_story"].transform.position).z)
				arg_174_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1019ui_story"].transform.localEulerAngles = arg_174_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_174_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1019ui_story"].transform.position).z)
				arg_174_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1019ui_story"].transform.localEulerAngles = arg_174_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["1019ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect1019ui_story == nil then
				arg_174_1.var_.characterEffect1019ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect1019ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect1019ui_story then
				arg_174_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_mute_off", "")
			end

			local var_177_5 = 0
			local var_177_6 = 0.75

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:GetWordFromCfg(323021041)
				local var_177_8 = arg_174_1:FormatText(var_177_7.content)

				arg_174_1.text_.text = var_177_8

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_10 = 30 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 30)

				if (30 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 30)) > 0 and var_177_6 < var_177_10 then
					arg_174_1.talkMaxDuration = var_177_10

					if var_177_10 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_8
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021041", "story_v_out_323021.awb") ~= 0 then
					local var_177_11 = manager.audio:GetVoiceLength("story_v_out_323021", "323021041", "story_v_out_323021.awb") / 1000

					if var_177_11 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_5
					end

					if var_177_7.prefab_name ~= "" and arg_174_1.actors_[var_177_7.prefab_name] ~= nil then
						local var_177_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_7.prefab_name].transform, "story_v_out_323021", "323021041", "story_v_out_323021.awb")

						arg_174_1:RecordAudio("323021041", var_177_12)
						arg_174_1:RecordAudio("323021041", var_177_12)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_323021", "323021041", "story_v_out_323021.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_323021", "323021041", "story_v_out_323021.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_6, arg_174_1.talkMaxDuration)

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_5) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_5 + var_177_13 and arg_174_1.time_ < var_177_5 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play323021042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 323021042
		arg_178_1.duration_ = 8.07

		local var_178_0 = {
			zh = 7.766,
			ja = 8.066
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play323021043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.925

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:GetWordFromCfg(323021042)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 37 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 37)

				if (37 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 37)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021042", "story_v_out_323021.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021042", "story_v_out_323021.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_323021", "323021042", "story_v_out_323021.awb")

						arg_178_1:RecordAudio("323021042", var_181_6)
						arg_178_1:RecordAudio("323021042", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_323021", "323021042", "story_v_out_323021.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_323021", "323021042", "story_v_out_323021.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play323021043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 323021043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play323021044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1019ui_story"]) and arg_182_1.var_.characterEffect1019ui_story == nil then
				arg_182_1.var_.characterEffect1019ui_story = arg_182_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1019ui_story"]) then
				if arg_182_1.var_.characterEffect1019ui_story and not isNil(arg_182_1.actors_["1019ui_story"]) then
					arg_182_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1019ui_story"]) and arg_182_1.var_.characterEffect1019ui_story then
				arg_182_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_185_1 = 0
			local var_185_2 = 0.9

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_182_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_185_3 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(323021043).content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 36 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 36)

				if (36 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 36)) > 0 and var_185_2 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_6 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_6 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_6

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_6 and arg_182_1.time_ < var_185_1 + var_185_6 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play323021044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 323021044
		arg_186_1.duration_ = 7.93

		local var_186_0 = {
			zh = 7.7,
			ja = 7.933
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play323021045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1019ui_story"]) and arg_186_1.var_.characterEffect1019ui_story == nil then
				arg_186_1.var_.characterEffect1019ui_story = arg_186_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1019ui_story"]) then
				if arg_186_1.var_.characterEffect1019ui_story and not isNil(arg_186_1.actors_["1019ui_story"]) then
					arg_186_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1019ui_story"]) and arg_186_1.var_.characterEffect1019ui_story then
				arg_186_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_189_2 = 0
			local var_189_3 = 0.825

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(323021044)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 33 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 33)

				if (33 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 33)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021044", "story_v_out_323021.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021044", "story_v_out_323021.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_323021", "323021044", "story_v_out_323021.awb")

						arg_186_1:RecordAudio("323021044", var_189_9)
						arg_186_1:RecordAudio("323021044", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_323021", "323021044", "story_v_out_323021.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_323021", "323021044", "story_v_out_323021.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play323021045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 323021045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play323021046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1019ui_story"]) and arg_190_1.var_.characterEffect1019ui_story == nil then
				arg_190_1.var_.characterEffect1019ui_story = arg_190_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1019ui_story"]) then
				if arg_190_1.var_.characterEffect1019ui_story and not isNil(arg_190_1.actors_["1019ui_story"]) then
					arg_190_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1019ui_story"]) and arg_190_1.var_.characterEffect1019ui_story then
				arg_190_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.8

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(323021045).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 32 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 32)

				if (32 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 32)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play323021046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 323021046
		arg_194_1.duration_ = 6.63

		local var_194_0 = {
			zh = 5.333,
			ja = 6.633
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play323021047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1019ui_story"]) and arg_194_1.var_.characterEffect1019ui_story == nil then
				arg_194_1.var_.characterEffect1019ui_story = arg_194_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1019ui_story"]) then
				if arg_194_1.var_.characterEffect1019ui_story and not isNil(arg_194_1.actors_["1019ui_story"]) then
					arg_194_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1019ui_story"]) and arg_194_1.var_.characterEffect1019ui_story then
				arg_194_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_2 = 0
			local var_197_3 = 0.6

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(323021046)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 24 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 24)

				if (24 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 24)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021046", "story_v_out_323021.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021046", "story_v_out_323021.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_323021", "323021046", "story_v_out_323021.awb")

						arg_194_1:RecordAudio("323021046", var_197_9)
						arg_194_1:RecordAudio("323021046", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_323021", "323021046", "story_v_out_323021.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_323021", "323021046", "story_v_out_323021.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play323021047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 323021047
		arg_198_1.duration_ = 11.97

		local var_198_0 = {
			zh = 7.1,
			ja = 11.966
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play323021048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 1.05

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(323021047)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 42 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 42)

				if (42 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 42)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021047", "story_v_out_323021.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021047", "story_v_out_323021.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_323021", "323021047", "story_v_out_323021.awb")

						arg_198_1:RecordAudio("323021047", var_201_6)
						arg_198_1:RecordAudio("323021047", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_323021", "323021047", "story_v_out_323021.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_323021", "323021047", "story_v_out_323021.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play323021048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 323021048
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play323021049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1019ui_story"]) and arg_202_1.var_.characterEffect1019ui_story == nil then
				arg_202_1.var_.characterEffect1019ui_story = arg_202_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1019ui_story"]) then
				if arg_202_1.var_.characterEffect1019ui_story and not isNil(arg_202_1.actors_["1019ui_story"]) then
					arg_202_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1019ui_story"]) and arg_202_1.var_.characterEffect1019ui_story then
				arg_202_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.575

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_202_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(323021048).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 23 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 23)

				if (23 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 23)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play323021049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 323021049
		arg_206_1.duration_ = 4.47

		local var_206_0 = {
			zh = 1.966,
			ja = 4.466
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play323021050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1019ui_story"]) and arg_206_1.var_.characterEffect1019ui_story == nil then
				arg_206_1.var_.characterEffect1019ui_story = arg_206_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1019ui_story"]) then
				if arg_206_1.var_.characterEffect1019ui_story and not isNil(arg_206_1.actors_["1019ui_story"]) then
					arg_206_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1019ui_story"]) and arg_206_1.var_.characterEffect1019ui_story then
				arg_206_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_209_2 = 0
			local var_209_3 = 0.275

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(323021049)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 11 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 11)

				if (11 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 11)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021049", "story_v_out_323021.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021049", "story_v_out_323021.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_out_323021", "323021049", "story_v_out_323021.awb")

						arg_206_1:RecordAudio("323021049", var_209_9)
						arg_206_1:RecordAudio("323021049", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_323021", "323021049", "story_v_out_323021.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_323021", "323021049", "story_v_out_323021.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play323021050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 323021050
		arg_210_1.duration_ = 19

		local var_210_0 = {
			zh = 11.433,
			ja = 19
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play323021051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_213_0 = 0
			local var_213_1 = 1.4

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:GetWordFromCfg(323021050)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 56 <= 0 and var_213_1 or var_213_1 * (utf8.len(var_213_3) / 56)

				if (56 <= 0 and var_213_1 or var_213_1 * (utf8.len(var_213_3) / 56)) > 0 and var_213_1 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021050", "story_v_out_323021.awb") ~= 0 then
					local var_213_6 = manager.audio:GetVoiceLength("story_v_out_323021", "323021050", "story_v_out_323021.awb") / 1000

					if var_213_6 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_0
					end

					if var_213_2.prefab_name ~= "" and arg_210_1.actors_[var_213_2.prefab_name] ~= nil then
						local var_213_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_2.prefab_name].transform, "story_v_out_323021", "323021050", "story_v_out_323021.awb")

						arg_210_1:RecordAudio("323021050", var_213_7)
						arg_210_1:RecordAudio("323021050", var_213_7)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_323021", "323021050", "story_v_out_323021.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_323021", "323021050", "story_v_out_323021.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_8 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_8 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_8

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_8 and arg_210_1.time_ < var_213_0 + var_213_8 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play323021051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 323021051
		arg_214_1.duration_ = 16.8

		local var_214_0 = {
			zh = 10.733,
			ja = 16.8
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play323021052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 1.4

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:GetWordFromCfg(323021051)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 56 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 56)

				if (56 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 56)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021051", "story_v_out_323021.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021051", "story_v_out_323021.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_323021", "323021051", "story_v_out_323021.awb")

						arg_214_1:RecordAudio("323021051", var_217_6)
						arg_214_1:RecordAudio("323021051", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_323021", "323021051", "story_v_out_323021.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_323021", "323021051", "story_v_out_323021.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play323021052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 323021052
		arg_218_1.duration_ = 13.53

		local var_218_0 = {
			zh = 13.033,
			ja = 13.533
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play323021053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 1.45

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:GetWordFromCfg(323021052)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 58 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 58)

				if (58 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 58)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021052", "story_v_out_323021.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021052", "story_v_out_323021.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_323021", "323021052", "story_v_out_323021.awb")

						arg_218_1:RecordAudio("323021052", var_221_6)
						arg_218_1:RecordAudio("323021052", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_323021", "323021052", "story_v_out_323021.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_323021", "323021052", "story_v_out_323021.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play323021053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 323021053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play323021054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1019ui_story"]) and arg_222_1.var_.characterEffect1019ui_story == nil then
				arg_222_1.var_.characterEffect1019ui_story = arg_222_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1019ui_story"]) then
				if arg_222_1.var_.characterEffect1019ui_story and not isNil(arg_222_1.actors_["1019ui_story"]) then
					arg_222_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1019ui_story"]) and arg_222_1.var_.characterEffect1019ui_story then
				arg_222_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_225_1 = 0
			local var_225_2 = 0.225

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_222_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_225_3 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(323021053).content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 9 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 9)

				if (9 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 9)) > 0 and var_225_2 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_1 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_1
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_6 = math.max(var_225_2, arg_222_1.talkMaxDuration)

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_6 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_1) / var_225_6

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_1 + var_225_6 and arg_222_1.time_ < var_225_1 + var_225_6 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play323021054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 323021054
		arg_226_1.duration_ = 12.73

		local var_226_0 = {
			zh = 8.866,
			ja = 12.733
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play323021055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1019ui_story"]) and arg_226_1.var_.characterEffect1019ui_story == nil then
				arg_226_1.var_.characterEffect1019ui_story = arg_226_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1019ui_story"]) then
				if arg_226_1.var_.characterEffect1019ui_story and not isNil(arg_226_1.actors_["1019ui_story"]) then
					arg_226_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1019ui_story"]) and arg_226_1.var_.characterEffect1019ui_story then
				arg_226_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_229_2 = 0
			local var_229_3 = 1.025

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:GetWordFromCfg(323021054)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 41 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 41)

				if (41 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 41)) > 0 and var_229_3 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021054", "story_v_out_323021.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021054", "story_v_out_323021.awb") / 1000

					if var_229_8 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_2
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_323021", "323021054", "story_v_out_323021.awb")

						arg_226_1:RecordAudio("323021054", var_229_9)
						arg_226_1:RecordAudio("323021054", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_323021", "323021054", "story_v_out_323021.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_323021", "323021054", "story_v_out_323021.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_10 and arg_226_1.time_ < var_229_2 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play323021055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 323021055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play323021056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1019ui_story"]) and arg_230_1.var_.characterEffect1019ui_story == nil then
				arg_230_1.var_.characterEffect1019ui_story = arg_230_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1019ui_story"]) then
				if arg_230_1.var_.characterEffect1019ui_story and not isNil(arg_230_1.actors_["1019ui_story"]) then
					arg_230_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1019ui_story"]) and arg_230_1.var_.characterEffect1019ui_story then
				arg_230_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 0.7

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_230_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(323021055).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 28 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 28)

				if (28 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 28)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play323021056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 323021056
		arg_234_1.duration_ = 9.77

		local var_234_0 = {
			zh = 6.966,
			ja = 9.766
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play323021057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1019ui_story"]) and arg_234_1.var_.characterEffect1019ui_story == nil then
				arg_234_1.var_.characterEffect1019ui_story = arg_234_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1019ui_story"]) then
				if arg_234_1.var_.characterEffect1019ui_story and not isNil(arg_234_1.actors_["1019ui_story"]) then
					arg_234_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1019ui_story"]) and arg_234_1.var_.characterEffect1019ui_story then
				arg_234_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_237_2 = 0
			local var_237_3 = 0.925

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(323021056)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 37 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 37)

				if (37 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 37)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021056", "story_v_out_323021.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021056", "story_v_out_323021.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_323021", "323021056", "story_v_out_323021.awb")

						arg_234_1:RecordAudio("323021056", var_237_9)
						arg_234_1:RecordAudio("323021056", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_323021", "323021056", "story_v_out_323021.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_323021", "323021056", "story_v_out_323021.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play323021057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 323021057
		arg_238_1.duration_ = 12.8

		local var_238_0 = {
			zh = 8.333,
			ja = 12.8
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play323021058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 1.075

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(323021057)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 43 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 43)

				if (43 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 43)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021057", "story_v_out_323021.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021057", "story_v_out_323021.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_323021", "323021057", "story_v_out_323021.awb")

						arg_238_1:RecordAudio("323021057", var_241_6)
						arg_238_1:RecordAudio("323021057", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_323021", "323021057", "story_v_out_323021.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_323021", "323021057", "story_v_out_323021.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play323021058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 323021058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play323021059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1019ui_story"]) and arg_242_1.var_.characterEffect1019ui_story == nil then
				arg_242_1.var_.characterEffect1019ui_story = arg_242_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1019ui_story"]) then
				if arg_242_1.var_.characterEffect1019ui_story and not isNil(arg_242_1.actors_["1019ui_story"]) then
					arg_242_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1019ui_story"]) and arg_242_1.var_.characterEffect1019ui_story then
				arg_242_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.65

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_242_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(323021058).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 26 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 26)

				if (26 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 26)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play323021059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 323021059
		arg_246_1.duration_ = 18.03

		local var_246_0 = {
			zh = 10.366,
			ja = 18.033
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play323021060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1019ui_story"]) and arg_246_1.var_.characterEffect1019ui_story == nil then
				arg_246_1.var_.characterEffect1019ui_story = arg_246_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1019ui_story"]) then
				if arg_246_1.var_.characterEffect1019ui_story and not isNil(arg_246_1.actors_["1019ui_story"]) then
					arg_246_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1019ui_story"]) and arg_246_1.var_.characterEffect1019ui_story then
				arg_246_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_249_2 = 0
			local var_249_3 = 1.2

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_4 = arg_246_1:GetWordFromCfg(323021059)
				local var_249_5 = arg_246_1:FormatText(var_249_4.content)

				arg_246_1.text_.text = var_249_5

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 48 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_5) / 48)

				if (48 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_5) / 48)) > 0 and var_249_3 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_5
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021059", "story_v_out_323021.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021059", "story_v_out_323021.awb") / 1000

					if var_249_8 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_2
					end

					if var_249_4.prefab_name ~= "" and arg_246_1.actors_[var_249_4.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_4.prefab_name].transform, "story_v_out_323021", "323021059", "story_v_out_323021.awb")

						arg_246_1:RecordAudio("323021059", var_249_9)
						arg_246_1:RecordAudio("323021059", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_323021", "323021059", "story_v_out_323021.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_323021", "323021059", "story_v_out_323021.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_10 and arg_246_1.time_ < var_249_2 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play323021060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 323021060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play323021061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1019ui_story"]) and arg_250_1.var_.characterEffect1019ui_story == nil then
				arg_250_1.var_.characterEffect1019ui_story = arg_250_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1019ui_story"]) then
				if arg_250_1.var_.characterEffect1019ui_story and not isNil(arg_250_1.actors_["1019ui_story"]) then
					arg_250_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1019ui_story"]) and arg_250_1.var_.characterEffect1019ui_story then
				arg_250_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 0.35

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_250_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(323021060).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 14 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 14)

				if (14 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 14)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play323021061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 323021061
		arg_254_1.duration_ = 9.27

		local var_254_0 = {
			zh = 8.266,
			ja = 9.266
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play323021062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1019ui_story"]) and arg_254_1.var_.characterEffect1019ui_story == nil then
				arg_254_1.var_.characterEffect1019ui_story = arg_254_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1019ui_story"]) then
				if arg_254_1.var_.characterEffect1019ui_story and not isNil(arg_254_1.actors_["1019ui_story"]) then
					arg_254_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1019ui_story"]) and arg_254_1.var_.characterEffect1019ui_story then
				arg_254_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			local var_257_2 = 0
			local var_257_3 = 0.875

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_4 = arg_254_1:GetWordFromCfg(323021061)
				local var_257_5 = arg_254_1:FormatText(var_257_4.content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 35 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 35)

				if (35 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 35)) > 0 and var_257_3 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021061", "story_v_out_323021.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021061", "story_v_out_323021.awb") / 1000

					if var_257_8 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_2
					end

					if var_257_4.prefab_name ~= "" and arg_254_1.actors_[var_257_4.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_4.prefab_name].transform, "story_v_out_323021", "323021061", "story_v_out_323021.awb")

						arg_254_1:RecordAudio("323021061", var_257_9)
						arg_254_1:RecordAudio("323021061", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_323021", "323021061", "story_v_out_323021.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_323021", "323021061", "story_v_out_323021.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_10 and arg_254_1.time_ < var_257_2 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play323021062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 323021062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play323021063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1019ui_story"]) and arg_258_1.var_.characterEffect1019ui_story == nil then
				arg_258_1.var_.characterEffect1019ui_story = arg_258_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1019ui_story"]) then
				if arg_258_1.var_.characterEffect1019ui_story and not isNil(arg_258_1.actors_["1019ui_story"]) then
					arg_258_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1019ui_story"]) and arg_258_1.var_.characterEffect1019ui_story then
				arg_258_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_261_1 = 0
			local var_261_2 = 0.375

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_258_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(323021062).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 15 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 15)

				if (15 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 15)) > 0 and var_261_2 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_1 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_1
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_6 = math.max(var_261_2, arg_258_1.talkMaxDuration)

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_6 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_1) / var_261_6

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_1 + var_261_6 and arg_258_1.time_ < var_261_1 + var_261_6 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play323021063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 323021063
		arg_262_1.duration_ = 5.9

		local var_262_0 = {
			zh = 4.133,
			ja = 5.9
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
				arg_262_0:Play323021064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1019ui_story"]) and arg_262_1.var_.characterEffect1019ui_story == nil then
				arg_262_1.var_.characterEffect1019ui_story = arg_262_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1019ui_story"]) then
				if arg_262_1.var_.characterEffect1019ui_story and not isNil(arg_262_1.actors_["1019ui_story"]) then
					arg_262_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1019ui_story"]) and arg_262_1.var_.characterEffect1019ui_story then
				arg_262_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_265_2 = 0
			local var_265_3 = 0.525

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(323021063)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 21 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 21)

				if (21 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 21)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021063", "story_v_out_323021.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021063", "story_v_out_323021.awb") / 1000

					if var_265_8 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_2
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_out_323021", "323021063", "story_v_out_323021.awb")

						arg_262_1:RecordAudio("323021063", var_265_9)
						arg_262_1:RecordAudio("323021063", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_323021", "323021063", "story_v_out_323021.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_323021", "323021063", "story_v_out_323021.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 <= arg_262_1.time_ and arg_262_1.time_ < var_265_2 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_2) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_2 + var_265_10 and arg_262_1.time_ < var_265_2 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play323021064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 323021064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play323021065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1019ui_story"]) and arg_266_1.var_.characterEffect1019ui_story == nil then
				arg_266_1.var_.characterEffect1019ui_story = arg_266_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1019ui_story"]) then
				if arg_266_1.var_.characterEffect1019ui_story and not isNil(arg_266_1.actors_["1019ui_story"]) then
					arg_266_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1019ui_story"]) and arg_266_1.var_.characterEffect1019ui_story then
				arg_266_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_269_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_266_1.bgmTxt_.text ~= var_269_3 and arg_266_1.bgmTxt_.text ~= "" then
						if arg_266_1.bgmTxt2_.text ~= "" then
							arg_266_1.bgmTxt_.text = arg_266_1.bgmTxt2_.text
						end

						arg_266_1.bgmTxt2_.text = var_269_3

						arg_266_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_266_1.bgmTxt_.text = var_269_3
						arg_266_1.bgmTxt2_.text = var_269_3
					end

					if arg_266_1.bgmTimer then
						arg_266_1.bgmTimer:Stop()

						arg_266_1.bgmTimer = nil
					end

					if arg_266_1.settingData.show_music_name == 1 then
						arg_266_1.musicController:SetSelectedState("show")
						arg_266_1.musicAnimator_:Play("open", 0, 0)

						if arg_266_1.settingData.music_time ~= 0 then
							arg_266_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_266_1.settingData.music_time), function()
								if arg_266_1 == nil or isNil(arg_266_1.bgmTxt_) then
									return
								end

								arg_266_1.musicController:SetSelectedState("hide")
								arg_266_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_269_4 = 0
			local var_269_5 = 0.55

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_266_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_269_6 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(323021064).content)

				arg_266_1.text_.text = var_269_6

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_8 = 22 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_6) / 22)

				if (22 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_6) / 22)) > 0 and var_269_5 < var_269_8 then
					arg_266_1.talkMaxDuration = var_269_8

					if var_269_8 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_6
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_9 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_9 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_9

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_9 and arg_266_1.time_ < var_269_4 + var_269_9 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play323021065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 323021065
		arg_271_1.duration_ = 8.4

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play323021066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 1.66666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 1.66666666666667 + arg_274_0 then
				local var_274_0 = arg_271_1.bgs_.J13f

				arg_271_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_1 = var_274_0:GetComponent("SpriteRenderer")

				if var_274_1 and var_274_1.sprite then
					local var_274_2 = 2 * (var_274_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_0.transform.localScale = Vector3.New(var_274_2 / var_274_1.sprite.bounds.size.y < var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x and var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x or var_274_2 / var_274_1.sprite.bounds.size.y, var_274_2 / var_274_1.sprite.bounds.size.y < var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x and var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x or var_274_2 / var_274_1.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "J13f" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_3 = 1.66666666666667

			if 1.66666666666667 < arg_271_1.time_ and arg_271_1.time_ <= var_274_3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= var_274_3 + 0.3 and arg_271_1.time_ < var_274_3 + 0.3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_4 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_5 = 1.66666666666667

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_5 then
				local var_274_6 = Color.New(0, 0, 0)

				var_274_6.a = Mathf.Lerp(0, 1, (arg_271_1.time_ - var_274_4) / var_274_5)
				arg_271_1.mask_.color = var_274_6
			end

			if arg_271_1.time_ >= var_274_4 + var_274_5 and arg_271_1.time_ < var_274_4 + var_274_5 + arg_274_0 then
				local var_274_7 = Color.New(0, 0, 0)

				var_274_7.a = 1
				arg_271_1.mask_.color = var_274_7
			end

			local var_274_8 = 1.66666666666667

			if 1.66666666666667 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_9 = 2

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 then
				local var_274_10 = Color.New(0, 0, 0)

				var_274_10.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_8) / var_274_9)
				arg_271_1.mask_.color = var_274_10
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 then
				local var_274_11 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_11.a = 0
				arg_271_1.mask_.color = var_274_11
			end

			local var_274_12 = arg_271_1.actors_["1019ui_story"].transform

			if 1.66666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 1.66666666666667 + arg_274_0 then
				arg_271_1.var_.moveOldPos1019ui_story = var_274_12.localPosition
			end

			local var_274_13 = 0.001

			if 1.66666666666667 <= arg_271_1.time_ and arg_271_1.time_ < 1.66666666666667 + var_274_13 then
				var_274_12.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 1.66666666666667) / var_274_13)
				var_274_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_12.position).x, (manager.ui.mainCamera.transform.position - var_274_12.position).y, (manager.ui.mainCamera.transform.position - var_274_12.position).z)
				var_274_12.localEulerAngles.z = 0
				var_274_12.localEulerAngles.x = 0
				var_274_12.localEulerAngles = var_274_12.localEulerAngles
			end

			if arg_271_1.time_ >= 1.66666666666667 + var_274_13 and arg_271_1.time_ < 1.66666666666667 + var_274_13 + arg_274_0 then
				var_274_12.localPosition = Vector3.New(0, 100, 0)
				var_274_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_12.position).x, (manager.ui.mainCamera.transform.position - var_274_12.position).y, (manager.ui.mainCamera.transform.position - var_274_12.position).z)
				var_274_12.localEulerAngles.z = 0
				var_274_12.localEulerAngles.x = 0
				var_274_12.localEulerAngles = var_274_12.localEulerAngles
			end

			if 0.266666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 0.266666666666667 + arg_274_0 then
				arg_271_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_274_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_271_1.bgmTxt_.text ~= var_274_16 and arg_271_1.bgmTxt_.text ~= "" then
						if arg_271_1.bgmTxt2_.text ~= "" then
							arg_271_1.bgmTxt_.text = arg_271_1.bgmTxt2_.text
						end

						arg_271_1.bgmTxt2_.text = var_274_16

						arg_271_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_271_1.bgmTxt_.text = var_274_16
						arg_271_1.bgmTxt2_.text = var_274_16
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

			if 1.36666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 1.36666666666667 + arg_274_0 then
				arg_271_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_274_19 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if "" ~= "" then
					if arg_271_1.bgmTxt_.text ~= var_274_19 and arg_271_1.bgmTxt_.text ~= "" then
						if arg_271_1.bgmTxt2_.text ~= "" then
							arg_271_1.bgmTxt_.text = arg_271_1.bgmTxt2_.text
						end

						arg_271_1.bgmTxt2_.text = var_274_19

						arg_271_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_271_1.bgmTxt_.text = var_274_19
						arg_271_1.bgmTxt2_.text = var_274_19
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

			if 1.36666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 1.36666666666667 + arg_274_0 then
				arg_271_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if 0.266666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 0.266666666666667 + arg_274_0 then
				arg_271_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_274_22 = 1.66666666666667

			arg_271_1.isInRecall_ = false

			if var_274_22 < arg_271_1.time_ and arg_271_1.time_ <= var_274_22 + arg_274_0 then
				arg_271_1.screenFilterGo_:SetActive(false)

				for iter_274_2, iter_274_3 in pairs(arg_271_1.actors_) do
					for iter_274_4, iter_274_5 in ipairs((iter_274_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_274_5.color = iter_274_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_274_23 = 0.034000001847744

			if var_274_22 <= arg_271_1.time_ and arg_271_1.time_ < var_274_22 + var_274_23 then
				arg_271_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_22) / var_274_23)
			end

			if arg_271_1.time_ >= var_274_22 + var_274_23 and arg_271_1.time_ < var_274_22 + var_274_23 + arg_274_0 then
				arg_271_1.screenFilterEffect_.weight = 0
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_24 = 3.4
			local var_274_25 = 0.375

			if 3.4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_24 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_26 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_26:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_271_1.dialogCg_.alpha = arg_277_0
				end))
				var_274_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_27 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(323021065).content)

				arg_271_1.text_.text = var_274_27

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_29 = 15 <= 0 and var_274_25 or var_274_25 * (utf8.len(var_274_27) / 15)

				if (15 <= 0 and var_274_25 or var_274_25 * (utf8.len(var_274_27) / 15)) > 0 and var_274_25 < var_274_29 then
					arg_271_1.talkMaxDuration = var_274_29
					var_274_24 = var_274_24 + 0.3

					if var_274_29 + var_274_24 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_29 + var_274_24
					end
				end

				arg_271_1.text_.text = var_274_27
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_30 = var_274_24 + 0.3
			local var_274_31 = math.max(var_274_25, arg_271_1.talkMaxDuration)

			if var_274_24 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_30 + var_274_31 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_30) / var_274_31

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_30 + var_274_31 and arg_271_1.time_ < var_274_30 + var_274_31 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play323021066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 323021066
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play323021067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.775

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(323021066).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 31 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 31)

				if (31 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 31)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play323021067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 323021067
		arg_283_1.duration_ = 13.47

		local var_283_0 = {
			zh = 9.7,
			ja = 13.466
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play323021068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1071ui_story = arg_283_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).z)
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles = arg_283_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_283_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).z)
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles = arg_283_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1071ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1071ui_story == nil then
				arg_283_1.var_.characterEffect1071ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1071ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1071ui_story then
				arg_283_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_286_4 = 0
			local var_286_5 = 1.175

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(323021067)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 47 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 47)

				if (47 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 47)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021067", "story_v_out_323021.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_323021", "323021067", "story_v_out_323021.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_323021", "323021067", "story_v_out_323021.awb")

						arg_283_1:RecordAudio("323021067", var_286_11)
						arg_283_1:RecordAudio("323021067", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_323021", "323021067", "story_v_out_323021.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_323021", "323021067", "story_v_out_323021.awb")
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
				actorName = "1071ui_story",
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
	Play323021068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 323021068
		arg_287_1.duration_ = 13.97

		local var_287_0 = {
			zh = 12.3,
			ja = 13.966
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
				arg_287_0:Play323021069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.425

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(323021068)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 57 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 57)

				if (57 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 57)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021068", "story_v_out_323021.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021068", "story_v_out_323021.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_323021", "323021068", "story_v_out_323021.awb")

						arg_287_1:RecordAudio("323021068", var_290_6)
						arg_287_1:RecordAudio("323021068", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_323021", "323021068", "story_v_out_323021.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_323021", "323021068", "story_v_out_323021.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play323021069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 323021069
		arg_291_1.duration_ = 15.47

		local var_291_0 = {
			zh = 9.9,
			ja = 15.466
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play323021070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 1.2

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(323021069)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 48 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 48)

				if (48 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 48)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021069", "story_v_out_323021.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_323021", "323021069", "story_v_out_323021.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_323021", "323021069", "story_v_out_323021.awb")

						arg_291_1:RecordAudio("323021069", var_294_6)
						arg_291_1:RecordAudio("323021069", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_323021", "323021069", "story_v_out_323021.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_323021", "323021069", "story_v_out_323021.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play323021070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 323021070
		arg_295_1.duration_ = 16

		local var_295_0 = {
			zh = 9.966,
			ja = 16
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
				arg_295_0:Play323021071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_298_0 = 0
			local var_298_1 = 1.275

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(323021070)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 51 <= 0 and var_298_1 or var_298_1 * (utf8.len(var_298_3) / 51)

				if (51 <= 0 and var_298_1 or var_298_1 * (utf8.len(var_298_3) / 51)) > 0 and var_298_1 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021070", "story_v_out_323021.awb") ~= 0 then
					local var_298_6 = manager.audio:GetVoiceLength("story_v_out_323021", "323021070", "story_v_out_323021.awb") / 1000

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end

					if var_298_2.prefab_name ~= "" and arg_295_1.actors_[var_298_2.prefab_name] ~= nil then
						local var_298_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_2.prefab_name].transform, "story_v_out_323021", "323021070", "story_v_out_323021.awb")

						arg_295_1:RecordAudio("323021070", var_298_7)
						arg_295_1:RecordAudio("323021070", var_298_7)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_323021", "323021070", "story_v_out_323021.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_323021", "323021070", "story_v_out_323021.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play323021071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 323021071
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play323021072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1071ui_story"]) and arg_299_1.var_.characterEffect1071ui_story == nil then
				arg_299_1.var_.characterEffect1071ui_story = arg_299_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1071ui_story"]) then
				if arg_299_1.var_.characterEffect1071ui_story and not isNil(arg_299_1.actors_["1071ui_story"]) then
					arg_299_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1071ui_story"]) and arg_299_1.var_.characterEffect1071ui_story then
				arg_299_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.9

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(323021071).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 36 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 36)

				if (36 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 36)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play323021072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 323021072
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play323021073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.575

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(323021072).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 63 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 63)

				if (63 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 63)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play323021073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 323021073
		arg_307_1.duration_ = 17.73

		local var_307_0 = {
			zh = 11,
			ja = 17.733
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
				arg_307_0:Play323021074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1071ui_story"]) and arg_307_1.var_.characterEffect1071ui_story == nil then
				arg_307_1.var_.characterEffect1071ui_story = arg_307_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1071ui_story"]) then
				if arg_307_1.var_.characterEffect1071ui_story and not isNil(arg_307_1.actors_["1071ui_story"]) then
					arg_307_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1071ui_story"]) and arg_307_1.var_.characterEffect1071ui_story then
				arg_307_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_310_2 = 0
			local var_310_3 = 1.3

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(323021073)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 52 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 52)

				if (52 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 52)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021073", "story_v_out_323021.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021073", "story_v_out_323021.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_out_323021", "323021073", "story_v_out_323021.awb")

						arg_307_1:RecordAudio("323021073", var_310_9)
						arg_307_1:RecordAudio("323021073", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_323021", "323021073", "story_v_out_323021.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_323021", "323021073", "story_v_out_323021.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play323021074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 323021074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play323021075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1071ui_story"]) and arg_311_1.var_.characterEffect1071ui_story == nil then
				arg_311_1.var_.characterEffect1071ui_story = arg_311_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1071ui_story"]) then
				if arg_311_1.var_.characterEffect1071ui_story and not isNil(arg_311_1.actors_["1071ui_story"]) then
					arg_311_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1071ui_story"]) and arg_311_1.var_.characterEffect1071ui_story then
				arg_311_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.325

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(323021074).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 13 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 13)

				if (13 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 13)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play323021075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 323021075
		arg_315_1.duration_ = 10.67

		local var_315_0 = {
			zh = 9.5,
			ja = 10.666
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
				arg_315_0:Play323021076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1071ui_story"]) and arg_315_1.var_.characterEffect1071ui_story == nil then
				arg_315_1.var_.characterEffect1071ui_story = arg_315_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1071ui_story"]) then
				if arg_315_1.var_.characterEffect1071ui_story and not isNil(arg_315_1.actors_["1071ui_story"]) then
					arg_315_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1071ui_story"]) and arg_315_1.var_.characterEffect1071ui_story then
				arg_315_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_318_2 = 0
			local var_318_3 = 0.95

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(323021075)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 38 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 38)

				if (38 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 38)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021075", "story_v_out_323021.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021075", "story_v_out_323021.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_out_323021", "323021075", "story_v_out_323021.awb")

						arg_315_1:RecordAudio("323021075", var_318_9)
						arg_315_1:RecordAudio("323021075", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_323021", "323021075", "story_v_out_323021.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_323021", "323021075", "story_v_out_323021.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play323021076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 323021076
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play323021077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1071ui_story"]) and arg_319_1.var_.characterEffect1071ui_story == nil then
				arg_319_1.var_.characterEffect1071ui_story = arg_319_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1071ui_story"]) then
				if arg_319_1.var_.characterEffect1071ui_story and not isNil(arg_319_1.actors_["1071ui_story"]) then
					arg_319_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1071ui_story"]) and arg_319_1.var_.characterEffect1071ui_story then
				arg_319_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.575

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(323021076).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 23 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 23)

				if (23 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 23)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play323021077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 323021077
		arg_323_1.duration_ = 12.9

		local var_323_0 = {
			zh = 9.8,
			ja = 12.9
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
				arg_323_0:Play323021078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1071ui_story"]) and arg_323_1.var_.characterEffect1071ui_story == nil then
				arg_323_1.var_.characterEffect1071ui_story = arg_323_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1071ui_story"]) then
				if arg_323_1.var_.characterEffect1071ui_story and not isNil(arg_323_1.actors_["1071ui_story"]) then
					arg_323_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1071ui_story"]) and arg_323_1.var_.characterEffect1071ui_story then
				arg_323_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_326_2 = 0
			local var_326_3 = 0.975

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(323021077)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 39 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 39)

				if (39 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 39)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021077", "story_v_out_323021.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021077", "story_v_out_323021.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_out_323021", "323021077", "story_v_out_323021.awb")

						arg_323_1:RecordAudio("323021077", var_326_9)
						arg_323_1:RecordAudio("323021077", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_323021", "323021077", "story_v_out_323021.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_323021", "323021077", "story_v_out_323021.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play323021078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 323021078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play323021079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1071ui_story"]) and arg_327_1.var_.characterEffect1071ui_story == nil then
				arg_327_1.var_.characterEffect1071ui_story = arg_327_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1071ui_story"]) then
				if arg_327_1.var_.characterEffect1071ui_story and not isNil(arg_327_1.actors_["1071ui_story"]) then
					arg_327_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1071ui_story"]) and arg_327_1.var_.characterEffect1071ui_story then
				arg_327_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_330_1 = arg_327_1.actors_["1071ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1071ui_story = var_330_1.localPosition
			end

			local var_330_2 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 then
				var_330_1.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_2)
				var_330_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_1.position).x, (manager.ui.mainCamera.transform.position - var_330_1.position).y, (manager.ui.mainCamera.transform.position - var_330_1.position).z)
				var_330_1.localEulerAngles.z = 0
				var_330_1.localEulerAngles.x = 0
				var_330_1.localEulerAngles = var_330_1.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 then
				var_330_1.localPosition = Vector3.New(0, 100, 0)
				var_330_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_1.position).x, (manager.ui.mainCamera.transform.position - var_330_1.position).y, (manager.ui.mainCamera.transform.position - var_330_1.position).z)
				var_330_1.localEulerAngles.z = 0
				var_330_1.localEulerAngles.x = 0
				var_330_1.localEulerAngles = var_330_1.localEulerAngles
			end

			local var_330_3 = 0
			local var_330_4 = 1.175

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_3 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_5 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(323021078).content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 47 <= 0 and var_330_4 or var_330_4 * (utf8.len(var_330_5) / 47)

				if (47 <= 0 and var_330_4 or var_330_4 * (utf8.len(var_330_5) / 47)) > 0 and var_330_4 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_3 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_3
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_8 = math.max(var_330_4, arg_327_1.talkMaxDuration)

			if var_330_3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_3 + var_330_8 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_3) / var_330_8

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_3 + var_330_8 and arg_327_1.time_ < var_330_3 + var_330_8 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play323021079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 323021079
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play323021080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.775

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(323021079).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 71 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 71)

				if (71 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 71)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play323021080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 323021080
		arg_335_1.duration_ = 7.37

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play323021081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 1 < arg_335_1.time_ and arg_335_1.time_ <= 1 + arg_338_0 then
				local var_338_0 = arg_335_1.bgs_.J13f

				arg_335_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_338_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_338_1 = var_338_0:GetComponent("SpriteRenderer")

				if var_338_1 and var_338_1.sprite then
					local var_338_2 = 2 * (var_338_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_338_0.transform.localScale = Vector3.New(var_338_2 / var_338_1.sprite.bounds.size.y < var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x and var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x or var_338_2 / var_338_1.sprite.bounds.size.y, var_338_2 / var_338_1.sprite.bounds.size.y < var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x and var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x or var_338_2 / var_338_1.sprite.bounds.size.y, 0)
				end

				for iter_338_0, iter_338_1 in pairs(arg_335_1.bgs_) do
					if iter_338_0 ~= "J13f" then
						iter_338_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_338_3 = 1

			if 1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_3 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			if arg_335_1.time_ >= var_338_3 + 0.3 and arg_335_1.time_ < var_338_3 + 0.3 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end

			local var_338_4 = 0

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_5 = 1

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_5 then
				local var_338_6 = Color.New(0, 0, 0)

				var_338_6.a = Mathf.Lerp(0, 1, (arg_335_1.time_ - var_338_4) / var_338_5)
				arg_335_1.mask_.color = var_338_6
			end

			if arg_335_1.time_ >= var_338_4 + var_338_5 and arg_335_1.time_ < var_338_4 + var_338_5 + arg_338_0 then
				local var_338_7 = Color.New(0, 0, 0)

				var_338_7.a = 1
				arg_335_1.mask_.color = var_338_7
			end

			local var_338_8 = 1

			if 1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_9 = 2

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_9 then
				local var_338_10 = Color.New(0, 0, 0)

				var_338_10.a = Mathf.Lerp(1, 0, (arg_335_1.time_ - var_338_8) / var_338_9)
				arg_335_1.mask_.color = var_338_10
			end

			if arg_335_1.time_ >= var_338_8 + var_338_9 and arg_335_1.time_ < var_338_8 + var_338_9 + arg_338_0 then
				local var_338_11 = Color.New(0, 0, 0)

				arg_335_1.mask_.enabled = false
				var_338_11.a = 0
				arg_335_1.mask_.color = var_338_11
			end

			if arg_335_1.frameCnt_ <= 1 then
				arg_335_1.dialog_:SetActive(false)
			end

			local var_338_12 = 2.36666666666667
			local var_338_13 = 1.25

			if 2.36666666666667 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0

				arg_335_1.dialog_:SetActive(true)

				arg_335_1.dialogCg_.alpha = 0

				local var_338_14 = LeanTween.value(arg_335_1.dialog_, 0, 1, 0.3)

				var_338_14:setOnUpdate(LuaHelper.FloatAction(function(arg_339_0)
					arg_335_1.dialogCg_.alpha = arg_339_0
				end))
				var_338_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_335_1.dialog_)
					var_338_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_335_1.duration_ = arg_335_1.duration_ + 0.3

				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_15 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(323021080).content)

				arg_335_1.text_.text = var_338_15

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_17 = 50 <= 0 and var_338_13 or var_338_13 * (utf8.len(var_338_15) / 50)

				if (50 <= 0 and var_338_13 or var_338_13 * (utf8.len(var_338_15) / 50)) > 0 and var_338_13 < var_338_17 then
					arg_335_1.talkMaxDuration = var_338_17
					var_338_12 = var_338_12 + 0.3

					if var_338_17 + var_338_12 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_17 + var_338_12
					end
				end

				arg_335_1.text_.text = var_338_15
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_18 = var_338_12 + 0.3
			local var_338_19 = math.max(var_338_13, arg_335_1.talkMaxDuration)

			if var_338_12 + 0.3 <= arg_335_1.time_ and arg_335_1.time_ < var_338_18 + var_338_19 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_18) / var_338_19

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_18 + var_338_19 and arg_335_1.time_ < var_338_18 + var_338_19 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play323021081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 323021081
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play323021082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.25

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(323021081).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 10 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 10)

				if (10 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 10)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play323021082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 323021082
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play323021083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 1.275

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(323021082).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 51 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 51)

				if (51 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 51)) > 0 and var_348_0 < var_348_3 then
					arg_345_1.talkMaxDuration = var_348_3

					if var_348_3 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_3 + 0
					end
				end

				arg_345_1.text_.text = var_348_1
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_4 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_4

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play323021083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 323021083
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play323021084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.225

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(323021083).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 9 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 9)

				if (9 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 9)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play323021084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 323021084
		arg_353_1.duration_ = 9.63

		local var_353_0 = {
			zh = 5.933,
			ja = 9.633
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play323021085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1071ui_story = arg_353_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1071ui_story"].transform.position).z)
				arg_353_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1071ui_story"].transform.localEulerAngles = arg_353_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_353_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1071ui_story"].transform.position).z)
				arg_353_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1071ui_story"].transform.localEulerAngles = arg_353_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1071ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1071ui_story == nil then
				arg_353_1.var_.characterEffect1071ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1071ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1071ui_story then
				arg_353_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_356_4 = 0
			local var_356_5 = 0.5

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(323021084)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 20 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 20)

				if (20 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 20)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021084", "story_v_out_323021.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_out_323021", "323021084", "story_v_out_323021.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_out_323021", "323021084", "story_v_out_323021.awb")

						arg_353_1:RecordAudio("323021084", var_356_11)
						arg_353_1:RecordAudio("323021084", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_323021", "323021084", "story_v_out_323021.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_323021", "323021084", "story_v_out_323021.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play323021085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 323021085
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play323021086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1071ui_story"]) and arg_357_1.var_.characterEffect1071ui_story == nil then
				arg_357_1.var_.characterEffect1071ui_story = arg_357_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1071ui_story"]) then
				if arg_357_1.var_.characterEffect1071ui_story and not isNil(arg_357_1.actors_["1071ui_story"]) then
					arg_357_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1071ui_story"]) and arg_357_1.var_.characterEffect1071ui_story then
				arg_357_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_360_1 = 0
			local var_360_2 = 0.25

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

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(323021085).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 10 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 10)

				if (10 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 10)) > 0 and var_360_2 < var_360_5 then
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
	Play323021086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 323021086
		arg_361_1.duration_ = 15.37

		local var_361_0 = {
			zh = 12.7,
			ja = 15.366
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play323021087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1071ui_story"]) and arg_361_1.var_.characterEffect1071ui_story == nil then
				arg_361_1.var_.characterEffect1071ui_story = arg_361_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1071ui_story"]) then
				if arg_361_1.var_.characterEffect1071ui_story and not isNil(arg_361_1.actors_["1071ui_story"]) then
					arg_361_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1071ui_story"]) and arg_361_1.var_.characterEffect1071ui_story then
				arg_361_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_364_2 = 0
			local var_364_3 = 1.25

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:GetWordFromCfg(323021086)
				local var_364_5 = arg_361_1:FormatText(var_364_4.content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_7 = 50 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_5) / 50)

				if (50 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_5) / 50)) > 0 and var_364_3 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021086", "story_v_out_323021.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021086", "story_v_out_323021.awb") / 1000

					if var_364_8 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_2
					end

					if var_364_4.prefab_name ~= "" and arg_361_1.actors_[var_364_4.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_4.prefab_name].transform, "story_v_out_323021", "323021086", "story_v_out_323021.awb")

						arg_361_1:RecordAudio("323021086", var_364_9)
						arg_361_1:RecordAudio("323021086", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_323021", "323021086", "story_v_out_323021.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_323021", "323021086", "story_v_out_323021.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_10 and arg_361_1.time_ < var_364_2 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play323021087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 323021087
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play323021088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1071ui_story"]) and arg_365_1.var_.characterEffect1071ui_story == nil then
				arg_365_1.var_.characterEffect1071ui_story = arg_365_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1071ui_story"]) then
				if arg_365_1.var_.characterEffect1071ui_story and not isNil(arg_365_1.actors_["1071ui_story"]) then
					arg_365_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_0)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1071ui_story"]) and arg_365_1.var_.characterEffect1071ui_story then
				arg_365_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_368_1 = 0
			local var_368_2 = 0.35

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(323021087).content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 14 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 14)

				if (14 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 14)) > 0 and var_368_2 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_1
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_6 = math.max(var_368_2, arg_365_1.talkMaxDuration)

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_6 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_1) / var_368_6

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_1 + var_368_6 and arg_365_1.time_ < var_368_1 + var_368_6 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play323021088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 323021088
		arg_369_1.duration_ = 7.37

		local var_369_0 = {
			zh = 6,
			ja = 7.366
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play323021089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1071ui_story"]) and arg_369_1.var_.characterEffect1071ui_story == nil then
				arg_369_1.var_.characterEffect1071ui_story = arg_369_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1071ui_story"]) then
				if arg_369_1.var_.characterEffect1071ui_story and not isNil(arg_369_1.actors_["1071ui_story"]) then
					arg_369_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1071ui_story"]) and arg_369_1.var_.characterEffect1071ui_story then
				arg_369_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_372_2 = 0
			local var_372_3 = 0.625

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_4 = arg_369_1:GetWordFromCfg(323021088)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 25 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 25)

				if (25 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 25)) > 0 and var_372_3 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021088", "story_v_out_323021.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021088", "story_v_out_323021.awb") / 1000

					if var_372_8 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_2
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_out_323021", "323021088", "story_v_out_323021.awb")

						arg_369_1:RecordAudio("323021088", var_372_9)
						arg_369_1:RecordAudio("323021088", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_323021", "323021088", "story_v_out_323021.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_323021", "323021088", "story_v_out_323021.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_10 and arg_369_1.time_ < var_372_2 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play323021089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 323021089
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play323021090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1071ui_story"]) and arg_373_1.var_.characterEffect1071ui_story == nil then
				arg_373_1.var_.characterEffect1071ui_story = arg_373_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1071ui_story"]) then
				if arg_373_1.var_.characterEffect1071ui_story and not isNil(arg_373_1.actors_["1071ui_story"]) then
					arg_373_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1071ui_story"]) and arg_373_1.var_.characterEffect1071ui_story then
				arg_373_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_376_1 = 0
			local var_376_2 = 0.175

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(323021089).content)

				arg_373_1.text_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 7 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 7)

				if (7 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 7)) > 0 and var_376_2 < var_376_5 then
					arg_373_1.talkMaxDuration = var_376_5

					if var_376_5 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_3
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_6 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_6 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_6

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_6 and arg_373_1.time_ < var_376_1 + var_376_6 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play323021090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 323021090
		arg_377_1.duration_ = 9.83

		local var_377_0 = {
			zh = 4.933,
			ja = 9.833
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play323021091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1071ui_story"]) and arg_377_1.var_.characterEffect1071ui_story == nil then
				arg_377_1.var_.characterEffect1071ui_story = arg_377_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1071ui_story"]) then
				if arg_377_1.var_.characterEffect1071ui_story and not isNil(arg_377_1.actors_["1071ui_story"]) then
					arg_377_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1071ui_story"]) and arg_377_1.var_.characterEffect1071ui_story then
				arg_377_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_1")
			end

			local var_380_2 = 0
			local var_380_3 = 0.6

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_4 = arg_377_1:GetWordFromCfg(323021090)
				local var_380_5 = arg_377_1:FormatText(var_380_4.content)

				arg_377_1.text_.text = var_380_5

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_7 = 24 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 24)

				if (24 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 24)) > 0 and var_380_3 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_2
					end
				end

				arg_377_1.text_.text = var_380_5
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323021", "323021090", "story_v_out_323021.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_323021", "323021090", "story_v_out_323021.awb") / 1000

					if var_380_8 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_2
					end

					if var_380_4.prefab_name ~= "" and arg_377_1.actors_[var_380_4.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_4.prefab_name].transform, "story_v_out_323021", "323021090", "story_v_out_323021.awb")

						arg_377_1:RecordAudio("323021090", var_380_9)
						arg_377_1:RecordAudio("323021090", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_323021", "323021090", "story_v_out_323021.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_323021", "323021090", "story_v_out_323021.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_3, arg_377_1.talkMaxDuration)

			if var_380_2 <= arg_377_1.time_ and arg_377_1.time_ < var_380_2 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_2) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_2 + var_380_10 and arg_377_1.time_ < var_380_2 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play323021091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 323021091
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
			arg_381_1.auto_ = false
		end

		function arg_381_1.playNext_(arg_383_0)
			arg_381_1.onStoryFinished_()
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1071ui_story"]) and arg_381_1.var_.characterEffect1071ui_story == nil then
				arg_381_1.var_.characterEffect1071ui_story = arg_381_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1071ui_story"]) then
				if arg_381_1.var_.characterEffect1071ui_story and not isNil(arg_381_1.actors_["1071ui_story"]) then
					arg_381_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_0)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1071ui_story"]) and arg_381_1.var_.characterEffect1071ui_story then
				arg_381_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_384_1 = arg_381_1.actors_["1071ui_story"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1071ui_story = var_384_1.localPosition
			end

			local var_384_2 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 then
				var_384_1.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_2)
				var_384_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_1.position).x, (manager.ui.mainCamera.transform.position - var_384_1.position).y, (manager.ui.mainCamera.transform.position - var_384_1.position).z)
				var_384_1.localEulerAngles.z = 0
				var_384_1.localEulerAngles.x = 0
				var_384_1.localEulerAngles = var_384_1.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 then
				var_384_1.localPosition = Vector3.New(0, 100, 0)
				var_384_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_1.position).x, (manager.ui.mainCamera.transform.position - var_384_1.position).y, (manager.ui.mainCamera.transform.position - var_384_1.position).z)
				var_384_1.localEulerAngles.z = 0
				var_384_1.localEulerAngles.x = 0
				var_384_1.localEulerAngles = var_384_1.localEulerAngles
			end

			local var_384_3 = 0
			local var_384_4 = 1.5

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_3 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_5 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(323021091).content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 60 <= 0 and var_384_4 or var_384_4 * (utf8.len(var_384_5) / 60)

				if (60 <= 0 and var_384_4 or var_384_4 * (utf8.len(var_384_5) / 60)) > 0 and var_384_4 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_3 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_3
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_4, arg_381_1.talkMaxDuration)

			if var_384_3 <= arg_381_1.time_ and arg_381_1.time_ < var_384_3 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_3) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_3 + var_384_8 and arg_381_1.time_ < var_384_3 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	assets = {
		"TextureConfig/Background/J13f",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_323021.awb"
	}
}
