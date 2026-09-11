return {
	Play1108104001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108104001
		arg_1_1.duration_ = 5.63

		local var_1_0 = {
			ja = 5.633,
			ko = 5.233,
			zh = 5.233
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
				arg_1_0:Play1108104002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST15 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_4_0.name = "ST15"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST15 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST15

				arg_1_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST15" then
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

			local var_4_8 = "1081ui_story"

			if arg_1_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1081ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1081ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.92, -5.8)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1081ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1081ui_story == nil then
				arg_1_1.var_.characterEffect1081ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.0166666666666667

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1081ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1081ui_story then
				arg_1_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
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

			if 0.566666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.566666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_smallwaveloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.25

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(1108104001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 10)

				if (10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 10)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104001", "story_v_side_new_1108104.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104001", "story_v_side_new_1108104.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_side_new_1108104", "1108104001", "story_v_side_new_1108104.awb")

						arg_1_1:RecordAudio("1108104001", var_4_32)
						arg_1_1:RecordAudio("1108104001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104001", "story_v_side_new_1108104.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104001", "story_v_side_new_1108104.awb")
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108104002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1108104002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1108104003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1081ui_story = arg_9_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1081ui_story"].transform.position).z)
				arg_9_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1081ui_story"].transform.localEulerAngles = arg_9_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_9_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1081ui_story"].transform.position).z)
				arg_9_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1081ui_story"].transform.localEulerAngles = arg_9_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1081ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1081ui_story == nil then
				arg_9_1.var_.characterEffect1081ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.0166666666666667

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1081ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1081ui_story then
				arg_9_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_12_3 = 0
			local var_12_4 = 0.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1108104002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 17 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 17)

				if (17 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 17)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1108104003
		arg_13_1.duration_ = 5.5

		local var_13_0 = {
			ja = 5.5,
			ko = 4.033,
			zh = 4.033
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
				arg_13_0:Play1108104004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1081ui_story = arg_13_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1081ui_story"].transform.position).z)
				arg_13_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1081ui_story"].transform.localEulerAngles = arg_13_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_13_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1081ui_story"].transform.position).z)
				arg_13_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1081ui_story"].transform.localEulerAngles = arg_13_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1081ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1081ui_story == nil then
				arg_13_1.var_.characterEffect1081ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.0166666666666667

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1081ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1081ui_story then
				arg_13_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action494")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_16_4 = 0
			local var_16_5 = 0.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(1108104003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 11 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 11)

				if (11 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 11)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104003", "story_v_side_new_1108104.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104003", "story_v_side_new_1108104.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_side_new_1108104", "1108104003", "story_v_side_new_1108104.awb")

						arg_13_1:RecordAudio("1108104003", var_16_11)
						arg_13_1:RecordAudio("1108104003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104003", "story_v_side_new_1108104.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104003", "story_v_side_new_1108104.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1108104004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1108104005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1081ui_story = arg_17_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1081ui_story"].transform.position).z)
				arg_17_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1081ui_story"].transform.localEulerAngles = arg_17_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1081ui_story"].transform.position).z)
				arg_17_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1081ui_story"].transform.localEulerAngles = arg_17_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1081ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1081ui_story == nil then
				arg_17_1.var_.characterEffect1081ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.0166666666666667

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1081ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1081ui_story then
				arg_17_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 1.175

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

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1108104004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 47 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 47)

				if (47 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 47)) > 0 and var_20_4 < var_20_7 then
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
				actorName = "1081ui_story",
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
	Play1108104005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1108104005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1108104006(arg_21_1)
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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1108104005).content)

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
	Play1108104006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1108104006
		arg_25_1.duration_ = 3

		local var_25_0 = {
			ja = 2.433,
			ko = 3,
			zh = 3
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
				arg_25_0:Play1108104007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1081ui_story = arg_25_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).z)
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles = arg_25_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_25_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).z)
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles = arg_25_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1081ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1081ui_story == nil then
				arg_25_1.var_.characterEffect1081ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.0166666666666667

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1081ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1081ui_story then
				arg_25_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(1108104006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 7 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 7)

				if (7 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 7)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104006", "story_v_side_new_1108104.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104006", "story_v_side_new_1108104.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_new_1108104", "1108104006", "story_v_side_new_1108104.awb")

						arg_25_1:RecordAudio("1108104006", var_28_11)
						arg_25_1:RecordAudio("1108104006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104006", "story_v_side_new_1108104.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104006", "story_v_side_new_1108104.awb")
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

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1108104007
		arg_29_1.duration_ = 6.43

		local var_29_0 = {
			ja = 6.433,
			ko = 4,
			zh = 4
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
				arg_29_0:Play1108104008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1081ui_story = arg_29_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1081ui_story"].transform.position).z)
				arg_29_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1081ui_story"].transform.localEulerAngles = arg_29_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_29_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1081ui_story"].transform.position).z)
				arg_29_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1081ui_story"].transform.localEulerAngles = arg_29_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1081ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1081ui_story == nil then
				arg_29_1.var_.characterEffect1081ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.0166666666666667

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1081ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1081ui_story then
				arg_29_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_32_4 = 0
			local var_32_5 = 0.4

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(1108104007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 16 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 16)

				if (16 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 16)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104007", "story_v_side_new_1108104.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104007", "story_v_side_new_1108104.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_side_new_1108104", "1108104007", "story_v_side_new_1108104.awb")

						arg_29_1:RecordAudio("1108104007", var_32_11)
						arg_29_1:RecordAudio("1108104007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104007", "story_v_side_new_1108104.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104007", "story_v_side_new_1108104.awb")
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
				actorName = "1081ui_story",
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
	Play1108104008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1108104008
		arg_33_1.duration_ = 4.03

		local var_33_0 = {
			ja = 4.033,
			ko = 3.733,
			zh = 3.733
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
				arg_33_0:Play1108104009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1081ui_story = arg_33_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1081ui_story"].transform.position).z)
				arg_33_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1081ui_story"].transform.localEulerAngles = arg_33_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_33_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1081ui_story"].transform.position).z)
				arg_33_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1081ui_story"].transform.localEulerAngles = arg_33_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1081ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1081ui_story == nil then
				arg_33_1.var_.characterEffect1081ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.0166666666666667

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1081ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1081ui_story then
				arg_33_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(1108104008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 13 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 13)

				if (13 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 13)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104008", "story_v_side_new_1108104.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104008", "story_v_side_new_1108104.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_new_1108104", "1108104008", "story_v_side_new_1108104.awb")

						arg_33_1:RecordAudio("1108104008", var_36_11)
						arg_33_1:RecordAudio("1108104008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104008", "story_v_side_new_1108104.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104008", "story_v_side_new_1108104.awb")
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

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1108104009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1108104010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1081ui_story = arg_37_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1081ui_story"].transform.position).z)
				arg_37_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1081ui_story"].transform.localEulerAngles = arg_37_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_37_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1081ui_story"].transform.position).z)
				arg_37_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1081ui_story"].transform.localEulerAngles = arg_37_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1081ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1081ui_story == nil then
				arg_37_1.var_.characterEffect1081ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.0166666666666667

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1081ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1081ui_story then
				arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_40_3 = 0
			local var_40_4 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1108104009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 7 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 7)

				if (7 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 7)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1108104010
		arg_41_1.duration_ = 4.2

		local var_41_0 = {
			ja = 4.2,
			ko = 2.933,
			zh = 2.933
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
				arg_41_0:Play1108104011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1081ui_story = arg_41_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1081ui_story"].transform.position).z)
				arg_41_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1081ui_story"].transform.localEulerAngles = arg_41_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_41_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1081ui_story"].transform.position).z)
				arg_41_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1081ui_story"].transform.localEulerAngles = arg_41_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1081ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1081ui_story == nil then
				arg_41_1.var_.characterEffect1081ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.0166666666666667

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1081ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1081ui_story then
				arg_41_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1108104010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 13 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 13)

				if (13 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 13)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104010", "story_v_side_new_1108104.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104010", "story_v_side_new_1108104.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1108104", "1108104010", "story_v_side_new_1108104.awb")

						arg_41_1:RecordAudio("1108104010", var_44_11)
						arg_41_1:RecordAudio("1108104010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104010", "story_v_side_new_1108104.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104010", "story_v_side_new_1108104.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1108104011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1108104012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1081ui_story = arg_45_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).z)
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles = arg_45_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_45_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).z)
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles = arg_45_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1081ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1081ui_story == nil then
				arg_45_1.var_.characterEffect1081ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.0166666666666667

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1081ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_2)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1081ui_story then
				arg_45_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_48_3 = 0
			local var_48_4 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1108104011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 15 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 15)

				if (15 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 15)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1108104012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1108104013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.825

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

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1108104012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 33)

				if (33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 33)) > 0 and var_52_0 < var_52_3 then
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
	Play1108104013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1108104013
		arg_53_1.duration_ = 4.47

		local var_53_0 = {
			ja = 4.466,
			ko = 3.833,
			zh = 3.833
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
				arg_53_0:Play1108104014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1081ui_story = arg_53_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).z)
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles = arg_53_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_53_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).z)
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles = arg_53_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1081ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1081ui_story == nil then
				arg_53_1.var_.characterEffect1081ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.0166666666666667

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1081ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1081ui_story then
				arg_53_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_56_4 = 0
			local var_56_5 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1108104013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 14 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 14)

				if (14 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 14)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104013", "story_v_side_new_1108104.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104013", "story_v_side_new_1108104.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1108104", "1108104013", "story_v_side_new_1108104.awb")

						arg_53_1:RecordAudio("1108104013", var_56_11)
						arg_53_1:RecordAudio("1108104013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104013", "story_v_side_new_1108104.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104013", "story_v_side_new_1108104.awb")
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play1108104014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1108104014
		arg_57_1.duration_ = 5.87

		local var_57_0 = {
			ja = 3.6,
			ko = 5.866,
			zh = 5.866
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
				arg_57_0:Play1108104015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1081ui_story = arg_57_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).z)
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles = arg_57_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_57_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).z)
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles = arg_57_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1081ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1081ui_story == nil then
				arg_57_1.var_.characterEffect1081ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.0166666666666667

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1081ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1081ui_story then
				arg_57_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.725

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1108104014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 29 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 29)

				if (29 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 29)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104014", "story_v_side_new_1108104.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104014", "story_v_side_new_1108104.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1108104", "1108104014", "story_v_side_new_1108104.awb")

						arg_57_1:RecordAudio("1108104014", var_60_11)
						arg_57_1:RecordAudio("1108104014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104014", "story_v_side_new_1108104.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104014", "story_v_side_new_1108104.awb")
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

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1108104015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1108104015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1108104016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1081ui_story = arg_61_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).z)
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles = arg_61_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_61_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).z)
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles = arg_61_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1081ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1081ui_story == nil then
				arg_61_1.var_.characterEffect1081ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.0166666666666667

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1081ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1081ui_story then
				arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_64_3 = 0
			local var_64_4 = 0.45

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1108104015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 18 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 18)

				if (18 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 18)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play1108104016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1108104016
		arg_65_1.duration_ = 5.7

		local var_65_0 = {
			ja = 5.7,
			ko = 3.1,
			zh = 3.1
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
				arg_65_0:Play1108104017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1081ui_story = arg_65_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).z)
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles = arg_65_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_65_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).z)
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles = arg_65_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1081ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1081ui_story == nil then
				arg_65_1.var_.characterEffect1081ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.0166666666666667

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1081ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1081ui_story then
				arg_65_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action465")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(1108104016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 14 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 14)

				if (14 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 14)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104016", "story_v_side_new_1108104.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104016", "story_v_side_new_1108104.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_new_1108104", "1108104016", "story_v_side_new_1108104.awb")

						arg_65_1:RecordAudio("1108104016", var_68_11)
						arg_65_1:RecordAudio("1108104016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104016", "story_v_side_new_1108104.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104016", "story_v_side_new_1108104.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play1108104017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1108104017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1108104018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1081ui_story = arg_69_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).z)
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles = arg_69_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_69_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).z)
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles = arg_69_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1081ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1081ui_story == nil then
				arg_69_1.var_.characterEffect1081ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.0166666666666667

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1081ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_2)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1081ui_story then
				arg_69_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_72_3 = 0
			local var_72_4 = 0.475

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_5 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1108104017).content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 19 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 19)

				if (19 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 19)) > 0 and var_72_4 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_3) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_8 and arg_69_1.time_ < var_72_3 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1108104018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1108104018
		arg_73_1.duration_ = 9.2

		local var_73_0 = {
			ja = 9.2,
			ko = 5.666,
			zh = 5.666
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
				arg_73_0:Play1108104019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1081ui_story = arg_73_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).z)
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles = arg_73_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_73_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).z)
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles = arg_73_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1081ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1081ui_story == nil then
				arg_73_1.var_.characterEffect1081ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.0166666666666667

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1081ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1081ui_story then
				arg_73_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_76_4 = 0
			local var_76_5 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(1108104018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 23 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 23)

				if (23 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 23)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104018", "story_v_side_new_1108104.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104018", "story_v_side_new_1108104.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_side_new_1108104", "1108104018", "story_v_side_new_1108104.awb")

						arg_73_1:RecordAudio("1108104018", var_76_11)
						arg_73_1:RecordAudio("1108104018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104018", "story_v_side_new_1108104.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104018", "story_v_side_new_1108104.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play1108104019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1108104019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1108104020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1081ui_story = arg_77_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).z)
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles = arg_77_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_77_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).z)
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles = arg_77_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1081ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1081ui_story == nil then
				arg_77_1.var_.characterEffect1081ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.0166666666666667

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1081ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1081ui_story then
				arg_77_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_80_3 = 0
			local var_80_4 = 0.05

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
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

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1108104019).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 2 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 2)

				if (2 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 2)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1108104020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1108104020
		arg_81_1.duration_ = 8.43

		local var_81_0 = {
			ja = 8.433,
			ko = 6.133,
			zh = 6.133
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
				arg_81_0:Play1108104021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1081ui_story = arg_81_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).z)
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles = arg_81_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_81_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).z)
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles = arg_81_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1081ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1081ui_story == nil then
				arg_81_1.var_.characterEffect1081ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.0166666666666667

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1081ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1081ui_story then
				arg_81_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1108104020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 20 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 20)

				if (20 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 20)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104020", "story_v_side_new_1108104.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104020", "story_v_side_new_1108104.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_new_1108104", "1108104020", "story_v_side_new_1108104.awb")

						arg_81_1:RecordAudio("1108104020", var_84_11)
						arg_81_1:RecordAudio("1108104020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104020", "story_v_side_new_1108104.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104020", "story_v_side_new_1108104.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1108104021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1108104021
		arg_85_1.duration_ = 3.23

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1108104022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1081ui_story = arg_85_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1081ui_story"].transform.position).z)
				arg_85_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1081ui_story"].transform.localEulerAngles = arg_85_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_85_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1081ui_story"].transform.position).z)
				arg_85_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1081ui_story"].transform.localEulerAngles = arg_85_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1081ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1081ui_story == nil then
				arg_85_1.var_.characterEffect1081ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.0166666666666667

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1081ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1081ui_story then
				arg_85_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_88_3 = 0
			local var_88_4 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[11].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(1108104021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 5 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 5)

				if (5 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 5)) > 0 and var_88_4 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104021", "story_v_side_new_1108104.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104021", "story_v_side_new_1108104.awb") / 1000

					if var_88_9 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_3
					end

					if var_88_5.prefab_name ~= "" and arg_85_1.actors_[var_88_5.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_5.prefab_name].transform, "story_v_side_new_1108104", "1108104021", "story_v_side_new_1108104.awb")

						arg_85_1:RecordAudio("1108104021", var_88_10)
						arg_85_1:RecordAudio("1108104021", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104021", "story_v_side_new_1108104.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104021", "story_v_side_new_1108104.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_11 and arg_85_1.time_ < var_88_3 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1108104022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1108104023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1081ui_story = arg_89_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1081ui_story"].transform.position).z)
				arg_89_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1081ui_story"].transform.localEulerAngles = arg_89_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1081ui_story"].transform.position).z)
				arg_89_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1081ui_story"].transform.localEulerAngles = arg_89_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_92_1 = 0
			local var_92_2 = 0.775

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1108104022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 31 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 31)

				if (31 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 31)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1108104023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1108104023
		arg_93_1.duration_ = 8.13

		local var_93_0 = {
			ja = 8.133,
			ko = 4.9,
			zh = 4.9
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
				arg_93_0:Play1108104024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1081ui_story = arg_93_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1081ui_story"].transform.position).z)
				arg_93_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1081ui_story"].transform.localEulerAngles = arg_93_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_93_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1081ui_story"].transform.position).z)
				arg_93_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1081ui_story"].transform.localEulerAngles = arg_93_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1081ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1081ui_story == nil then
				arg_93_1.var_.characterEffect1081ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.0166666666666667

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1081ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1081ui_story then
				arg_93_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(1108104023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 17 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 17)

				if (17 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 17)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104023", "story_v_side_new_1108104.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104023", "story_v_side_new_1108104.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_side_new_1108104", "1108104023", "story_v_side_new_1108104.awb")

						arg_93_1:RecordAudio("1108104023", var_96_11)
						arg_93_1:RecordAudio("1108104023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104023", "story_v_side_new_1108104.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104023", "story_v_side_new_1108104.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1108104024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1108104024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1108104025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1081ui_story = arg_97_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1081ui_story"].transform.position).z)
				arg_97_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1081ui_story"].transform.localEulerAngles = arg_97_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_97_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1081ui_story"].transform.position).z)
				arg_97_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1081ui_story"].transform.localEulerAngles = arg_97_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1081ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1081ui_story == nil then
				arg_97_1.var_.characterEffect1081ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.0166666666666667

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1081ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_2)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1081ui_story then
				arg_97_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_3 = 0
			local var_100_4 = 0.55

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_5 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1108104024).content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 22 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_5) / 22)

				if (22 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_5) / 22)) > 0 and var_100_4 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_8 and arg_97_1.time_ < var_100_3 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1108104025
		arg_101_1.duration_ = 7.73

		local var_101_0 = {
			ja = 7.566,
			ko = 7.733,
			zh = 7.733
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
				arg_101_0:Play1108104026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1081ui_story = arg_101_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1081ui_story"].transform.position).z)
				arg_101_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1081ui_story"].transform.localEulerAngles = arg_101_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_101_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1081ui_story"].transform.position).z)
				arg_101_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1081ui_story"].transform.localEulerAngles = arg_101_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1081ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1081ui_story == nil then
				arg_101_1.var_.characterEffect1081ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.0166666666666667

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1081ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1081ui_story then
				arg_101_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(1108104025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 33 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 33)

				if (33 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 33)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104025", "story_v_side_new_1108104.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104025", "story_v_side_new_1108104.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_side_new_1108104", "1108104025", "story_v_side_new_1108104.awb")

						arg_101_1:RecordAudio("1108104025", var_104_11)
						arg_101_1:RecordAudio("1108104025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104025", "story_v_side_new_1108104.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104025", "story_v_side_new_1108104.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1108104026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1108104026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1108104027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1081ui_story"]) and arg_105_1.var_.characterEffect1081ui_story == nil then
				arg_105_1.var_.characterEffect1081ui_story = arg_105_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.0166666666666667

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1081ui_story"]) then
				if arg_105_1.var_.characterEffect1081ui_story and not isNil(arg_105_1.actors_["1081ui_story"]) then
					arg_105_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1081ui_story"]) and arg_105_1.var_.characterEffect1081ui_story then
				arg_105_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_108_1 = arg_105_1.actors_["1081ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1081ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(0, 100, 0)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			local var_108_3 = 0
			local var_108_4 = 1.7

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1108104026).content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 68 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 68)

				if (68 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 68)) > 0 and var_108_4 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_8 and arg_105_1.time_ < var_108_3 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1108104027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1108104028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1081ui_story = arg_109_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1081ui_story"].transform.position).z)
				arg_109_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1081ui_story"].transform.localEulerAngles = arg_109_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_109_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1081ui_story"].transform.position).z)
				arg_109_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1081ui_story"].transform.localEulerAngles = arg_109_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_112_1 = 0
			local var_112_2 = 0.325

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1108104027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 13 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 13)

				if (13 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 13)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play1108104028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1108104028
		arg_113_1.duration_ = 5

		local var_113_0 = {
			ja = 3.066,
			ko = 5,
			zh = 5
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
				arg_113_0:Play1108104029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1081ui_story = arg_113_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1081ui_story"].transform.position).z)
				arg_113_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1081ui_story"].transform.localEulerAngles = arg_113_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_113_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1081ui_story"].transform.position).z)
				arg_113_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1081ui_story"].transform.localEulerAngles = arg_113_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1081ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1081ui_story == nil then
				arg_113_1.var_.characterEffect1081ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.0166666666666667

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1081ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1081ui_story then
				arg_113_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(1108104028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 24 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 24)

				if (24 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 24)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104028", "story_v_side_new_1108104.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104028", "story_v_side_new_1108104.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_side_new_1108104", "1108104028", "story_v_side_new_1108104.awb")

						arg_113_1:RecordAudio("1108104028", var_116_11)
						arg_113_1:RecordAudio("1108104028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104028", "story_v_side_new_1108104.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104028", "story_v_side_new_1108104.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1108104029
		arg_117_1.duration_ = 10.27

		local var_117_0 = {
			ja = 8.3,
			ko = 10.266,
			zh = 10.266
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
				arg_117_0:Play1108104030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(1108104029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 44 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 44)

				if (44 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 44)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104029", "story_v_side_new_1108104.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104029", "story_v_side_new_1108104.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_side_new_1108104", "1108104029", "story_v_side_new_1108104.awb")

						arg_117_1:RecordAudio("1108104029", var_120_6)
						arg_117_1:RecordAudio("1108104029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104029", "story_v_side_new_1108104.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104029", "story_v_side_new_1108104.awb")
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
	Play1108104030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1108104030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1108104031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1081ui_story = arg_121_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1081ui_story"].transform.position).z)
				arg_121_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1081ui_story"].transform.localEulerAngles = arg_121_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_121_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1081ui_story"].transform.position).z)
				arg_121_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1081ui_story"].transform.localEulerAngles = arg_121_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1081ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1081ui_story == nil then
				arg_121_1.var_.characterEffect1081ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.0166666666666667

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1081ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1081ui_story then
				arg_121_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_3 = 0
			local var_124_4 = 0.35

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_5 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1108104030).content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 14 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 14)

				if (14 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 14)) > 0 and var_124_4 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_8 and arg_121_1.time_ < var_124_3 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1108104031
		arg_125_1.duration_ = 6.47

		local var_125_0 = {
			ja = 3.633,
			ko = 6.466,
			zh = 6.466
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1108104032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1081ui_story = arg_125_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1081ui_story"].transform.position).z)
				arg_125_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1081ui_story"].transform.localEulerAngles = arg_125_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_125_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1081ui_story"].transform.position).z)
				arg_125_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1081ui_story"].transform.localEulerAngles = arg_125_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1081ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1081ui_story == nil then
				arg_125_1.var_.characterEffect1081ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.0166666666666667

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1081ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1081ui_story then
				arg_125_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.75

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1108104031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 30 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 30)

				if (30 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 30)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104031", "story_v_side_new_1108104.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104031", "story_v_side_new_1108104.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1108104", "1108104031", "story_v_side_new_1108104.awb")

						arg_125_1:RecordAudio("1108104031", var_128_11)
						arg_125_1:RecordAudio("1108104031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104031", "story_v_side_new_1108104.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104031", "story_v_side_new_1108104.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1108104032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1108104032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1108104033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1081ui_story = arg_129_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).z)
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles = arg_129_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_129_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).z)
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles = arg_129_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1081ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1081ui_story == nil then
				arg_129_1.var_.characterEffect1081ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1081ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_2)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1081ui_story then
				arg_129_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_132_3 = 0
			local var_132_4 = 0.9

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_5 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1108104032).content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 36 <= 0 and var_132_4 or var_132_4 * (utf8.len(var_132_5) / 36)

				if (36 <= 0 and var_132_4 or var_132_4 * (utf8.len(var_132_5) / 36)) > 0 and var_132_4 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_3 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_3
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_4, arg_129_1.talkMaxDuration)

			if var_132_3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_3 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_3) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_3 + var_132_8 and arg_129_1.time_ < var_132_3 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1108104033
		arg_133_1.duration_ = 6.93

		local var_133_0 = {
			ja = 6.933,
			ko = 6.4,
			zh = 6.4
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
				arg_133_0:Play1108104034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1081ui_story = arg_133_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).z)
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles = arg_133_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_133_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).z)
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles = arg_133_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1081ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1081ui_story == nil then
				arg_133_1.var_.characterEffect1081ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.0166666666666667

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1081ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1081ui_story then
				arg_133_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.775

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(1108104033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 31 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 31)

				if (31 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 31)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104033", "story_v_side_new_1108104.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104033", "story_v_side_new_1108104.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_side_new_1108104", "1108104033", "story_v_side_new_1108104.awb")

						arg_133_1:RecordAudio("1108104033", var_136_11)
						arg_133_1:RecordAudio("1108104033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104033", "story_v_side_new_1108104.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104033", "story_v_side_new_1108104.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1108104034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1108104034
		arg_137_1.duration_ = 7.53

		local var_137_0 = {
			ja = 6.9,
			ko = 7.533,
			zh = 7.533
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
				arg_137_0:Play1108104035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.125

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(1108104034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 45 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 45)

				if (45 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 45)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104034", "story_v_side_new_1108104.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104034", "story_v_side_new_1108104.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_side_new_1108104", "1108104034", "story_v_side_new_1108104.awb")

						arg_137_1:RecordAudio("1108104034", var_140_6)
						arg_137_1:RecordAudio("1108104034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104034", "story_v_side_new_1108104.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104034", "story_v_side_new_1108104.awb")
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
	Play1108104035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1108104035
		arg_141_1.duration_ = 12.77

		local var_141_0 = {
			ja = 12.233,
			ko = 12.766,
			zh = 12.766
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
				arg_141_0:Play1108104036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_144_0 = 0
			local var_144_1 = 1.5

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(1108104035)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 60 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 60)

				if (60 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 60)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104035", "story_v_side_new_1108104.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104035", "story_v_side_new_1108104.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_side_new_1108104", "1108104035", "story_v_side_new_1108104.awb")

						arg_141_1:RecordAudio("1108104035", var_144_7)
						arg_141_1:RecordAudio("1108104035", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104035", "story_v_side_new_1108104.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104035", "story_v_side_new_1108104.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1108104036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1108104036
		arg_145_1.duration_ = 8.8

		local var_145_0 = {
			ja = 8.8,
			ko = 5.433,
			zh = 5.433
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
				arg_145_0:Play1108104037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1081ui_story = arg_145_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).z)
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles = arg_145_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_145_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).z)
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles = arg_145_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1081ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1081ui_story == nil then
				arg_145_1.var_.characterEffect1081ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.0166666666666667

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1081ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1081ui_story then
				arg_145_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			local var_148_4 = 0
			local var_148_5 = 0.725

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(1108104036)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 29 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 29)

				if (29 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 29)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104036", "story_v_side_new_1108104.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104036", "story_v_side_new_1108104.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_side_new_1108104", "1108104036", "story_v_side_new_1108104.awb")

						arg_145_1:RecordAudio("1108104036", var_148_11)
						arg_145_1:RecordAudio("1108104036", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104036", "story_v_side_new_1108104.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104036", "story_v_side_new_1108104.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play1108104037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1108104037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1108104038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1081ui_story"]) and arg_149_1.var_.characterEffect1081ui_story == nil then
				arg_149_1.var_.characterEffect1081ui_story = arg_149_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.0166666666666667

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1081ui_story"]) then
				if arg_149_1.var_.characterEffect1081ui_story and not isNil(arg_149_1.actors_["1081ui_story"]) then
					arg_149_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1081ui_story"]) and arg_149_1.var_.characterEffect1081ui_story then
				arg_149_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_152_1 = arg_149_1.actors_["1081ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1081ui_story = var_152_1.localPosition
			end

			local var_152_2 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 then
				var_152_1.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_2)
				var_152_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_1.position).x, (manager.ui.mainCamera.transform.position - var_152_1.position).y, (manager.ui.mainCamera.transform.position - var_152_1.position).z)
				var_152_1.localEulerAngles.z = 0
				var_152_1.localEulerAngles.x = 0
				var_152_1.localEulerAngles = var_152_1.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 then
				var_152_1.localPosition = Vector3.New(0, 100, 0)
				var_152_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_1.position).x, (manager.ui.mainCamera.transform.position - var_152_1.position).y, (manager.ui.mainCamera.transform.position - var_152_1.position).z)
				var_152_1.localEulerAngles.z = 0
				var_152_1.localEulerAngles.x = 0
				var_152_1.localEulerAngles = var_152_1.localEulerAngles
			end

			local var_152_3 = 0
			local var_152_4 = 0.65

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_5 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1108104037).content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 26 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_5) / 26)

				if (26 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_5) / 26)) > 0 and var_152_4 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_3
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_4, arg_149_1.talkMaxDuration)

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_3) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_3 + var_152_8 and arg_149_1.time_ < var_152_3 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play1108104038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1108104038
		arg_153_1.duration_ = 6.23

		local var_153_0 = {
			ja = 5.466,
			ko = 6.233,
			zh = 6.233
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
				arg_153_0:Play1108104039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1081ui_story = arg_153_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).z)
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles = arg_153_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_153_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).z)
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles = arg_153_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1081ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1081ui_story == nil then
				arg_153_1.var_.characterEffect1081ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.0166666666666667

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1081ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1081ui_story then
				arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.6

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(1108104038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 24 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 24)

				if (24 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 24)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104038", "story_v_side_new_1108104.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104038", "story_v_side_new_1108104.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_side_new_1108104", "1108104038", "story_v_side_new_1108104.awb")

						arg_153_1:RecordAudio("1108104038", var_156_11)
						arg_153_1:RecordAudio("1108104038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104038", "story_v_side_new_1108104.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104038", "story_v_side_new_1108104.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1108104039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1108104039
		arg_157_1.duration_ = 3.37

		local var_157_0 = {
			ja = 2.633,
			ko = 3.366,
			zh = 3.366
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
				arg_157_0:Play1108104040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.275

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(1108104039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 11 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 11)

				if (11 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 11)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104039", "story_v_side_new_1108104.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104039", "story_v_side_new_1108104.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_side_new_1108104", "1108104039", "story_v_side_new_1108104.awb")

						arg_157_1:RecordAudio("1108104039", var_160_6)
						arg_157_1:RecordAudio("1108104039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104039", "story_v_side_new_1108104.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104039", "story_v_side_new_1108104.awb")
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
	Play1108104040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1108104040
		arg_161_1.duration_ = 1

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"

			SetActive(arg_161_1.choicesGo_, true)

			for iter_162_0, iter_162_1 in ipairs(arg_161_1.choices_) do
				SetActive(iter_162_1.go, iter_162_0 <= 2)
			end

			arg_161_1.choices_[1].txt.text = arg_161_1:FormatText(StoryChoiceCfg[468].name)
			arg_161_1.choices_[2].txt.text = arg_161_1:FormatText(StoryChoiceCfg[469].name)
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1108104041(arg_161_1)
			end

			if arg_163_0 == 2 then
				arg_161_0:Play1108104041(arg_161_1)
			end

			arg_161_1:RecordChoiceLog(1108104040, 468, 469)
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1081ui_story = arg_161_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).z)
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles = arg_161_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_161_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).z)
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles = arg_161_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1081ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1081ui_story == nil then
				arg_161_1.var_.characterEffect1081ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.0166666666666667

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1081ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1081ui_story then
				arg_161_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play1108104041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1108104041
		arg_165_1.duration_ = 8.03

		local var_165_0 = {
			ja = 4.133,
			ko = 8.033,
			zh = 8.033
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
				arg_165_0:Play1108104042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1081ui_story"]) and arg_165_1.var_.characterEffect1081ui_story == nil then
				arg_165_1.var_.characterEffect1081ui_story = arg_165_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.0166666666666667

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1081ui_story"]) then
				if arg_165_1.var_.characterEffect1081ui_story and not isNil(arg_165_1.actors_["1081ui_story"]) then
					arg_165_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1081ui_story"]) and arg_165_1.var_.characterEffect1081ui_story then
				arg_165_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_168_2 = 0
			local var_168_3 = 0.675

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(1108104041)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 27 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 27)

				if (27 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 27)) > 0 and var_168_3 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104041", "story_v_side_new_1108104.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104041", "story_v_side_new_1108104.awb") / 1000

					if var_168_8 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_2
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_side_new_1108104", "1108104041", "story_v_side_new_1108104.awb")

						arg_165_1:RecordAudio("1108104041", var_168_9)
						arg_165_1:RecordAudio("1108104041", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104041", "story_v_side_new_1108104.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104041", "story_v_side_new_1108104.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_10 and arg_165_1.time_ < var_168_2 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1108104042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1108104042
		arg_169_1.duration_ = 5.73

		local var_169_0 = {
			ja = 2.966,
			ko = 5.733,
			zh = 5.733
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
				arg_169_0:Play1108104043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1081ui_story = arg_169_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).z)
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles = arg_169_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_169_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).z)
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles = arg_169_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1081ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1081ui_story == nil then
				arg_169_1.var_.characterEffect1081ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.0166666666666667

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1081ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1081ui_story then
				arg_169_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.45

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(1108104042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 18 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 18)

				if (18 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 18)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104042", "story_v_side_new_1108104.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104042", "story_v_side_new_1108104.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_side_new_1108104", "1108104042", "story_v_side_new_1108104.awb")

						arg_169_1:RecordAudio("1108104042", var_172_11)
						arg_169_1:RecordAudio("1108104042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104042", "story_v_side_new_1108104.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104042", "story_v_side_new_1108104.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1108104043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108104043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1108104044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1081ui_story = arg_173_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1081ui_story"].transform.position).z)
				arg_173_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1081ui_story"].transform.localEulerAngles = arg_173_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_173_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1081ui_story"].transform.position).z)
				arg_173_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1081ui_story"].transform.localEulerAngles = arg_173_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1081ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1081ui_story == nil then
				arg_173_1.var_.characterEffect1081ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.0166666666666667

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1081ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_2)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1081ui_story then
				arg_173_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_176_3 = 0
			local var_176_4 = 0.2

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_5 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1108104043).content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 8 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 8)

				if (8 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 8)) > 0 and var_176_4 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_3
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_4, arg_173_1.talkMaxDuration)

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_3) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_3 + var_176_8 and arg_173_1.time_ < var_176_3 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play1108104044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1108104044
		arg_177_1.duration_ = 5.5

		local var_177_0 = {
			ja = 5.5,
			ko = 2.766,
			zh = 2.766
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
				arg_177_0:Play1108104045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1081ui_story = arg_177_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1081ui_story"].transform.position).z)
				arg_177_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1081ui_story"].transform.localEulerAngles = arg_177_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_177_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1081ui_story"].transform.position).z)
				arg_177_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1081ui_story"].transform.localEulerAngles = arg_177_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1081ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1081ui_story == nil then
				arg_177_1.var_.characterEffect1081ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.0166666666666667

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1081ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1081ui_story then
				arg_177_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(1108104044)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 13 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 13)

				if (13 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 13)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104044", "story_v_side_new_1108104.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104044", "story_v_side_new_1108104.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_side_new_1108104", "1108104044", "story_v_side_new_1108104.awb")

						arg_177_1:RecordAudio("1108104044", var_180_11)
						arg_177_1:RecordAudio("1108104044", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104044", "story_v_side_new_1108104.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104044", "story_v_side_new_1108104.awb")
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
				actorName = "1081ui_story",
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
	Play1108104045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1108104045
		arg_181_1.duration_ = 5.87

		local var_181_0 = {
			ja = 5.866,
			ko = 4.5,
			zh = 4.5
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
				arg_181_0:Play1108104046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1081ui_story = arg_181_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).z)
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles = arg_181_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_181_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).z)
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles = arg_181_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1081ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1081ui_story == nil then
				arg_181_1.var_.characterEffect1081ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.0166666666666667

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1081ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1081ui_story then
				arg_181_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_184_4 = 0
			local var_184_5 = 0.7

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(1108104045)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 28 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 28)

				if (28 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 28)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104045", "story_v_side_new_1108104.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104045", "story_v_side_new_1108104.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_side_new_1108104", "1108104045", "story_v_side_new_1108104.awb")

						arg_181_1:RecordAudio("1108104045", var_184_11)
						arg_181_1:RecordAudio("1108104045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104045", "story_v_side_new_1108104.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104045", "story_v_side_new_1108104.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1108104046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1108104046
		arg_185_1.duration_ = 5.3

		local var_185_0 = {
			ja = 5.3,
			ko = 4.233,
			zh = 4.233
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
				arg_185_0:Play1108104047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1081ui_story = arg_185_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1081ui_story"].transform.position).z)
				arg_185_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1081ui_story"].transform.localEulerAngles = arg_185_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_185_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1081ui_story"].transform.position).z)
				arg_185_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1081ui_story"].transform.localEulerAngles = arg_185_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1081ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1081ui_story == nil then
				arg_185_1.var_.characterEffect1081ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.0166666666666667

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1081ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1081ui_story then
				arg_185_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_4 = 0
			local var_188_5 = 0.6

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(1108104046)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 24 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 24)

				if (24 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 24)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104046", "story_v_side_new_1108104.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104046", "story_v_side_new_1108104.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_side_new_1108104", "1108104046", "story_v_side_new_1108104.awb")

						arg_185_1:RecordAudio("1108104046", var_188_11)
						arg_185_1:RecordAudio("1108104046", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104046", "story_v_side_new_1108104.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104046", "story_v_side_new_1108104.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play1108104047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1108104047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1108104048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1081ui_story = arg_189_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).z)
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles = arg_189_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_189_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).z)
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles = arg_189_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1081ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1081ui_story == nil then
				arg_189_1.var_.characterEffect1081ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.0166666666666667

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1081ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1081ui_story then
				arg_189_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_192_3 = 0
			local var_192_4 = 0.3

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_5 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1108104047).content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 12 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 12)

				if (12 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 12)) > 0 and var_192_4 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_3 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_3
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_4, arg_189_1.talkMaxDuration)

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_3) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_3 + var_192_8 and arg_189_1.time_ < var_192_3 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play1108104048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1108104048
		arg_193_1.duration_ = 10.17

		local var_193_0 = {
			ja = 8.3,
			ko = 10.166,
			zh = 10.166
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
				arg_193_0:Play1108104049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1081ui_story = arg_193_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1081ui_story"].transform.position).z)
				arg_193_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1081ui_story"].transform.localEulerAngles = arg_193_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_193_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1081ui_story"].transform.position).z)
				arg_193_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1081ui_story"].transform.localEulerAngles = arg_193_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1081ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1081ui_story == nil then
				arg_193_1.var_.characterEffect1081ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.0166666666666667

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1081ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1081ui_story then
				arg_193_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action476")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_196_4 = 0
			local var_196_5 = 1.125

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(1108104048)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 45 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 45)

				if (45 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 45)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104048", "story_v_side_new_1108104.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104048", "story_v_side_new_1108104.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_side_new_1108104", "1108104048", "story_v_side_new_1108104.awb")

						arg_193_1:RecordAudio("1108104048", var_196_11)
						arg_193_1:RecordAudio("1108104048", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104048", "story_v_side_new_1108104.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104048", "story_v_side_new_1108104.awb")
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

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play1108104049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1108104049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1108104050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1081ui_story = arg_197_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).z)
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles = arg_197_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_197_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).z)
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles = arg_197_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1081ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1081ui_story == nil then
				arg_197_1.var_.characterEffect1081ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.0166666666666667

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1081ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_2)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1081ui_story then
				arg_197_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_200_3 = 0
			local var_200_4 = 0.175

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_5 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1108104049).content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 7 <= 0 and var_200_4 or var_200_4 * (utf8.len(var_200_5) / 7)

				if (7 <= 0 and var_200_4 or var_200_4 * (utf8.len(var_200_5) / 7)) > 0 and var_200_4 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_3 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_3
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_4, arg_197_1.talkMaxDuration)

			if var_200_3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_3 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_3) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_3 + var_200_8 and arg_197_1.time_ < var_200_3 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play1108104050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1108104050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1108104051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1081ui_story = arg_201_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).z)
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles = arg_201_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).z)
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles = arg_201_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_204_1 = 0
			local var_204_2 = 2.275

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1108104050).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 90 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 90)

				if (90 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 90)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play1108104051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1108104051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1108104052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1081ui_story = arg_205_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).z)
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles = arg_205_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_205_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).z)
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles = arg_205_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1081ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1081ui_story == nil then
				arg_205_1.var_.characterEffect1081ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.0166666666666667

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1081ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_2)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1081ui_story then
				arg_205_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_208_3 = 0
			local var_208_4 = 0.175

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_5 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1108104051).content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 7 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 7)

				if (7 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 7)) > 0 and var_208_4 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_3
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_4, arg_205_1.talkMaxDuration)

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_3) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_3 + var_208_8 and arg_205_1.time_ < var_208_3 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1108104052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108104052
		arg_209_1.duration_ = 6.73

		local var_209_0 = {
			ja = 6.733,
			ko = 4.533,
			zh = 4.533
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1108104053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1081ui_story = arg_209_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1081ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story == nil then
				arg_209_1.var_.characterEffect1081ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.0166666666666667

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1081ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story then
				arg_209_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_212_4 = 0
			local var_212_5 = 0.55

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(1108104052)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 22 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 22)

				if (22 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 22)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104052", "story_v_side_new_1108104.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104052", "story_v_side_new_1108104.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_side_new_1108104", "1108104052", "story_v_side_new_1108104.awb")

						arg_209_1:RecordAudio("1108104052", var_212_11)
						arg_209_1:RecordAudio("1108104052", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104052", "story_v_side_new_1108104.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104052", "story_v_side_new_1108104.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108104053
		arg_213_1.duration_ = 6.87

		local var_213_0 = {
			ja = 6.366,
			ko = 6.866,
			zh = 6.866
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
				arg_213_0:Play1108104054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1081ui_story = arg_213_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1081ui_story"].transform.position).z)
				arg_213_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1081ui_story"].transform.localEulerAngles = arg_213_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_213_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1081ui_story"].transform.position).z)
				arg_213_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1081ui_story"].transform.localEulerAngles = arg_213_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1081ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1081ui_story == nil then
				arg_213_1.var_.characterEffect1081ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.0166666666666667

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1081ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1081ui_story then
				arg_213_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.95

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(1108104053)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 38 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 38)

				if (38 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 38)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104053", "story_v_side_new_1108104.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104053", "story_v_side_new_1108104.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1108104", "1108104053", "story_v_side_new_1108104.awb")

						arg_213_1:RecordAudio("1108104053", var_216_11)
						arg_213_1:RecordAudio("1108104053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104053", "story_v_side_new_1108104.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104053", "story_v_side_new_1108104.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1108104054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1108104054
		arg_217_1.duration_ = 6.73

		local var_217_0 = {
			ja = 6.733,
			ko = 3.466,
			zh = 3.466
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
				arg_217_0:Play1108104055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(1108104054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)

				if (21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104054", "story_v_side_new_1108104.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104054", "story_v_side_new_1108104.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_side_new_1108104", "1108104054", "story_v_side_new_1108104.awb")

						arg_217_1:RecordAudio("1108104054", var_220_6)
						arg_217_1:RecordAudio("1108104054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104054", "story_v_side_new_1108104.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104054", "story_v_side_new_1108104.awb")
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
	Play1108104055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1108104055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1108104056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1081ui_story = arg_221_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1081ui_story"].transform.position).z)
				arg_221_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1081ui_story"].transform.localEulerAngles = arg_221_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1081ui_story"].transform.position).z)
				arg_221_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1081ui_story"].transform.localEulerAngles = arg_221_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1081ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1081ui_story == nil then
				arg_221_1.var_.characterEffect1081ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.0166666666666667

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1081ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_2)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1081ui_story then
				arg_221_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_224_3 = 0
			local var_224_4 = 0.55

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1108104055).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 22 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 22)

				if (22 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 22)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1108104056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1108104056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1108104057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.825

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1108104056).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 33 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 33)

				if (33 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 33)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1108104057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1108104057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1108104058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1081ui_story = arg_229_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).z)
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles = arg_229_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_229_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).z)
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles = arg_229_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1081ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1081ui_story == nil then
				arg_229_1.var_.characterEffect1081ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.0166666666666667

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1081ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_2)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1081ui_story then
				arg_229_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_232_3 = 0
			local var_232_4 = 0.3

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_5 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1108104057).content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 12 <= 0 and var_232_4 or var_232_4 * (utf8.len(var_232_5) / 12)

				if (12 <= 0 and var_232_4 or var_232_4 * (utf8.len(var_232_5) / 12)) > 0 and var_232_4 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_3 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_3
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_4, arg_229_1.talkMaxDuration)

			if var_232_3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_3 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_3) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_3 + var_232_8 and arg_229_1.time_ < var_232_3 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1108104058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1108104058
		arg_233_1.duration_ = 7.57

		local var_233_0 = {
			ja = 6.666,
			ko = 7.566,
			zh = 7.566
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
				arg_233_0:Play1108104059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1081ui_story = arg_233_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1081ui_story"].transform.position).z)
				arg_233_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1081ui_story"].transform.localEulerAngles = arg_233_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_233_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1081ui_story"].transform.position).z)
				arg_233_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1081ui_story"].transform.localEulerAngles = arg_233_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1081ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1081ui_story == nil then
				arg_233_1.var_.characterEffect1081ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.0166666666666667

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1081ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1081ui_story then
				arg_233_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_2")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = 0
			local var_236_5 = 0.85

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(1108104058)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 34 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 34)

				if (34 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 34)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104058", "story_v_side_new_1108104.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104058", "story_v_side_new_1108104.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_side_new_1108104", "1108104058", "story_v_side_new_1108104.awb")

						arg_233_1:RecordAudio("1108104058", var_236_11)
						arg_233_1:RecordAudio("1108104058", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104058", "story_v_side_new_1108104.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104058", "story_v_side_new_1108104.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1108104059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108104059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108104060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1081ui_story = arg_237_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1081ui_story"].transform.position).z)
				arg_237_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1081ui_story"].transform.localEulerAngles = arg_237_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1081ui_story"].transform.position).z)
				arg_237_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1081ui_story"].transform.localEulerAngles = arg_237_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1081ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1081ui_story == nil then
				arg_237_1.var_.characterEffect1081ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1081ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_2)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1081ui_story then
				arg_237_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_240_3 = 0
			local var_240_4 = 0.95

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_5 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1108104059).content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 38 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_5) / 38)

				if (38 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_5) / 38)) > 0 and var_240_4 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_3
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_8 = math.max(var_240_4, arg_237_1.talkMaxDuration)

			if var_240_3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_3 + var_240_8 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_3) / var_240_8

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_3 + var_240_8 and arg_237_1.time_ < var_240_3 + var_240_8 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108104060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1108104060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1108104061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.9

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

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1108104060).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 36 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 36)

				if (36 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 36)) > 0 and var_244_0 < var_244_3 then
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
	Play1108104061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1108104061
		arg_245_1.duration_ = 4.63

		local var_245_0 = {
			ja = 4.633,
			ko = 3.8,
			zh = 3.8
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1108104062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1081ui_story = arg_245_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1081ui_story"].transform.position).z)
				arg_245_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1081ui_story"].transform.localEulerAngles = arg_245_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_245_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1081ui_story"].transform.position).z)
				arg_245_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1081ui_story"].transform.localEulerAngles = arg_245_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1081ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1081ui_story == nil then
				arg_245_1.var_.characterEffect1081ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.0166666666666667

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1081ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1081ui_story then
				arg_245_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_248_4 = 0
			local var_248_5 = 0.375

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(1108104061)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 15 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 15)

				if (15 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 15)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104061", "story_v_side_new_1108104.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104061", "story_v_side_new_1108104.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_side_new_1108104", "1108104061", "story_v_side_new_1108104.awb")

						arg_245_1:RecordAudio("1108104061", var_248_11)
						arg_245_1:RecordAudio("1108104061", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104061", "story_v_side_new_1108104.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104061", "story_v_side_new_1108104.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1108104062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1108104062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1108104063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1081ui_story = arg_249_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1081ui_story"].transform.position).z)
				arg_249_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1081ui_story"].transform.localEulerAngles = arg_249_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_249_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1081ui_story"].transform.position).z)
				arg_249_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1081ui_story"].transform.localEulerAngles = arg_249_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1081ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1081ui_story == nil then
				arg_249_1.var_.characterEffect1081ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.0166666666666667

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1081ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_2)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1081ui_story then
				arg_249_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_252_3 = 0
			local var_252_4 = 0.4

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_3 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_5 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1108104062).content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 16 <= 0 and var_252_4 or var_252_4 * (utf8.len(var_252_5) / 16)

				if (16 <= 0 and var_252_4 or var_252_4 * (utf8.len(var_252_5) / 16)) > 0 and var_252_4 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_3 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_3
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_4, arg_249_1.talkMaxDuration)

			if var_252_3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_3 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_3) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_3 + var_252_8 and arg_249_1.time_ < var_252_3 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1108104063
		arg_253_1.duration_ = 4.8

		local var_253_0 = {
			ja = 3.1,
			ko = 4.8,
			zh = 4.8
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
				arg_253_0:Play1108104064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1081ui_story = arg_253_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).z)
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles = arg_253_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_253_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).z)
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles = arg_253_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1081ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1081ui_story == nil then
				arg_253_1.var_.characterEffect1081ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.0166666666666667

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1081ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1081ui_story then
				arg_253_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.65

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(1108104063)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 26 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 26)

				if (26 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 26)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104063", "story_v_side_new_1108104.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104063", "story_v_side_new_1108104.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_side_new_1108104", "1108104063", "story_v_side_new_1108104.awb")

						arg_253_1:RecordAudio("1108104063", var_256_11)
						arg_253_1:RecordAudio("1108104063", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104063", "story_v_side_new_1108104.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104063", "story_v_side_new_1108104.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1108104064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1108104064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1108104065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1081ui_story = arg_257_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).z)
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles = arg_257_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_257_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).z)
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles = arg_257_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1081ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1081ui_story == nil then
				arg_257_1.var_.characterEffect1081ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.0166666666666667

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1081ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_2)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1081ui_story then
				arg_257_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_260_3 = 0
			local var_260_4 = 0.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_5 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1108104064).content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 15 <= 0 and var_260_4 or var_260_4 * (utf8.len(var_260_5) / 15)

				if (15 <= 0 and var_260_4 or var_260_4 * (utf8.len(var_260_5) / 15)) > 0 and var_260_4 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_3 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_3
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_4, arg_257_1.talkMaxDuration)

			if var_260_3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_3 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_3) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_3 + var_260_8 and arg_257_1.time_ < var_260_3 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1108104065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1108104065
		arg_261_1.duration_ = 8.57

		local var_261_0 = {
			ja = 8.566,
			ko = 8,
			zh = 8
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
				arg_261_0:Play1108104066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1081ui_story = arg_261_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).z)
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles = arg_261_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_261_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).z)
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles = arg_261_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1081ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1081ui_story == nil then
				arg_261_1.var_.characterEffect1081ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.0166666666666667

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1081ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1081ui_story then
				arg_261_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_264_4 = 0
			local var_264_5 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(1108104065)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 29 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 29)

				if (29 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 29)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104065", "story_v_side_new_1108104.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104065", "story_v_side_new_1108104.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_side_new_1108104", "1108104065", "story_v_side_new_1108104.awb")

						arg_261_1:RecordAudio("1108104065", var_264_11)
						arg_261_1:RecordAudio("1108104065", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104065", "story_v_side_new_1108104.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104065", "story_v_side_new_1108104.awb")
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
				actorName = "1081ui_story",
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
	Play1108104066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1108104066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1108104067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1081ui_story = arg_265_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1081ui_story"].transform.position).z)
				arg_265_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1081ui_story"].transform.localEulerAngles = arg_265_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_265_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1081ui_story"].transform.position).z)
				arg_265_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1081ui_story"].transform.localEulerAngles = arg_265_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1081ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1081ui_story == nil then
				arg_265_1.var_.characterEffect1081ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.0166666666666667

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1081ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_2)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1081ui_story then
				arg_265_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_268_3 = 0
			local var_268_4 = 0.125

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_5 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1108104066).content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 5 <= 0 and var_268_4 or var_268_4 * (utf8.len(var_268_5) / 5)

				if (5 <= 0 and var_268_4 or var_268_4 * (utf8.len(var_268_5) / 5)) > 0 and var_268_4 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_3 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_3
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_4, arg_265_1.talkMaxDuration)

			if var_268_3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_3 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_3) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_3 + var_268_8 and arg_265_1.time_ < var_268_3 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1108104067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1108104068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1081ui_story = arg_269_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).z)
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles = arg_269_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).z)
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles = arg_269_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1081ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1081ui_story == nil then
				arg_269_1.var_.characterEffect1081ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1081ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_2)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1081ui_story then
				arg_269_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_272_3 = 0
			local var_272_4 = 1.225

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_5 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1108104067).content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 49 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_5) / 49)

				if (49 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_5) / 49)) > 0 and var_272_4 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_3
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_4, arg_269_1.talkMaxDuration)

			if var_272_3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_3 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_3) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_3 + var_272_8 and arg_269_1.time_ < var_272_3 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1108104068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1108104069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 1.425

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1108104068).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 57 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 57)

				if (57 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 57)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1108104069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1108104069
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1108104070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0.133333333333333 < arg_277_1.time_ and arg_277_1.time_ <= 0.133333333333333 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_bubble", "")
			end

			if 0.666666666666667 < arg_277_1.time_ and arg_277_1.time_ <= 0.666666666666667 + arg_280_0 then
				arg_277_1:AudioAction("stop", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_280_3 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_277_1.bgmTxt_.text ~= var_280_3 and arg_277_1.bgmTxt_.text ~= "" then
						if arg_277_1.bgmTxt2_.text ~= "" then
							arg_277_1.bgmTxt_.text = arg_277_1.bgmTxt2_.text
						end

						arg_277_1.bgmTxt2_.text = var_280_3

						arg_277_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_277_1.bgmTxt_.text = var_280_3
						arg_277_1.bgmTxt2_.text = var_280_3
					end

					if arg_277_1.bgmTimer then
						arg_277_1.bgmTimer:Stop()

						arg_277_1.bgmTimer = nil
					end

					if arg_277_1.settingData.show_music_name == 1 then
						arg_277_1.musicController:SetSelectedState("show")
						arg_277_1.musicAnimator_:Play("open", 0, 0)

						if arg_277_1.settingData.music_time ~= 0 then
							arg_277_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_277_1.settingData.music_time), function()
								if arg_277_1 == nil or isNil(arg_277_1.bgmTxt_) then
									return
								end

								arg_277_1.musicController:SetSelectedState("hide")
								arg_277_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_280_4 = 0
			local var_280_5 = 0.35

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_6 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1108104069).content)

				arg_277_1.text_.text = var_280_6

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_8 = 14 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_6) / 14)

				if (14 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_6) / 14)) > 0 and var_280_5 < var_280_8 then
					arg_277_1.talkMaxDuration = var_280_8

					if var_280_8 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_6
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_9 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_9 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_9

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_9 and arg_277_1.time_ < var_280_4 + var_280_9 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1108104070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1108104070
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1108104071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.925

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1108104070).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 37 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 37)

				if (37 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 37)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1108104071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1108104071
		arg_286_1.duration_ = 9

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1108104072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if arg_286_1.bgs_.R8101 == nil then
				local var_289_0 = Object.Instantiate(arg_286_1.paintGo_)

				var_289_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8101")
				var_289_0.name = "R8101"
				var_289_0.transform.parent = arg_286_1.stage_.transform
				var_289_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.bgs_.R8101 = var_289_0
			end

			if 2 < arg_286_1.time_ and arg_286_1.time_ <= 2 + arg_289_0 then
				local var_289_1 = arg_286_1.bgs_.R8101

				arg_286_1.bgs_.R8101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_2 = var_289_1:GetComponent("SpriteRenderer")

				if var_289_2 and var_289_2.sprite then
					local var_289_3 = 2 * (var_289_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_1.transform.localScale = Vector3.New(var_289_3 / var_289_2.sprite.bounds.size.y < var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x and var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x or var_289_3 / var_289_2.sprite.bounds.size.y, var_289_3 / var_289_2.sprite.bounds.size.y < var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x and var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x or var_289_3 / var_289_2.sprite.bounds.size.y, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "R8101" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_4 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_5 = 2

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_5 then
				local var_289_6 = Color.New(1, 1, 1)

				var_289_6.a = Mathf.Lerp(0, 1, (arg_286_1.time_ - var_289_4) / var_289_5)
				arg_286_1.mask_.color = var_289_6
			end

			if arg_286_1.time_ >= var_289_4 + var_289_5 and arg_286_1.time_ < var_289_4 + var_289_5 + arg_289_0 then
				local var_289_7 = Color.New(1, 1, 1)

				var_289_7.a = 1
				arg_286_1.mask_.color = var_289_7
			end

			local var_289_8 = 2

			if 2 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_9 = 2

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_9 then
				local var_289_10 = Color.New(1, 1, 1)

				var_289_10.a = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_8) / var_289_9)
				arg_286_1.mask_.color = var_289_10
			end

			if arg_286_1.time_ >= var_289_8 + var_289_9 and arg_286_1.time_ < var_289_8 + var_289_9 + arg_289_0 then
				local var_289_11 = Color.New(1, 1, 1)

				arg_286_1.mask_.enabled = false
				var_289_11.a = 0
				arg_286_1.mask_.color = var_289_11
			end

			local var_289_12 = "R8101a"

			if arg_286_1.bgs_.R8101a == nil then
				local var_289_13 = Object.Instantiate(arg_286_1.paintGo_)

				var_289_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_289_12)
				var_289_13.name = var_289_12
				var_289_13.transform.parent = arg_286_1.stage_.transform
				var_289_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.bgs_[var_289_12] = var_289_13
			end

			local var_289_14 = arg_286_1.bgs_.R8101a.transform

			if 2 < arg_286_1.time_ and arg_286_1.time_ <= 2 + arg_289_0 then
				arg_286_1.var_.moveOldPosR8101a = var_289_14.localPosition
			end

			local var_289_15 = 0.001

			if 2 <= arg_286_1.time_ and arg_286_1.time_ < 2 + var_289_15 then
				var_289_14.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPosR8101a, Vector3.New(2.44, -0.5, 0), (arg_286_1.time_ - 2) / var_289_15)
			end

			if arg_286_1.time_ >= 2 + var_289_15 and arg_286_1.time_ < 2 + var_289_15 + arg_289_0 then
				var_289_14.localPosition = Vector3.New(2.44, -0.5, 0)
			end

			local var_289_16 = arg_286_1.bgs_.R8101a.transform

			if 2.034 < arg_286_1.time_ and arg_286_1.time_ <= 2.034 + arg_289_0 then
				arg_286_1.var_.moveOldPosR8101a = var_289_16.localPosition
			end

			local var_289_17 = 1.966

			if 2.034 <= arg_286_1.time_ and arg_286_1.time_ < 2.034 + var_289_17 then
				var_289_16.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPosR8101a, Vector3.New(2.44, -0.05, 0), (arg_286_1.time_ - 2.034) / var_289_17)
			end

			if arg_286_1.time_ >= 2.034 + var_289_17 and arg_286_1.time_ < 2.034 + var_289_17 + arg_289_0 then
				var_289_16.localPosition = Vector3.New(2.44, -0.05, 0)
			end

			if 1.5 < arg_286_1.time_ and arg_286_1.time_ <= 1.5 + arg_289_0 then
				arg_286_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach.awb")

				local var_289_20 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach")

				if "" ~= "" then
					if arg_286_1.bgmTxt_.text ~= var_289_20 and arg_286_1.bgmTxt_.text ~= "" then
						if arg_286_1.bgmTxt2_.text ~= "" then
							arg_286_1.bgmTxt_.text = arg_286_1.bgmTxt2_.text
						end

						arg_286_1.bgmTxt2_.text = var_289_20

						arg_286_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_286_1.bgmTxt_.text = var_289_20
						arg_286_1.bgmTxt2_.text = var_289_20
					end

					if arg_286_1.bgmTimer then
						arg_286_1.bgmTimer:Stop()

						arg_286_1.bgmTimer = nil
					end

					if arg_286_1.settingData.show_music_name == 1 then
						arg_286_1.musicController:SetSelectedState("show")
						arg_286_1.musicAnimator_:Play("open", 0, 0)

						if arg_286_1.settingData.music_time ~= 0 then
							arg_286_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_286_1.settingData.music_time), function()
								if arg_286_1 == nil or isNil(arg_286_1.bgmTxt_) then
									return
								end

								arg_286_1.musicController:SetSelectedState("hide")
								arg_286_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_21 = 4
			local var_289_22 = 0.825

			if 4 < arg_286_1.time_ and arg_286_1.time_ <= var_289_21 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_23 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_23:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_286_1.dialogCg_.alpha = arg_291_0
				end))
				var_289_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_24 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(1108104071).content)

				arg_286_1.text_.text = var_289_24

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_26 = 33 <= 0 and var_289_22 or var_289_22 * (utf8.len(var_289_24) / 33)

				if (33 <= 0 and var_289_22 or var_289_22 * (utf8.len(var_289_24) / 33)) > 0 and var_289_22 < var_289_26 then
					arg_286_1.talkMaxDuration = var_289_26
					var_289_21 = var_289_21 + 0.3

					if var_289_26 + var_289_21 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_26 + var_289_21
					end
				end

				arg_286_1.text_.text = var_289_24
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_27 = var_289_21 + 0.3
			local var_289_28 = math.max(var_289_22, arg_286_1.talkMaxDuration)

			if var_289_21 + 0.3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_27 + var_289_28 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_27) / var_289_28

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_27 + var_289_28 and arg_286_1.time_ < var_289_27 + var_289_28 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R8101a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R8101a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play1108104072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1108104072
		arg_293_1.duration_ = 3.03

		local var_293_0 = {
			ja = 3.033,
			ko = 1.233,
			zh = 1.233
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
				arg_293_0:Play1108104073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.125

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(1108104072)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 5 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 5)

				if (5 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 5)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104072", "story_v_side_new_1108104.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104072", "story_v_side_new_1108104.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_side_new_1108104", "1108104072", "story_v_side_new_1108104.awb")

						arg_293_1:RecordAudio("1108104072", var_296_6)
						arg_293_1:RecordAudio("1108104072", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104072", "story_v_side_new_1108104.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104072", "story_v_side_new_1108104.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1108104073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1108104073
		arg_297_1.duration_ = 5.03

		local var_297_0 = {
			ja = 4.633,
			ko = 5.033,
			zh = 5.033
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
				arg_297_0:Play1108104074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				local var_300_0 = arg_297_1.bgs_.R8101a

				arg_297_1.bgs_.R8101a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_1 = var_300_0:GetComponent("SpriteRenderer")

				if var_300_1 and var_300_1.sprite then
					local var_300_2 = 2 * (var_300_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_0.transform.localScale = Vector3.New(var_300_2 / var_300_1.sprite.bounds.size.y < var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x and var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x or var_300_2 / var_300_1.sprite.bounds.size.y, var_300_2 / var_300_1.sprite.bounds.size.y < var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x and var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x or var_300_2 / var_300_1.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "R8101a" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_3 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_4 = 2

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_4 then
				local var_300_5 = Color.New(1, 1, 1)

				var_300_5.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_3) / var_300_4)
				arg_297_1.mask_.color = var_300_5
			end

			if arg_297_1.time_ >= var_300_3 + var_300_4 and arg_297_1.time_ < var_300_3 + var_300_4 + arg_300_0 then
				local var_300_6 = Color.New(1, 1, 1)

				arg_297_1.mask_.enabled = false
				var_300_6.a = 0
				arg_297_1.mask_.color = var_300_6
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_7 = 2
			local var_300_8 = 0.425

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_7 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_9 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_9:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(1108104073)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 17 <= 0 and var_300_8 or var_300_8 * (utf8.len(var_300_11) / 17)

				if (17 <= 0 and var_300_8 or var_300_8 * (utf8.len(var_300_11) / 17)) > 0 and var_300_8 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13
					var_300_7 = var_300_7 + 0.3

					if var_300_13 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_7
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104073", "story_v_side_new_1108104.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104073", "story_v_side_new_1108104.awb") / 1000

					if var_300_14 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_7
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_side_new_1108104", "1108104073", "story_v_side_new_1108104.awb")

						arg_297_1:RecordAudio("1108104073", var_300_15)
						arg_297_1:RecordAudio("1108104073", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104073", "story_v_side_new_1108104.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104073", "story_v_side_new_1108104.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = var_300_7 + 0.3
			local var_300_17 = math.max(var_300_8, arg_297_1.talkMaxDuration)

			if var_300_7 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_16) / var_300_17

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1108104074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1108104074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1108104075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.225

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1108104074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 9 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 9)

				if (9 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 9)) > 0 and var_306_0 < var_306_3 then
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
	Play1108104075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1108104075
		arg_307_1.duration_ = 5.33

		local var_307_0 = {
			ja = 5.333,
			ko = 5.033,
			zh = 5.033
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
				arg_307_0:Play1108104076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.475

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(1108104075)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 19 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 19)

				if (19 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 19)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104075", "story_v_side_new_1108104.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104075", "story_v_side_new_1108104.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_side_new_1108104", "1108104075", "story_v_side_new_1108104.awb")

						arg_307_1:RecordAudio("1108104075", var_310_6)
						arg_307_1:RecordAudio("1108104075", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104075", "story_v_side_new_1108104.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104075", "story_v_side_new_1108104.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1108104076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1108104076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1108104077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.6

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
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

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1108104076).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 24 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 24)

				if (24 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 24)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1108104077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1108104077
		arg_315_1.duration_ = 5.17

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1108104078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.425

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(1108104077)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 17 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 17)

				if (17 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 17)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104077", "story_v_side_new_1108104.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104077", "story_v_side_new_1108104.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_side_new_1108104", "1108104077", "story_v_side_new_1108104.awb")

						arg_315_1:RecordAudio("1108104077", var_318_6)
						arg_315_1:RecordAudio("1108104077", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104077", "story_v_side_new_1108104.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104077", "story_v_side_new_1108104.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1108104078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1108104078
		arg_319_1.duration_ = 6.93

		local var_319_0 = {
			ja = 6.933,
			ko = 6.2,
			zh = 6.2
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
				arg_319_0:Play1108104079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.9

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:GetWordFromCfg(1108104078)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 36 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 36)

				if (36 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 36)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104078", "story_v_side_new_1108104.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104078", "story_v_side_new_1108104.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_side_new_1108104", "1108104078", "story_v_side_new_1108104.awb")

						arg_319_1:RecordAudio("1108104078", var_322_6)
						arg_319_1:RecordAudio("1108104078", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104078", "story_v_side_new_1108104.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104078", "story_v_side_new_1108104.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1108104079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1108104079
		arg_323_1.duration_ = 10.17

		local var_323_0 = {
			ja = 10.166,
			ko = 3.466,
			zh = 3.466
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
				arg_323_0:Play1108104080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.275

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:GetWordFromCfg(1108104079)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 11 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 11)

				if (11 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 11)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104079", "story_v_side_new_1108104.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104079", "story_v_side_new_1108104.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_side_new_1108104", "1108104079", "story_v_side_new_1108104.awb")

						arg_323_1:RecordAudio("1108104079", var_326_6)
						arg_323_1:RecordAudio("1108104079", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104079", "story_v_side_new_1108104.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104079", "story_v_side_new_1108104.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1108104080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1108104080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1108104081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.825

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1108104080).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 33 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 33)

				if (33 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 33)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1108104081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1108104081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1108104082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.45

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1108104081).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 18 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 18)

				if (18 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 18)) > 0 and var_334_0 < var_334_3 then
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
	Play1108104082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1108104082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1108104083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1.1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1108104082).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 44 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 44)

				if (44 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 44)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1108104083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1108104083
		arg_339_1.duration_ = 9.8

		local var_339_0 = {
			ja = 9.8,
			ko = 4.9,
			zh = 4.9
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
				arg_339_0:Play1108104084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.6

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(1108104083)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 24 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 24)

				if (24 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 24)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104083", "story_v_side_new_1108104.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104083", "story_v_side_new_1108104.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_side_new_1108104", "1108104083", "story_v_side_new_1108104.awb")

						arg_339_1:RecordAudio("1108104083", var_342_6)
						arg_339_1:RecordAudio("1108104083", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104083", "story_v_side_new_1108104.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104083", "story_v_side_new_1108104.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1108104084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1108104084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1108104085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.125

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1108104084).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 5 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 5)

				if (5 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 5)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1108104085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1108104085
		arg_347_1.duration_ = 1.1

		local var_347_0 = {
			ja = 0.999999999999,
			ko = 1.1,
			zh = 1.1
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
				arg_347_0:Play1108104086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.05

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(1108104085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 2 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 2)

				if (2 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 2)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104085", "story_v_side_new_1108104.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104085", "story_v_side_new_1108104.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_side_new_1108104", "1108104085", "story_v_side_new_1108104.awb")

						arg_347_1:RecordAudio("1108104085", var_350_6)
						arg_347_1:RecordAudio("1108104085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104085", "story_v_side_new_1108104.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104085", "story_v_side_new_1108104.awb")
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
	Play1108104086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1108104086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1108104087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.975

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1108104086).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 39 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 39)

				if (39 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 39)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1108104087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1108104087
		arg_355_1.duration_ = 4.17

		local var_355_0 = {
			ja = 3.9,
			ko = 4.166,
			zh = 4.166
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
				arg_355_0:Play1108104088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.4

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(1108104087)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 16 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 16)

				if (16 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 16)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104087", "story_v_side_new_1108104.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104087", "story_v_side_new_1108104.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_side_new_1108104", "1108104087", "story_v_side_new_1108104.awb")

						arg_355_1:RecordAudio("1108104087", var_358_6)
						arg_355_1:RecordAudio("1108104087", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104087", "story_v_side_new_1108104.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104087", "story_v_side_new_1108104.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1108104088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1108104088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1108104089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.375

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1108104088).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 55 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 55)

				if (55 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 55)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1108104089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1108104089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1108104090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.65

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1108104089).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 26 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 26)

				if (26 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 26)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1108104090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1108104090
		arg_367_1.duration_ = 2.68

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1108104091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				local var_370_0 = arg_367_1.bgs_.R8101

				arg_367_1.bgs_.R8101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_370_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_370_1 = var_370_0:GetComponent("SpriteRenderer")

				if var_370_1 and var_370_1.sprite then
					local var_370_2 = 2 * (var_370_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_370_0.transform.localScale = Vector3.New(var_370_2 / var_370_1.sprite.bounds.size.y < var_370_2 * manager.ui.mainCameraCom_.aspect / var_370_1.sprite.bounds.size.x and var_370_2 * manager.ui.mainCameraCom_.aspect / var_370_1.sprite.bounds.size.x or var_370_2 / var_370_1.sprite.bounds.size.y, var_370_2 / var_370_1.sprite.bounds.size.y < var_370_2 * manager.ui.mainCameraCom_.aspect / var_370_1.sprite.bounds.size.x and var_370_2 * manager.ui.mainCameraCom_.aspect / var_370_1.sprite.bounds.size.x or var_370_2 / var_370_1.sprite.bounds.size.y, 0)
				end

				for iter_370_0, iter_370_1 in pairs(arg_367_1.bgs_) do
					if iter_370_0 ~= "R8101" then
						iter_370_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_370_3 = 0

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_3 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = false

				arg_367_1:SetGaussion(false)
			end

			local var_370_4 = 2

			if var_370_3 <= arg_367_1.time_ and arg_367_1.time_ < var_370_3 + var_370_4 then
				local var_370_5 = Color.New(1, 1, 1)

				var_370_5.a = Mathf.Lerp(1, 0, (arg_367_1.time_ - var_370_3) / var_370_4)
				arg_367_1.mask_.color = var_370_5
			end

			if arg_367_1.time_ >= var_370_3 + var_370_4 and arg_367_1.time_ < var_370_3 + var_370_4 + arg_370_0 then
				local var_370_6 = Color.New(1, 1, 1)

				arg_367_1.mask_.enabled = false
				var_370_6.a = 0
				arg_367_1.mask_.color = var_370_6
			end

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= 2 + arg_370_0 then
				arg_367_1.fswbg_:SetActive(true)
				arg_367_1.dialog_:SetActive(false)

				arg_367_1.fswtw_.percent = 0
				arg_367_1.fswt_.text = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1108104090).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.fswt_)

				arg_367_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_367_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_367_1.fswtw_:SetDirty()

				arg_367_1.typewritterCharCountI18N = 0

				SetActive(arg_367_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_367_1:ShowNextGo(false)
			end

			local var_370_7 = 2.01666666666667

			if 2.01666666666667 < arg_367_1.time_ and arg_367_1.time_ <= var_370_7 + arg_370_0 then
				arg_367_1.var_.oldValueTypewriter = arg_367_1.fswtw_.percent

				SetActive(arg_367_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_367_1:ShowNextGo(false)
			end

			local var_370_8 = 10
			local var_370_9 = 0.666666666666667
			local var_370_10, var_370_11 = arg_367_1:GetPercentByPara(arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1108104090).content), 1)

			if var_370_7 < arg_367_1.time_ and arg_367_1.time_ <= var_370_7 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0

				local var_370_12 = var_370_8 <= 0 and var_370_9 or var_370_9 * ((var_370_11 - arg_367_1.typewritterCharCountI18N) / var_370_8)

				if (var_370_8 <= 0 and var_370_9 or var_370_9 * ((var_370_11 - arg_367_1.typewritterCharCountI18N) / var_370_8)) > 0 and var_370_9 < var_370_12 then
					arg_367_1.talkMaxDuration = var_370_12

					if var_370_12 + var_370_7 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_12 + var_370_7
					end
				end
			end

			local var_370_13 = math.max(0.666666666666667, arg_367_1.talkMaxDuration)

			if var_370_7 <= arg_367_1.time_ and arg_367_1.time_ < var_370_7 + var_370_13 then
				arg_367_1.fswtw_.percent = Mathf.Lerp(arg_367_1.var_.oldValueTypewriter, var_370_10, (arg_367_1.time_ - var_370_7) / var_370_13)
				arg_367_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_367_1.fswtw_:SetDirty()
			end

			if arg_367_1.time_ >= var_370_7 + var_370_13 and arg_367_1.time_ < var_370_7 + var_370_13 + arg_370_0 then
				arg_367_1.fswtw_.percent = var_370_10

				arg_367_1.fswtw_:SetDirty()
				arg_367_1:ShowNextGo(true)

				arg_367_1.typewritterCharCountI18N = var_370_11
			end

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= 2 + arg_370_0 then
				local var_370_14 = arg_367_1.fswbg_.transform:Find("textbox/adapt/content") or arg_367_1.fswbg_.transform:Find("textbox/content")
				local var_370_15 = arg_367_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_370_16 = var_370_14:GetComponent("RectTransform")

				var_370_14:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_370_16.offsetMin = Vector2.New(0, 0)
				var_370_16.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1108104091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1108104091
		arg_371_1.duration_ = 1.68

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1108104092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.fswbg_:SetActive(true)
				arg_371_1.dialog_:SetActive(false)

				arg_371_1.fswtw_.percent = 0
				arg_371_1.fswt_.text = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1108104091).content)

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

			local var_374_1 = 25
			local var_374_2 = 1.66666666666667
			local var_374_3, var_374_4 = arg_371_1:GetPercentByPara(arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1108104091).content), 1)

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

			local var_374_6 = math.max(1.66666666666667, arg_371_1.talkMaxDuration)

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
	Play1108104092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1108104092
		arg_375_1.duration_ = 2.15

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1108104093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.fswbg_:SetActive(true)
				arg_375_1.dialog_:SetActive(false)

				arg_375_1.fswtw_.percent = 0
				arg_375_1.fswt_.text = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1108104092).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.fswt_)

				arg_375_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_375_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_375_1.fswtw_:SetDirty()

				arg_375_1.typewritterCharCountI18N = 0

				SetActive(arg_375_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_375_1:ShowNextGo(false)
			end

			local var_378_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.var_.oldValueTypewriter = arg_375_1.fswtw_.percent

				SetActive(arg_375_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_375_1:ShowNextGo(false)
			end

			local var_378_1 = 32
			local var_378_2 = 2.13333333333333
			local var_378_3, var_378_4 = arg_375_1:GetPercentByPara(arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1108104092).content), 1)

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				local var_378_5 = var_378_1 <= 0 and var_378_2 or var_378_2 * ((var_378_4 - arg_375_1.typewritterCharCountI18N) / var_378_1)

				if (var_378_1 <= 0 and var_378_2 or var_378_2 * ((var_378_4 - arg_375_1.typewritterCharCountI18N) / var_378_1)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end
			end

			local var_378_6 = math.max(2.13333333333333, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_6 then
				arg_375_1.fswtw_.percent = Mathf.Lerp(arg_375_1.var_.oldValueTypewriter, var_378_3, (arg_375_1.time_ - var_378_0) / var_378_6)
				arg_375_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_375_1.fswtw_:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_6 and arg_375_1.time_ < var_378_0 + var_378_6 + arg_378_0 then
				arg_375_1.fswtw_.percent = var_378_3

				arg_375_1.fswtw_:SetDirty()
				arg_375_1:ShowNextGo(true)

				arg_375_1.typewritterCharCountI18N = var_378_4
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1108104093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1108104093
		arg_379_1.duration_ = 1.55

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1108104094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.fswbg_:SetActive(true)
				arg_379_1.dialog_:SetActive(false)

				arg_379_1.fswtw_.percent = 0
				arg_379_1.fswt_.text = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1108104093).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.fswt_)

				arg_379_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_379_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_379_1.fswtw_:SetDirty()

				arg_379_1.typewritterCharCountI18N = 0

				SetActive(arg_379_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_379_1:ShowNextGo(false)
			end

			local var_382_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.var_.oldValueTypewriter = arg_379_1.fswtw_.percent

				SetActive(arg_379_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_379_1:ShowNextGo(false)
			end

			local var_382_1 = 23
			local var_382_2 = 1.53333333333333
			local var_382_3, var_382_4 = arg_379_1:GetPercentByPara(arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1108104093).content), 1)

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				local var_382_5 = var_382_1 <= 0 and var_382_2 or var_382_2 * ((var_382_4 - arg_379_1.typewritterCharCountI18N) / var_382_1)

				if (var_382_1 <= 0 and var_382_2 or var_382_2 * ((var_382_4 - arg_379_1.typewritterCharCountI18N) / var_382_1)) > 0 and var_382_2 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_0
					end
				end
			end

			local var_382_6 = math.max(1.53333333333333, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_6 then
				arg_379_1.fswtw_.percent = Mathf.Lerp(arg_379_1.var_.oldValueTypewriter, var_382_3, (arg_379_1.time_ - var_382_0) / var_382_6)
				arg_379_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_379_1.fswtw_:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_6 and arg_379_1.time_ < var_382_0 + var_382_6 + arg_382_0 then
				arg_379_1.fswtw_.percent = var_382_3

				arg_379_1.fswtw_:SetDirty()
				arg_379_1:ShowNextGo(true)

				arg_379_1.typewritterCharCountI18N = var_382_4
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1108104094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1108104094
		arg_383_1.duration_ = 1.15

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1108104095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.fswbg_:SetActive(true)
				arg_383_1.dialog_:SetActive(false)

				arg_383_1.fswtw_.percent = 0
				arg_383_1.fswt_.text = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1108104094).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.fswt_)

				arg_383_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_383_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_383_1.fswtw_:SetDirty()

				arg_383_1.typewritterCharCountI18N = 0

				SetActive(arg_383_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_383_1:ShowNextGo(false)
			end

			local var_386_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.var_.oldValueTypewriter = arg_383_1.fswtw_.percent

				SetActive(arg_383_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_383_1:ShowNextGo(false)
			end

			local var_386_1 = 17
			local var_386_2 = 1.13333333333333
			local var_386_3, var_386_4 = arg_383_1:GetPercentByPara(arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1108104094).content), 1)

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				local var_386_5 = var_386_1 <= 0 and var_386_2 or var_386_2 * ((var_386_4 - arg_383_1.typewritterCharCountI18N) / var_386_1)

				if (var_386_1 <= 0 and var_386_2 or var_386_2 * ((var_386_4 - arg_383_1.typewritterCharCountI18N) / var_386_1)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_0
					end
				end
			end

			local var_386_6 = math.max(1.13333333333333, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_6 then
				arg_383_1.fswtw_.percent = Mathf.Lerp(arg_383_1.var_.oldValueTypewriter, var_386_3, (arg_383_1.time_ - var_386_0) / var_386_6)
				arg_383_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_383_1.fswtw_:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_6 and arg_383_1.time_ < var_386_0 + var_386_6 + arg_386_0 then
				arg_383_1.fswtw_.percent = var_386_3

				arg_383_1.fswtw_:SetDirty()
				arg_383_1:ShowNextGo(true)

				arg_383_1.typewritterCharCountI18N = var_386_4
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1108104095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1108104095
		arg_387_1.duration_ = 1

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1108104096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.fswbg_:SetActive(true)
				arg_387_1.dialog_:SetActive(false)

				arg_387_1.fswtw_.percent = 0
				arg_387_1.fswt_.text = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1108104095).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.fswt_)

				arg_387_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_387_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_387_1.fswtw_:SetDirty()

				arg_387_1.typewritterCharCountI18N = 0

				SetActive(arg_387_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_387_1:ShowNextGo(false)
			end

			local var_390_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.var_.oldValueTypewriter = arg_387_1.fswtw_.percent

				SetActive(arg_387_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_387_1:ShowNextGo(false)
			end

			local var_390_1 = 5
			local var_390_2 = 0.333333333333333
			local var_390_3, var_390_4 = arg_387_1:GetPercentByPara(arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1108104095).content), 1)

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				local var_390_5 = var_390_1 <= 0 and var_390_2 or var_390_2 * ((var_390_4 - arg_387_1.typewritterCharCountI18N) / var_390_1)

				if (var_390_1 <= 0 and var_390_2 or var_390_2 * ((var_390_4 - arg_387_1.typewritterCharCountI18N) / var_390_1)) > 0 and var_390_2 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_0
					end
				end
			end

			local var_390_6 = math.max(0.333333333333333, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_6 then
				arg_387_1.fswtw_.percent = Mathf.Lerp(arg_387_1.var_.oldValueTypewriter, var_390_3, (arg_387_1.time_ - var_390_0) / var_390_6)
				arg_387_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_387_1.fswtw_:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_6 and arg_387_1.time_ < var_390_0 + var_390_6 + arg_390_0 then
				arg_387_1.fswtw_.percent = var_390_3

				arg_387_1.fswtw_:SetDirty()
				arg_387_1:ShowNextGo(true)

				arg_387_1.typewritterCharCountI18N = var_390_4
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1108104096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1108104096
		arg_391_1.duration_ = 9

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1108104097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if arg_391_1.bgs_.STblack == nil then
				local var_394_0 = Object.Instantiate(arg_391_1.paintGo_)

				var_394_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_394_0.name = "STblack"
				var_394_0.transform.parent = arg_391_1.stage_.transform
				var_394_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.bgs_.STblack = var_394_0
			end

			if 2 < arg_391_1.time_ and arg_391_1.time_ <= 2 + arg_394_0 then
				local var_394_1 = arg_391_1.bgs_.STblack

				arg_391_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_394_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_394_2 = var_394_1:GetComponent("SpriteRenderer")

				if var_394_2 and var_394_2.sprite then
					local var_394_3 = 2 * (var_394_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_394_1.transform.localScale = Vector3.New(var_394_3 / var_394_2.sprite.bounds.size.y < var_394_3 * manager.ui.mainCameraCom_.aspect / var_394_2.sprite.bounds.size.x and var_394_3 * manager.ui.mainCameraCom_.aspect / var_394_2.sprite.bounds.size.x or var_394_3 / var_394_2.sprite.bounds.size.y, var_394_3 / var_394_2.sprite.bounds.size.y < var_394_3 * manager.ui.mainCameraCom_.aspect / var_394_2.sprite.bounds.size.x and var_394_3 * manager.ui.mainCameraCom_.aspect / var_394_2.sprite.bounds.size.x or var_394_3 / var_394_2.sprite.bounds.size.y, 0)
				end

				for iter_394_0, iter_394_1 in pairs(arg_391_1.bgs_) do
					if iter_394_0 ~= "STblack" then
						iter_394_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_394_4 = 0

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_4 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_5 = 2

			if var_394_4 <= arg_391_1.time_ and arg_391_1.time_ < var_394_4 + var_394_5 then
				local var_394_6 = Color.New(0, 0, 0)

				var_394_6.a = Mathf.Lerp(0, 1, (arg_391_1.time_ - var_394_4) / var_394_5)
				arg_391_1.mask_.color = var_394_6
			end

			if arg_391_1.time_ >= var_394_4 + var_394_5 and arg_391_1.time_ < var_394_4 + var_394_5 + arg_394_0 then
				local var_394_7 = Color.New(0, 0, 0)

				var_394_7.a = 1
				arg_391_1.mask_.color = var_394_7
			end

			local var_394_8 = 2

			if 2 < arg_391_1.time_ and arg_391_1.time_ <= var_394_8 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_9 = 2

			if var_394_8 <= arg_391_1.time_ and arg_391_1.time_ < var_394_8 + var_394_9 then
				local var_394_10 = Color.New(0, 0, 0)

				var_394_10.a = Mathf.Lerp(1, 0, (arg_391_1.time_ - var_394_8) / var_394_9)
				arg_391_1.mask_.color = var_394_10
			end

			if arg_391_1.time_ >= var_394_8 + var_394_9 and arg_391_1.time_ < var_394_8 + var_394_9 + arg_394_0 then
				local var_394_11 = Color.New(0, 0, 0)

				arg_391_1.mask_.enabled = false
				var_394_11.a = 0
				arg_391_1.mask_.color = var_394_11
			end

			if 2 < arg_391_1.time_ and arg_391_1.time_ <= 2 + arg_394_0 then
				arg_391_1.fswbg_:SetActive(false)
				arg_391_1.dialog_:SetActive(false)
				SetActive(arg_391_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_391_1:ShowNextGo(false)
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_12 = 4
			local var_394_13 = 0.975

			if 4 < arg_391_1.time_ and arg_391_1.time_ <= var_394_12 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_14 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_14:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_15 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1108104096).content)

				arg_391_1.text_.text = var_394_15

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_17 = 39 <= 0 and var_394_13 or var_394_13 * (utf8.len(var_394_15) / 39)

				if (39 <= 0 and var_394_13 or var_394_13 * (utf8.len(var_394_15) / 39)) > 0 and var_394_13 < var_394_17 then
					arg_391_1.talkMaxDuration = var_394_17
					var_394_12 = var_394_12 + 0.3

					if var_394_17 + var_394_12 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_17 + var_394_12
					end
				end

				arg_391_1.text_.text = var_394_15
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_18 = var_394_12 + 0.3
			local var_394_19 = math.max(var_394_13, arg_391_1.talkMaxDuration)

			if var_394_12 + 0.3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_18 + var_394_19 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_18) / var_394_19

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_18 + var_394_19 and arg_391_1.time_ < var_394_18 + var_394_19 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1108104097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1108104097
		arg_397_1.duration_ = 7

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1108104098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if arg_397_1.bgs_.ST15a == nil then
				local var_400_0 = Object.Instantiate(arg_397_1.paintGo_)

				var_400_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_400_0.name = "ST15a"
				var_400_0.transform.parent = arg_397_1.stage_.transform
				var_400_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_397_1.bgs_.ST15a = var_400_0
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				local var_400_1 = arg_397_1.bgs_.ST15a

				arg_397_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_400_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_400_2 = var_400_1:GetComponent("SpriteRenderer")

				if var_400_2 and var_400_2.sprite then
					local var_400_3 = 2 * (var_400_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_400_1.transform.localScale = Vector3.New(var_400_3 / var_400_2.sprite.bounds.size.y < var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x and var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x or var_400_3 / var_400_2.sprite.bounds.size.y, var_400_3 / var_400_2.sprite.bounds.size.y < var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x and var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x or var_400_3 / var_400_2.sprite.bounds.size.y, 0)
				end

				for iter_400_0, iter_400_1 in pairs(arg_397_1.bgs_) do
					if iter_400_0 ~= "ST15a" then
						iter_400_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_400_4 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_5 = 2

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_5 then
				local var_400_6 = Color.New(0, 0, 0)

				var_400_6.a = Mathf.Lerp(1, 0, (arg_397_1.time_ - var_400_4) / var_400_5)
				arg_397_1.mask_.color = var_400_6
			end

			if arg_397_1.time_ >= var_400_4 + var_400_5 and arg_397_1.time_ < var_400_4 + var_400_5 + arg_400_0 then
				local var_400_7 = Color.New(0, 0, 0)

				arg_397_1.mask_.enabled = false
				var_400_7.a = 0
				arg_397_1.mask_.color = var_400_7
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_8 = 2
			local var_400_9 = 1.025

			if 2 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_10 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_10:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_11 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1108104097).content)

				arg_397_1.text_.text = var_400_11

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_13 = 41 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 41)

				if (41 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 41)) > 0 and var_400_9 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13
					var_400_8 = var_400_8 + 0.3

					if var_400_13 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_11
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = var_400_8 + 0.3
			local var_400_15 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 + 0.3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_14 + var_400_15 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_14) / var_400_15

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_14 + var_400_15 and arg_397_1.time_ < var_400_14 + var_400_15 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1108104098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1108104098
		arg_403_1.duration_ = 7.93

		local var_403_0 = {
			ja = 7.933,
			ko = 5.6,
			zh = 5.6
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1108104099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1081ui_story = arg_403_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).z)
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles = arg_403_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_403_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).z)
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles = arg_403_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1081ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1081ui_story == nil then
				arg_403_1.var_.characterEffect1081ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.0166666666666667

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1081ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1081ui_story then
				arg_403_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.525

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(1108104098)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 21 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 21)

				if (21 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 21)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104098", "story_v_side_new_1108104.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104098", "story_v_side_new_1108104.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_new_1108104", "1108104098", "story_v_side_new_1108104.awb")

						arg_403_1:RecordAudio("1108104098", var_406_11)
						arg_403_1:RecordAudio("1108104098", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104098", "story_v_side_new_1108104.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104098", "story_v_side_new_1108104.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1108104099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1108104099
		arg_407_1.duration_ = 9.53

		local var_407_0 = {
			ja = 9.533,
			ko = 6.7,
			zh = 6.7
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1108104100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1081ui_story = arg_407_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).z)
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles = arg_407_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_407_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).z)
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles = arg_407_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["1081ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1081ui_story == nil then
				arg_407_1.var_.characterEffect1081ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.0166666666666667

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect1081ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1081ui_story then
				arg_407_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_410_4 = 0
			local var_410_5 = 0.8

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_6 = arg_407_1:GetWordFromCfg(1108104099)
				local var_410_7 = arg_407_1:FormatText(var_410_6.content)

				arg_407_1.text_.text = var_410_7

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_9 = 32 <= 0 and var_410_5 or var_410_5 * (utf8.len(var_410_7) / 32)

				if (32 <= 0 and var_410_5 or var_410_5 * (utf8.len(var_410_7) / 32)) > 0 and var_410_5 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_4
					end
				end

				arg_407_1.text_.text = var_410_7
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104099", "story_v_side_new_1108104.awb") ~= 0 then
					local var_410_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104099", "story_v_side_new_1108104.awb") / 1000

					if var_410_10 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_4
					end

					if var_410_6.prefab_name ~= "" and arg_407_1.actors_[var_410_6.prefab_name] ~= nil then
						local var_410_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_6.prefab_name].transform, "story_v_side_new_1108104", "1108104099", "story_v_side_new_1108104.awb")

						arg_407_1:RecordAudio("1108104099", var_410_11)
						arg_407_1:RecordAudio("1108104099", var_410_11)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104099", "story_v_side_new_1108104.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104099", "story_v_side_new_1108104.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_12 = math.max(var_410_5, arg_407_1.talkMaxDuration)

			if var_410_4 <= arg_407_1.time_ and arg_407_1.time_ < var_410_4 + var_410_12 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_4) / var_410_12

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_4 + var_410_12 and arg_407_1.time_ < var_410_4 + var_410_12 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play1108104100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1108104100
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1108104101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1081ui_story = arg_411_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1081ui_story"].transform.position).z)
				arg_411_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1081ui_story"].transform.localEulerAngles = arg_411_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_411_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1081ui_story"].transform.position).z)
				arg_411_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1081ui_story"].transform.localEulerAngles = arg_411_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1081ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1081ui_story == nil then
				arg_411_1.var_.characterEffect1081ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.0166666666666667

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1081ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_2)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1081ui_story then
				arg_411_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_414_3 = 0
			local var_414_4 = 0.9

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_3 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_5 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1108104100).content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_7 = 36 <= 0 and var_414_4 or var_414_4 * (utf8.len(var_414_5) / 36)

				if (36 <= 0 and var_414_4 or var_414_4 * (utf8.len(var_414_5) / 36)) > 0 and var_414_4 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_3 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_3
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_4, arg_411_1.talkMaxDuration)

			if var_414_3 <= arg_411_1.time_ and arg_411_1.time_ < var_414_3 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_3) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_3 + var_414_8 and arg_411_1.time_ < var_414_3 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play1108104101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1108104101
		arg_415_1.duration_ = 4.83

		local var_415_0 = {
			ja = 4.833,
			ko = 3.366,
			zh = 3.366
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1108104102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1081ui_story = arg_415_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1081ui_story"].transform.position).z)
				arg_415_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1081ui_story"].transform.localEulerAngles = arg_415_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_415_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1081ui_story"].transform.position).z)
				arg_415_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1081ui_story"].transform.localEulerAngles = arg_415_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["1081ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1081ui_story == nil then
				arg_415_1.var_.characterEffect1081ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.0166666666666667

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1081ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1081ui_story then
				arg_415_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_418_4 = 0
			local var_418_5 = 0.625

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(1108104101)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 25 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 25)

				if (25 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 25)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104101", "story_v_side_new_1108104.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104101", "story_v_side_new_1108104.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_side_new_1108104", "1108104101", "story_v_side_new_1108104.awb")

						arg_415_1:RecordAudio("1108104101", var_418_11)
						arg_415_1:RecordAudio("1108104101", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104101", "story_v_side_new_1108104.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104101", "story_v_side_new_1108104.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1108104102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1108104102
		arg_419_1.duration_ = 6.13

		local var_419_0 = {
			ja = 6.133,
			ko = 4.7,
			zh = 4.7
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1108104103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1081ui_story = arg_419_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).z)
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles = arg_419_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_419_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).z)
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles = arg_419_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1081ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1081ui_story == nil then
				arg_419_1.var_.characterEffect1081ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.0166666666666667

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1081ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1081ui_story then
				arg_419_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_422_4 = 0
			local var_422_5 = 0.575

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(1108104102)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 23 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 23)

				if (23 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 23)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104102", "story_v_side_new_1108104.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104102", "story_v_side_new_1108104.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_side_new_1108104", "1108104102", "story_v_side_new_1108104.awb")

						arg_419_1:RecordAudio("1108104102", var_422_11)
						arg_419_1:RecordAudio("1108104102", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104102", "story_v_side_new_1108104.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104102", "story_v_side_new_1108104.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1108104103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1108104103
		arg_423_1.duration_ = 10.1

		local var_423_0 = {
			ja = 10.1,
			ko = 5.633,
			zh = 5.633
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1108104104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1081ui_story = arg_423_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1081ui_story"].transform.position).z)
				arg_423_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1081ui_story"].transform.localEulerAngles = arg_423_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_423_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1081ui_story"].transform.position).z)
				arg_423_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1081ui_story"].transform.localEulerAngles = arg_423_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1081ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1081ui_story == nil then
				arg_423_1.var_.characterEffect1081ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.0166666666666667

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1081ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1081ui_story then
				arg_423_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_426_4 = 0
			local var_426_5 = 0.65

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(1108104103)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 26 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 26)

				if (26 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 26)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104103", "story_v_side_new_1108104.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104103", "story_v_side_new_1108104.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_side_new_1108104", "1108104103", "story_v_side_new_1108104.awb")

						arg_423_1:RecordAudio("1108104103", var_426_11)
						arg_423_1:RecordAudio("1108104103", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104103", "story_v_side_new_1108104.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104103", "story_v_side_new_1108104.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1108104104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1108104104
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1108104105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1081ui_story = arg_427_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).z)
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles = arg_427_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_427_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).z)
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles = arg_427_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1081ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1081ui_story == nil then
				arg_427_1.var_.characterEffect1081ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1081ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_2)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1081ui_story then
				arg_427_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_430_3 = 0
			local var_430_4 = 0.2

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_3 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_5 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1108104104).content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 8 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_5) / 8)

				if (8 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_5) / 8)) > 0 and var_430_4 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_3 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_3
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_4, arg_427_1.talkMaxDuration)

			if var_430_3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_3 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_3) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_3 + var_430_8 and arg_427_1.time_ < var_430_3 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play1108104105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108104105
		arg_431_1.duration_ = 14

		local var_431_0 = {
			ja = 14,
			ko = 10.766,
			zh = 10.766
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108104106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1081ui_story = arg_431_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1081ui_story"].transform.position).z)
				arg_431_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1081ui_story"].transform.localEulerAngles = arg_431_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_431_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1081ui_story"].transform.position).z)
				arg_431_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1081ui_story"].transform.localEulerAngles = arg_431_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_434_1 = arg_431_1.actors_["1081ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1081ui_story == nil then
				arg_431_1.var_.characterEffect1081ui_story = var_434_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_2 and not isNil(var_434_1) then
				if arg_431_1.var_.characterEffect1081ui_story and not isNil(var_434_1) then
					arg_431_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_2 and arg_431_1.time_ < 0 + var_434_2 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1081ui_story then
				arg_431_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_4 = 0
			local var_434_5 = 1.4

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(1108104105)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_9 = 56 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 56)

				if (56 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 56)) > 0 and var_434_5 < var_434_9 then
					arg_431_1.talkMaxDuration = var_434_9

					if var_434_9 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104105", "story_v_side_new_1108104.awb") ~= 0 then
					local var_434_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104105", "story_v_side_new_1108104.awb") / 1000

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end

					if var_434_6.prefab_name ~= "" and arg_431_1.actors_[var_434_6.prefab_name] ~= nil then
						local var_434_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_6.prefab_name].transform, "story_v_side_new_1108104", "1108104105", "story_v_side_new_1108104.awb")

						arg_431_1:RecordAudio("1108104105", var_434_11)
						arg_431_1:RecordAudio("1108104105", var_434_11)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104105", "story_v_side_new_1108104.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104105", "story_v_side_new_1108104.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_12 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_12 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_12

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_12 and arg_431_1.time_ < var_434_4 + var_434_12 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108104106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108104106
		arg_435_1.duration_ = 10.37

		local var_435_0 = {
			ja = 10.366,
			ko = 8.266,
			zh = 8.266
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108104107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1081ui_story = arg_435_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1081ui_story"].transform.position).z)
				arg_435_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1081ui_story"].transform.localEulerAngles = arg_435_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_435_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1081ui_story"].transform.position).z)
				arg_435_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1081ui_story"].transform.localEulerAngles = arg_435_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1081ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1081ui_story == nil then
				arg_435_1.var_.characterEffect1081ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.0166666666666667

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1081ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1081ui_story then
				arg_435_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_438_4 = 0
			local var_438_5 = 1.25

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(1108104106)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 50 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 50)

				if (50 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 50)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104106", "story_v_side_new_1108104.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104106", "story_v_side_new_1108104.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_side_new_1108104", "1108104106", "story_v_side_new_1108104.awb")

						arg_435_1:RecordAudio("1108104106", var_438_11)
						arg_435_1:RecordAudio("1108104106", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104106", "story_v_side_new_1108104.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104106", "story_v_side_new_1108104.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108104107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108104107
		arg_439_1.duration_ = 5.97

		local var_439_0 = {
			ja = 5.966,
			ko = 5.066,
			zh = 5.066
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108104108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1081ui_story = arg_439_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1081ui_story"].transform.position).z)
				arg_439_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1081ui_story"].transform.localEulerAngles = arg_439_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_439_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1081ui_story"].transform.position).z)
				arg_439_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1081ui_story"].transform.localEulerAngles = arg_439_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_442_1 = arg_439_1.actors_["1081ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1081ui_story == nil then
				arg_439_1.var_.characterEffect1081ui_story = var_442_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.0166666666666667

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 and not isNil(var_442_1) then
				if arg_439_1.var_.characterEffect1081ui_story and not isNil(var_442_1) then
					arg_439_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1081ui_story then
				arg_439_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_442_4 = 0
			local var_442_5 = 0.75

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_6 = arg_439_1:GetWordFromCfg(1108104107)
				local var_442_7 = arg_439_1:FormatText(var_442_6.content)

				arg_439_1.text_.text = var_442_7

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_9 = 30 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 30)

				if (30 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 30)) > 0 and var_442_5 < var_442_9 then
					arg_439_1.talkMaxDuration = var_442_9

					if var_442_9 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_9 + var_442_4
					end
				end

				arg_439_1.text_.text = var_442_7
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104107", "story_v_side_new_1108104.awb") ~= 0 then
					local var_442_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104107", "story_v_side_new_1108104.awb") / 1000

					if var_442_10 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_4
					end

					if var_442_6.prefab_name ~= "" and arg_439_1.actors_[var_442_6.prefab_name] ~= nil then
						local var_442_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_6.prefab_name].transform, "story_v_side_new_1108104", "1108104107", "story_v_side_new_1108104.awb")

						arg_439_1:RecordAudio("1108104107", var_442_11)
						arg_439_1:RecordAudio("1108104107", var_442_11)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104107", "story_v_side_new_1108104.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104107", "story_v_side_new_1108104.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_12 = math.max(var_442_5, arg_439_1.talkMaxDuration)

			if var_442_4 <= arg_439_1.time_ and arg_439_1.time_ < var_442_4 + var_442_12 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_4) / var_442_12

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_4 + var_442_12 and arg_439_1.time_ < var_442_4 + var_442_12 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108104108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108104108
		arg_443_1.duration_ = 4.33

		local var_443_0 = {
			ja = 2.233,
			ko = 4.333,
			zh = 4.333
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108104109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1081ui_story = arg_443_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1081ui_story"].transform.position).z)
				arg_443_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1081ui_story"].transform.localEulerAngles = arg_443_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_443_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1081ui_story"].transform.position).z)
				arg_443_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1081ui_story"].transform.localEulerAngles = arg_443_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1081ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1081ui_story == nil then
				arg_443_1.var_.characterEffect1081ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.0166666666666667

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1081ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1081ui_story then
				arg_443_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_446_4 = 0
			local var_446_5 = 0.525

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_6 = arg_443_1:GetWordFromCfg(1108104108)
				local var_446_7 = arg_443_1:FormatText(var_446_6.content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 21 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 21)

				if (21 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 21)) > 0 and var_446_5 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_4
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104108", "story_v_side_new_1108104.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104108", "story_v_side_new_1108104.awb") / 1000

					if var_446_10 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_4
					end

					if var_446_6.prefab_name ~= "" and arg_443_1.actors_[var_446_6.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_6.prefab_name].transform, "story_v_side_new_1108104", "1108104108", "story_v_side_new_1108104.awb")

						arg_443_1:RecordAudio("1108104108", var_446_11)
						arg_443_1:RecordAudio("1108104108", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104108", "story_v_side_new_1108104.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104108", "story_v_side_new_1108104.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = math.max(var_446_5, arg_443_1.talkMaxDuration)

			if var_446_4 <= arg_443_1.time_ and arg_443_1.time_ < var_446_4 + var_446_12 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_4) / var_446_12

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_4 + var_446_12 and arg_443_1.time_ < var_446_4 + var_446_12 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play1108104109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108104109
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108104110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1081ui_story = arg_447_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_450_0 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_447_1.time_ - 0) / var_450_0)
				arg_447_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1081ui_story"].transform.position).z)
				arg_447_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1081ui_story"].transform.localEulerAngles = arg_447_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_447_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1081ui_story"].transform.position).z)
				arg_447_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1081ui_story"].transform.localEulerAngles = arg_447_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_450_1 = arg_447_1.actors_["1081ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1081ui_story == nil then
				arg_447_1.var_.characterEffect1081ui_story = var_450_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.0166666666666667

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_2 and not isNil(var_450_1) then
				if arg_447_1.var_.characterEffect1081ui_story and not isNil(var_450_1) then
					arg_447_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_2)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_2 and arg_447_1.time_ < 0 + var_450_2 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1081ui_story then
				arg_447_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_450_3 = 0
			local var_450_4 = 0.175

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_3 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_5 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1108104109).content)

				arg_447_1.text_.text = var_450_5

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_7 = 7 <= 0 and var_450_4 or var_450_4 * (utf8.len(var_450_5) / 7)

				if (7 <= 0 and var_450_4 or var_450_4 * (utf8.len(var_450_5) / 7)) > 0 and var_450_4 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_3 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_3
					end
				end

				arg_447_1.text_.text = var_450_5
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_8 = math.max(var_450_4, arg_447_1.talkMaxDuration)

			if var_450_3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_3 + var_450_8 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_3) / var_450_8

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_3 + var_450_8 and arg_447_1.time_ < var_450_3 + var_450_8 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1108104110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1108104110
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1108104111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_454_0 = arg_451_1.actors_["1081ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1081ui_story = var_454_0.localPosition
			end

			local var_454_1 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_1 then
				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_451_1.time_ - 0) / var_454_1)
				var_454_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_0.position).x, (manager.ui.mainCamera.transform.position - var_454_0.position).y, (manager.ui.mainCamera.transform.position - var_454_0.position).z)
				var_454_0.localEulerAngles.z = 0
				var_454_0.localEulerAngles.x = 0
				var_454_0.localEulerAngles = var_454_0.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_1 and arg_451_1.time_ < 0 + var_454_1 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(0, 100, 0)
				var_454_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_0.position).x, (manager.ui.mainCamera.transform.position - var_454_0.position).y, (manager.ui.mainCamera.transform.position - var_454_0.position).z)
				var_454_0.localEulerAngles.z = 0
				var_454_0.localEulerAngles.x = 0
				var_454_0.localEulerAngles = var_454_0.localEulerAngles
			end

			local var_454_2 = 0
			local var_454_3 = 1.025

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_4 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(1108104110).content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_6 = 41 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_4) / 41)

				if (41 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_4) / 41)) > 0 and var_454_3 < var_454_6 then
					arg_451_1.talkMaxDuration = var_454_6

					if var_454_6 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_7 and arg_451_1.time_ < var_454_2 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play1108104111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1108104111
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1108104112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos1081ui_story = arg_455_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_458_0 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				arg_455_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_455_1.time_ - 0) / var_458_0)
				arg_455_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1081ui_story"].transform.position).z)
				arg_455_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1081ui_story"].transform.localEulerAngles = arg_455_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				arg_455_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_455_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1081ui_story"].transform.position).z)
				arg_455_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1081ui_story"].transform.localEulerAngles = arg_455_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_458_1 = arg_455_1.actors_["1081ui_story"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_1) and arg_455_1.var_.characterEffect1081ui_story == nil then
				arg_455_1.var_.characterEffect1081ui_story = var_458_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.0166666666666667

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_2 and not isNil(var_458_1) then
				if arg_455_1.var_.characterEffect1081ui_story and not isNil(var_458_1) then
					arg_455_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_2)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_2 and arg_455_1.time_ < 0 + var_458_2 + arg_458_0 and not isNil(var_458_1) and arg_455_1.var_.characterEffect1081ui_story then
				arg_455_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_458_3 = 0
			local var_458_4 = 0.1

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_3 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_5 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(1108104111).content)

				arg_455_1.text_.text = var_458_5

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 4 <= 0 and var_458_4 or var_458_4 * (utf8.len(var_458_5) / 4)

				if (4 <= 0 and var_458_4 or var_458_4 * (utf8.len(var_458_5) / 4)) > 0 and var_458_4 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_3 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_3
					end
				end

				arg_455_1.text_.text = var_458_5
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_8 = math.max(var_458_4, arg_455_1.talkMaxDuration)

			if var_458_3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_3 + var_458_8 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_3) / var_458_8

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_3 + var_458_8 and arg_455_1.time_ < var_458_3 + var_458_8 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1108104112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1108104112
		arg_459_1.duration_ = 5.6

		local var_459_0 = {
			ja = 3.133,
			ko = 5.6,
			zh = 5.6
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1108104113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos1081ui_story = arg_459_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_462_0 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 then
				arg_459_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_459_1.time_ - 0) / var_462_0)
				arg_459_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1081ui_story"].transform.position).z)
				arg_459_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["1081ui_story"].transform.localEulerAngles = arg_459_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 then
				arg_459_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_459_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1081ui_story"].transform.position).z)
				arg_459_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["1081ui_story"].transform.localEulerAngles = arg_459_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_462_1 = arg_459_1.actors_["1081ui_story"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect1081ui_story == nil then
				arg_459_1.var_.characterEffect1081ui_story = var_462_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.0166666666666667

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_2 and not isNil(var_462_1) then
				if arg_459_1.var_.characterEffect1081ui_story and not isNil(var_462_1) then
					arg_459_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_2 and arg_459_1.time_ < 0 + var_462_2 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect1081ui_story then
				arg_459_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action469")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_462_4 = 0
			local var_462_5 = 0.5

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_6 = arg_459_1:GetWordFromCfg(1108104112)
				local var_462_7 = arg_459_1:FormatText(var_462_6.content)

				arg_459_1.text_.text = var_462_7

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_9 = 21 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 21)

				if (21 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 21)) > 0 and var_462_5 < var_462_9 then
					arg_459_1.talkMaxDuration = var_462_9

					if var_462_9 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_9 + var_462_4
					end
				end

				arg_459_1.text_.text = var_462_7
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104112", "story_v_side_new_1108104.awb") ~= 0 then
					local var_462_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104112", "story_v_side_new_1108104.awb") / 1000

					if var_462_10 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_4
					end

					if var_462_6.prefab_name ~= "" and arg_459_1.actors_[var_462_6.prefab_name] ~= nil then
						local var_462_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_6.prefab_name].transform, "story_v_side_new_1108104", "1108104112", "story_v_side_new_1108104.awb")

						arg_459_1:RecordAudio("1108104112", var_462_11)
						arg_459_1:RecordAudio("1108104112", var_462_11)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104112", "story_v_side_new_1108104.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104112", "story_v_side_new_1108104.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_12 = math.max(var_462_5, arg_459_1.talkMaxDuration)

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_12 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_4) / var_462_12

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_4 + var_462_12 and arg_459_1.time_ < var_462_4 + var_462_12 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play1108104113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1108104113
		arg_463_1.duration_ = 9.63

		local var_463_0 = {
			ja = 9.633,
			ko = 8.166,
			zh = 8.166
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1108104114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos1081ui_story = arg_463_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_466_0 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 then
				arg_463_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_463_1.time_ - 0) / var_466_0)
				arg_463_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1081ui_story"].transform.position).z)
				arg_463_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1081ui_story"].transform.localEulerAngles = arg_463_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 then
				arg_463_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_463_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1081ui_story"].transform.position).z)
				arg_463_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1081ui_story"].transform.localEulerAngles = arg_463_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_466_1 = arg_463_1.actors_["1081ui_story"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1081ui_story == nil then
				arg_463_1.var_.characterEffect1081ui_story = var_466_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.0166666666666667

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_2 and not isNil(var_466_1) then
				if arg_463_1.var_.characterEffect1081ui_story and not isNil(var_466_1) then
					arg_463_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_2 and arg_463_1.time_ < 0 + var_466_2 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1081ui_story then
				arg_463_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action494")
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_466_4 = 0
			local var_466_5 = 0.975

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_4 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_6 = arg_463_1:GetWordFromCfg(1108104113)
				local var_466_7 = arg_463_1:FormatText(var_466_6.content)

				arg_463_1.text_.text = var_466_7

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_9 = 39 <= 0 and var_466_5 or var_466_5 * (utf8.len(var_466_7) / 39)

				if (39 <= 0 and var_466_5 or var_466_5 * (utf8.len(var_466_7) / 39)) > 0 and var_466_5 < var_466_9 then
					arg_463_1.talkMaxDuration = var_466_9

					if var_466_9 + var_466_4 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_9 + var_466_4
					end
				end

				arg_463_1.text_.text = var_466_7
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104113", "story_v_side_new_1108104.awb") ~= 0 then
					local var_466_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104113", "story_v_side_new_1108104.awb") / 1000

					if var_466_10 + var_466_4 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_10 + var_466_4
					end

					if var_466_6.prefab_name ~= "" and arg_463_1.actors_[var_466_6.prefab_name] ~= nil then
						local var_466_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_6.prefab_name].transform, "story_v_side_new_1108104", "1108104113", "story_v_side_new_1108104.awb")

						arg_463_1:RecordAudio("1108104113", var_466_11)
						arg_463_1:RecordAudio("1108104113", var_466_11)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104113", "story_v_side_new_1108104.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104113", "story_v_side_new_1108104.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_12 = math.max(var_466_5, arg_463_1.talkMaxDuration)

			if var_466_4 <= arg_463_1.time_ and arg_463_1.time_ < var_466_4 + var_466_12 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_4) / var_466_12

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_4 + var_466_12 and arg_463_1.time_ < var_466_4 + var_466_12 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play1108104114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108104114
		arg_467_1.duration_ = 10.53

		local var_467_0 = {
			ja = 10.533,
			ko = 7.633,
			zh = 7.633
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108104115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos1081ui_story = arg_467_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_470_0 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 then
				arg_467_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_467_1.time_ - 0) / var_470_0)
				arg_467_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1081ui_story"].transform.position).z)
				arg_467_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1081ui_story"].transform.localEulerAngles = arg_467_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 then
				arg_467_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_467_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1081ui_story"].transform.position).z)
				arg_467_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1081ui_story"].transform.localEulerAngles = arg_467_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_470_1 = arg_467_1.actors_["1081ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1081ui_story == nil then
				arg_467_1.var_.characterEffect1081ui_story = var_470_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.0166666666666667

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_2 and not isNil(var_470_1) then
				if arg_467_1.var_.characterEffect1081ui_story and not isNil(var_470_1) then
					arg_467_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_2 and arg_467_1.time_ < 0 + var_470_2 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1081ui_story then
				arg_467_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_470_4 = 0
			local var_470_5 = 0.825

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_6 = arg_467_1:GetWordFromCfg(1108104114)
				local var_470_7 = arg_467_1:FormatText(var_470_6.content)

				arg_467_1.text_.text = var_470_7

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_9 = 33 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 33)

				if (33 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 33)) > 0 and var_470_5 < var_470_9 then
					arg_467_1.talkMaxDuration = var_470_9

					if var_470_9 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_9 + var_470_4
					end
				end

				arg_467_1.text_.text = var_470_7
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104114", "story_v_side_new_1108104.awb") ~= 0 then
					local var_470_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104114", "story_v_side_new_1108104.awb") / 1000

					if var_470_10 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_4
					end

					if var_470_6.prefab_name ~= "" and arg_467_1.actors_[var_470_6.prefab_name] ~= nil then
						local var_470_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_6.prefab_name].transform, "story_v_side_new_1108104", "1108104114", "story_v_side_new_1108104.awb")

						arg_467_1:RecordAudio("1108104114", var_470_11)
						arg_467_1:RecordAudio("1108104114", var_470_11)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104114", "story_v_side_new_1108104.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104114", "story_v_side_new_1108104.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_12 = math.max(var_470_5, arg_467_1.talkMaxDuration)

			if var_470_4 <= arg_467_1.time_ and arg_467_1.time_ < var_470_4 + var_470_12 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_4) / var_470_12

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_4 + var_470_12 and arg_467_1.time_ < var_470_4 + var_470_12 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108104115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108104115
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108104116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1081ui_story = arg_471_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_471_1.time_ - 0) / var_474_0)
				arg_471_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1081ui_story"].transform.position).z)
				arg_471_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1081ui_story"].transform.localEulerAngles = arg_471_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_471_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1081ui_story"].transform.position).z)
				arg_471_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1081ui_story"].transform.localEulerAngles = arg_471_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_474_1 = arg_471_1.actors_["1081ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1081ui_story == nil then
				arg_471_1.var_.characterEffect1081ui_story = var_474_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.0166666666666667

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_2 and not isNil(var_474_1) then
				if arg_471_1.var_.characterEffect1081ui_story and not isNil(var_474_1) then
					arg_471_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_2)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_2 and arg_471_1.time_ < 0 + var_474_2 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1081ui_story then
				arg_471_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_474_3 = 0
			local var_474_4 = 0.475

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_3 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_5 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1108104115).content)

				arg_471_1.text_.text = var_474_5

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_7 = 19 <= 0 and var_474_4 or var_474_4 * (utf8.len(var_474_5) / 19)

				if (19 <= 0 and var_474_4 or var_474_4 * (utf8.len(var_474_5) / 19)) > 0 and var_474_4 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_3 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_3
					end
				end

				arg_471_1.text_.text = var_474_5
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_8 = math.max(var_474_4, arg_471_1.talkMaxDuration)

			if var_474_3 <= arg_471_1.time_ and arg_471_1.time_ < var_474_3 + var_474_8 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_3) / var_474_8

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_3 + var_474_8 and arg_471_1.time_ < var_474_3 + var_474_8 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play1108104116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1108104116
		arg_475_1.duration_ = 4.87

		local var_475_0 = {
			ja = 4.866,
			ko = 3.5,
			zh = 3.5
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1108104117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1081ui_story = arg_475_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1081ui_story"].transform.position).z)
				arg_475_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1081ui_story"].transform.localEulerAngles = arg_475_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_475_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1081ui_story"].transform.position).z)
				arg_475_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1081ui_story"].transform.localEulerAngles = arg_475_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["1081ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1081ui_story == nil then
				arg_475_1.var_.characterEffect1081ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.0166666666666667

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect1081ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1081ui_story then
				arg_475_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_478_4 = 0
			local var_478_5 = 0.425

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_6 = arg_475_1:GetWordFromCfg(1108104116)
				local var_478_7 = arg_475_1:FormatText(var_478_6.content)

				arg_475_1.text_.text = var_478_7

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_9 = 17 <= 0 and var_478_5 or var_478_5 * (utf8.len(var_478_7) / 17)

				if (17 <= 0 and var_478_5 or var_478_5 * (utf8.len(var_478_7) / 17)) > 0 and var_478_5 < var_478_9 then
					arg_475_1.talkMaxDuration = var_478_9

					if var_478_9 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_9 + var_478_4
					end
				end

				arg_475_1.text_.text = var_478_7
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104116", "story_v_side_new_1108104.awb") ~= 0 then
					local var_478_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104116", "story_v_side_new_1108104.awb") / 1000

					if var_478_10 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_10 + var_478_4
					end

					if var_478_6.prefab_name ~= "" and arg_475_1.actors_[var_478_6.prefab_name] ~= nil then
						local var_478_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_6.prefab_name].transform, "story_v_side_new_1108104", "1108104116", "story_v_side_new_1108104.awb")

						arg_475_1:RecordAudio("1108104116", var_478_11)
						arg_475_1:RecordAudio("1108104116", var_478_11)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104116", "story_v_side_new_1108104.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104116", "story_v_side_new_1108104.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_12 = math.max(var_478_5, arg_475_1.talkMaxDuration)

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_12 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_4) / var_478_12

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_4 + var_478_12 and arg_475_1.time_ < var_478_4 + var_478_12 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play1108104117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1108104117
		arg_479_1.duration_ = 5.33

		local var_479_0 = {
			ja = 5.333,
			ko = 3.033,
			zh = 3.033
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1108104118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1081ui_story = arg_479_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_479_1.time_ - 0) / var_482_0)
				arg_479_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1081ui_story"].transform.position).z)
				arg_479_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1081ui_story"].transform.localEulerAngles = arg_479_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_479_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1081ui_story"].transform.position).z)
				arg_479_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1081ui_story"].transform.localEulerAngles = arg_479_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_482_1 = arg_479_1.actors_["1081ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1081ui_story == nil then
				arg_479_1.var_.characterEffect1081ui_story = var_482_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.0166666666666667

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_2 and not isNil(var_482_1) then
				if arg_479_1.var_.characterEffect1081ui_story and not isNil(var_482_1) then
					arg_479_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_2 and arg_479_1.time_ < 0 + var_482_2 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1081ui_story then
				arg_479_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_4 = 0
			local var_482_5 = 0.425

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_6 = arg_479_1:GetWordFromCfg(1108104117)
				local var_482_7 = arg_479_1:FormatText(var_482_6.content)

				arg_479_1.text_.text = var_482_7

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_9 = 17 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 17)

				if (17 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 17)) > 0 and var_482_5 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_4
					end
				end

				arg_479_1.text_.text = var_482_7
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104117", "story_v_side_new_1108104.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104117", "story_v_side_new_1108104.awb") / 1000

					if var_482_10 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_4
					end

					if var_482_6.prefab_name ~= "" and arg_479_1.actors_[var_482_6.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_6.prefab_name].transform, "story_v_side_new_1108104", "1108104117", "story_v_side_new_1108104.awb")

						arg_479_1:RecordAudio("1108104117", var_482_11)
						arg_479_1:RecordAudio("1108104117", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104117", "story_v_side_new_1108104.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104117", "story_v_side_new_1108104.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_5, arg_479_1.talkMaxDuration)

			if var_482_4 <= arg_479_1.time_ and arg_479_1.time_ < var_482_4 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_4) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_4 + var_482_12 and arg_479_1.time_ < var_482_4 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play1108104118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1108104118
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1108104119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos1081ui_story = arg_483_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1081ui_story"].transform.position).z)
				arg_483_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["1081ui_story"].transform.localEulerAngles = arg_483_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_483_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1081ui_story"].transform.position).z)
				arg_483_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["1081ui_story"].transform.localEulerAngles = arg_483_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["1081ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect1081ui_story == nil then
				arg_483_1.var_.characterEffect1081ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.0166666666666667

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect1081ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_483_1.time_ - 0) / var_486_2)
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect1081ui_story then
				arg_483_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_486_3 = 0
			local var_486_4 = 0.975

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_3 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_5 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(1108104118).content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 39 <= 0 and var_486_4 or var_486_4 * (utf8.len(var_486_5) / 39)

				if (39 <= 0 and var_486_4 or var_486_4 * (utf8.len(var_486_5) / 39)) > 0 and var_486_4 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_3 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_3
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_8 = math.max(var_486_4, arg_483_1.talkMaxDuration)

			if var_486_3 <= arg_483_1.time_ and arg_483_1.time_ < var_486_3 + var_486_8 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_3) / var_486_8

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_3 + var_486_8 and arg_483_1.time_ < var_486_3 + var_486_8 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1108104119
		arg_487_1.duration_ = 7.3

		local var_487_0 = {
			ja = 7.3,
			ko = 6.3,
			zh = 6.3
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
				arg_487_0:Play1108104120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1081ui_story = arg_487_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_490_0 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 then
				arg_487_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_487_1.time_ - 0) / var_490_0)
				arg_487_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1081ui_story"].transform.position).z)
				arg_487_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1081ui_story"].transform.localEulerAngles = arg_487_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_487_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1081ui_story"].transform.position).z)
				arg_487_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1081ui_story"].transform.localEulerAngles = arg_487_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_490_1 = arg_487_1.actors_["1081ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1081ui_story == nil then
				arg_487_1.var_.characterEffect1081ui_story = var_490_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.0166666666666667

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 and not isNil(var_490_1) then
				if arg_487_1.var_.characterEffect1081ui_story and not isNil(var_490_1) then
					arg_487_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1081ui_story then
				arg_487_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_490_4 = 0
			local var_490_5 = 0.675

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_4 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_6 = arg_487_1:GetWordFromCfg(1108104119)
				local var_490_7 = arg_487_1:FormatText(var_490_6.content)

				arg_487_1.text_.text = var_490_7

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_9 = 27 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_7) / 27)

				if (27 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_7) / 27)) > 0 and var_490_5 < var_490_9 then
					arg_487_1.talkMaxDuration = var_490_9

					if var_490_9 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_9 + var_490_4
					end
				end

				arg_487_1.text_.text = var_490_7
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104119", "story_v_side_new_1108104.awb") ~= 0 then
					local var_490_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104119", "story_v_side_new_1108104.awb") / 1000

					if var_490_10 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_10 + var_490_4
					end

					if var_490_6.prefab_name ~= "" and arg_487_1.actors_[var_490_6.prefab_name] ~= nil then
						local var_490_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_6.prefab_name].transform, "story_v_side_new_1108104", "1108104119", "story_v_side_new_1108104.awb")

						arg_487_1:RecordAudio("1108104119", var_490_11)
						arg_487_1:RecordAudio("1108104119", var_490_11)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104119", "story_v_side_new_1108104.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104119", "story_v_side_new_1108104.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_12 = math.max(var_490_5, arg_487_1.talkMaxDuration)

			if var_490_4 <= arg_487_1.time_ and arg_487_1.time_ < var_490_4 + var_490_12 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_4) / var_490_12

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_4 + var_490_12 and arg_487_1.time_ < var_490_4 + var_490_12 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1108104120
		arg_491_1.duration_ = 5.23

		local var_491_0 = {
			ja = 5.233,
			ko = 4.6,
			zh = 4.6
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
				arg_491_0:Play1108104121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1081ui_story = arg_491_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1081ui_story"].transform.position).z)
				arg_491_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1081ui_story"].transform.localEulerAngles = arg_491_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_491_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1081ui_story"].transform.position).z)
				arg_491_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1081ui_story"].transform.localEulerAngles = arg_491_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["1081ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1081ui_story == nil then
				arg_491_1.var_.characterEffect1081ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.0166666666666667

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect1081ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1081ui_story then
				arg_491_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_494_4 = 0
			local var_494_5 = 0.5

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_6 = arg_491_1:GetWordFromCfg(1108104120)
				local var_494_7 = arg_491_1:FormatText(var_494_6.content)

				arg_491_1.text_.text = var_494_7

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_9 = 20 <= 0 and var_494_5 or var_494_5 * (utf8.len(var_494_7) / 20)

				if (20 <= 0 and var_494_5 or var_494_5 * (utf8.len(var_494_7) / 20)) > 0 and var_494_5 < var_494_9 then
					arg_491_1.talkMaxDuration = var_494_9

					if var_494_9 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_9 + var_494_4
					end
				end

				arg_491_1.text_.text = var_494_7
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104120", "story_v_side_new_1108104.awb") ~= 0 then
					local var_494_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104120", "story_v_side_new_1108104.awb") / 1000

					if var_494_10 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_10 + var_494_4
					end

					if var_494_6.prefab_name ~= "" and arg_491_1.actors_[var_494_6.prefab_name] ~= nil then
						local var_494_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_6.prefab_name].transform, "story_v_side_new_1108104", "1108104120", "story_v_side_new_1108104.awb")

						arg_491_1:RecordAudio("1108104120", var_494_11)
						arg_491_1:RecordAudio("1108104120", var_494_11)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104120", "story_v_side_new_1108104.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104120", "story_v_side_new_1108104.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_12 = math.max(var_494_5, arg_491_1.talkMaxDuration)

			if var_494_4 <= arg_491_1.time_ and arg_491_1.time_ < var_494_4 + var_494_12 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_4) / var_494_12

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_4 + var_494_12 and arg_491_1.time_ < var_494_4 + var_494_12 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1108104121
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1108104122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1081ui_story = arg_495_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1081ui_story"].transform.position).z)
				arg_495_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1081ui_story"].transform.localEulerAngles = arg_495_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_495_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1081ui_story"].transform.position).z)
				arg_495_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1081ui_story"].transform.localEulerAngles = arg_495_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["1081ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1081ui_story == nil then
				arg_495_1.var_.characterEffect1081ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.0166666666666667

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect1081ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_495_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_2)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1081ui_story then
				arg_495_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_495_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_498_3 = 0
			local var_498_4 = 0.125

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_3 + arg_498_0 then
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

				local var_498_5 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(1108104121).content)

				arg_495_1.text_.text = var_498_5

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_7 = 5 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_5) / 5)

				if (5 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_5) / 5)) > 0 and var_498_4 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_3 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_3
					end
				end

				arg_495_1.text_.text = var_498_5
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_8 = math.max(var_498_4, arg_495_1.talkMaxDuration)

			if var_498_3 <= arg_495_1.time_ and arg_495_1.time_ < var_498_3 + var_498_8 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_3) / var_498_8

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_3 + var_498_8 and arg_495_1.time_ < var_498_3 + var_498_8 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play1108104122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1108104122
		arg_499_1.duration_ = 4.57

		local var_499_0 = {
			ja = 4.566,
			ko = 2.566,
			zh = 2.566
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1108104123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1081ui_story = arg_499_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1081ui_story"].transform.position).z)
				arg_499_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1081ui_story"].transform.localEulerAngles = arg_499_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_499_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1081ui_story"].transform.position).z)
				arg_499_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1081ui_story"].transform.localEulerAngles = arg_499_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1081ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1081ui_story == nil then
				arg_499_1.var_.characterEffect1081ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.0166666666666667

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1081ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1081ui_story then
				arg_499_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action436")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_502_4 = 0
			local var_502_5 = 0.3

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_6 = arg_499_1:GetWordFromCfg(1108104122)
				local var_502_7 = arg_499_1:FormatText(var_502_6.content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 12 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 12)

				if (12 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 12)) > 0 and var_502_5 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_4
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104122", "story_v_side_new_1108104.awb") ~= 0 then
					local var_502_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104122", "story_v_side_new_1108104.awb") / 1000

					if var_502_10 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_4
					end

					if var_502_6.prefab_name ~= "" and arg_499_1.actors_[var_502_6.prefab_name] ~= nil then
						local var_502_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_6.prefab_name].transform, "story_v_side_new_1108104", "1108104122", "story_v_side_new_1108104.awb")

						arg_499_1:RecordAudio("1108104122", var_502_11)
						arg_499_1:RecordAudio("1108104122", var_502_11)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104122", "story_v_side_new_1108104.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104122", "story_v_side_new_1108104.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_12 = math.max(var_502_5, arg_499_1.talkMaxDuration)

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_12 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_4) / var_502_12

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_4 + var_502_12 and arg_499_1.time_ < var_502_4 + var_502_12 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1108104123
		arg_503_1.duration_ = 7

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1108104124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				local var_506_0 = arg_503_1.bgs_.ST15a

				arg_503_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_506_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_506_1 = var_506_0:GetComponent("SpriteRenderer")

				if var_506_1 and var_506_1.sprite then
					local var_506_2 = 2 * (var_506_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_506_0.transform.localScale = Vector3.New(var_506_2 / var_506_1.sprite.bounds.size.y < var_506_2 * manager.ui.mainCameraCom_.aspect / var_506_1.sprite.bounds.size.x and var_506_2 * manager.ui.mainCameraCom_.aspect / var_506_1.sprite.bounds.size.x or var_506_2 / var_506_1.sprite.bounds.size.y, var_506_2 / var_506_1.sprite.bounds.size.y < var_506_2 * manager.ui.mainCameraCom_.aspect / var_506_1.sprite.bounds.size.x and var_506_2 * manager.ui.mainCameraCom_.aspect / var_506_1.sprite.bounds.size.x or var_506_2 / var_506_1.sprite.bounds.size.y, 0)
				end

				for iter_506_0, iter_506_1 in pairs(arg_503_1.bgs_) do
					if iter_506_0 ~= "ST15a" then
						iter_506_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_506_3 = 0

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_3 + arg_506_0 then
				arg_503_1.mask_.enabled = true
				arg_503_1.mask_.raycastTarget = true

				arg_503_1:SetGaussion(false)
			end

			local var_506_4 = 2

			if var_506_3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_3 + var_506_4 then
				local var_506_5 = Color.New(0, 0, 0)

				var_506_5.a = Mathf.Lerp(1, 0, (arg_503_1.time_ - var_506_3) / var_506_4)
				arg_503_1.mask_.color = var_506_5
			end

			if arg_503_1.time_ >= var_506_3 + var_506_4 and arg_503_1.time_ < var_506_3 + var_506_4 + arg_506_0 then
				local var_506_6 = Color.New(0, 0, 0)

				arg_503_1.mask_.enabled = false
				var_506_6.a = 0
				arg_503_1.mask_.color = var_506_6
			end

			local var_506_7 = arg_503_1.actors_["1081ui_story"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos1081ui_story = var_506_7.localPosition
			end

			local var_506_8 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_8 then
				var_506_7.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_503_1.time_ - 0) / var_506_8)
				var_506_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_506_7.position).x, (manager.ui.mainCamera.transform.position - var_506_7.position).y, (manager.ui.mainCamera.transform.position - var_506_7.position).z)
				var_506_7.localEulerAngles.z = 0
				var_506_7.localEulerAngles.x = 0
				var_506_7.localEulerAngles = var_506_7.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_8 and arg_503_1.time_ < 0 + var_506_8 + arg_506_0 then
				var_506_7.localPosition = Vector3.New(0, 100, 0)
				var_506_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_506_7.position).x, (manager.ui.mainCamera.transform.position - var_506_7.position).y, (manager.ui.mainCamera.transform.position - var_506_7.position).z)
				var_506_7.localEulerAngles.z = 0
				var_506_7.localEulerAngles.x = 0
				var_506_7.localEulerAngles = var_506_7.localEulerAngles
			end

			local var_506_9 = "ST15a_blur"

			if arg_503_1.bgs_.ST15a_blur == nil then
				local var_506_10 = Object.Instantiate(arg_503_1.blurPaintGo_)

				var_506_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_506_9)
				var_506_10.name = var_506_9
				var_506_10.transform.parent = arg_503_1.stage_.transform
				var_506_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_503_1.bgs_[var_506_9] = var_506_10
			end

			local var_506_11 = 0
			local var_506_12 = arg_503_1.bgs_[var_506_9]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_11 + arg_506_0 then
				var_506_12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_506_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_506_13 = var_506_12:GetComponent("SpriteRenderer")

				if var_506_13 and var_506_13.sprite then
					local var_506_14 = 2 * (var_506_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_506_12.transform.localScale = Vector3.New(var_506_14 / var_506_13.sprite.bounds.size.y < var_506_14 * manager.ui.mainCameraCom_.aspect / var_506_13.sprite.bounds.size.x and var_506_14 * manager.ui.mainCameraCom_.aspect / var_506_13.sprite.bounds.size.x or var_506_14 / var_506_13.sprite.bounds.size.y, var_506_14 / var_506_13.sprite.bounds.size.y < var_506_14 * manager.ui.mainCameraCom_.aspect / var_506_13.sprite.bounds.size.x and var_506_14 * manager.ui.mainCameraCom_.aspect / var_506_13.sprite.bounds.size.x or var_506_14 / var_506_13.sprite.bounds.size.y, 0)
				end
			end

			local var_506_15 = 2

			if var_506_11 <= arg_503_1.time_ and arg_503_1.time_ < var_506_11 + var_506_15 then
				local var_506_16 = Color.New(1, 1, 1)

				var_506_16.a = Mathf.Lerp(0, 1, (arg_503_1.time_ - var_506_11) / var_506_15)

				var_506_12:GetComponent("SpriteRenderer").material:SetColor("_Color", var_506_16)
			end

			if arg_503_1.frameCnt_ <= 1 then
				arg_503_1.dialog_:SetActive(false)
			end

			local var_506_17 = 2
			local var_506_18 = 1.2

			if 2 < arg_503_1.time_ and arg_503_1.time_ <= var_506_17 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				arg_503_1.dialog_:SetActive(true)

				arg_503_1.dialogCg_.alpha = 0

				local var_506_19 = LeanTween.value(arg_503_1.dialog_, 0, 1, 0.3)

				var_506_19:setOnUpdate(LuaHelper.FloatAction(function(arg_507_0)
					arg_503_1.dialogCg_.alpha = arg_507_0
				end))
				var_506_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_503_1.dialog_)
					var_506_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_503_1.duration_ = arg_503_1.duration_ + 0.3

				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_20 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(1108104123).content)

				arg_503_1.text_.text = var_506_20

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_22 = 48 <= 0 and var_506_18 or var_506_18 * (utf8.len(var_506_20) / 48)

				if (48 <= 0 and var_506_18 or var_506_18 * (utf8.len(var_506_20) / 48)) > 0 and var_506_18 < var_506_22 then
					arg_503_1.talkMaxDuration = var_506_22
					var_506_17 = var_506_17 + 0.3

					if var_506_22 + var_506_17 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_22 + var_506_17
					end
				end

				arg_503_1.text_.text = var_506_20
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_23 = var_506_17 + 0.3
			local var_506_24 = math.max(var_506_18, arg_503_1.talkMaxDuration)

			if var_506_17 + 0.3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_23 + var_506_24 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_23) / var_506_24

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_23 + var_506_24 and arg_503_1.time_ < var_506_23 + var_506_24 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108104124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1108104124
		arg_509_1.duration_ = 8.1

		local var_509_0 = {
			ja = 8.1,
			ko = 5.733,
			zh = 5.733
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1108104125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1081ui_story = arg_509_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1081ui_story"].transform.position).z)
				arg_509_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1081ui_story"].transform.localEulerAngles = arg_509_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_509_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1081ui_story"].transform.position).z)
				arg_509_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1081ui_story"].transform.localEulerAngles = arg_509_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_512_1 = arg_509_1.actors_["1081ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1081ui_story == nil then
				arg_509_1.var_.characterEffect1081ui_story = var_512_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.0166666666666667

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_2 and not isNil(var_512_1) then
				if arg_509_1.var_.characterEffect1081ui_story and not isNil(var_512_1) then
					arg_509_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= 0 + var_512_2 and arg_509_1.time_ < 0 + var_512_2 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1081ui_story then
				arg_509_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_512_4 = 0
			local var_512_5 = 0.575

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_4 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_6 = arg_509_1:GetWordFromCfg(1108104124)
				local var_512_7 = arg_509_1:FormatText(var_512_6.content)

				arg_509_1.text_.text = var_512_7

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_9 = 23 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 23)

				if (23 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 23)) > 0 and var_512_5 < var_512_9 then
					arg_509_1.talkMaxDuration = var_512_9

					if var_512_9 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_4
					end
				end

				arg_509_1.text_.text = var_512_7
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104124", "story_v_side_new_1108104.awb") ~= 0 then
					local var_512_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104124", "story_v_side_new_1108104.awb") / 1000

					if var_512_10 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_10 + var_512_4
					end

					if var_512_6.prefab_name ~= "" and arg_509_1.actors_[var_512_6.prefab_name] ~= nil then
						local var_512_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_6.prefab_name].transform, "story_v_side_new_1108104", "1108104124", "story_v_side_new_1108104.awb")

						arg_509_1:RecordAudio("1108104124", var_512_11)
						arg_509_1:RecordAudio("1108104124", var_512_11)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104124", "story_v_side_new_1108104.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104124", "story_v_side_new_1108104.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_12 = math.max(var_512_5, arg_509_1.talkMaxDuration)

			if var_512_4 <= arg_509_1.time_ and arg_509_1.time_ < var_512_4 + var_512_12 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_4) / var_512_12

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_4 + var_512_12 and arg_509_1.time_ < var_512_4 + var_512_12 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play1108104125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1108104125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1108104126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos1081ui_story = arg_513_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_516_0 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 then
				arg_513_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_513_1.time_ - 0) / var_516_0)
				arg_513_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1081ui_story"].transform.position).z)
				arg_513_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["1081ui_story"].transform.localEulerAngles = arg_513_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 then
				arg_513_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_513_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1081ui_story"].transform.position).z)
				arg_513_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["1081ui_story"].transform.localEulerAngles = arg_513_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_516_1 = arg_513_1.actors_["1081ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect1081ui_story == nil then
				arg_513_1.var_.characterEffect1081ui_story = var_516_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.0166666666666667

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_2 and not isNil(var_516_1) then
				if arg_513_1.var_.characterEffect1081ui_story and not isNil(var_516_1) then
					arg_513_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_2)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_2 and arg_513_1.time_ < 0 + var_516_2 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect1081ui_story then
				arg_513_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_516_3 = 0
			local var_516_4 = 0.575

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_3 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_5 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1108104125).content)

				arg_513_1.text_.text = var_516_5

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_7 = 23 <= 0 and var_516_4 or var_516_4 * (utf8.len(var_516_5) / 23)

				if (23 <= 0 and var_516_4 or var_516_4 * (utf8.len(var_516_5) / 23)) > 0 and var_516_4 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_3 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_3
					end
				end

				arg_513_1.text_.text = var_516_5
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_8 = math.max(var_516_4, arg_513_1.talkMaxDuration)

			if var_516_3 <= arg_513_1.time_ and arg_513_1.time_ < var_516_3 + var_516_8 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_3) / var_516_8

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_3 + var_516_8 and arg_513_1.time_ < var_516_3 + var_516_8 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play1108104126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1108104126
		arg_517_1.duration_ = 6.73

		local var_517_0 = {
			ja = 6.733,
			ko = 3.2,
			zh = 3.2
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1108104127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1081ui_story = arg_517_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_520_0 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 then
				arg_517_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_517_1.time_ - 0) / var_520_0)
				arg_517_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1081ui_story"].transform.position).z)
				arg_517_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1081ui_story"].transform.localEulerAngles = arg_517_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 then
				arg_517_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_517_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1081ui_story"].transform.position).z)
				arg_517_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1081ui_story"].transform.localEulerAngles = arg_517_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_520_1 = arg_517_1.actors_["1081ui_story"]

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(var_520_1) and arg_517_1.var_.characterEffect1081ui_story == nil then
				arg_517_1.var_.characterEffect1081ui_story = var_520_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_2 = 0.0166666666666667

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_2 and not isNil(var_520_1) then
				if arg_517_1.var_.characterEffect1081ui_story and not isNil(var_520_1) then
					arg_517_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_2 and arg_517_1.time_ < 0 + var_520_2 + arg_520_0 and not isNil(var_520_1) and arg_517_1.var_.characterEffect1081ui_story then
				arg_517_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_520_4 = 0
			local var_520_5 = 0.2

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_4 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_6 = arg_517_1:GetWordFromCfg(1108104126)
				local var_520_7 = arg_517_1:FormatText(var_520_6.content)

				arg_517_1.text_.text = var_520_7

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_9 = 8 <= 0 and var_520_5 or var_520_5 * (utf8.len(var_520_7) / 8)

				if (8 <= 0 and var_520_5 or var_520_5 * (utf8.len(var_520_7) / 8)) > 0 and var_520_5 < var_520_9 then
					arg_517_1.talkMaxDuration = var_520_9

					if var_520_9 + var_520_4 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_4
					end
				end

				arg_517_1.text_.text = var_520_7
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104126", "story_v_side_new_1108104.awb") ~= 0 then
					local var_520_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104126", "story_v_side_new_1108104.awb") / 1000

					if var_520_10 + var_520_4 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_10 + var_520_4
					end

					if var_520_6.prefab_name ~= "" and arg_517_1.actors_[var_520_6.prefab_name] ~= nil then
						local var_520_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_6.prefab_name].transform, "story_v_side_new_1108104", "1108104126", "story_v_side_new_1108104.awb")

						arg_517_1:RecordAudio("1108104126", var_520_11)
						arg_517_1:RecordAudio("1108104126", var_520_11)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104126", "story_v_side_new_1108104.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104126", "story_v_side_new_1108104.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_12 = math.max(var_520_5, arg_517_1.talkMaxDuration)

			if var_520_4 <= arg_517_1.time_ and arg_517_1.time_ < var_520_4 + var_520_12 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_4) / var_520_12

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_4 + var_520_12 and arg_517_1.time_ < var_520_4 + var_520_12 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play1108104127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1108104127
		arg_521_1.duration_ = 6.63

		local var_521_0 = {
			ja = 6.633,
			ko = 4.933,
			zh = 4.933
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1108104128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.var_.moveOldPos1081ui_story = arg_521_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_524_0 = 0.001

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 then
				arg_521_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_521_1.time_ - 0) / var_524_0)
				arg_521_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1081ui_story"].transform.position).z)
				arg_521_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1081ui_story"].transform.localEulerAngles = arg_521_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 then
				arg_521_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_521_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1081ui_story"].transform.position).z)
				arg_521_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1081ui_story"].transform.localEulerAngles = arg_521_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_524_1 = arg_521_1.actors_["1081ui_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1081ui_story == nil then
				arg_521_1.var_.characterEffect1081ui_story = var_524_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.0166666666666667

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_2 and not isNil(var_524_1) then
				if arg_521_1.var_.characterEffect1081ui_story and not isNil(var_524_1) then
					arg_521_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_2 and arg_521_1.time_ < 0 + var_524_2 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1081ui_story then
				arg_521_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_524_4 = 0
			local var_524_5 = 0.7

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(1108104127)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 28 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 28)

				if (28 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 28)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104127", "story_v_side_new_1108104.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104127", "story_v_side_new_1108104.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_side_new_1108104", "1108104127", "story_v_side_new_1108104.awb")

						arg_521_1:RecordAudio("1108104127", var_524_11)
						arg_521_1:RecordAudio("1108104127", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104127", "story_v_side_new_1108104.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104127", "story_v_side_new_1108104.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	Play1108104128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1108104128
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1108104129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos1081ui_story = arg_525_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_528_0 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 then
				arg_525_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_525_1.time_ - 0) / var_528_0)
				arg_525_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1081ui_story"].transform.position).z)
				arg_525_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1081ui_story"].transform.localEulerAngles = arg_525_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 then
				arg_525_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_525_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1081ui_story"].transform.position).z)
				arg_525_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1081ui_story"].transform.localEulerAngles = arg_525_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_528_1 = arg_525_1.actors_["1081ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1081ui_story == nil then
				arg_525_1.var_.characterEffect1081ui_story = var_528_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.0166666666666667

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_2 and not isNil(var_528_1) then
				if arg_525_1.var_.characterEffect1081ui_story and not isNil(var_528_1) then
					arg_525_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_525_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_2)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_2 and arg_525_1.time_ < 0 + var_528_2 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1081ui_story then
				arg_525_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_525_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_528_3 = 0
			local var_528_4 = 0.575

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_3 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_5 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1108104128).content)

				arg_525_1.text_.text = var_528_5

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_7 = 23 <= 0 and var_528_4 or var_528_4 * (utf8.len(var_528_5) / 23)

				if (23 <= 0 and var_528_4 or var_528_4 * (utf8.len(var_528_5) / 23)) > 0 and var_528_4 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_3 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_3
					end
				end

				arg_525_1.text_.text = var_528_5
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_8 = math.max(var_528_4, arg_525_1.talkMaxDuration)

			if var_528_3 <= arg_525_1.time_ and arg_525_1.time_ < var_528_3 + var_528_8 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_3) / var_528_8

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_3 + var_528_8 and arg_525_1.time_ < var_528_3 + var_528_8 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play1108104129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1108104129
		arg_529_1.duration_ = 4.77

		local var_529_0 = {
			ja = 4.766,
			ko = 4.133,
			zh = 4.133
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1108104130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos1081ui_story = arg_529_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_532_0 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 then
				arg_529_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_529_1.time_ - 0) / var_532_0)
				arg_529_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1081ui_story"].transform.position).z)
				arg_529_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["1081ui_story"].transform.localEulerAngles = arg_529_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 then
				arg_529_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_529_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1081ui_story"].transform.position).z)
				arg_529_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["1081ui_story"].transform.localEulerAngles = arg_529_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_532_1 = arg_529_1.actors_["1081ui_story"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_1) and arg_529_1.var_.characterEffect1081ui_story == nil then
				arg_529_1.var_.characterEffect1081ui_story = var_532_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.0166666666666667

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_2 and not isNil(var_532_1) then
				if arg_529_1.var_.characterEffect1081ui_story and not isNil(var_532_1) then
					arg_529_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_2 and arg_529_1.time_ < 0 + var_532_2 + arg_532_0 and not isNil(var_532_1) and arg_529_1.var_.characterEffect1081ui_story then
				arg_529_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_532_4 = 0
			local var_532_5 = 0.475

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_4 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_6 = arg_529_1:GetWordFromCfg(1108104129)
				local var_532_7 = arg_529_1:FormatText(var_532_6.content)

				arg_529_1.text_.text = var_532_7

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_9 = 19 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 19)

				if (19 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 19)) > 0 and var_532_5 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_4
					end
				end

				arg_529_1.text_.text = var_532_7
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104129", "story_v_side_new_1108104.awb") ~= 0 then
					local var_532_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104129", "story_v_side_new_1108104.awb") / 1000

					if var_532_10 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_10 + var_532_4
					end

					if var_532_6.prefab_name ~= "" and arg_529_1.actors_[var_532_6.prefab_name] ~= nil then
						local var_532_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_6.prefab_name].transform, "story_v_side_new_1108104", "1108104129", "story_v_side_new_1108104.awb")

						arg_529_1:RecordAudio("1108104129", var_532_11)
						arg_529_1:RecordAudio("1108104129", var_532_11)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104129", "story_v_side_new_1108104.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104129", "story_v_side_new_1108104.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_12 = math.max(var_532_5, arg_529_1.talkMaxDuration)

			if var_532_4 <= arg_529_1.time_ and arg_529_1.time_ < var_532_4 + var_532_12 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_4) / var_532_12

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_4 + var_532_12 and arg_529_1.time_ < var_532_4 + var_532_12 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play1108104130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1108104130
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1108104131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos1081ui_story = arg_533_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_536_0 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 then
				arg_533_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_533_1.time_ - 0) / var_536_0)
				arg_533_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1081ui_story"].transform.position).z)
				arg_533_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1081ui_story"].transform.localEulerAngles = arg_533_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 then
				arg_533_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_533_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1081ui_story"].transform.position).z)
				arg_533_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1081ui_story"].transform.localEulerAngles = arg_533_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_536_1 = arg_533_1.actors_["1081ui_story"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_1) and arg_533_1.var_.characterEffect1081ui_story == nil then
				arg_533_1.var_.characterEffect1081ui_story = var_536_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.0166666666666667

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_2 and not isNil(var_536_1) then
				if arg_533_1.var_.characterEffect1081ui_story and not isNil(var_536_1) then
					arg_533_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_2)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_2 and arg_533_1.time_ < 0 + var_536_2 + arg_536_0 and not isNil(var_536_1) and arg_533_1.var_.characterEffect1081ui_story then
				arg_533_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_536_3 = 0
			local var_536_4 = 0.225

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_3 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_5 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1108104130).content)

				arg_533_1.text_.text = var_536_5

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_7 = 9 <= 0 and var_536_4 or var_536_4 * (utf8.len(var_536_5) / 9)

				if (9 <= 0 and var_536_4 or var_536_4 * (utf8.len(var_536_5) / 9)) > 0 and var_536_4 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_3 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_3
					end
				end

				arg_533_1.text_.text = var_536_5
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_8 = math.max(var_536_4, arg_533_1.talkMaxDuration)

			if var_536_3 <= arg_533_1.time_ and arg_533_1.time_ < var_536_3 + var_536_8 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_3) / var_536_8

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_3 + var_536_8 and arg_533_1.time_ < var_536_3 + var_536_8 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play1108104131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1108104131
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1108104132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1081ui_story = arg_537_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_540_0 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				arg_537_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1081ui_story"].transform.position).z)
				arg_537_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1081ui_story"].transform.localEulerAngles = arg_537_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				arg_537_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_537_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1081ui_story"].transform.position).z)
				arg_537_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1081ui_story"].transform.localEulerAngles = arg_537_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_540_1 = arg_537_1.bgs_.ST15a.transform

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPosST15a = var_540_1.localPosition
			end

			local var_540_2 = 3

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_2 then
				var_540_1.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPosST15a, Vector3.New(-4.97, 1.42, -1.64), (arg_537_1.time_ - 0) / var_540_2)
			end

			if arg_537_1.time_ >= 0 + var_540_2 and arg_537_1.time_ < 0 + var_540_2 + arg_540_0 then
				var_540_1.localPosition = Vector3.New(-4.97, 1.42, -1.64)
			end

			local var_540_3 = 0
			local var_540_4 = 0.775

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_3 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_5 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1108104131).content)

				arg_537_1.text_.text = var_540_5

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 31 <= 0 and var_540_4 or var_540_4 * (utf8.len(var_540_5) / 31)

				if (31 <= 0 and var_540_4 or var_540_4 * (utf8.len(var_540_5) / 31)) > 0 and var_540_4 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_3 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_3
					end
				end

				arg_537_1.text_.text = var_540_5
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_4, arg_537_1.talkMaxDuration)

			if var_540_3 <= arg_537_1.time_ and arg_537_1.time_ < var_540_3 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_3) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_3 + var_540_8 and arg_537_1.time_ < var_540_3 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ST15a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play1108104132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1108104132
		arg_541_1.duration_ = 5.9

		local var_541_0 = {
			ja = 5.9,
			ko = 4.833,
			zh = 4.833
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1108104133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1081ui_story = arg_541_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1081ui_story"].transform.position).z)
				arg_541_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1081ui_story"].transform.localEulerAngles = arg_541_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_541_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1081ui_story"].transform.position).z)
				arg_541_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1081ui_story"].transform.localEulerAngles = arg_541_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_544_1 = arg_541_1.actors_["1081ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect1081ui_story == nil then
				arg_541_1.var_.characterEffect1081ui_story = var_544_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.0166666666666667

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_2 and not isNil(var_544_1) then
				if arg_541_1.var_.characterEffect1081ui_story and not isNil(var_544_1) then
					arg_541_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= 0 + var_544_2 and arg_541_1.time_ < 0 + var_544_2 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect1081ui_story then
				arg_541_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_544_4 = 0
			local var_544_5 = 0.575

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_6 = arg_541_1:GetWordFromCfg(1108104132)
				local var_544_7 = arg_541_1:FormatText(var_544_6.content)

				arg_541_1.text_.text = var_544_7

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_9 = 23 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_7) / 23)

				if (23 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_7) / 23)) > 0 and var_544_5 < var_544_9 then
					arg_541_1.talkMaxDuration = var_544_9

					if var_544_9 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_9 + var_544_4
					end
				end

				arg_541_1.text_.text = var_544_7
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104132", "story_v_side_new_1108104.awb") ~= 0 then
					local var_544_10 = manager.audio:GetVoiceLength("story_v_side_new_1108104", "1108104132", "story_v_side_new_1108104.awb") / 1000

					if var_544_10 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_10 + var_544_4
					end

					if var_544_6.prefab_name ~= "" and arg_541_1.actors_[var_544_6.prefab_name] ~= nil then
						local var_544_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_6.prefab_name].transform, "story_v_side_new_1108104", "1108104132", "story_v_side_new_1108104.awb")

						arg_541_1:RecordAudio("1108104132", var_544_11)
						arg_541_1:RecordAudio("1108104132", var_544_11)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1108104", "1108104132", "story_v_side_new_1108104.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1108104", "1108104132", "story_v_side_new_1108104.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_12 = math.max(var_544_5, arg_541_1.talkMaxDuration)

			if var_544_4 <= arg_541_1.time_ and arg_541_1.time_ < var_544_4 + var_544_12 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_4) / var_544_12

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_4 + var_544_12 and arg_541_1.time_ < var_544_4 + var_544_12 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play1108104133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1108104133
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
			arg_545_1.auto_ = false
		end

		function arg_545_1.playNext_(arg_547_0)
			arg_545_1.onStoryFinished_()
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["1081ui_story"]) and arg_545_1.var_.characterEffect1081ui_story == nil then
				arg_545_1.var_.characterEffect1081ui_story = arg_545_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_0 = 0.0166666666666667

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["1081ui_story"]) then
				if arg_545_1.var_.characterEffect1081ui_story and not isNil(arg_545_1.actors_["1081ui_story"]) then
					arg_545_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_545_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_545_1.time_ - 0) / var_548_0)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["1081ui_story"]) and arg_545_1.var_.characterEffect1081ui_story then
				arg_545_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_545_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_548_1 = 0
			local var_548_2 = 0.3

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_3 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(1108104133).content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 12 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_3) / 12)

				if (12 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_3) / 12)) > 0 and var_548_2 < var_548_5 then
					arg_545_1.talkMaxDuration = var_548_5

					if var_548_5 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_5 + var_548_1
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_6 = math.max(var_548_2, arg_545_1.talkMaxDuration)

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_6 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_1) / var_548_6

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_1 + var_548_6 and arg_545_1.time_ < var_548_1 + var_548_6 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/R8101",
		"TextureConfig/Background/R8101a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST15a"
	},
	voices = {
		"story_v_side_new_1108104.awb"
	}
}
