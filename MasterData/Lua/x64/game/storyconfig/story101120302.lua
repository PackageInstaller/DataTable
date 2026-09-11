return {
	Play112032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112032001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_4_0.name = "H02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H02

				arg_1_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.H02:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueH02 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueH02 = var_4_4
				end

				arg_1_1.var_.alphaOldValueH02 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueH02 then
					arg_1_1.var_.alphaMatValueH02.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueH02, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueH02.color = arg_1_1.var_.alphaMatValueH02.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueH02 then
				arg_1_1.var_.alphaMatValueH02.color.a = 1
				arg_1_1.var_.alphaMatValueH02.color = arg_1_1.var_.alphaMatValueH02.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112032001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 41 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 41)

				if (41 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 41)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112032002
		arg_8_1.duration_ = 3.43

		local var_8_0 = {
			ja = 2.7,
			ko = 2.066,
			zh = 3.133,
			en = 3.433
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
				arg_8_0:Play112032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1081ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1081ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1081ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1081ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1081ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1081ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_11_5 = arg_8_1.actors_["1081ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1081ui_story == nil then
				arg_8_1.var_.characterEffect1081ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1081ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1081ui_story then
				arg_8_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_11_8 = 0
			local var_11_9 = 0.3

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(112032002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 12 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 12)

				if (12 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 12)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032002", "story_v_out_112032.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_112032", "112032002", "story_v_out_112032.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_112032", "112032002", "story_v_out_112032.awb")

						arg_8_1:RecordAudio("112032002", var_11_15)
						arg_8_1:RecordAudio("112032002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_112032", "112032002", "story_v_out_112032.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_112032", "112032002", "story_v_out_112032.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play112032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112032003
		arg_12_1.duration_ = 5.43

		local var_12_0 = {
			ja = 4.966,
			ko = 5.433,
			zh = 4,
			en = 4.066
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
				arg_12_0:Play112032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1081ui_story = arg_12_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_15_0 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				arg_12_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_0)
				arg_12_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1081ui_story"].transform.position).z)
				arg_12_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1081ui_story"].transform.localEulerAngles = arg_12_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				arg_12_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1081ui_story"].transform.position).z)
				arg_12_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1081ui_story"].transform.localEulerAngles = arg_12_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_15_1 = "1084ui_story"

			if arg_12_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

				var_15_2.name = var_15_1
				var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_[var_15_1] = var_15_2

				local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

				var_15_3.enabled = true

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_3.transform, false)

				arg_12_1.var_[var_15_1 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_[var_15_1 .. "Animator"].applyRootMotion = true
				arg_12_1.var_[var_15_1 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_5.localPosition
			end

			local var_15_6 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 then
				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_12_1.time_ - 0) / var_15_6)
				var_15_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_5.position).x, (manager.ui.mainCamera.transform.position - var_15_5.position).y, (manager.ui.mainCamera.transform.position - var_15_5.position).z)
				var_15_5.localEulerAngles.z = 0
				var_15_5.localEulerAngles.x = 0
				var_15_5.localEulerAngles = var_15_5.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_15_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_5.position).x, (manager.ui.mainCamera.transform.position - var_15_5.position).y, (manager.ui.mainCamera.transform.position - var_15_5.position).z)
				var_15_5.localEulerAngles.z = 0
				var_15_5.localEulerAngles.x = 0
				var_15_5.localEulerAngles = var_15_5.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_15_7 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_8 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 and not isNil(var_15_7) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_7) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_10 = 0
			local var_15_11 = 0.5

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(112032003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 20 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 20)

				if (20 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 20)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032003", "story_v_out_112032.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_112032", "112032003", "story_v_out_112032.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_112032", "112032003", "story_v_out_112032.awb")

						arg_12_1:RecordAudio("112032003", var_15_17)
						arg_12_1:RecordAudio("112032003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_112032", "112032003", "story_v_out_112032.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_112032", "112032003", "story_v_out_112032.awb")
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play112032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112032004
		arg_16_1.duration_ = 9.7

		local var_16_0 = {
			ja = 8.666,
			ko = 7.4,
			zh = 8.766,
			en = 9.7
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
				arg_16_0:Play112032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1148ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1148ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1148ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1148ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1148ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_19_5 = arg_16_1.actors_["1148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1148ui_story == nil then
				arg_16_1.var_.characterEffect1148ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1148ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1148ui_story then
				arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_19_8 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_9 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 and not isNil(var_19_8) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_8) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_9)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_19_10 = 0
			local var_19_11 = 1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(112032004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 40 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 40)

				if (40 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 40)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032004", "story_v_out_112032.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_112032", "112032004", "story_v_out_112032.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_112032", "112032004", "story_v_out_112032.awb")

						arg_16_1:RecordAudio("112032004", var_19_17)
						arg_16_1:RecordAudio("112032004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_112032", "112032004", "story_v_out_112032.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_112032", "112032004", "story_v_out_112032.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play112032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112032005
		arg_20_1.duration_ = 0.2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"

			SetActive(arg_20_1.choicesGo_, true)

			for iter_21_0, iter_21_1 in ipairs(arg_20_1.choices_) do
				SetActive(iter_21_1.go, iter_21_0 <= 2)
			end

			arg_20_1.choices_[1].txt.text = arg_20_1:FormatText(StoryChoiceCfg[162].name)
			arg_20_1.choices_[2].txt.text = arg_20_1:FormatText(StoryChoiceCfg[163].name)
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play112032006(arg_20_1)
			end

			if arg_22_0 == 2 then
				arg_20_0:Play112032010(arg_20_1)
			end

			arg_20_1:RecordChoiceLog(112032005, 162, 163)
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = arg_20_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) then
				if arg_20_1.var_.characterEffect1148ui_story and not isNil(arg_20_1.actors_["1148ui_story"]) then
					arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) and arg_20_1.var_.characterEffect1148ui_story then
				arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112032006
		arg_24_1.duration_ = 12.6

		local var_24_0 = {
			ja = 12.6,
			ko = 9.4,
			zh = 7.266,
			en = 10.966
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
				arg_24_0:Play112032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action464")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_27_0 = arg_24_1.actors_["1148ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_1 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 and not isNil(var_27_0) then
				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_27_3 = 0
			local var_27_4 = 0.975

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:GetWordFromCfg(112032006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 39 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 39)

				if (39 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 39)) > 0 and var_27_4 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032006", "story_v_out_112032.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032006", "story_v_out_112032.awb") / 1000

					if var_27_9 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_3
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_112032", "112032006", "story_v_out_112032.awb")

						arg_24_1:RecordAudio("112032006", var_27_10)
						arg_24_1:RecordAudio("112032006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112032", "112032006", "story_v_out_112032.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112032", "112032006", "story_v_out_112032.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_4, arg_24_1.talkMaxDuration)

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_3) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_3 + var_27_11 and arg_24_1.time_ < var_27_3 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play112032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112032007
		arg_28_1.duration_ = 4.93

		local var_28_0 = {
			ja = 4.5,
			ko = 4.933,
			zh = 3.366,
			en = 4.266
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
				arg_28_0:Play112032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1084ui_story"]) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = arg_28_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1084ui_story"]) then
				if arg_28_1.var_.characterEffect1084ui_story and not isNil(arg_28_1.actors_["1084ui_story"]) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1084ui_story"]) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_31_2 = arg_28_1.actors_["1148ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1148ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1148ui_story then
				arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_31_4 = 0
			local var_31_5 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(112032007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 16 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 16)

				if (16 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 16)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032007", "story_v_out_112032.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032007", "story_v_out_112032.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_112032", "112032007", "story_v_out_112032.awb")

						arg_28_1:RecordAudio("112032007", var_31_11)
						arg_28_1:RecordAudio("112032007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_112032", "112032007", "story_v_out_112032.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_112032", "112032007", "story_v_out_112032.awb")
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
	Play112032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112032008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play112032009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1148ui_story = arg_32_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1148ui_story"].transform.position).z)
				arg_32_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1148ui_story"].transform.localEulerAngles = arg_32_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1148ui_story"].transform.position).z)
				arg_32_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1148ui_story"].transform.localEulerAngles = arg_32_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1084ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_1.localPosition
			end

			local var_35_2 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 then
				var_35_1.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_2)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 then
				var_35_1.localPosition = Vector3.New(0, 100, 0)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			local var_35_3 = 0
			local var_35_4 = 0.3

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_5 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(112032008).content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 12 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_5) / 12)

				if (12 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_5) / 12)) > 0 and var_35_4 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_8 and arg_32_1.time_ < var_35_3 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play112032009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112032009
		arg_36_1.duration_ = 3.47

		local var_36_0 = {
			ja = 3.366,
			ko = 3.266,
			zh = 3.033,
			en = 3.466
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
				arg_36_0:Play112032012(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.275

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(112032009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 11 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 11)

				if (11 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 11)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032009", "story_v_out_112032.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_112032", "112032009", "story_v_out_112032.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_112032", "112032009", "story_v_out_112032.awb")

						arg_36_1:RecordAudio("112032009", var_39_6)
						arg_36_1:RecordAudio("112032009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_112032", "112032009", "story_v_out_112032.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_112032", "112032009", "story_v_out_112032.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play112032012 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112032012
		arg_40_1.duration_ = 7.08

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112032013(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = arg_40_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).z)
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles = arg_40_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).z)
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles = arg_40_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_43_1 = arg_40_1.actors_["1148ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1148ui_story = var_43_1.localPosition
			end

			local var_43_2 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 then
				var_43_1.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_2)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 then
				var_43_1.localPosition = Vector3.New(0, 100, 0)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			local var_43_3 = "H02a"

			if arg_40_1.bgs_.H02a == nil then
				local var_43_4 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_3)
				var_43_4.name = var_43_3
				var_43_4.transform.parent = arg_40_1.stage_.transform
				var_43_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_3] = var_43_4
			end

			if 1.5 < arg_40_1.time_ and arg_40_1.time_ <= 1.5 + arg_43_0 then
				local var_43_5 = arg_40_1.bgs_.H02a

				arg_40_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_43_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_6 = var_43_5:GetComponent("SpriteRenderer")

				if var_43_6 and var_43_6.sprite then
					local var_43_7 = 2 * (var_43_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_43_5.transform.localScale = Vector3.New(var_43_7 / var_43_6.sprite.bounds.size.y < var_43_7 * manager.ui.mainCameraCom_.aspect / var_43_6.sprite.bounds.size.x and var_43_7 * manager.ui.mainCameraCom_.aspect / var_43_6.sprite.bounds.size.x or var_43_7 / var_43_6.sprite.bounds.size.y, var_43_7 / var_43_6.sprite.bounds.size.y < var_43_7 * manager.ui.mainCameraCom_.aspect / var_43_6.sprite.bounds.size.x and var_43_7 * manager.ui.mainCameraCom_.aspect / var_43_6.sprite.bounds.size.x or var_43_7 / var_43_6.sprite.bounds.size.y, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "H02a" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				local var_43_8 = arg_40_1.bgs_.H02:GetComponent("SpriteRenderer")

				if var_43_8 then
					arg_40_1.var_.alphaOldValueH02 = var_43_8.color.a
					arg_40_1.var_.alphaMatValueH02 = var_43_8
				end

				arg_40_1.var_.alphaOldValueH02 = 1
			end

			local var_43_9 = 1.5

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_9 then
				if arg_40_1.var_.alphaMatValueH02 then
					arg_40_1.var_.alphaMatValueH02.color.a = Mathf.Lerp(arg_40_1.var_.alphaOldValueH02, 0, (arg_40_1.time_ - 0) / var_43_9)
					arg_40_1.var_.alphaMatValueH02.color = arg_40_1.var_.alphaMatValueH02.color
				end
			end

			if arg_40_1.time_ >= 0 + var_43_9 and arg_40_1.time_ < 0 + var_43_9 + arg_43_0 and arg_40_1.var_.alphaMatValueH02 then
				arg_40_1.var_.alphaMatValueH02.color.a = 0
				arg_40_1.var_.alphaMatValueH02.color = arg_40_1.var_.alphaMatValueH02.color
			end

			if 1.5 < arg_40_1.time_ and arg_40_1.time_ <= 1.5 + arg_43_0 then
				local var_43_10 = arg_40_1.bgs_.H02a:GetComponent("SpriteRenderer")

				if var_43_10 then
					arg_40_1.var_.alphaOldValueH02a = var_43_10.color.a
					arg_40_1.var_.alphaMatValueH02a = var_43_10
				end

				arg_40_1.var_.alphaOldValueH02a = 0
			end

			local var_43_11 = 1.5

			if 1.5 <= arg_40_1.time_ and arg_40_1.time_ < 1.5 + var_43_11 then
				if arg_40_1.var_.alphaMatValueH02a then
					arg_40_1.var_.alphaMatValueH02a.color.a = Mathf.Lerp(arg_40_1.var_.alphaOldValueH02a, 1, (arg_40_1.time_ - 1.5) / var_43_11)
					arg_40_1.var_.alphaMatValueH02a.color = arg_40_1.var_.alphaMatValueH02a.color
				end
			end

			if arg_40_1.time_ >= 1.5 + var_43_11 and arg_40_1.time_ < 1.5 + var_43_11 + arg_43_0 and arg_40_1.var_.alphaMatValueH02a then
				arg_40_1.var_.alphaMatValueH02a.color.a = 1
				arg_40_1.var_.alphaMatValueH02a.color = arg_40_1.var_.alphaMatValueH02a.color
			end

			if 1.075 < arg_40_1.time_ and arg_40_1.time_ <= 1.075 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_fireloop", "")
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_13 = 2.075
			local var_43_14 = 0.925

			if 2.075 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_15 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_15:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_16 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(112032012).content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_18 = 37 <= 0 and var_43_14 or var_43_14 * (utf8.len(var_43_16) / 37)

				if (37 <= 0 and var_43_14 or var_43_14 * (utf8.len(var_43_16) / 37)) > 0 and var_43_14 < var_43_18 then
					arg_40_1.talkMaxDuration = var_43_18
					var_43_13 = var_43_13 + 0.3

					if var_43_18 + var_43_13 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_13
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_19 = var_43_13 + 0.3
			local var_43_20 = math.max(var_43_14, arg_40_1.talkMaxDuration)

			if var_43_13 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_19 + var_43_20 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_19) / var_43_20

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_19 + var_43_20 and arg_40_1.time_ < var_43_19 + var_43_20 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play112032013 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 112032013
		arg_46_1.duration_ = 4.63

		local var_46_0 = {
			ja = 4.633,
			ko = 2.966,
			zh = 2.166,
			en = 1.999999999999
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
				arg_46_0:Play112032014(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_49_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_46_1.stage_.transform)

				var_49_0.name = "1039ui_story"
				var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1039ui_story"] = var_49_0

				local var_49_1 = var_49_0:GetComponentInChildren(typeof(CharacterEffect))

				var_49_1.enabled = true

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end

				arg_46_1:ShowWeapon(var_49_1.transform, false)

				arg_46_1.var_["1039ui_story" .. "Animator"] = var_49_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_46_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_46_1.var_["1039ui_story" .. "LipSync"] = var_49_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_49_3 = arg_46_1.actors_["1039ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1039ui_story = var_49_3.localPosition
			end

			local var_49_4 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_3.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_46_1.time_ - 0) / var_49_4)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_49_5 = arg_46_1.actors_["1039ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1039ui_story == nil then
				arg_46_1.var_.characterEffect1039ui_story = var_49_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_6 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_6 and not isNil(var_49_5) then
				if arg_46_1.var_.characterEffect1039ui_story and not isNil(var_49_5) then
					arg_46_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_6 and arg_46_1.time_ < 0 + var_49_6 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1039ui_story then
				arg_46_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_49_8 = 0
			local var_49_9 = 0.2

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_10 = arg_46_1:GetWordFromCfg(112032013)
				local var_49_11 = arg_46_1:FormatText(var_49_10.content)

				arg_46_1.text_.text = var_49_11

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 9 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_11) / 9)

				if (9 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_11) / 9)) > 0 and var_49_9 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_8
					end
				end

				arg_46_1.text_.text = var_49_11
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032013", "story_v_out_112032.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_112032", "112032013", "story_v_out_112032.awb") / 1000

					if var_49_14 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_8
					end

					if var_49_10.prefab_name ~= "" and arg_46_1.actors_[var_49_10.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_10.prefab_name].transform, "story_v_out_112032", "112032013", "story_v_out_112032.awb")

						arg_46_1:RecordAudio("112032013", var_49_15)
						arg_46_1:RecordAudio("112032013", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_112032", "112032013", "story_v_out_112032.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_112032", "112032013", "story_v_out_112032.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_9, arg_46_1.talkMaxDuration)

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_8) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_8 + var_49_16 and arg_46_1.time_ < var_49_8 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play112032014 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 112032014
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play112032015(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1039ui_story = arg_50_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1039ui_story"].transform.position).z)
				arg_50_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1039ui_story"].transform.localEulerAngles = arg_50_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1039ui_story"].transform.position).z)
				arg_50_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1039ui_story"].transform.localEulerAngles = arg_50_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_53_1 = 0
			local var_53_2 = 0.975

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(112032014).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 39 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 39)

				if (39 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 39)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_6 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_6 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_6

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_6 and arg_50_1.time_ < var_53_1 + var_53_6 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play112032015 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 112032015
		arg_54_1.duration_ = 8.3

		local var_54_0 = {
			ja = 8.3,
			ko = 5.833,
			zh = 7.5,
			en = 6.566
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
				arg_54_0:Play112032016(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1148ui_story = arg_54_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1148ui_story"].transform.position).z)
				arg_54_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1148ui_story"].transform.localEulerAngles = arg_54_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_54_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1148ui_story"].transform.position).z)
				arg_54_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1148ui_story"].transform.localEulerAngles = arg_54_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_57_1 = arg_54_1.actors_["1148ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1148ui_story == nil then
				arg_54_1.var_.characterEffect1148ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect1148ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1148ui_story then
				arg_54_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_57_4 = 0
			local var_57_5 = 0.8

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(112032015)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 32 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 32)

				if (32 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 32)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032015", "story_v_out_112032.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032015", "story_v_out_112032.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_112032", "112032015", "story_v_out_112032.awb")

						arg_54_1:RecordAudio("112032015", var_57_11)
						arg_54_1:RecordAudio("112032015", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_112032", "112032015", "story_v_out_112032.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_112032", "112032015", "story_v_out_112032.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play112032016 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 112032016
		arg_58_1.duration_ = 9.8

		local var_58_0 = {
			ja = 9.8,
			ko = 6.1,
			zh = 8.3,
			en = 4.566
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
				arg_58_0:Play112032017(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1081ui_story = arg_58_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1081ui_story"].transform.position).z)
				arg_58_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1081ui_story"].transform.localEulerAngles = arg_58_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0.7, -0.92, -5.8)
				arg_58_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1081ui_story"].transform.position).z)
				arg_58_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1081ui_story"].transform.localEulerAngles = arg_58_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_61_1 = arg_58_1.actors_["1081ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1081ui_story == nil then
				arg_58_1.var_.characterEffect1081ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect1081ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1081ui_story then
				arg_58_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["1148ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1148ui_story == nil then
				arg_58_1.var_.characterEffect1148ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_5 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_5 and not isNil(var_61_4) then
				if arg_58_1.var_.characterEffect1148ui_story and not isNil(var_61_4) then
					arg_58_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_5)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_5 and arg_58_1.time_ < 0 + var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1148ui_story then
				arg_58_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_61_6 = 0
			local var_61_7 = 1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(112032016)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 24 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 24)

				if (24 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 24)) > 0 and var_61_7 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032016", "story_v_out_112032.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_out_112032", "112032016", "story_v_out_112032.awb") / 1000

					if var_61_12 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_6
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_112032", "112032016", "story_v_out_112032.awb")

						arg_58_1:RecordAudio("112032016", var_61_13)
						arg_58_1:RecordAudio("112032016", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_112032", "112032016", "story_v_out_112032.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_112032", "112032016", "story_v_out_112032.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play112032017 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 112032017
		arg_62_1.duration_ = 5.13

		local var_62_0 = {
			ja = 4.866,
			ko = 5.133,
			zh = 4.333,
			en = 3.866
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
				arg_62_0:Play112032018(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1081ui_story = arg_62_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1081ui_story"].transform.position).z)
				arg_62_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1081ui_story"].transform.localEulerAngles = arg_62_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1081ui_story"].transform.position).z)
				arg_62_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1081ui_story"].transform.localEulerAngles = arg_62_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["1148ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1148ui_story = var_65_1.localPosition
			end

			local var_65_2 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 then
				var_65_1.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_2)
				var_65_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_1.position).x, (manager.ui.mainCamera.transform.position - var_65_1.position).y, (manager.ui.mainCamera.transform.position - var_65_1.position).z)
				var_65_1.localEulerAngles.z = 0
				var_65_1.localEulerAngles.x = 0
				var_65_1.localEulerAngles = var_65_1.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 then
				var_65_1.localPosition = Vector3.New(0, 100, 0)
				var_65_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_1.position).x, (manager.ui.mainCamera.transform.position - var_65_1.position).y, (manager.ui.mainCamera.transform.position - var_65_1.position).z)
				var_65_1.localEulerAngles.z = 0
				var_65_1.localEulerAngles.x = 0
				var_65_1.localEulerAngles = var_65_1.localEulerAngles
			end

			local var_65_3 = arg_62_1.actors_["1084ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1084ui_story = var_65_3.localPosition
			end

			local var_65_4 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				var_65_3.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_62_1.time_ - 0) / var_65_4)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				var_65_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_65_5 = arg_62_1.actors_["1084ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1084ui_story == nil then
				arg_62_1.var_.characterEffect1084ui_story = var_65_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_6 and not isNil(var_65_5) then
				if arg_62_1.var_.characterEffect1084ui_story and not isNil(var_65_5) then
					arg_62_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_6 and arg_62_1.time_ < 0 + var_65_6 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1084ui_story then
				arg_62_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_65_8 = 0
			local var_65_9 = 0.45

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(112032017)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 18 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 18)

				if (18 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 18)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032017", "story_v_out_112032.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_112032", "112032017", "story_v_out_112032.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_112032", "112032017", "story_v_out_112032.awb")

						arg_62_1:RecordAudio("112032017", var_65_15)
						arg_62_1:RecordAudio("112032017", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_112032", "112032017", "story_v_out_112032.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_112032", "112032017", "story_v_out_112032.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play112032018 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 112032018
		arg_66_1.duration_ = 4.63

		local var_66_0 = {
			ja = 3.166,
			ko = 2.966,
			zh = 4.633,
			en = 3.066
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
				arg_66_0:Play112032019(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1084ui_story"]) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = arg_66_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1084ui_story"]) then
				if arg_66_1.var_.characterEffect1084ui_story and not isNil(arg_66_1.actors_["1084ui_story"]) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1084ui_story"]) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_69_1 = "1027ui_story"

			if arg_66_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_69_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_66_1.stage_.transform)

				var_69_2.name = var_69_1
				var_69_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_[var_69_1] = var_69_2

				local var_69_3 = var_69_2:GetComponentInChildren(typeof(CharacterEffect))

				var_69_3.enabled = true

				local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_2, typeof(DynamicBoneHelper))

				if var_69_4 then
					var_69_4:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_3.transform, false)

				arg_66_1.var_[var_69_1 .. "Animator"] = var_69_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_[var_69_1 .. "Animator"].applyRootMotion = true
				arg_66_1.var_[var_69_1 .. "LipSync"] = var_69_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_5 = arg_66_1.actors_["1027ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1027ui_story = var_69_5.localPosition
			end

			local var_69_6 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 then
				var_69_5.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_66_1.time_ - 0) / var_69_6)
				var_69_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_5.position).x, (manager.ui.mainCamera.transform.position - var_69_5.position).y, (manager.ui.mainCamera.transform.position - var_69_5.position).z)
				var_69_5.localEulerAngles.z = 0
				var_69_5.localEulerAngles.x = 0
				var_69_5.localEulerAngles = var_69_5.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 then
				var_69_5.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_69_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_5.position).x, (manager.ui.mainCamera.transform.position - var_69_5.position).y, (manager.ui.mainCamera.transform.position - var_69_5.position).z)
				var_69_5.localEulerAngles.z = 0
				var_69_5.localEulerAngles.x = 0
				var_69_5.localEulerAngles = var_69_5.localEulerAngles
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_69_7 = arg_66_1.actors_["1027ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_7) and arg_66_1.var_.characterEffect1027ui_story == nil then
				arg_66_1.var_.characterEffect1027ui_story = var_69_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_8 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_8 and not isNil(var_69_7) then
				if arg_66_1.var_.characterEffect1027ui_story and not isNil(var_69_7) then
					arg_66_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_8 and arg_66_1.time_ < 0 + var_69_8 + arg_69_0 and not isNil(var_69_7) and arg_66_1.var_.characterEffect1027ui_story then
				arg_66_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_69_10 = 0
			local var_69_11 = 0.225

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_12 = arg_66_1:GetWordFromCfg(112032018)
				local var_69_13 = arg_66_1:FormatText(var_69_12.content)

				arg_66_1.text_.text = var_69_13

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 9 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 9)

				if (9 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 9)) > 0 and var_69_11 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_13
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032018", "story_v_out_112032.awb") ~= 0 then
					local var_69_16 = manager.audio:GetVoiceLength("story_v_out_112032", "112032018", "story_v_out_112032.awb") / 1000

					if var_69_16 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_10
					end

					if var_69_12.prefab_name ~= "" and arg_66_1.actors_[var_69_12.prefab_name] ~= nil then
						local var_69_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_12.prefab_name].transform, "story_v_out_112032", "112032018", "story_v_out_112032.awb")

						arg_66_1:RecordAudio("112032018", var_69_17)
						arg_66_1:RecordAudio("112032018", var_69_17)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_112032", "112032018", "story_v_out_112032.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_112032", "112032018", "story_v_out_112032.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_18 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_18

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_18 and arg_66_1.time_ < var_69_10 + var_69_18 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play112032019 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 112032019
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play112032020(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1027ui_story = arg_70_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1027ui_story"].transform.position).z)
				arg_70_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1027ui_story"].transform.localEulerAngles = arg_70_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1027ui_story"].transform.position).z)
				arg_70_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1027ui_story"].transform.localEulerAngles = arg_70_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_73_1 = arg_70_1.actors_["1084ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1084ui_story = var_73_1.localPosition
			end

			local var_73_2 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 then
				var_73_1.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_2)
				var_73_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_1.position).x, (manager.ui.mainCamera.transform.position - var_73_1.position).y, (manager.ui.mainCamera.transform.position - var_73_1.position).z)
				var_73_1.localEulerAngles.z = 0
				var_73_1.localEulerAngles.x = 0
				var_73_1.localEulerAngles = var_73_1.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 then
				var_73_1.localPosition = Vector3.New(0, 100, 0)
				var_73_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_1.position).x, (manager.ui.mainCamera.transform.position - var_73_1.position).y, (manager.ui.mainCamera.transform.position - var_73_1.position).z)
				var_73_1.localEulerAngles.z = 0
				var_73_1.localEulerAngles.x = 0
				var_73_1.localEulerAngles = var_73_1.localEulerAngles
			end

			local var_73_3 = 0
			local var_73_4 = 0.725

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_3 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_5 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(112032019).content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 29 <= 0 and var_73_4 or var_73_4 * (utf8.len(var_73_5) / 29)

				if (29 <= 0 and var_73_4 or var_73_4 * (utf8.len(var_73_5) / 29)) > 0 and var_73_4 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_3 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_3
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_8 = math.max(var_73_4, arg_70_1.talkMaxDuration)

			if var_73_3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_3 + var_73_8 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_3) / var_73_8

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_3 + var_73_8 and arg_70_1.time_ < var_73_3 + var_73_8 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play112032020 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 112032020
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play112032021(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.25

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(112032020).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 10 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 10)

				if (10 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 10)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play112032021 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 112032021
		arg_78_1.duration_ = 4.8

		local var_78_0 = {
			ja = 4.8,
			ko = 4.2,
			zh = 3.9,
			en = 3.3
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
				arg_78_0:Play112032022(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1148ui_story = arg_78_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1148ui_story"].transform.position).z)
				arg_78_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1148ui_story"].transform.localEulerAngles = arg_78_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_78_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1148ui_story"].transform.position).z)
				arg_78_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1148ui_story"].transform.localEulerAngles = arg_78_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_81_1 = arg_78_1.actors_["1148ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1148ui_story == nil then
				arg_78_1.var_.characterEffect1148ui_story = var_81_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 and not isNil(var_81_1) then
				if arg_78_1.var_.characterEffect1148ui_story and not isNil(var_81_1) then
					arg_78_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1148ui_story then
				arg_78_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_81_4 = 0
			local var_81_5 = 0.475

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(112032021)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 19 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 19)

				if (19 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 19)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032021", "story_v_out_112032.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032021", "story_v_out_112032.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_112032", "112032021", "story_v_out_112032.awb")

						arg_78_1:RecordAudio("112032021", var_81_11)
						arg_78_1:RecordAudio("112032021", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_112032", "112032021", "story_v_out_112032.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_112032", "112032021", "story_v_out_112032.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play112032022 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 112032022
		arg_82_1.duration_ = 14.8

		local var_82_0 = {
			ja = 14.8,
			ko = 8.4,
			zh = 8.1,
			en = 8.133
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
				arg_82_0:Play112032023(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1039ui_story = arg_82_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_85_0 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_82_1.time_ - 0) / var_85_0)
				arg_82_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1039ui_story"].transform.position).z)
				arg_82_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1039ui_story"].transform.localEulerAngles = arg_82_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -5.9)
				arg_82_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1039ui_story"].transform.position).z)
				arg_82_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1039ui_story"].transform.localEulerAngles = arg_82_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_85_1 = arg_82_1.actors_["1039ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1039ui_story == nil then
				arg_82_1.var_.characterEffect1039ui_story = var_85_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 and not isNil(var_85_1) then
				if arg_82_1.var_.characterEffect1039ui_story and not isNil(var_85_1) then
					arg_82_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1039ui_story then
				arg_82_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1148ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1148ui_story == nil then
				arg_82_1.var_.characterEffect1148ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_5 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_5 and not isNil(var_85_4) then
				if arg_82_1.var_.characterEffect1148ui_story and not isNil(var_85_4) then
					arg_82_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_5)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_5 and arg_82_1.time_ < 0 + var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1148ui_story then
				arg_82_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_85_6 = 0
			local var_85_7 = 0.9

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(112032022)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 36 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 36)

				if (36 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 36)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032022", "story_v_out_112032.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_112032", "112032022", "story_v_out_112032.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_112032", "112032022", "story_v_out_112032.awb")

						arg_82_1:RecordAudio("112032022", var_85_13)
						arg_82_1:RecordAudio("112032022", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_112032", "112032022", "story_v_out_112032.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_112032", "112032022", "story_v_out_112032.awb")
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play112032023 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 112032023
		arg_86_1.duration_ = 11.63

		local var_86_0 = {
			ja = 6.4,
			ko = 11.633,
			zh = 9.2,
			en = 11.366
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
				arg_86_0:Play112032024(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1039ui_story = arg_86_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1039ui_story"].transform.position).z)
				arg_86_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1039ui_story"].transform.localEulerAngles = arg_86_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1039ui_story"].transform.position).z)
				arg_86_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1039ui_story"].transform.localEulerAngles = arg_86_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1148ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1148ui_story = var_89_1.localPosition
			end

			local var_89_2 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_2)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0, 100, 0)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			local var_89_3 = arg_86_1.actors_["1081ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1081ui_story = var_89_3.localPosition
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_3.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_86_1.time_ - 0) / var_89_4)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_89_5 = arg_86_1.actors_["1081ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1081ui_story == nil then
				arg_86_1.var_.characterEffect1081ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_6 and not isNil(var_89_5) then
				if arg_86_1.var_.characterEffect1081ui_story and not isNil(var_89_5) then
					arg_86_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_6 and arg_86_1.time_ < 0 + var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1081ui_story then
				arg_86_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_89_8 = 0
			local var_89_9 = 1.3

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(112032023)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 52 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 52)

				if (52 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 52)) > 0 and var_89_9 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032023", "story_v_out_112032.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_112032", "112032023", "story_v_out_112032.awb") / 1000

					if var_89_14 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_8
					end

					if var_89_10.prefab_name ~= "" and arg_86_1.actors_[var_89_10.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_10.prefab_name].transform, "story_v_out_112032", "112032023", "story_v_out_112032.awb")

						arg_86_1:RecordAudio("112032023", var_89_15)
						arg_86_1:RecordAudio("112032023", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_112032", "112032023", "story_v_out_112032.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_112032", "112032023", "story_v_out_112032.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_16 and arg_86_1.time_ < var_89_8 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_86_1:InitPlayNodeList()
	end,
	Play112032024 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 112032024
		arg_90_1.duration_ = 2.97

		local var_90_0 = {
			ja = 2.4,
			ko = 2.966,
			zh = 1.9,
			en = 2.833
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play112032025(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1081ui_story"]) and arg_90_1.var_.characterEffect1081ui_story == nil then
				arg_90_1.var_.characterEffect1081ui_story = arg_90_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1081ui_story"]) then
				if arg_90_1.var_.characterEffect1081ui_story and not isNil(arg_90_1.actors_["1081ui_story"]) then
					arg_90_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1081ui_story"]) and arg_90_1.var_.characterEffect1081ui_story then
				arg_90_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.2

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(112032024)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 8 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_4) / 8)

				if (8 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_4) / 8)) > 0 and var_93_2 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032024", "story_v_out_112032.awb") ~= 0 then
					local var_93_7 = manager.audio:GetVoiceLength("story_v_out_112032", "112032024", "story_v_out_112032.awb") / 1000

					if var_93_7 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_1
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_112032", "112032024", "story_v_out_112032.awb")

						arg_90_1:RecordAudio("112032024", var_93_8)
						arg_90_1:RecordAudio("112032024", var_93_8)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_112032", "112032024", "story_v_out_112032.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_112032", "112032024", "story_v_out_112032.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_9 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_9 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_9

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_9 and arg_90_1.time_ < var_93_1 + var_93_9 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play112032025 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 112032025
		arg_94_1.duration_ = 4.37

		local var_94_0 = {
			ja = 3.9,
			ko = 4.366,
			zh = 3.566,
			en = 3.466
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
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play112032026(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_97_0 = arg_94_1.actors_["1081ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1081ui_story == nil then
				arg_94_1.var_.characterEffect1081ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_1 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 and not isNil(var_97_0) then
				if arg_94_1.var_.characterEffect1081ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1081ui_story then
				arg_94_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_97_3 = 0
			local var_97_4 = 0.35

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:GetWordFromCfg(112032025)
				local var_97_6 = arg_94_1:FormatText(var_97_5.content)

				arg_94_1.text_.text = var_97_6

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_8 = 14 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_6) / 14)

				if (14 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_6) / 14)) > 0 and var_97_4 < var_97_8 then
					arg_94_1.talkMaxDuration = var_97_8

					if var_97_8 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_3
					end
				end

				arg_94_1.text_.text = var_97_6
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032025", "story_v_out_112032.awb") ~= 0 then
					local var_97_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032025", "story_v_out_112032.awb") / 1000

					if var_97_9 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_3
					end

					if var_97_5.prefab_name ~= "" and arg_94_1.actors_[var_97_5.prefab_name] ~= nil then
						local var_97_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_5.prefab_name].transform, "story_v_out_112032", "112032025", "story_v_out_112032.awb")

						arg_94_1:RecordAudio("112032025", var_97_10)
						arg_94_1:RecordAudio("112032025", var_97_10)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_112032", "112032025", "story_v_out_112032.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_112032", "112032025", "story_v_out_112032.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_11 = math.max(var_97_4, arg_94_1.talkMaxDuration)

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_11 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_3) / var_97_11

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_3 + var_97_11 and arg_94_1.time_ < var_97_3 + var_97_11 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play112032026 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 112032026
		arg_98_1.duration_ = 12.73

		local var_98_0 = {
			ja = 12.733,
			ko = 9.1,
			zh = 9.433,
			en = 11.4
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play112032027(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_101_0 = 0
			local var_101_1 = 1.1

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(112032026)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 44 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 44)

				if (44 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 44)) > 0 and var_101_1 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032026", "story_v_out_112032.awb") ~= 0 then
					local var_101_6 = manager.audio:GetVoiceLength("story_v_out_112032", "112032026", "story_v_out_112032.awb") / 1000

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end

					if var_101_2.prefab_name ~= "" and arg_98_1.actors_[var_101_2.prefab_name] ~= nil then
						local var_101_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_2.prefab_name].transform, "story_v_out_112032", "112032026", "story_v_out_112032.awb")

						arg_98_1:RecordAudio("112032026", var_101_7)
						arg_98_1:RecordAudio("112032026", var_101_7)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_112032", "112032026", "story_v_out_112032.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_112032", "112032026", "story_v_out_112032.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play112032027 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 112032027
		arg_102_1.duration_ = 7.6

		local var_102_0 = {
			ja = 7.6,
			ko = 3.133,
			zh = 3.5,
			en = 3.6
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play112032028(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1081ui_story"]) and arg_102_1.var_.characterEffect1081ui_story == nil then
				arg_102_1.var_.characterEffect1081ui_story = arg_102_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1081ui_story"]) then
				if arg_102_1.var_.characterEffect1081ui_story and not isNil(arg_102_1.actors_["1081ui_story"]) then
					arg_102_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1081ui_story"]) and arg_102_1.var_.characterEffect1081ui_story then
				arg_102_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_fireloop", "")
			end

			local var_105_2 = 0
			local var_105_3 = 0.35

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_4 = arg_102_1:GetWordFromCfg(112032027)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 14 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 14)

				if (14 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 14)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032027", "story_v_out_112032.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_112032", "112032027", "story_v_out_112032.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_112032", "112032027", "story_v_out_112032.awb")

						arg_102_1:RecordAudio("112032027", var_105_9)
						arg_102_1:RecordAudio("112032027", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_112032", "112032027", "story_v_out_112032.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_112032", "112032027", "story_v_out_112032.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play112032028 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 112032028
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play112032029(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1081ui_story = arg_106_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1081ui_story"].transform.position).z)
				arg_106_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1081ui_story"].transform.localEulerAngles = arg_106_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1081ui_story"].transform.position).z)
				arg_106_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1081ui_story"].transform.localEulerAngles = arg_106_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_109_2 = 0
			local var_109_3 = 1.2

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(112032028).content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_6 = 48 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_4) / 48)

				if (48 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_4) / 48)) > 0 and var_109_3 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_7 and arg_106_1.time_ < var_109_2 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play112032029 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 112032029
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play112032030(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_tideloop", "")
			end

			local var_113_1 = 0
			local var_113_2 = 0.475

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(112032029).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 19 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 19)

				if (19 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 19)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play112032030 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 112032030
		arg_114_1.duration_ = 8.43

		local var_114_0 = {
			ja = 7.6,
			ko = 8.433,
			zh = 5.4,
			en = 5.966
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play112032031(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach.awb")

				local var_117_2 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach")

				if "" ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_2 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_2

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_2
						arg_114_1.bgmTxt2_.text = var_117_2
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_117_3 = 0
			local var_117_4 = 0.575

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_3 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_5 = arg_114_1:GetWordFromCfg(112032030)
				local var_117_6 = arg_114_1:FormatText(var_117_5.content)

				arg_114_1.text_.text = var_117_6

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_8 = 23 <= 0 and var_117_4 or var_117_4 * (utf8.len(var_117_6) / 23)

				if (23 <= 0 and var_117_4 or var_117_4 * (utf8.len(var_117_6) / 23)) > 0 and var_117_4 < var_117_8 then
					arg_114_1.talkMaxDuration = var_117_8

					if var_117_8 + var_117_3 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_3
					end
				end

				arg_114_1.text_.text = var_117_6
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032030", "story_v_out_112032.awb") ~= 0 then
					local var_117_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032030", "story_v_out_112032.awb") / 1000

					if var_117_9 + var_117_3 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_3
					end

					if var_117_5.prefab_name ~= "" and arg_114_1.actors_[var_117_5.prefab_name] ~= nil then
						local var_117_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_5.prefab_name].transform, "story_v_out_112032", "112032030", "story_v_out_112032.awb")

						arg_114_1:RecordAudio("112032030", var_117_10)
						arg_114_1:RecordAudio("112032030", var_117_10)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_112032", "112032030", "story_v_out_112032.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_112032", "112032030", "story_v_out_112032.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_11 = math.max(var_117_4, arg_114_1.talkMaxDuration)

			if var_117_3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_3 + var_117_11 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_3) / var_117_11

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_3 + var_117_11 and arg_114_1.time_ < var_117_3 + var_117_11 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play112032031 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 112032031
		arg_119_1.duration_ = 5.27

		local var_119_0 = {
			ja = 5.266,
			ko = 5.033,
			zh = 3.966,
			en = 3.166
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
				arg_119_0:Play112032032(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.4

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(112032031)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 16 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 16)

				if (16 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 16)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032031", "story_v_out_112032.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_112032", "112032031", "story_v_out_112032.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_112032", "112032031", "story_v_out_112032.awb")

						arg_119_1:RecordAudio("112032031", var_122_6)
						arg_119_1:RecordAudio("112032031", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_112032", "112032031", "story_v_out_112032.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_112032", "112032031", "story_v_out_112032.awb")
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
	Play112032032 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 112032032
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play112032033(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.125

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(112032032).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 5 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 5)

				if (5 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 5)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play112032033 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 112032033
		arg_127_1.duration_ = 3.4

		local var_127_0 = {
			ja = 3,
			ko = 1.633,
			zh = 3.4,
			en = 2.5
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
				arg_127_0:Play112032034(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.shakeOldPos1081ui_light = manager.ui.mainCamera.transform.localPosition
			end

			local var_130_0 = 0.6

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				local var_130_1, var_130_2 = math.modf((arg_127_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_130_2 * 0.13, var_130_2 * 0.13, var_130_2 * 0.13) + arg_127_1.var_.shakeOldPos1081ui_light
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				manager.ui.mainCamera.transform.localPosition = arg_127_1.var_.shakeOldPos1081ui_light
			end

			local var_130_3 = 0
			local var_130_4 = 0.175

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_5 = arg_127_1:GetWordFromCfg(112032033)
				local var_130_6 = arg_127_1:FormatText(var_130_5.content)

				arg_127_1.text_.text = var_130_6

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_8 = 7 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_6) / 7)

				if (7 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_6) / 7)) > 0 and var_130_4 < var_130_8 then
					arg_127_1.talkMaxDuration = var_130_8

					if var_130_8 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_3
					end
				end

				arg_127_1.text_.text = var_130_6
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032033", "story_v_out_112032.awb") ~= 0 then
					local var_130_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032033", "story_v_out_112032.awb") / 1000

					if var_130_9 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_3
					end

					if var_130_5.prefab_name ~= "" and arg_127_1.actors_[var_130_5.prefab_name] ~= nil then
						local var_130_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_5.prefab_name].transform, "story_v_out_112032", "112032033", "story_v_out_112032.awb")

						arg_127_1:RecordAudio("112032033", var_130_10)
						arg_127_1:RecordAudio("112032033", var_130_10)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_112032", "112032033", "story_v_out_112032.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_112032", "112032033", "story_v_out_112032.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_11 = math.max(var_130_4, arg_127_1.talkMaxDuration)

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_11 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_3) / var_130_11

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_3 + var_130_11 and arg_127_1.time_ < var_130_3 + var_130_11 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play112032034 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 112032034
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play112032035(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.2

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(112032034).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 8 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 8)

				if (8 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 8)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play112032035 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 112032035
		arg_135_1.duration_ = 6.83

		local var_135_0 = {
			ja = 6.833,
			ko = 4.3,
			zh = 4.966,
			en = 6.5
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
				arg_135_0:Play112032036(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1081ui_story = arg_135_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1081ui_story"].transform.position).z)
				arg_135_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1081ui_story"].transform.localEulerAngles = arg_135_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_135_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1081ui_story"].transform.position).z)
				arg_135_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1081ui_story"].transform.localEulerAngles = arg_135_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_138_1 = arg_135_1.actors_["1081ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1081ui_story == nil then
				arg_135_1.var_.characterEffect1081ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1081ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1081ui_story then
				arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_138_4 = 0
			local var_138_5 = 0.475

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(112032035)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 19 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 19)

				if (19 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 19)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032035", "story_v_out_112032.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032035", "story_v_out_112032.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_112032", "112032035", "story_v_out_112032.awb")

						arg_135_1:RecordAudio("112032035", var_138_11)
						arg_135_1:RecordAudio("112032035", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_112032", "112032035", "story_v_out_112032.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_112032", "112032035", "story_v_out_112032.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play112032036 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 112032036
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play112032037(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1081ui_story"]) and arg_139_1.var_.characterEffect1081ui_story == nil then
				arg_139_1.var_.characterEffect1081ui_story = arg_139_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1081ui_story"]) then
				if arg_139_1.var_.characterEffect1081ui_story and not isNil(arg_139_1.actors_["1081ui_story"]) then
					arg_139_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1081ui_story"]) and arg_139_1.var_.characterEffect1081ui_story then
				arg_139_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.7

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(112032036).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 28 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 28)

				if (28 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 28)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play112032037 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 112032037
		arg_143_1.duration_ = 13.33

		local var_143_0 = {
			ja = 13.333,
			ko = 10.2,
			zh = 8.866,
			en = 9.5
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
				arg_143_0:Play112032038(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_146_0 = arg_143_1.actors_["1081ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1081ui_story == nil then
				arg_143_1.var_.characterEffect1081ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_1 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 and not isNil(var_146_0) then
				if arg_143_1.var_.characterEffect1081ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1081ui_story then
				arg_143_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_146_3 = 0
			local var_146_4 = 0.925

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:GetWordFromCfg(112032037)
				local var_146_6 = arg_143_1:FormatText(var_146_5.content)

				arg_143_1.text_.text = var_146_6

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_8 = 37 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_6) / 37)

				if (37 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_6) / 37)) > 0 and var_146_4 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_6
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032037", "story_v_out_112032.awb") ~= 0 then
					local var_146_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032037", "story_v_out_112032.awb") / 1000

					if var_146_9 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_3
					end

					if var_146_5.prefab_name ~= "" and arg_143_1.actors_[var_146_5.prefab_name] ~= nil then
						local var_146_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_5.prefab_name].transform, "story_v_out_112032", "112032037", "story_v_out_112032.awb")

						arg_143_1:RecordAudio("112032037", var_146_10)
						arg_143_1:RecordAudio("112032037", var_146_10)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_112032", "112032037", "story_v_out_112032.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_112032", "112032037", "story_v_out_112032.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_11 and arg_143_1.time_ < var_146_3 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play112032038 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 112032038
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play112032039(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1081ui_story = arg_147_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).z)
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles = arg_147_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).z)
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles = arg_147_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_150_1 = 0
			local var_150_2 = 1.175

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(112032038).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 47 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 47)

				if (47 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 47)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play112032039 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 112032039
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play112032040(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.8

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(112032039).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 32 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 32)

				if (32 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 32)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play112032040 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 112032040
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play112032041(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.75

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(112032040).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 30 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 30)

				if (30 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 30)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play112032041 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 112032041
		arg_159_1.duration_ = 5.03

		local var_159_0 = {
			ja = 5.033,
			ko = 3.6,
			zh = 4,
			en = 4.4
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
				arg_159_0:Play112032042(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1081ui_story = arg_159_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1081ui_story"].transform.position).z)
				arg_159_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1081ui_story"].transform.localEulerAngles = arg_159_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_159_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1081ui_story"].transform.position).z)
				arg_159_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1081ui_story"].transform.localEulerAngles = arg_159_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_162_1 = arg_159_1.actors_["1081ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1081ui_story == nil then
				arg_159_1.var_.characterEffect1081ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1081ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1081ui_story then
				arg_159_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_162_4 = 0
			local var_162_5 = 0.475

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(112032041)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 19 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 19)

				if (19 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 19)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032041", "story_v_out_112032.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032041", "story_v_out_112032.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_112032", "112032041", "story_v_out_112032.awb")

						arg_159_1:RecordAudio("112032041", var_162_11)
						arg_159_1:RecordAudio("112032041", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_112032", "112032041", "story_v_out_112032.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_112032", "112032041", "story_v_out_112032.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play112032042 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 112032042
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play112032043(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1081ui_story"]) and arg_163_1.var_.characterEffect1081ui_story == nil then
				arg_163_1.var_.characterEffect1081ui_story = arg_163_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1081ui_story"]) then
				if arg_163_1.var_.characterEffect1081ui_story and not isNil(arg_163_1.actors_["1081ui_story"]) then
					arg_163_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1081ui_story"]) and arg_163_1.var_.characterEffect1081ui_story then
				arg_163_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.05

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(112032042).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 2 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 2)

				if (2 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 2)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play112032043 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 112032043
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play112032044(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.375

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(112032043).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 15 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 15)

				if (15 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 15)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play112032044 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 112032044
		arg_171_1.duration_ = 2

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play112032045(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_174_0 = arg_171_1.actors_["1081ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1081ui_story == nil then
				arg_171_1.var_.characterEffect1081ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_1 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 and not isNil(var_174_0) then
				if arg_171_1.var_.characterEffect1081ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1081ui_story then
				arg_171_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_174_3 = 0
			local var_174_4 = 0.1

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:GetWordFromCfg(112032044)
				local var_174_6 = arg_171_1:FormatText(var_174_5.content)

				arg_171_1.text_.text = var_174_6

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_8 = 4 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_6) / 4)

				if (4 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_6) / 4)) > 0 and var_174_4 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_6
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032044", "story_v_out_112032.awb") ~= 0 then
					local var_174_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032044", "story_v_out_112032.awb") / 1000

					if var_174_9 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_3
					end

					if var_174_5.prefab_name ~= "" and arg_171_1.actors_[var_174_5.prefab_name] ~= nil then
						local var_174_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_5.prefab_name].transform, "story_v_out_112032", "112032044", "story_v_out_112032.awb")

						arg_171_1:RecordAudio("112032044", var_174_10)
						arg_171_1:RecordAudio("112032044", var_174_10)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_112032", "112032044", "story_v_out_112032.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_112032", "112032044", "story_v_out_112032.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_11 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_11 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_11

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_11 and arg_171_1.time_ < var_174_3 + var_174_11 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play112032045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 112032045
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play112032046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1081ui_story = arg_175_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1081ui_story"].transform.position).z)
				arg_175_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1081ui_story"].transform.localEulerAngles = arg_175_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1081ui_story"].transform.position).z)
				arg_175_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1081ui_story"].transform.localEulerAngles = arg_175_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_178_1 = 0
			local var_178_2 = 0.425

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(112032045).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 17 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 17)

				if (17 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 17)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play112032046 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 112032046
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play112032047(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(112032046).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 40 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 40)

				if (40 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 40)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play112032047 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 112032047
		arg_183_1.duration_ = 14.27

		local var_183_0 = {
			ja = 13.366,
			ko = 12.766,
			zh = 13.466,
			en = 14.266
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play112032048(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1081ui_story = arg_183_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1081ui_story"].transform.position).z)
				arg_183_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1081ui_story"].transform.localEulerAngles = arg_183_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_183_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1081ui_story"].transform.position).z)
				arg_183_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1081ui_story"].transform.localEulerAngles = arg_183_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_186_1 = arg_183_1.actors_["1081ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1081ui_story == nil then
				arg_183_1.var_.characterEffect1081ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1081ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1081ui_story then
				arg_183_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_186_4 = 0
			local var_186_5 = 1.3

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(112032047)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 52 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 52)

				if (52 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 52)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032047", "story_v_out_112032.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032047", "story_v_out_112032.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_112032", "112032047", "story_v_out_112032.awb")

						arg_183_1:RecordAudio("112032047", var_186_11)
						arg_183_1:RecordAudio("112032047", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_112032", "112032047", "story_v_out_112032.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_112032", "112032047", "story_v_out_112032.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play112032048 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 112032048
		arg_187_1.duration_ = 8.5

		local var_187_0 = {
			ja = 7.6,
			ko = 8.5,
			zh = 6.633,
			en = 6.333
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play112032049(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_190_0 = 0
			local var_190_1 = 0.875

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(112032048)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 35 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 35)

				if (35 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 35)) > 0 and var_190_1 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032048", "story_v_out_112032.awb") ~= 0 then
					local var_190_6 = manager.audio:GetVoiceLength("story_v_out_112032", "112032048", "story_v_out_112032.awb") / 1000

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end

					if var_190_2.prefab_name ~= "" and arg_187_1.actors_[var_190_2.prefab_name] ~= nil then
						local var_190_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_2.prefab_name].transform, "story_v_out_112032", "112032048", "story_v_out_112032.awb")

						arg_187_1:RecordAudio("112032048", var_190_7)
						arg_187_1:RecordAudio("112032048", var_190_7)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_112032", "112032048", "story_v_out_112032.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_112032", "112032048", "story_v_out_112032.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play112032049 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 112032049
		arg_191_1.duration_ = 8.1

		local var_191_0 = {
			ja = 8.1,
			ko = 7.633,
			zh = 5,
			en = 7.033
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
				arg_191_0:Play112032050(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_194_0 = 0
			local var_194_1 = 0.725

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(112032049)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 29 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 29)

				if (29 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 29)) > 0 and var_194_1 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032049", "story_v_out_112032.awb") ~= 0 then
					local var_194_6 = manager.audio:GetVoiceLength("story_v_out_112032", "112032049", "story_v_out_112032.awb") / 1000

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end

					if var_194_2.prefab_name ~= "" and arg_191_1.actors_[var_194_2.prefab_name] ~= nil then
						local var_194_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_2.prefab_name].transform, "story_v_out_112032", "112032049", "story_v_out_112032.awb")

						arg_191_1:RecordAudio("112032049", var_194_7)
						arg_191_1:RecordAudio("112032049", var_194_7)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_112032", "112032049", "story_v_out_112032.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_112032", "112032049", "story_v_out_112032.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play112032050 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 112032050
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play112032051(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1081ui_story"]) and arg_195_1.var_.characterEffect1081ui_story == nil then
				arg_195_1.var_.characterEffect1081ui_story = arg_195_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1081ui_story"]) then
				if arg_195_1.var_.characterEffect1081ui_story and not isNil(arg_195_1.actors_["1081ui_story"]) then
					arg_195_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1081ui_story"]) and arg_195_1.var_.characterEffect1081ui_story then
				arg_195_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.2

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(112032050).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 8 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 8)

				if (8 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 8)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play112032051 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 112032051
		arg_199_1.duration_ = 9.13

		local var_199_0 = {
			ja = 9.133,
			ko = 8.4,
			zh = 8.2,
			en = 7.6
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
				arg_199_0:Play112032052(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_202_0 = arg_199_1.actors_["1081ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1081ui_story == nil then
				arg_199_1.var_.characterEffect1081ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_1 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 and not isNil(var_202_0) then
				if arg_199_1.var_.characterEffect1081ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1081ui_story then
				arg_199_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_202_3 = 0
			local var_202_4 = 0.925

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_5 = arg_199_1:GetWordFromCfg(112032051)
				local var_202_6 = arg_199_1:FormatText(var_202_5.content)

				arg_199_1.text_.text = var_202_6

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_8 = 37 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_6) / 37)

				if (37 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_6) / 37)) > 0 and var_202_4 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_3
					end
				end

				arg_199_1.text_.text = var_202_6
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032051", "story_v_out_112032.awb") ~= 0 then
					local var_202_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032051", "story_v_out_112032.awb") / 1000

					if var_202_9 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_3
					end

					if var_202_5.prefab_name ~= "" and arg_199_1.actors_[var_202_5.prefab_name] ~= nil then
						local var_202_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_5.prefab_name].transform, "story_v_out_112032", "112032051", "story_v_out_112032.awb")

						arg_199_1:RecordAudio("112032051", var_202_10)
						arg_199_1:RecordAudio("112032051", var_202_10)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_112032", "112032051", "story_v_out_112032.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_112032", "112032051", "story_v_out_112032.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_11 = math.max(var_202_4, arg_199_1.talkMaxDuration)

			if var_202_3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_3 + var_202_11 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_3) / var_202_11

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_3 + var_202_11 and arg_199_1.time_ < var_202_3 + var_202_11 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play112032052 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 112032052
		arg_203_1.duration_ = 15.83

		local var_203_0 = {
			ja = 15.833,
			ko = 12.533,
			zh = 9.366,
			en = 12
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
				arg_203_0:Play112032053(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_206_0 = 0
			local var_206_1 = 1.325

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(112032052)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 53 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 53)

				if (53 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 53)) > 0 and var_206_1 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032052", "story_v_out_112032.awb") ~= 0 then
					local var_206_6 = manager.audio:GetVoiceLength("story_v_out_112032", "112032052", "story_v_out_112032.awb") / 1000

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end

					if var_206_2.prefab_name ~= "" and arg_203_1.actors_[var_206_2.prefab_name] ~= nil then
						local var_206_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_2.prefab_name].transform, "story_v_out_112032", "112032052", "story_v_out_112032.awb")

						arg_203_1:RecordAudio("112032052", var_206_7)
						arg_203_1:RecordAudio("112032052", var_206_7)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_112032", "112032052", "story_v_out_112032.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_112032", "112032052", "story_v_out_112032.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play112032053 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 112032053
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play112032054(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1081ui_story"]) and arg_207_1.var_.characterEffect1081ui_story == nil then
				arg_207_1.var_.characterEffect1081ui_story = arg_207_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1081ui_story"]) then
				if arg_207_1.var_.characterEffect1081ui_story and not isNil(arg_207_1.actors_["1081ui_story"]) then
					arg_207_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1081ui_story"]) and arg_207_1.var_.characterEffect1081ui_story then
				arg_207_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.55

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(112032053).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 22 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 22)

				if (22 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 22)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play112032054 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 112032054
		arg_211_1.duration_ = 4.73

		local var_211_0 = {
			ja = 0.999999999999,
			ko = 1.7,
			zh = 4.733,
			en = 0.999999999999
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
				arg_211_0:Play112032055(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1081ui_story"]) and arg_211_1.var_.characterEffect1081ui_story == nil then
				arg_211_1.var_.characterEffect1081ui_story = arg_211_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1081ui_story"]) then
				if arg_211_1.var_.characterEffect1081ui_story and not isNil(arg_211_1.actors_["1081ui_story"]) then
					arg_211_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1081ui_story"]) and arg_211_1.var_.characterEffect1081ui_story then
				arg_211_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_214_2 = 0
			local var_214_3 = 0.05

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(112032054)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 2 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 2)

				if (2 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 2)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032054", "story_v_out_112032.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_112032", "112032054", "story_v_out_112032.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_112032", "112032054", "story_v_out_112032.awb")

						arg_211_1:RecordAudio("112032054", var_214_9)
						arg_211_1:RecordAudio("112032054", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_112032", "112032054", "story_v_out_112032.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_112032", "112032054", "story_v_out_112032.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play112032055 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 112032055
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play112032056(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1081ui_story"]) and arg_215_1.var_.characterEffect1081ui_story == nil then
				arg_215_1.var_.characterEffect1081ui_story = arg_215_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1081ui_story"]) then
				if arg_215_1.var_.characterEffect1081ui_story and not isNil(arg_215_1.actors_["1081ui_story"]) then
					arg_215_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1081ui_story"]) and arg_215_1.var_.characterEffect1081ui_story then
				arg_215_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.375

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(112032055).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 15 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 15)

				if (15 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 15)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play112032056 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 112032056
		arg_219_1.duration_ = 4.73

		local var_219_0 = {
			ja = 1.1,
			ko = 1.366,
			zh = 4.733,
			en = 1.466
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
				arg_219_0:Play112032057(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1081ui_story"]) and arg_219_1.var_.characterEffect1081ui_story == nil then
				arg_219_1.var_.characterEffect1081ui_story = arg_219_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1081ui_story"]) then
				if arg_219_1.var_.characterEffect1081ui_story and not isNil(arg_219_1.actors_["1081ui_story"]) then
					arg_219_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1081ui_story"]) and arg_219_1.var_.characterEffect1081ui_story then
				arg_219_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_222_2 = 0
			local var_222_3 = 0.05

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(112032056)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 2 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 2)

				if (2 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 2)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032056", "story_v_out_112032.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_112032", "112032056", "story_v_out_112032.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_112032", "112032056", "story_v_out_112032.awb")

						arg_219_1:RecordAudio("112032056", var_222_9)
						arg_219_1:RecordAudio("112032056", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_112032", "112032056", "story_v_out_112032.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_112032", "112032056", "story_v_out_112032.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play112032057 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 112032057
		arg_223_1.duration_ = 13.1

		local var_223_0 = {
			ja = 13.1,
			ko = 6.9,
			zh = 9.3,
			en = 6.5
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
				arg_223_0:Play112032058(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action475")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_226_0 = 0
			local var_226_1 = 0.725

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(112032057)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 29 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 29)

				if (29 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 29)) > 0 and var_226_1 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032057", "story_v_out_112032.awb") ~= 0 then
					local var_226_6 = manager.audio:GetVoiceLength("story_v_out_112032", "112032057", "story_v_out_112032.awb") / 1000

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end

					if var_226_2.prefab_name ~= "" and arg_223_1.actors_[var_226_2.prefab_name] ~= nil then
						local var_226_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_2.prefab_name].transform, "story_v_out_112032", "112032057", "story_v_out_112032.awb")

						arg_223_1:RecordAudio("112032057", var_226_7)
						arg_223_1:RecordAudio("112032057", var_226_7)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_112032", "112032057", "story_v_out_112032.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_112032", "112032057", "story_v_out_112032.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play112032058 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 112032058
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play112032059(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1081ui_story"]) and arg_227_1.var_.characterEffect1081ui_story == nil then
				arg_227_1.var_.characterEffect1081ui_story = arg_227_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1081ui_story"]) then
				if arg_227_1.var_.characterEffect1081ui_story and not isNil(arg_227_1.actors_["1081ui_story"]) then
					arg_227_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1081ui_story"]) and arg_227_1.var_.characterEffect1081ui_story then
				arg_227_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.25

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(112032058).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 10 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 10)

				if (10 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 10)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play112032059 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 112032059
		arg_231_1.duration_ = 5.53

		local var_231_0 = {
			ja = 3.233,
			ko = 5,
			zh = 3.6,
			en = 5.533
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
				arg_231_0:Play112032060(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_234_0 = arg_231_1.actors_["1081ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1081ui_story == nil then
				arg_231_1.var_.characterEffect1081ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_1 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 and not isNil(var_234_0) then
				if arg_231_1.var_.characterEffect1081ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1081ui_story then
				arg_231_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_234_3 = 0
			local var_234_4 = 0.325

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_3 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_5 = arg_231_1:GetWordFromCfg(112032059)
				local var_234_6 = arg_231_1:FormatText(var_234_5.content)

				arg_231_1.text_.text = var_234_6

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_8 = 13 <= 0 and var_234_4 or var_234_4 * (utf8.len(var_234_6) / 13)

				if (13 <= 0 and var_234_4 or var_234_4 * (utf8.len(var_234_6) / 13)) > 0 and var_234_4 < var_234_8 then
					arg_231_1.talkMaxDuration = var_234_8

					if var_234_8 + var_234_3 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_3
					end
				end

				arg_231_1.text_.text = var_234_6
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032059", "story_v_out_112032.awb") ~= 0 then
					local var_234_9 = manager.audio:GetVoiceLength("story_v_out_112032", "112032059", "story_v_out_112032.awb") / 1000

					if var_234_9 + var_234_3 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_3
					end

					if var_234_5.prefab_name ~= "" and arg_231_1.actors_[var_234_5.prefab_name] ~= nil then
						local var_234_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_5.prefab_name].transform, "story_v_out_112032", "112032059", "story_v_out_112032.awb")

						arg_231_1:RecordAudio("112032059", var_234_10)
						arg_231_1:RecordAudio("112032059", var_234_10)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_112032", "112032059", "story_v_out_112032.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_112032", "112032059", "story_v_out_112032.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_11 = math.max(var_234_4, arg_231_1.talkMaxDuration)

			if var_234_3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_3 + var_234_11 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_3) / var_234_11

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_3 + var_234_11 and arg_231_1.time_ < var_234_3 + var_234_11 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play112032060 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 112032060
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play112032061(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1081ui_story"]) and arg_235_1.var_.characterEffect1081ui_story == nil then
				arg_235_1.var_.characterEffect1081ui_story = arg_235_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1081ui_story"]) then
				if arg_235_1.var_.characterEffect1081ui_story and not isNil(arg_235_1.actors_["1081ui_story"]) then
					arg_235_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1081ui_story"]) and arg_235_1.var_.characterEffect1081ui_story then
				arg_235_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.75

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(112032060).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 30 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 30)

				if (30 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 30)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play112032061 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 112032061
		arg_239_1.duration_ = 3.97

		local var_239_0 = {
			ja = 3.966,
			ko = 2.9,
			zh = 3.066,
			en = 3.266
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
			arg_239_1.auto_ = false
		end

		function arg_239_1.playNext_(arg_241_0)
			arg_239_1.onStoryFinished_()
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_242_0 = arg_239_1.actors_["1081ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1081ui_story == nil then
				arg_239_1.var_.characterEffect1081ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_1 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 and not isNil(var_242_0) then
				if arg_239_1.var_.characterEffect1081ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1081ui_story then
				arg_239_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_tideloop", "")
			end

			local var_242_4 = 0
			local var_242_5 = 0.3

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(112032061)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 12 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 12)

				if (12 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 12)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032061", "story_v_out_112032.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_112032", "112032061", "story_v_out_112032.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_112032", "112032061", "story_v_out_112032.awb")

						arg_239_1:RecordAudio("112032061", var_242_11)
						arg_239_1:RecordAudio("112032061", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_112032", "112032061", "story_v_out_112032.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_112032", "112032061", "story_v_out_112032.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play112032010 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 112032010
		arg_243_1.duration_ = 5.63

		local var_243_0 = {
			ja = 5.633,
			ko = 5.466,
			zh = 4.7,
			en = 4
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play112032011(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if arg_243_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_246_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_243_1.stage_.transform)

				var_246_0.name = "1148ui_story"
				var_246_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1148ui_story"] = var_246_0

				local var_246_1 = var_246_0:GetComponentInChildren(typeof(CharacterEffect))

				var_246_1.enabled = true

				local var_246_2 = GameObjectTools.GetOrAddComponent(var_246_0, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(false)
				end

				arg_243_1:ShowWeapon(var_246_1.transform, false)

				arg_243_1.var_["1148ui_story" .. "Animator"] = var_246_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_243_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_243_1.var_["1148ui_story" .. "LipSync"] = var_246_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_246_3 = "1148ui_story"

			if arg_243_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_246_4 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_243_1.stage_.transform)

				var_246_4.name = var_246_3
				var_246_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_[var_246_3] = var_246_4

				local var_246_5 = var_246_4:GetComponentInChildren(typeof(CharacterEffect))

				var_246_5.enabled = true

				local var_246_6 = GameObjectTools.GetOrAddComponent(var_246_4, typeof(DynamicBoneHelper))

				if var_246_6 then
					var_246_6:EnableDynamicBone(false)
				end

				arg_243_1:ShowWeapon(var_246_5.transform, false)

				arg_243_1.var_[var_246_3 .. "Animator"] = var_246_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_243_1.var_[var_246_3 .. "Animator"].applyRootMotion = true
				arg_243_1.var_[var_246_3 .. "LipSync"] = var_246_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_246_7 = arg_243_1.actors_["1148ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1148ui_story == nil then
				arg_243_1.var_.characterEffect1148ui_story = var_246_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_8 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_8 and not isNil(var_246_7) then
				if arg_243_1.var_.characterEffect1148ui_story and not isNil(var_246_7) then
					arg_243_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_8 and arg_243_1.time_ < 0 + var_246_8 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1148ui_story then
				arg_243_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_246_10 = 0
			local var_246_11 = 0.425

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_12 = arg_243_1:GetWordFromCfg(112032010)
				local var_246_13 = arg_243_1:FormatText(var_246_12.content)

				arg_243_1.text_.text = var_246_13

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_15 = 17 <= 0 and var_246_11 or var_246_11 * (utf8.len(var_246_13) / 17)

				if (17 <= 0 and var_246_11 or var_246_11 * (utf8.len(var_246_13) / 17)) > 0 and var_246_11 < var_246_15 then
					arg_243_1.talkMaxDuration = var_246_15

					if var_246_15 + var_246_10 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_15 + var_246_10
					end
				end

				arg_243_1.text_.text = var_246_13
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032010", "story_v_out_112032.awb") ~= 0 then
					local var_246_16 = manager.audio:GetVoiceLength("story_v_out_112032", "112032010", "story_v_out_112032.awb") / 1000

					if var_246_16 + var_246_10 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_16 + var_246_10
					end

					if var_246_12.prefab_name ~= "" and arg_243_1.actors_[var_246_12.prefab_name] ~= nil then
						local var_246_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_12.prefab_name].transform, "story_v_out_112032", "112032010", "story_v_out_112032.awb")

						arg_243_1:RecordAudio("112032010", var_246_17)
						arg_243_1:RecordAudio("112032010", var_246_17)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_112032", "112032010", "story_v_out_112032.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_112032", "112032010", "story_v_out_112032.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_18 = math.max(var_246_11, arg_243_1.talkMaxDuration)

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_18 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_10) / var_246_18

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_10 + var_246_18 and arg_243_1.time_ < var_246_10 + var_246_18 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play112032011 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 112032011
		arg_247_1.duration_ = 4.3

		local var_247_0 = {
			ja = 3.933,
			ko = 3.166,
			zh = 3.6,
			en = 4.3
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play112032012(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1148ui_story"]) and arg_247_1.var_.characterEffect1148ui_story == nil then
				arg_247_1.var_.characterEffect1148ui_story = arg_247_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1148ui_story"]) then
				if arg_247_1.var_.characterEffect1148ui_story and not isNil(arg_247_1.actors_["1148ui_story"]) then
					arg_247_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1148ui_story"]) and arg_247_1.var_.characterEffect1148ui_story then
				arg_247_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.35

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(112032011)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 14 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 14)

				if (14 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 14)) > 0 and var_250_2 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112032", "112032011", "story_v_out_112032.awb") ~= 0 then
					local var_250_7 = manager.audio:GetVoiceLength("story_v_out_112032", "112032011", "story_v_out_112032.awb") / 1000

					if var_250_7 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_1
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_112032", "112032011", "story_v_out_112032.awb")

						arg_247_1:RecordAudio("112032011", var_250_8)
						arg_247_1:RecordAudio("112032011", var_250_8)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_112032", "112032011", "story_v_out_112032.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_112032", "112032011", "story_v_out_112032.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_9 and arg_247_1.time_ < var_250_1 + var_250_9 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02",
		"TextureConfig/Background/H02a"
	},
	voices = {
		"story_v_out_112032.awb"
	}
}
