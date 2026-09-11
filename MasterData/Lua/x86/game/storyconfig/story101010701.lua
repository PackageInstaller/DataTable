return {
	Play101071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "A00"

			if arg_1_1.bgs_.A00 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_4_5 then
					arg_1_1.var_.alphaOldValueA00 = var_4_5.color.a
					arg_1_1.var_.alphaMatValueA00 = var_4_5
				end

				arg_1_1.var_.alphaOldValueA00 = 0
			end

			local var_4_6 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 then
				if arg_1_1.var_.alphaMatValueA00 then
					arg_1_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA00, 1, (arg_1_1.time_ - 0) / var_4_6)
					arg_1_1.var_.alphaMatValueA00.color = arg_1_1.var_.alphaMatValueA00.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and arg_1_1.var_.alphaMatValueA00 then
				arg_1_1.var_.alphaMatValueA00.color.a = 1
				arg_1_1.var_.alphaMatValueA00.color = arg_1_1.var_.alphaMatValueA00.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_10 + 2 and arg_1_1.time_ < var_4_10 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.25

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

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(101071001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 10 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 10)

				if (10 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 10)) > 0 and var_4_12 < var_4_16 then
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
	Play101071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101071002
		arg_8_1.duration_ = 3.63

		local var_8_0 = {
			ja = 2.966,
			ko = 2.3,
			zh = 2.266,
			en = 3.633
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
				arg_8_0:Play101071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1084ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1084ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1084ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(0, -0.97, -6)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_11_8 = 0
			local var_11_9 = 0.275

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(101071002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 11 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 11)

				if (11 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 11)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071002", "story_v_out_101071.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071002", "story_v_out_101071.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_101071", "101071002", "story_v_out_101071.awb")

						arg_8_1:RecordAudio("101071002", var_11_15)
						arg_8_1:RecordAudio("101071002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101071", "101071002", "story_v_out_101071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101071", "101071002", "story_v_out_101071.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play101071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101071003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1084ui_story"]) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = arg_12_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1084ui_story"]) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(arg_12_1.actors_["1084ui_story"]) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1084ui_story"]) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.475

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(101071003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 19 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 19)

				if (19 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 19)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play101071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101071004
		arg_16_1.duration_ = 6.13

		local var_16_0 = {
			ja = 6.133,
			ko = 1.999999999999,
			zh = 3.533,
			en = 2.533
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
				arg_16_0:Play101071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1019ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1019ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1019ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1019ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1019ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_6.localPosition
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_16_1.time_ - 0) / var_19_7)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, -0.97, -6)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			local var_19_8 = arg_16_1.actors_["1084ui_story"].transform

			if 0.033 < arg_16_1.time_ and arg_16_1.time_ <= 0.033 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_8.localPosition
			end

			local var_19_9 = 0.5

			if 0.033 <= arg_16_1.time_ and arg_16_1.time_ < 0.033 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_16_1.time_ - 0.033) / var_19_9)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0.033 + var_19_9 and arg_16_1.time_ < 0.033 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0.7, -0.97, -6)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			local var_19_10 = arg_16_1.actors_["1019ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_10.localPosition
			end

			local var_19_11 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 then
				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_16_1.time_ - 0) / var_19_11)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.4

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:GetWordFromCfg(101071004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 16 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 16)

				if (16 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 16)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071004", "story_v_out_101071.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_101071", "101071004", "story_v_out_101071.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_101071", "101071004", "story_v_out_101071.awb")

						arg_16_1:RecordAudio("101071004", var_19_19)
						arg_16_1:RecordAudio("101071004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101071", "101071004", "story_v_out_101071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101071", "101071004", "story_v_out_101071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_20 and arg_16_1.time_ < var_19_12 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101071005
		arg_20_1.duration_ = 5.7

		local var_20_0 = {
			ja = 4.5,
			ko = 5.7,
			zh = 4,
			en = 5.066
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
				arg_20_0:Play101071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = arg_20_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(arg_20_1.actors_["1084ui_story"]) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action427")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_23_2 = 0
			local var_23_3 = 0.45

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(101071005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 18 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 18)

				if (18 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 18)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071005", "story_v_out_101071.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_101071", "101071005", "story_v_out_101071.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_101071", "101071005", "story_v_out_101071.awb")

						arg_20_1:RecordAudio("101071005", var_23_9)
						arg_20_1:RecordAudio("101071005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101071", "101071005", "story_v_out_101071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101071", "101071005", "story_v_out_101071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_10 and arg_20_1.time_ < var_23_2 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101071006
		arg_24_1.duration_ = 0.1

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"

			SetActive(arg_24_1.choicesGo_, true)

			for iter_25_0, iter_25_1 in ipairs(arg_24_1.choices_) do
				SetActive(iter_25_1.go, iter_25_0 <= 2)
			end

			arg_24_1.choices_[1].txt.text = arg_24_1:FormatText(StoryChoiceCfg[10].name)
			arg_24_1.choices_[2].txt.text = arg_24_1:FormatText(StoryChoiceCfg[11].name)
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play101071007(arg_24_1)
			end

			if arg_26_0 == 2 then
				arg_24_0:Play101071007(arg_24_1)
			end

			arg_24_1:RecordChoiceLog(101071006, 10, 11)
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = arg_24_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(arg_24_1.actors_["1084ui_story"]) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play101071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101071007
		arg_28_1.duration_ = 15.13

		local var_28_0 = {
			ja = 15.133,
			ko = 7.933,
			zh = 7.066,
			en = 7.766
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
				arg_28_0:Play101071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = arg_28_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(arg_28_1.actors_["1019ui_story"]) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_2 = "1019ui_story"

			if arg_28_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_31_3 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

				var_31_3.name = var_31_2
				var_31_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_[var_31_2] = var_31_3

				local var_31_4 = var_31_3:GetComponentInChildren(typeof(CharacterEffect))

				var_31_4.enabled = true

				local var_31_5 = GameObjectTools.GetOrAddComponent(var_31_3, typeof(DynamicBoneHelper))

				if var_31_5 then
					var_31_5:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_4.transform, false)

				arg_28_1.var_[var_31_2 .. "Animator"] = var_31_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_[var_31_2 .. "Animator"].applyRootMotion = true
				arg_28_1.var_[var_31_2 .. "LipSync"] = var_31_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_31_6 = "1019ui_story"

			if arg_28_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_31_7 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

				var_31_7.name = var_31_6
				var_31_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_[var_31_6] = var_31_7

				local var_31_8 = var_31_7:GetComponentInChildren(typeof(CharacterEffect))

				var_31_8.enabled = true

				local var_31_9 = GameObjectTools.GetOrAddComponent(var_31_7, typeof(DynamicBoneHelper))

				if var_31_9 then
					var_31_9:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_8.transform, false)

				arg_28_1.var_[var_31_6 .. "Animator"] = var_31_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_[var_31_6 .. "Animator"].applyRootMotion = true
				arg_28_1.var_[var_31_6 .. "LipSync"] = var_31_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_10 = 0
			local var_31_11 = 0.9

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(101071007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 35 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 35)

				if (35 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 35)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071007", "story_v_out_101071.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_101071", "101071007", "story_v_out_101071.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_101071", "101071007", "story_v_out_101071.awb")

						arg_28_1:RecordAudio("101071007", var_31_17)
						arg_28_1:RecordAudio("101071007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101071", "101071007", "story_v_out_101071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101071", "101071007", "story_v_out_101071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101071008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play101071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1019ui_story"]) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = arg_32_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1019ui_story"]) then
				if arg_32_1.var_.characterEffect1019ui_story and not isNil(arg_32_1.actors_["1019ui_story"]) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1019ui_story"]) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_35_1 = 0
			local var_35_2 = 0.325

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
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

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(101071008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 13 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 13)

				if (13 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 13)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101071009
		arg_36_1.duration_ = 4.3

		local var_36_0 = {
			ja = 4.3,
			ko = 2.833,
			zh = 2.2,
			en = 2
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
				arg_36_0:Play101071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = arg_36_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) then
				if arg_36_1.var_.characterEffect1019ui_story and not isNil(arg_36_1.actors_["1019ui_story"]) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_39_2 = 0
			local var_39_3 = 0.3

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(101071009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 12 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 12)

				if (12 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 12)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071009", "story_v_out_101071.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_101071", "101071009", "story_v_out_101071.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_101071", "101071009", "story_v_out_101071.awb")

						arg_36_1:RecordAudio("101071009", var_39_9)
						arg_36_1:RecordAudio("101071009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101071", "101071009", "story_v_out_101071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101071", "101071009", "story_v_out_101071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101071010
		arg_40_1.duration_ = 4.5

		local var_40_0 = {
			ja = 4.5,
			ko = 2.933,
			zh = 2.033,
			en = 2.5
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
				arg_40_0:Play101071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = arg_40_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(arg_40_1.actors_["1084ui_story"]) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1019ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action476")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(101071010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 8 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 8)

				if (8 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 8)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071010", "story_v_out_101071.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071010", "story_v_out_101071.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_101071", "101071010", "story_v_out_101071.awb")

						arg_40_1:RecordAudio("101071010", var_43_11)
						arg_40_1:RecordAudio("101071010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101071", "101071010", "story_v_out_101071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101071", "101071010", "story_v_out_101071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101071011
		arg_44_1.duration_ = 17.33

		local var_44_0 = {
			ja = 17.333,
			ko = 10.766,
			zh = 10.9,
			en = 10.533
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
				arg_44_0:Play101071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = arg_44_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) then
				if arg_44_1.var_.characterEffect1019ui_story and not isNil(arg_44_1.actors_["1019ui_story"]) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_4 = 0
			local var_47_5 = 1.475

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(101071011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 59 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 59)

				if (59 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 59)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071011", "story_v_out_101071.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071011", "story_v_out_101071.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_101071", "101071011", "story_v_out_101071.awb")

						arg_44_1:RecordAudio("101071011", var_47_11)
						arg_44_1:RecordAudio("101071011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101071", "101071011", "story_v_out_101071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101071", "101071011", "story_v_out_101071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play101071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101071012
		arg_48_1.duration_ = 6.7

		local var_48_0 = {
			ja = 6.7,
			ko = 4.433,
			zh = 4.166,
			en = 3.3
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
				arg_48_0:Play101071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = arg_48_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(arg_48_1.actors_["1084ui_story"]) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1019ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4613")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.45

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(101071012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 18 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 18)

				if (18 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 18)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071012", "story_v_out_101071.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071012", "story_v_out_101071.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_101071", "101071012", "story_v_out_101071.awb")

						arg_48_1:RecordAudio("101071012", var_51_11)
						arg_48_1:RecordAudio("101071012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101071", "101071012", "story_v_out_101071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101071", "101071012", "story_v_out_101071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play101071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101071013
		arg_52_1.duration_ = 4.83

		local var_52_0 = {
			ja = 4.833,
			ko = 3.333,
			zh = 3.566,
			en = 3.5
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
				arg_52_0:Play101071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = arg_52_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) then
				if arg_52_1.var_.characterEffect1019ui_story and not isNil(arg_52_1.actors_["1019ui_story"]) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["1084ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.425

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(101071013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 17 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 17)

				if (17 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 17)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071013", "story_v_out_101071.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071013", "story_v_out_101071.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_101071", "101071013", "story_v_out_101071.awb")

						arg_52_1:RecordAudio("101071013", var_55_11)
						arg_52_1:RecordAudio("101071013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101071", "101071013", "story_v_out_101071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101071", "101071013", "story_v_out_101071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play101071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101071014
		arg_56_1.duration_ = 10.53

		local var_56_0 = {
			ja = 10.533,
			ko = 7,
			zh = 7.3,
			en = 7.733
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
				arg_56_0:Play101071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_59_0 = 0
			local var_59_1 = 0.925

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(101071014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 37 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 37)

				if (37 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 37)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071014", "story_v_out_101071.awb") ~= 0 then
					local var_59_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071014", "story_v_out_101071.awb") / 1000

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end

					if var_59_2.prefab_name ~= "" and arg_56_1.actors_[var_59_2.prefab_name] ~= nil then
						local var_59_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_2.prefab_name].transform, "story_v_out_101071", "101071014", "story_v_out_101071.awb")

						arg_56_1:RecordAudio("101071014", var_59_7)
						arg_56_1:RecordAudio("101071014", var_59_7)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101071", "101071014", "story_v_out_101071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101071", "101071014", "story_v_out_101071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101071015
		arg_60_1.duration_ = 8.23

		local var_60_0 = {
			ja = 8.233,
			ko = 5.633,
			zh = 5.966,
			en = 6.766
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
				arg_60_0:Play101071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = arg_60_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) then
				if arg_60_1.var_.characterEffect1084ui_story and not isNil(arg_60_1.actors_["1084ui_story"]) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1019ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4138")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_63_4 = 0
			local var_63_5 = 0.75

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(101071015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 30 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 30)

				if (30 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 30)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071015", "story_v_out_101071.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071015", "story_v_out_101071.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_101071", "101071015", "story_v_out_101071.awb")

						arg_60_1:RecordAudio("101071015", var_63_11)
						arg_60_1:RecordAudio("101071015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101071", "101071015", "story_v_out_101071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101071", "101071015", "story_v_out_101071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play101071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101071016
		arg_64_1.duration_ = 14

		local var_64_0 = {
			ja = 14,
			ko = 9.266,
			zh = 8.6,
			en = 11.9
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
				arg_64_0:Play101071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1019ui_story"]) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = arg_64_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1019ui_story"]) then
				if arg_64_1.var_.characterEffect1019ui_story and not isNil(arg_64_1.actors_["1019ui_story"]) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1019ui_story"]) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1084ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_4 = 0
			local var_67_5 = 1.05

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(101071016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 42 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 42)

				if (42 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 42)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071016", "story_v_out_101071.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071016", "story_v_out_101071.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_101071", "101071016", "story_v_out_101071.awb")

						arg_64_1:RecordAudio("101071016", var_67_11)
						arg_64_1:RecordAudio("101071016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101071", "101071016", "story_v_out_101071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101071", "101071016", "story_v_out_101071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play101071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101071017
		arg_68_1.duration_ = 0.1

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"

			SetActive(arg_68_1.choicesGo_, true)

			for iter_69_0, iter_69_1 in ipairs(arg_68_1.choices_) do
				SetActive(iter_69_1.go, iter_69_0 <= 2)
			end

			arg_68_1.choices_[1].txt.text = arg_68_1:FormatText(StoryChoiceCfg[12].name)
			arg_68_1.choices_[2].txt.text = arg_68_1:FormatText(StoryChoiceCfg[13].name)
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play101071020(arg_68_1)
			end

			if arg_70_0 == 2 then
				arg_68_0:Play101071018(arg_68_1)
			end

			arg_68_1:RecordChoiceLog(101071017, 12, 13)
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1019ui_story"]) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = arg_68_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1019ui_story"]) then
				if arg_68_1.var_.characterEffect1019ui_story and not isNil(arg_68_1.actors_["1019ui_story"]) then
					arg_68_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1019ui_story"]) and arg_68_1.var_.characterEffect1019ui_story then
				arg_68_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play101071020 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101071020
		arg_72_1.duration_ = 5.57

		local var_72_0 = {
			ja = 5.566,
			ko = 2.266,
			zh = 2.666,
			en = 2.9
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
				arg_72_0:Play101071021(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1019ui_story"]) and arg_72_1.var_.characterEffect1019ui_story == nil then
				arg_72_1.var_.characterEffect1019ui_story = arg_72_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1019ui_story"]) then
				if arg_72_1.var_.characterEffect1019ui_story and not isNil(arg_72_1.actors_["1019ui_story"]) then
					arg_72_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1019ui_story"]) and arg_72_1.var_.characterEffect1019ui_story then
				arg_72_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1084ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_2.localPosition
			end

			local var_75_3 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 then
				var_75_2.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_72_1.time_ - 0) / var_75_3)
				var_75_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_2.position).x, (manager.ui.mainCamera.transform.position - var_75_2.position).y, (manager.ui.mainCamera.transform.position - var_75_2.position).z)
				var_75_2.localEulerAngles.z = 0
				var_75_2.localEulerAngles.x = 0
				var_75_2.localEulerAngles = var_75_2.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 then
				var_75_2.localPosition = Vector3.New(0.7, -0.97, -6)
				var_75_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_2.position).x, (manager.ui.mainCamera.transform.position - var_75_2.position).y, (manager.ui.mainCamera.transform.position - var_75_2.position).z)
				var_75_2.localEulerAngles.z = 0
				var_75_2.localEulerAngles.x = 0
				var_75_2.localEulerAngles = var_75_2.localEulerAngles
			end

			local var_75_4 = arg_72_1.actors_["1019ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_75_6 = 0
			local var_75_7 = 0.35

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(101071020)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 14 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 14)

				if (14 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 14)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071020", "story_v_out_101071.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_101071", "101071020", "story_v_out_101071.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_101071", "101071020", "story_v_out_101071.awb")

						arg_72_1:RecordAudio("101071020", var_75_13)
						arg_72_1:RecordAudio("101071020", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101071", "101071020", "story_v_out_101071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101071", "101071020", "story_v_out_101071.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play101071021 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101071021
		arg_76_1.duration_ = 14.33

		local var_76_0 = {
			ja = 14.333,
			ko = 9.033,
			zh = 7.766,
			en = 8.666
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
				arg_76_0:Play101071022(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1019ui_story"]) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = arg_76_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1019ui_story"]) then
				if arg_76_1.var_.characterEffect1019ui_story and not isNil(arg_76_1.actors_["1019ui_story"]) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1019ui_story"]) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1084ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = var_79_2.localPosition
			end

			local var_79_3 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 then
				var_79_2.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_76_1.time_ - 0) / var_79_3)
				var_79_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_2.position).x, (manager.ui.mainCamera.transform.position - var_79_2.position).y, (manager.ui.mainCamera.transform.position - var_79_2.position).z)
				var_79_2.localEulerAngles.z = 0
				var_79_2.localEulerAngles.x = 0
				var_79_2.localEulerAngles = var_79_2.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 then
				var_79_2.localPosition = Vector3.New(0.7, -0.97, -6)
				var_79_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_2.position).x, (manager.ui.mainCamera.transform.position - var_79_2.position).y, (manager.ui.mainCamera.transform.position - var_79_2.position).z)
				var_79_2.localEulerAngles.z = 0
				var_79_2.localEulerAngles.x = 0
				var_79_2.localEulerAngles = var_79_2.localEulerAngles
			end

			local var_79_4 = arg_76_1.actors_["1019ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_6 = 0
			local var_79_7 = 0.95

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(101071021)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 38 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 38)

				if (38 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 38)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071021", "story_v_out_101071.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_101071", "101071021", "story_v_out_101071.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_101071", "101071021", "story_v_out_101071.awb")

						arg_76_1:RecordAudio("101071021", var_79_13)
						arg_76_1:RecordAudio("101071021", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101071", "101071021", "story_v_out_101071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101071", "101071021", "story_v_out_101071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play101071022 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101071022
		arg_80_1.duration_ = 7.7

		local var_80_0 = {
			ja = 7.7,
			ko = 6.833,
			zh = 6.533,
			en = 6.566
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play101071023(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_83_0 = 0
			local var_83_1 = 0.825

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(101071022)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 33 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 33)

				if (33 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 33)) > 0 and var_83_1 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071022", "story_v_out_101071.awb") ~= 0 then
					local var_83_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071022", "story_v_out_101071.awb") / 1000

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end

					if var_83_2.prefab_name ~= "" and arg_80_1.actors_[var_83_2.prefab_name] ~= nil then
						local var_83_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_2.prefab_name].transform, "story_v_out_101071", "101071022", "story_v_out_101071.awb")

						arg_80_1:RecordAudio("101071022", var_83_7)
						arg_80_1:RecordAudio("101071022", var_83_7)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101071", "101071022", "story_v_out_101071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101071", "101071022", "story_v_out_101071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play101071023 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101071023
		arg_84_1.duration_ = 5.03

		local var_84_0 = {
			ja = 5.033,
			ko = 2.666,
			zh = 4.133,
			en = 3
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play101071024(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = arg_84_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) then
				if arg_84_1.var_.characterEffect1084ui_story and not isNil(arg_84_1.actors_["1084ui_story"]) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["1019ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect1019ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1019ui_story then
				arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_87_4 = arg_84_1.actors_["1019ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1019ui_story = var_87_4.localPosition
			end

			local var_87_5 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_5 then
				var_87_4.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_84_1.time_ - 0) / var_87_5)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_5 and arg_84_1.time_ < 0 + var_87_5 + arg_87_0 then
				var_87_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			local var_87_6 = arg_84_1.actors_["1084ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_6.localPosition
			end

			local var_87_7 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				var_87_6.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_84_1.time_ - 0) / var_87_7)
				var_87_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_6.position).x, (manager.ui.mainCamera.transform.position - var_87_6.position).y, (manager.ui.mainCamera.transform.position - var_87_6.position).z)
				var_87_6.localEulerAngles.z = 0
				var_87_6.localEulerAngles.x = 0
				var_87_6.localEulerAngles = var_87_6.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				var_87_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_87_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_6.position).x, (manager.ui.mainCamera.transform.position - var_87_6.position).y, (manager.ui.mainCamera.transform.position - var_87_6.position).z)
				var_87_6.localEulerAngles.z = 0
				var_87_6.localEulerAngles.x = 0
				var_87_6.localEulerAngles = var_87_6.localEulerAngles
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_8 = 0
			local var_87_9 = 0.325

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:GetWordFromCfg(101071023)
				local var_87_11 = arg_84_1:FormatText(var_87_10.content)

				arg_84_1.text_.text = var_87_11

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_13 = 13 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 13)

				if (13 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 13)) > 0 and var_87_9 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_11
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071023", "story_v_out_101071.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071023", "story_v_out_101071.awb") / 1000

					if var_87_14 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_8
					end

					if var_87_10.prefab_name ~= "" and arg_84_1.actors_[var_87_10.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_10.prefab_name].transform, "story_v_out_101071", "101071023", "story_v_out_101071.awb")

						arg_84_1:RecordAudio("101071023", var_87_15)
						arg_84_1:RecordAudio("101071023", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101071", "101071023", "story_v_out_101071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101071", "101071023", "story_v_out_101071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_16 and arg_84_1.time_ < var_87_8 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play101071024 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101071024
		arg_88_1.duration_ = 7.67

		local var_88_0 = {
			ja = 7.666,
			ko = 3.933,
			zh = 5,
			en = 4.133
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
				arg_88_0:Play101071025(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = arg_88_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(arg_88_1.actors_["1084ui_story"]) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_91_1 = arg_88_1.actors_["1084ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_1.localPosition
			end

			local var_91_2 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 then
				var_91_1.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_2)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 then
				var_91_1.localPosition = Vector3.New(0, 100, 0)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			local var_91_3 = arg_88_1.actors_["1019ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_3.localPosition
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_4)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(0, 100, 0)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			local var_91_5 = 0
			local var_91_6 = 0.325

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:GetWordFromCfg(101071024)
				local var_91_8 = arg_88_1:FormatText(var_91_7.content)

				arg_88_1.text_.text = var_91_8

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 13 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 13)

				if (13 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 13)) > 0 and var_91_6 < var_91_10 then
					arg_88_1.talkMaxDuration = var_91_10

					if var_91_10 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_8
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071024", "story_v_out_101071.awb") ~= 0 then
					local var_91_11 = manager.audio:GetVoiceLength("story_v_out_101071", "101071024", "story_v_out_101071.awb") / 1000

					if var_91_11 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_5
					end

					if var_91_7.prefab_name ~= "" and arg_88_1.actors_[var_91_7.prefab_name] ~= nil then
						local var_91_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_7.prefab_name].transform, "story_v_out_101071", "101071024", "story_v_out_101071.awb")

						arg_88_1:RecordAudio("101071024", var_91_12)
						arg_88_1:RecordAudio("101071024", var_91_12)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101071", "101071024", "story_v_out_101071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101071", "101071024", "story_v_out_101071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_13 and arg_88_1.time_ < var_91_5 + var_91_13 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play101071025 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101071025
		arg_92_1.duration_ = 3.07

		local var_92_0 = {
			ja = 2.4,
			ko = 2.266,
			zh = 3.066,
			en = 2.566
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
				arg_92_0:Play101071026(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story", "se_story_gasgate_open", "")
			end

			local var_95_1 = 0
			local var_95_2 = 0.275

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(101071025)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 11 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 11)

				if (11 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 11)) > 0 and var_95_2 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071025", "story_v_out_101071.awb") ~= 0 then
					local var_95_7 = manager.audio:GetVoiceLength("story_v_out_101071", "101071025", "story_v_out_101071.awb") / 1000

					if var_95_7 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_1
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_101071", "101071025", "story_v_out_101071.awb")

						arg_92_1:RecordAudio("101071025", var_95_8)
						arg_92_1:RecordAudio("101071025", var_95_8)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101071", "101071025", "story_v_out_101071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101071", "101071025", "story_v_out_101071.awb")
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
	Play101071026 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101071026
		arg_96_1.duration_ = 2.97

		local var_96_0 = {
			ja = 2.533,
			ko = 2.6,
			zh = 2.966,
			en = 2.766
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play101071027(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1019ui_story"]) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = arg_96_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1019ui_story"]) then
				if arg_96_1.var_.characterEffect1019ui_story and not isNil(arg_96_1.actors_["1019ui_story"]) then
					arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1019ui_story"]) and arg_96_1.var_.characterEffect1019ui_story then
				arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.175

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(101071026)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 7 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 7)

				if (7 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 7)) > 0 and var_99_2 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071026", "story_v_out_101071.awb") ~= 0 then
					local var_99_7 = manager.audio:GetVoiceLength("story_v_out_101071", "101071026", "story_v_out_101071.awb") / 1000

					if var_99_7 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_1
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_101071", "101071026", "story_v_out_101071.awb")

						arg_96_1:RecordAudio("101071026", var_99_8)
						arg_96_1:RecordAudio("101071026", var_99_8)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101071", "101071026", "story_v_out_101071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101071", "101071026", "story_v_out_101071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_9 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_9 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_9

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_9 and arg_96_1.time_ < var_99_1 + var_99_9 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play101071027 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101071027
		arg_100_1.duration_ = 9

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play101071028(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.bgs_.S0101 == nil then
				local var_103_0 = Object.Instantiate(arg_100_1.paintGo_)

				var_103_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0101")
				var_103_0.name = "S0101"
				var_103_0.transform.parent = arg_100_1.stage_.transform
				var_103_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.bgs_.S0101 = var_103_0
			end

			if 2 < arg_100_1.time_ and arg_100_1.time_ <= 2 + arg_103_0 then
				local var_103_1 = arg_100_1.bgs_.S0101

				arg_100_1.bgs_.S0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_103_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_2 = var_103_1:GetComponent("SpriteRenderer")

				if var_103_2 and var_103_2.sprite then
					local var_103_3 = 2 * (var_103_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_103_1.transform.localScale = Vector3.New(var_103_3 / var_103_2.sprite.bounds.size.y < var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x and var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x or var_103_3 / var_103_2.sprite.bounds.size.y, var_103_3 / var_103_2.sprite.bounds.size.y < var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x and var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x or var_103_3 / var_103_2.sprite.bounds.size.y, 0)
				end

				for iter_103_0, iter_103_1 in pairs(arg_100_1.bgs_) do
					if iter_103_0 ~= "S0101" then
						iter_103_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_103_4 = 0

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_5 = 2

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_5 then
				local var_103_6 = Color.New(0, 0, 0)

				var_103_6.a = Mathf.Lerp(0, 1, (arg_100_1.time_ - var_103_4) / var_103_5)
				arg_100_1.mask_.color = var_103_6
			end

			if arg_100_1.time_ >= var_103_4 + var_103_5 and arg_100_1.time_ < var_103_4 + var_103_5 + arg_103_0 then
				local var_103_7 = Color.New(0, 0, 0)

				var_103_7.a = 1
				arg_100_1.mask_.color = var_103_7
			end

			local var_103_8 = 2

			if 2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_9 = 2

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_9 then
				local var_103_10 = Color.New(0, 0, 0)

				var_103_10.a = Mathf.Lerp(1, 0, (arg_100_1.time_ - var_103_8) / var_103_9)
				arg_100_1.mask_.color = var_103_10
			end

			if arg_100_1.time_ >= var_103_8 + var_103_9 and arg_100_1.time_ < var_103_8 + var_103_9 + arg_103_0 then
				local var_103_11 = Color.New(0, 0, 0)

				arg_100_1.mask_.enabled = false
				var_103_11.a = 0
				arg_100_1.mask_.color = var_103_11
			end

			local var_103_12 = arg_100_1.bgs_.S0101.transform

			if 2 < arg_100_1.time_ and arg_100_1.time_ <= 2 + arg_103_0 then
				arg_100_1.var_.moveOldPosS0101 = var_103_12.localPosition
			end

			local var_103_13 = 0.001

			if 2 <= arg_100_1.time_ and arg_100_1.time_ < 2 + var_103_13 then
				var_103_12.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosS0101, Vector3.New(0, 1, 9), (arg_100_1.time_ - 2) / var_103_13)
			end

			if arg_100_1.time_ >= 2 + var_103_13 and arg_100_1.time_ < 2 + var_103_13 + arg_103_0 then
				var_103_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_103_14 = arg_100_1.bgs_.S0101.transform

			if 2.01666666666667 < arg_100_1.time_ and arg_100_1.time_ <= 2.01666666666667 + arg_103_0 then
				arg_100_1.var_.moveOldPosS0101 = var_103_14.localPosition
			end

			local var_103_15 = 5

			if 2.01666666666667 <= arg_100_1.time_ and arg_100_1.time_ < 2.01666666666667 + var_103_15 then
				var_103_14.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosS0101, Vector3.New(0, 1, 10), (arg_100_1.time_ - 2.01666666666667) / var_103_15)
			end

			if arg_100_1.time_ >= 2.01666666666667 + var_103_15 and arg_100_1.time_ < 2.01666666666667 + var_103_15 + arg_103_0 then
				var_103_14.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_16 = 4
			local var_103_17 = 0.6

			if 4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_18 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_18:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_19 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(101071027).content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_21 = 24 <= 0 and var_103_17 or var_103_17 * (utf8.len(var_103_19) / 24)

				if (24 <= 0 and var_103_17 or var_103_17 * (utf8.len(var_103_19) / 24)) > 0 and var_103_17 < var_103_21 then
					arg_100_1.talkMaxDuration = var_103_21
					var_103_16 = var_103_16 + 0.3

					if var_103_21 + var_103_16 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_21 + var_103_16
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = var_103_16 + 0.3
			local var_103_23 = math.max(var_103_17, arg_100_1.talkMaxDuration)

			if var_103_16 + 0.3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_22 + var_103_23 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_22) / var_103_23

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_22 + var_103_23 and arg_100_1.time_ < var_103_22 + var_103_23 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play101071028 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 101071028
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play101071029(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_109_0 = 0
			local var_109_1 = 1.75

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(101071028).content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 70 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_2) / 70)

				if (70 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_2) / 70)) > 0 and var_109_1 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_5 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_5 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_5

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_5 and arg_106_1.time_ < var_109_0 + var_109_5 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play101071029 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 101071029
		arg_110_1.duration_ = 10.87

		local var_110_0 = {
			ja = 10.866,
			ko = 9.466,
			zh = 9.433,
			en = 10.8
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play101071030(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = arg_110_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 4 <= arg_110_1.time_ and arg_110_1.time_ < 4 + var_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) then
				if arg_110_1.var_.characterEffect1019ui_story and not isNil(arg_110_1.actors_["1019ui_story"]) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 4 + var_113_0 and arg_110_1.time_ < 4 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_2 = arg_110_1.bgs_.A00

				arg_110_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_3 = var_113_2:GetComponent("SpriteRenderer")

				if var_113_3 and var_113_3.sprite then
					local var_113_4 = 2 * (var_113_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_2.transform.localScale = Vector3.New(var_113_4 / var_113_3.sprite.bounds.size.y < var_113_4 * manager.ui.mainCameraCom_.aspect / var_113_3.sprite.bounds.size.x and var_113_4 * manager.ui.mainCameraCom_.aspect / var_113_3.sprite.bounds.size.x or var_113_4 / var_113_3.sprite.bounds.size.y, var_113_4 / var_113_3.sprite.bounds.size.y < var_113_4 * manager.ui.mainCameraCom_.aspect / var_113_3.sprite.bounds.size.x and var_113_4 * manager.ui.mainCameraCom_.aspect / var_113_3.sprite.bounds.size.x or var_113_4 / var_113_3.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "A00" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_5 = arg_110_1.actors_["1019ui_story"].transform

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_5.localPosition
			end

			local var_113_6 = 0.001

			if 4 <= arg_110_1.time_ and arg_110_1.time_ < 4 + var_113_6 then
				var_113_5.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_110_1.time_ - 4) / var_113_6)
				var_113_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_5.position).x, (manager.ui.mainCamera.transform.position - var_113_5.position).y, (manager.ui.mainCamera.transform.position - var_113_5.position).z)
				var_113_5.localEulerAngles.z = 0
				var_113_5.localEulerAngles.x = 0
				var_113_5.localEulerAngles = var_113_5.localEulerAngles
			end

			if arg_110_1.time_ >= 4 + var_113_6 and arg_110_1.time_ < 4 + var_113_6 + arg_113_0 then
				var_113_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_113_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_5.position).x, (manager.ui.mainCamera.transform.position - var_113_5.position).y, (manager.ui.mainCamera.transform.position - var_113_5.position).z)
				var_113_5.localEulerAngles.z = 0
				var_113_5.localEulerAngles.x = 0
				var_113_5.localEulerAngles = var_113_5.localEulerAngles
			end

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_113_7 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_8 = 2

			if var_113_7 <= arg_110_1.time_ and arg_110_1.time_ < var_113_7 + var_113_8 then
				local var_113_9 = Color.New(0, 0, 0)

				var_113_9.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_7) / var_113_8)
				arg_110_1.mask_.color = var_113_9
			end

			if arg_110_1.time_ >= var_113_7 + var_113_8 and arg_110_1.time_ < var_113_7 + var_113_8 + arg_113_0 then
				local var_113_10 = Color.New(0, 0, 0)

				var_113_10.a = 1
				arg_110_1.mask_.color = var_113_10
			end

			local var_113_11 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_12 = 2

			if var_113_11 <= arg_110_1.time_ and arg_110_1.time_ < var_113_11 + var_113_12 then
				local var_113_13 = Color.New(0, 0, 0)

				var_113_13.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_11) / var_113_12)
				arg_110_1.mask_.color = var_113_13
			end

			if arg_110_1.time_ >= var_113_11 + var_113_12 and arg_110_1.time_ < var_113_11 + var_113_12 + arg_113_0 then
				local var_113_14 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_14.a = 0
				arg_110_1.mask_.color = var_113_14
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_15 = 4
			local var_113_16 = 0.775

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_17 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_17:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_18 = arg_110_1:GetWordFromCfg(101071029)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_21 = 28 <= 0 and var_113_16 or var_113_16 * (utf8.len(var_113_19) / 28)

				if (28 <= 0 and var_113_16 or var_113_16 * (utf8.len(var_113_19) / 28)) > 0 and var_113_16 < var_113_21 then
					arg_110_1.talkMaxDuration = var_113_21
					var_113_15 = var_113_15 + 0.3

					if var_113_21 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_21 + var_113_15
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071029", "story_v_out_101071.awb") ~= 0 then
					local var_113_22 = manager.audio:GetVoiceLength("story_v_out_101071", "101071029", "story_v_out_101071.awb") / 1000

					if var_113_22 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_15
					end

					if var_113_18.prefab_name ~= "" and arg_110_1.actors_[var_113_18.prefab_name] ~= nil then
						local var_113_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_18.prefab_name].transform, "story_v_out_101071", "101071029", "story_v_out_101071.awb")

						arg_110_1:RecordAudio("101071029", var_113_23)
						arg_110_1:RecordAudio("101071029", var_113_23)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_101071", "101071029", "story_v_out_101071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_101071", "101071029", "story_v_out_101071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_24 = var_113_15 + 0.3
			local var_113_25 = math.max(var_113_16, arg_110_1.talkMaxDuration)

			if var_113_15 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_24 + var_113_25 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_24) / var_113_25

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_24 + var_113_25 and arg_110_1.time_ < var_113_24 + var_113_25 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play101071030 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101071030
		arg_116_1.duration_ = 6.8

		local var_116_0 = {
			ja = 2.666,
			ko = 6.066,
			zh = 6.366,
			en = 6.8
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
				arg_116_0:Play101071031(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if arg_116_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_119_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_116_1.stage_.transform)

				var_119_0.name = "1011ui_story"
				var_119_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1011ui_story"] = var_119_0

				local var_119_1 = var_119_0:GetComponentInChildren(typeof(CharacterEffect))

				var_119_1.enabled = true

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end

				arg_116_1:ShowWeapon(var_119_1.transform, false)

				arg_116_1.var_["1011ui_story" .. "Animator"] = var_119_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_116_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_116_1.var_["1011ui_story" .. "LipSync"] = var_119_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_119_3 = arg_116_1.actors_["1011ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1011ui_story == nil then
				arg_116_1.var_.characterEffect1011ui_story = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect1011ui_story and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1011ui_story then
				arg_116_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_119_6 = arg_116_1.actors_["1019ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_7 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 and not isNil(var_119_6) then
				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_6) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_7)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_119_8 = arg_116_1.actors_["1011ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1011ui_story = var_119_8.localPosition
			end

			local var_119_9 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_9 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_116_1.time_ - 0) / var_119_9)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_9 and arg_116_1.time_ < 0 + var_119_9 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_10 = 0
			local var_119_11 = 0.5

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_12 = arg_116_1:GetWordFromCfg(101071030)
				local var_119_13 = arg_116_1:FormatText(var_119_12.content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 20 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 20)

				if (20 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 20)) > 0 and var_119_11 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_10
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071030", "story_v_out_101071.awb") ~= 0 then
					local var_119_16 = manager.audio:GetVoiceLength("story_v_out_101071", "101071030", "story_v_out_101071.awb") / 1000

					if var_119_16 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_10
					end

					if var_119_12.prefab_name ~= "" and arg_116_1.actors_[var_119_12.prefab_name] ~= nil then
						local var_119_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_12.prefab_name].transform, "story_v_out_101071", "101071030", "story_v_out_101071.awb")

						arg_116_1:RecordAudio("101071030", var_119_17)
						arg_116_1:RecordAudio("101071030", var_119_17)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101071", "101071030", "story_v_out_101071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101071", "101071030", "story_v_out_101071.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_11, arg_116_1.talkMaxDuration)

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_10) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_10 + var_119_18 and arg_116_1.time_ < var_119_10 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play101071031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101071031
		arg_120_1.duration_ = 0.1

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"

			SetActive(arg_120_1.choicesGo_, true)

			for iter_121_0, iter_121_1 in ipairs(arg_120_1.choices_) do
				SetActive(iter_121_1.go, iter_121_0 <= 2)
			end

			arg_120_1.choices_[1].txt.text = arg_120_1:FormatText(StoryChoiceCfg[14].name)
			arg_120_1.choices_[2].txt.text = arg_120_1:FormatText(StoryChoiceCfg[15].name)
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play101071032(arg_120_1)
			end

			if arg_122_0 == 2 then
				arg_120_0:Play101071034(arg_120_1)
			end

			arg_120_1:RecordChoiceLog(101071031, 14, 15)
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1011ui_story"]) and arg_120_1.var_.characterEffect1011ui_story == nil then
				arg_120_1.var_.characterEffect1011ui_story = arg_120_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1011ui_story"]) then
				if arg_120_1.var_.characterEffect1011ui_story and not isNil(arg_120_1.actors_["1011ui_story"]) then
					arg_120_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1011ui_story"]) and arg_120_1.var_.characterEffect1011ui_story then
				arg_120_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play101071032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 101071032
		arg_124_1.duration_ = 8.43

		local var_124_0 = {
			ja = 8.433,
			ko = 5.3,
			zh = 7,
			en = 5.466
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
				arg_124_0:Play101071035(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) and arg_124_1.var_.characterEffect1019ui_story == nil then
				arg_124_1.var_.characterEffect1019ui_story = arg_124_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) then
				if arg_124_1.var_.characterEffect1019ui_story and not isNil(arg_124_1.actors_["1019ui_story"]) then
					arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) and arg_124_1.var_.characterEffect1019ui_story then
				arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_127_2 = 0
			local var_127_3 = 0.75

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(101071032)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 30 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 30)

				if (30 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 30)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071032", "story_v_out_101071.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_101071", "101071032", "story_v_out_101071.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_101071", "101071032", "story_v_out_101071.awb")

						arg_124_1:RecordAudio("101071032", var_127_9)
						arg_124_1:RecordAudio("101071032", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_101071", "101071032", "story_v_out_101071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_101071", "101071032", "story_v_out_101071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play101071035 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 101071035
		arg_128_1.duration_ = 5.3

		local var_128_0 = {
			ja = 5.066,
			ko = 4.8,
			zh = 5.3,
			en = 5.066
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play101071036(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = arg_128_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) then
				if arg_128_1.var_.characterEffect1084ui_story and not isNil(arg_128_1.actors_["1084ui_story"]) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1019ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1019ui_story = var_131_2.localPosition
			end

			local var_131_3 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_3)
				var_131_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_2.position).x, (manager.ui.mainCamera.transform.position - var_131_2.position).y, (manager.ui.mainCamera.transform.position - var_131_2.position).z)
				var_131_2.localEulerAngles.z = 0
				var_131_2.localEulerAngles.x = 0
				var_131_2.localEulerAngles = var_131_2.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(0, 100, 0)
				var_131_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_2.position).x, (manager.ui.mainCamera.transform.position - var_131_2.position).y, (manager.ui.mainCamera.transform.position - var_131_2.position).z)
				var_131_2.localEulerAngles.z = 0
				var_131_2.localEulerAngles.x = 0
				var_131_2.localEulerAngles = var_131_2.localEulerAngles
			end

			local var_131_4 = arg_128_1.actors_["1084ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1084ui_story = var_131_4.localPosition
			end

			local var_131_5 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_5 then
				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_128_1.time_ - 0) / var_131_5)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_5 and arg_128_1.time_ < 0 + var_131_5 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_131_6 = 0
			local var_131_7 = 0.5

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(101071035)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 20 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 20)

				if (20 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 20)) > 0 and var_131_7 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071035", "story_v_out_101071.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_101071", "101071035", "story_v_out_101071.awb") / 1000

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_out_101071", "101071035", "story_v_out_101071.awb")

						arg_128_1:RecordAudio("101071035", var_131_13)
						arg_128_1:RecordAudio("101071035", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_101071", "101071035", "story_v_out_101071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_101071", "101071035", "story_v_out_101071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play101071036 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 101071036
		arg_132_1.duration_ = 4.9

		local var_132_0 = {
			ja = 4.233,
			ko = 4.9,
			zh = 4,
			en = 4.133
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
				arg_132_0:Play101071037(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4513")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_135_0 = 0
			local var_135_1 = 0.525

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(101071036)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 21 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 21)

				if (21 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 21)) > 0 and var_135_1 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071036", "story_v_out_101071.awb") ~= 0 then
					local var_135_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071036", "story_v_out_101071.awb") / 1000

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end

					if var_135_2.prefab_name ~= "" and arg_132_1.actors_[var_135_2.prefab_name] ~= nil then
						local var_135_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_2.prefab_name].transform, "story_v_out_101071", "101071036", "story_v_out_101071.awb")

						arg_132_1:RecordAudio("101071036", var_135_7)
						arg_132_1:RecordAudio("101071036", var_135_7)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_101071", "101071036", "story_v_out_101071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_101071", "101071036", "story_v_out_101071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_8 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_8 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_8

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_8 and arg_132_1.time_ < var_135_0 + var_135_8 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play101071037 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 101071037
		arg_136_1.duration_ = 6.2

		local var_136_0 = {
			ja = 6.2,
			ko = 4.533,
			zh = 3.9,
			en = 4.833
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
				arg_136_0:Play101071038(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1011ui_story"]) and arg_136_1.var_.characterEffect1011ui_story == nil then
				arg_136_1.var_.characterEffect1011ui_story = arg_136_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1011ui_story"]) then
				if arg_136_1.var_.characterEffect1011ui_story and not isNil(arg_136_1.actors_["1011ui_story"]) then
					arg_136_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1011ui_story"]) and arg_136_1.var_.characterEffect1011ui_story then
				arg_136_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1084ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_139_4 = 0
			local var_139_5 = 0.475

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(101071037)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 19 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 19)

				if (19 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 19)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071037", "story_v_out_101071.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071037", "story_v_out_101071.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_101071", "101071037", "story_v_out_101071.awb")

						arg_136_1:RecordAudio("101071037", var_139_11)
						arg_136_1:RecordAudio("101071037", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_101071", "101071037", "story_v_out_101071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_101071", "101071037", "story_v_out_101071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play101071038 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 101071038
		arg_140_1.duration_ = 8.43

		local var_140_0 = {
			ja = 7.266,
			ko = 5.533,
			zh = 6.6,
			en = 8.433
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
				arg_140_0:Play101071039(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = arg_140_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) then
				if arg_140_1.var_.characterEffect1084ui_story and not isNil(arg_140_1.actors_["1084ui_story"]) then
					arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story then
				arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_143_2 = arg_140_1.actors_["1011ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1011ui_story == nil then
				arg_140_1.var_.characterEffect1011ui_story = var_143_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_3 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.characterEffect1011ui_story and not isNil(var_143_2) then
					arg_140_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_3)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1011ui_story then
				arg_140_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_143_4 = 0
			local var_143_5 = 0.85

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(101071038)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 31 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 31)

				if (31 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 31)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071038", "story_v_out_101071.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071038", "story_v_out_101071.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_101071", "101071038", "story_v_out_101071.awb")

						arg_140_1:RecordAudio("101071038", var_143_11)
						arg_140_1:RecordAudio("101071038", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_101071", "101071038", "story_v_out_101071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_101071", "101071038", "story_v_out_101071.awb")
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

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play101071039 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 101071039
		arg_144_1.duration_ = 8.1

		local var_144_0 = {
			ja = 8.1,
			ko = 7.6,
			zh = 6,
			en = 6.766
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
				arg_144_0:Play101071040(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = arg_144_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) then
				if arg_144_1.var_.characterEffect1019ui_story and not isNil(arg_144_1.actors_["1019ui_story"]) then
					arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) and arg_144_1.var_.characterEffect1019ui_story then
				arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_147_2 = arg_144_1.actors_["1084ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_3 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_2) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_3)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_147_4 = arg_144_1.actors_["1084ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1084ui_story = var_147_4.localPosition
			end

			local var_147_5 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 then
				var_147_4.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_5)
				var_147_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_4.position).x, (manager.ui.mainCamera.transform.position - var_147_4.position).y, (manager.ui.mainCamera.transform.position - var_147_4.position).z)
				var_147_4.localEulerAngles.z = 0
				var_147_4.localEulerAngles.x = 0
				var_147_4.localEulerAngles = var_147_4.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 then
				var_147_4.localPosition = Vector3.New(0, 100, 0)
				var_147_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_4.position).x, (manager.ui.mainCamera.transform.position - var_147_4.position).y, (manager.ui.mainCamera.transform.position - var_147_4.position).z)
				var_147_4.localEulerAngles.z = 0
				var_147_4.localEulerAngles.x = 0
				var_147_4.localEulerAngles = var_147_4.localEulerAngles
			end

			local var_147_6 = arg_144_1.actors_["1011ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1011ui_story = var_147_6.localPosition
			end

			local var_147_7 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				var_147_6.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_144_1.time_ - 0) / var_147_7)
				var_147_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_6.position).x, (manager.ui.mainCamera.transform.position - var_147_6.position).y, (manager.ui.mainCamera.transform.position - var_147_6.position).z)
				var_147_6.localEulerAngles.z = 0
				var_147_6.localEulerAngles.x = 0
				var_147_6.localEulerAngles = var_147_6.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				var_147_6.localPosition = Vector3.New(0.7, -0.71, -6)
				var_147_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_6.position).x, (manager.ui.mainCamera.transform.position - var_147_6.position).y, (manager.ui.mainCamera.transform.position - var_147_6.position).z)
				var_147_6.localEulerAngles.z = 0
				var_147_6.localEulerAngles.x = 0
				var_147_6.localEulerAngles = var_147_6.localEulerAngles
			end

			local var_147_8 = arg_144_1.actors_["1019ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1019ui_story = var_147_8.localPosition
			end

			local var_147_9 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_9 then
				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_144_1.time_ - 0) / var_147_9)
				var_147_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_8.position).x, (manager.ui.mainCamera.transform.position - var_147_8.position).y, (manager.ui.mainCamera.transform.position - var_147_8.position).z)
				var_147_8.localEulerAngles.z = 0
				var_147_8.localEulerAngles.x = 0
				var_147_8.localEulerAngles = var_147_8.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_9 and arg_144_1.time_ < 0 + var_147_9 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_147_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_8.position).x, (manager.ui.mainCamera.transform.position - var_147_8.position).y, (manager.ui.mainCamera.transform.position - var_147_8.position).z)
				var_147_8.localEulerAngles.z = 0
				var_147_8.localEulerAngles.x = 0
				var_147_8.localEulerAngles = var_147_8.localEulerAngles
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_10 = 0
			local var_147_11 = 0.75

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
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

				local var_147_12 = arg_144_1:GetWordFromCfg(101071039)
				local var_147_13 = arg_144_1:FormatText(var_147_12.content)

				arg_144_1.text_.text = var_147_13

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 29 <= 0 and var_147_11 or var_147_11 * (utf8.len(var_147_13) / 29)

				if (29 <= 0 and var_147_11 or var_147_11 * (utf8.len(var_147_13) / 29)) > 0 and var_147_11 < var_147_15 then
					arg_144_1.talkMaxDuration = var_147_15

					if var_147_15 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_15 + var_147_10
					end
				end

				arg_144_1.text_.text = var_147_13
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071039", "story_v_out_101071.awb") ~= 0 then
					local var_147_16 = manager.audio:GetVoiceLength("story_v_out_101071", "101071039", "story_v_out_101071.awb") / 1000

					if var_147_16 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_10
					end

					if var_147_12.prefab_name ~= "" and arg_144_1.actors_[var_147_12.prefab_name] ~= nil then
						local var_147_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_12.prefab_name].transform, "story_v_out_101071", "101071039", "story_v_out_101071.awb")

						arg_144_1:RecordAudio("101071039", var_147_17)
						arg_144_1:RecordAudio("101071039", var_147_17)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_101071", "101071039", "story_v_out_101071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_101071", "101071039", "story_v_out_101071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_18 = math.max(var_147_11, arg_144_1.talkMaxDuration)

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_18 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_10) / var_147_18

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_10 + var_147_18 and arg_144_1.time_ < var_147_10 + var_147_18 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play101071040 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 101071040
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play101071041(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = arg_148_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.1

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
			local var_151_2 = 0.7

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(101071040).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 28 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 28)

				if (28 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 28)) > 0 and var_151_2 < var_151_5 then
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
	Play101071041 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 101071041
		arg_152_1.duration_ = 15.17

		local var_152_0 = {
			ja = 15.166,
			ko = 12.533,
			zh = 10.3,
			en = 11.2
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play101071042(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = arg_152_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) then
				if arg_152_1.var_.characterEffect1019ui_story and not isNil(arg_152_1.actors_["1019ui_story"]) then
					arg_152_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) and arg_152_1.var_.characterEffect1019ui_story then
				arg_152_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_155_2 = 0
			local var_155_3 = 1.3

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:GetWordFromCfg(101071041)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 52 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 52)

				if (52 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 52)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071041", "story_v_out_101071.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_101071", "101071041", "story_v_out_101071.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_101071", "101071041", "story_v_out_101071.awb")

						arg_152_1:RecordAudio("101071041", var_155_9)
						arg_152_1:RecordAudio("101071041", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_101071", "101071041", "story_v_out_101071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_101071", "101071041", "story_v_out_101071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play101071042 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 101071042
		arg_156_1.duration_ = 12

		local var_156_0 = {
			ja = 12,
			ko = 10.466,
			zh = 9.566,
			en = 10.4
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play101071043(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_159_0 = 0
			local var_159_1 = 1.175

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(101071042)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 47 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 47)

				if (47 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 47)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071042", "story_v_out_101071.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071042", "story_v_out_101071.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_out_101071", "101071042", "story_v_out_101071.awb")

						arg_156_1:RecordAudio("101071042", var_159_7)
						arg_156_1:RecordAudio("101071042", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_101071", "101071042", "story_v_out_101071.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_101071", "101071042", "story_v_out_101071.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play101071043 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 101071043
		arg_160_1.duration_ = 2

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play101071044(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1084ui_story"]) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = arg_160_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.1

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1084ui_story"]) then
				if arg_160_1.var_.characterEffect1084ui_story and not isNil(arg_160_1.actors_["1084ui_story"]) then
					arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1084ui_story"]) and arg_160_1.var_.characterEffect1084ui_story then
				arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_163_2 = arg_160_1.actors_["1019ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.characterEffect1019ui_story == nil then
				arg_160_1.var_.characterEffect1019ui_story = var_163_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_3 = 0.1

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_3 and not isNil(var_163_2) then
				if arg_160_1.var_.characterEffect1019ui_story and not isNil(var_163_2) then
					arg_160_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_3)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_3 and arg_160_1.time_ < 0 + var_163_3 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.characterEffect1019ui_story then
				arg_160_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_163_4 = arg_160_1.actors_["1084ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = var_163_4.localPosition
			end

			local var_163_5 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_5 then
				var_163_4.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_160_1.time_ - 0) / var_163_5)
				var_163_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_4.position).x, (manager.ui.mainCamera.transform.position - var_163_4.position).y, (manager.ui.mainCamera.transform.position - var_163_4.position).z)
				var_163_4.localEulerAngles.z = 0
				var_163_4.localEulerAngles.x = 0
				var_163_4.localEulerAngles = var_163_4.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_5 and arg_160_1.time_ < 0 + var_163_5 + arg_163_0 then
				var_163_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_163_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_4.position).x, (manager.ui.mainCamera.transform.position - var_163_4.position).y, (manager.ui.mainCamera.transform.position - var_163_4.position).z)
				var_163_4.localEulerAngles.z = 0
				var_163_4.localEulerAngles.x = 0
				var_163_4.localEulerAngles = var_163_4.localEulerAngles
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_163_6 = arg_160_1.actors_["1019ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1019ui_story = var_163_6.localPosition
			end

			local var_163_7 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				var_163_6.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_160_1.time_ - 0) / var_163_7)
				var_163_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_6.position).x, (manager.ui.mainCamera.transform.position - var_163_6.position).y, (manager.ui.mainCamera.transform.position - var_163_6.position).z)
				var_163_6.localEulerAngles.z = 0
				var_163_6.localEulerAngles.x = 0
				var_163_6.localEulerAngles = var_163_6.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				var_163_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_163_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_6.position).x, (manager.ui.mainCamera.transform.position - var_163_6.position).y, (manager.ui.mainCamera.transform.position - var_163_6.position).z)
				var_163_6.localEulerAngles.z = 0
				var_163_6.localEulerAngles.x = 0
				var_163_6.localEulerAngles = var_163_6.localEulerAngles
			end

			local var_163_8 = arg_160_1.actors_["1011ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1011ui_story = var_163_8.localPosition
			end

			local var_163_9 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_9 then
				var_163_8.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_9)
				var_163_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_8.position).x, (manager.ui.mainCamera.transform.position - var_163_8.position).y, (manager.ui.mainCamera.transform.position - var_163_8.position).z)
				var_163_8.localEulerAngles.z = 0
				var_163_8.localEulerAngles.x = 0
				var_163_8.localEulerAngles = var_163_8.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_9 and arg_160_1.time_ < 0 + var_163_9 + arg_163_0 then
				var_163_8.localPosition = Vector3.New(0, 100, 0)
				var_163_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_8.position).x, (manager.ui.mainCamera.transform.position - var_163_8.position).y, (manager.ui.mainCamera.transform.position - var_163_8.position).z)
				var_163_8.localEulerAngles.z = 0
				var_163_8.localEulerAngles.x = 0
				var_163_8.localEulerAngles = var_163_8.localEulerAngles
			end

			local var_163_10 = 0
			local var_163_11 = 0.1

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_12 = arg_160_1:GetWordFromCfg(101071043)
				local var_163_13 = arg_160_1:FormatText(var_163_12.content)

				arg_160_1.text_.text = var_163_13

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 4 <= 0 and var_163_11 or var_163_11 * (utf8.len(var_163_13) / 4)

				if (4 <= 0 and var_163_11 or var_163_11 * (utf8.len(var_163_13) / 4)) > 0 and var_163_11 < var_163_15 then
					arg_160_1.talkMaxDuration = var_163_15

					if var_163_15 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_10
					end
				end

				arg_160_1.text_.text = var_163_13
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071043", "story_v_out_101071.awb") ~= 0 then
					local var_163_16 = manager.audio:GetVoiceLength("story_v_out_101071", "101071043", "story_v_out_101071.awb") / 1000

					if var_163_16 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_16 + var_163_10
					end

					if var_163_12.prefab_name ~= "" and arg_160_1.actors_[var_163_12.prefab_name] ~= nil then
						local var_163_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_12.prefab_name].transform, "story_v_out_101071", "101071043", "story_v_out_101071.awb")

						arg_160_1:RecordAudio("101071043", var_163_17)
						arg_160_1:RecordAudio("101071043", var_163_17)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_101071", "101071043", "story_v_out_101071.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_101071", "101071043", "story_v_out_101071.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_18 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_18 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_10) / var_163_18

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_10 + var_163_18 and arg_160_1.time_ < var_163_10 + var_163_18 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play101071044 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 101071044
		arg_164_1.duration_ = 13.5

		local var_164_0 = {
			ja = 13.5,
			ko = 11.366,
			zh = 10.8,
			en = 12.933
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play101071045(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1019ui_story"]) and arg_164_1.var_.characterEffect1019ui_story == nil then
				arg_164_1.var_.characterEffect1019ui_story = arg_164_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1019ui_story"]) then
				if arg_164_1.var_.characterEffect1019ui_story and not isNil(arg_164_1.actors_["1019ui_story"]) then
					arg_164_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1019ui_story"]) and arg_164_1.var_.characterEffect1019ui_story then
				arg_164_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_167_2 = arg_164_1.actors_["1084ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = var_167_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_3 = 0.1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.characterEffect1084ui_story and not isNil(var_167_2) then
					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_3)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1084ui_story then
				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_167_4 = 0
			local var_167_5 = 1.25

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_6 = arg_164_1:GetWordFromCfg(101071044)
				local var_167_7 = arg_164_1:FormatText(var_167_6.content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 50 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 50)

				if (50 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 50)) > 0 and var_167_5 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071044", "story_v_out_101071.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071044", "story_v_out_101071.awb") / 1000

					if var_167_10 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_4
					end

					if var_167_6.prefab_name ~= "" and arg_164_1.actors_[var_167_6.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_6.prefab_name].transform, "story_v_out_101071", "101071044", "story_v_out_101071.awb")

						arg_164_1:RecordAudio("101071044", var_167_11)
						arg_164_1:RecordAudio("101071044", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_101071", "101071044", "story_v_out_101071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_101071", "101071044", "story_v_out_101071.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_12 and arg_164_1.time_ < var_167_4 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play101071045 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 101071045
		arg_168_1.duration_ = 10.5

		local var_168_0 = {
			ja = 10.333,
			ko = 9.633,
			zh = 9.733,
			en = 10.5
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play101071046(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_0 = 0
			local var_171_1 = 1.25

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(101071045)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 50 <= 0 and var_171_1 or var_171_1 * (utf8.len(var_171_3) / 50)

				if (50 <= 0 and var_171_1 or var_171_1 * (utf8.len(var_171_3) / 50)) > 0 and var_171_1 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071045", "story_v_out_101071.awb") ~= 0 then
					local var_171_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071045", "story_v_out_101071.awb") / 1000

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end

					if var_171_2.prefab_name ~= "" and arg_168_1.actors_[var_171_2.prefab_name] ~= nil then
						local var_171_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_2.prefab_name].transform, "story_v_out_101071", "101071045", "story_v_out_101071.awb")

						arg_168_1:RecordAudio("101071045", var_171_7)
						arg_168_1:RecordAudio("101071045", var_171_7)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_101071", "101071045", "story_v_out_101071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_101071", "101071045", "story_v_out_101071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_8 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_8 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_8

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_8 and arg_168_1.time_ < var_171_0 + var_171_8 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play101071046 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 101071046
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play101071047(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1019ui_story"]) and arg_172_1.var_.characterEffect1019ui_story == nil then
				arg_172_1.var_.characterEffect1019ui_story = arg_172_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.1

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1019ui_story"]) then
				if arg_172_1.var_.characterEffect1019ui_story and not isNil(arg_172_1.actors_["1019ui_story"]) then
					arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1019ui_story"]) and arg_172_1.var_.characterEffect1019ui_story then
				arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.675

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(101071046).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 27 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 27)

				if (27 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 27)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play101071047 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 101071047
		arg_176_1.duration_ = 9.63

		local var_176_0 = {
			ja = 9.633,
			ko = 5.3,
			zh = 6.066,
			en = 8.333
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play101071048(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1019ui_story"]) and arg_176_1.var_.characterEffect1019ui_story == nil then
				arg_176_1.var_.characterEffect1019ui_story = arg_176_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.1

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1019ui_story"]) then
				if arg_176_1.var_.characterEffect1019ui_story and not isNil(arg_176_1.actors_["1019ui_story"]) then
					arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1019ui_story"]) and arg_176_1.var_.characterEffect1019ui_story then
				arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_179_2 = 0
			local var_179_3 = 0.775

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(101071047)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 31 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 31)

				if (31 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 31)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071047", "story_v_out_101071.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_101071", "101071047", "story_v_out_101071.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_101071", "101071047", "story_v_out_101071.awb")

						arg_176_1:RecordAudio("101071047", var_179_9)
						arg_176_1:RecordAudio("101071047", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_101071", "101071047", "story_v_out_101071.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_101071", "101071047", "story_v_out_101071.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play101071048 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 101071048
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play101071049(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1019ui_story"]) and arg_180_1.var_.characterEffect1019ui_story == nil then
				arg_180_1.var_.characterEffect1019ui_story = arg_180_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.1

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1019ui_story"]) then
				if arg_180_1.var_.characterEffect1019ui_story and not isNil(arg_180_1.actors_["1019ui_story"]) then
					arg_180_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1019ui_story"]) and arg_180_1.var_.characterEffect1019ui_story then
				arg_180_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.2

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(101071048).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 8 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 8)

				if (8 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 8)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play101071049 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 101071049
		arg_184_1.duration_ = 8.2

		local var_184_0 = {
			ja = 7.9,
			ko = 5.933,
			zh = 8.2,
			en = 6.2
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
				arg_184_0:Play101071050(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1019ui_story"]) and arg_184_1.var_.characterEffect1019ui_story == nil then
				arg_184_1.var_.characterEffect1019ui_story = arg_184_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.1

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1019ui_story"]) then
				if arg_184_1.var_.characterEffect1019ui_story and not isNil(arg_184_1.actors_["1019ui_story"]) then
					arg_184_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1019ui_story"]) and arg_184_1.var_.characterEffect1019ui_story then
				arg_184_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_2 = 0
			local var_187_3 = 0.975

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(101071049)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 39 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 39)

				if (39 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 39)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071049", "story_v_out_101071.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_101071", "101071049", "story_v_out_101071.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_101071", "101071049", "story_v_out_101071.awb")

						arg_184_1:RecordAudio("101071049", var_187_9)
						arg_184_1:RecordAudio("101071049", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_101071", "101071049", "story_v_out_101071.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_101071", "101071049", "story_v_out_101071.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play101071050 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 101071050
		arg_188_1.duration_ = 4.17

		local var_188_0 = {
			ja = 4.166,
			ko = 3.7,
			zh = 2.966,
			en = 3.2
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
				arg_188_0:Play101071051(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1084ui_story"]) and arg_188_1.var_.characterEffect1084ui_story == nil then
				arg_188_1.var_.characterEffect1084ui_story = arg_188_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1084ui_story"]) then
				if arg_188_1.var_.characterEffect1084ui_story and not isNil(arg_188_1.actors_["1084ui_story"]) then
					arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1084ui_story"]) and arg_188_1.var_.characterEffect1084ui_story then
				arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_191_2 = arg_188_1.actors_["1019ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1019ui_story == nil then
				arg_188_1.var_.characterEffect1019ui_story = var_191_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_3 = 0.1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.characterEffect1019ui_story and not isNil(var_191_2) then
					arg_188_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_3)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1019ui_story then
				arg_188_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_191_4 = arg_188_1.actors_["1019ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1019ui_story = var_191_4.localPosition
			end

			local var_191_5 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_5 then
				var_191_4.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_188_1.time_ - 0) / var_191_5)
				var_191_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_4.position).x, (manager.ui.mainCamera.transform.position - var_191_4.position).y, (manager.ui.mainCamera.transform.position - var_191_4.position).z)
				var_191_4.localEulerAngles.z = 0
				var_191_4.localEulerAngles.x = 0
				var_191_4.localEulerAngles = var_191_4.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_5 and arg_188_1.time_ < 0 + var_191_5 + arg_191_0 then
				var_191_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_191_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_4.position).x, (manager.ui.mainCamera.transform.position - var_191_4.position).y, (manager.ui.mainCamera.transform.position - var_191_4.position).z)
				var_191_4.localEulerAngles.z = 0
				var_191_4.localEulerAngles.x = 0
				var_191_4.localEulerAngles = var_191_4.localEulerAngles
			end

			local var_191_6 = arg_188_1.actors_["1084ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1084ui_story = var_191_6.localPosition
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_6.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_188_1.time_ - 0) / var_191_7)
				var_191_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_6.position).x, (manager.ui.mainCamera.transform.position - var_191_6.position).y, (manager.ui.mainCamera.transform.position - var_191_6.position).z)
				var_191_6.localEulerAngles.z = 0
				var_191_6.localEulerAngles.x = 0
				var_191_6.localEulerAngles = var_191_6.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_191_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_6.position).x, (manager.ui.mainCamera.transform.position - var_191_6.position).y, (manager.ui.mainCamera.transform.position - var_191_6.position).z)
				var_191_6.localEulerAngles.z = 0
				var_191_6.localEulerAngles.x = 0
				var_191_6.localEulerAngles = var_191_6.localEulerAngles
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_191_8 = 0
			local var_191_9 = 0.325

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(101071050)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 13 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 13)

				if (13 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 13)) > 0 and var_191_9 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071050", "story_v_out_101071.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071050", "story_v_out_101071.awb") / 1000

					if var_191_14 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_8
					end

					if var_191_10.prefab_name ~= "" and arg_188_1.actors_[var_191_10.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_10.prefab_name].transform, "story_v_out_101071", "101071050", "story_v_out_101071.awb")

						arg_188_1:RecordAudio("101071050", var_191_15)
						arg_188_1:RecordAudio("101071050", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_101071", "101071050", "story_v_out_101071.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_101071", "101071050", "story_v_out_101071.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_9, arg_188_1.talkMaxDuration)

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_8) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_8 + var_191_16 and arg_188_1.time_ < var_191_8 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play101071051 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 101071051
		arg_192_1.duration_ = 6.37

		local var_192_0 = {
			ja = 5.2,
			ko = 4.866,
			zh = 5.566,
			en = 6.366
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
				arg_192_0:Play101071052(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1019ui_story"]) and arg_192_1.var_.characterEffect1019ui_story == nil then
				arg_192_1.var_.characterEffect1019ui_story = arg_192_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1019ui_story"]) then
				if arg_192_1.var_.characterEffect1019ui_story and not isNil(arg_192_1.actors_["1019ui_story"]) then
					arg_192_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1019ui_story"]) and arg_192_1.var_.characterEffect1019ui_story then
				arg_192_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["1084ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1084ui_story == nil then
				arg_192_1.var_.characterEffect1084ui_story = var_195_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_3 = 0.1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.characterEffect1084ui_story and not isNil(var_195_2) then
					arg_192_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_3)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1084ui_story then
				arg_192_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_195_4 = 0
			local var_195_5 = 0.6

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(101071051)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 24 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 24)

				if (24 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 24)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071051", "story_v_out_101071.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071051", "story_v_out_101071.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_101071", "101071051", "story_v_out_101071.awb")

						arg_192_1:RecordAudio("101071051", var_195_11)
						arg_192_1:RecordAudio("101071051", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_101071", "101071051", "story_v_out_101071.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_101071", "101071051", "story_v_out_101071.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_12 and arg_192_1.time_ < var_195_4 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play101071052 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 101071052
		arg_196_1.duration_ = 6.83

		local var_196_0 = {
			ja = 6.833,
			ko = 5,
			zh = 4.266,
			en = 4.033
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
				arg_196_0:Play101071053(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_199_0 = 0
			local var_199_1 = 0.575

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_2 = arg_196_1:GetWordFromCfg(101071052)
				local var_199_3 = arg_196_1:FormatText(var_199_2.content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 23 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_3) / 23)

				if (23 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_3) / 23)) > 0 and var_199_1 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071052", "story_v_out_101071.awb") ~= 0 then
					local var_199_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071052", "story_v_out_101071.awb") / 1000

					if var_199_6 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_0
					end

					if var_199_2.prefab_name ~= "" and arg_196_1.actors_[var_199_2.prefab_name] ~= nil then
						local var_199_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_2.prefab_name].transform, "story_v_out_101071", "101071052", "story_v_out_101071.awb")

						arg_196_1:RecordAudio("101071052", var_199_7)
						arg_196_1:RecordAudio("101071052", var_199_7)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_101071", "101071052", "story_v_out_101071.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_101071", "101071052", "story_v_out_101071.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_8 and arg_196_1.time_ < var_199_0 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play101071053 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 101071053
		arg_200_1.duration_ = 2.27

		local var_200_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.266,
			en = 1.999999999999
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
				arg_200_0:Play101071054(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1011ui_story"]) and arg_200_1.var_.characterEffect1011ui_story == nil then
				arg_200_1.var_.characterEffect1011ui_story = arg_200_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.1

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1011ui_story"]) then
				if arg_200_1.var_.characterEffect1011ui_story and not isNil(arg_200_1.actors_["1011ui_story"]) then
					arg_200_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1011ui_story"]) and arg_200_1.var_.characterEffect1011ui_story then
				arg_200_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_203_2 = arg_200_1.actors_["1019ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1019ui_story == nil then
				arg_200_1.var_.characterEffect1019ui_story = var_203_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_3 = 0.1

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.characterEffect1019ui_story and not isNil(var_203_2) then
					arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_3)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1019ui_story then
				arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_203_4 = arg_200_1.actors_["1084ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1084ui_story = var_203_4.localPosition
			end

			local var_203_5 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_5 then
				var_203_4.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_200_1.time_ - 0) / var_203_5)
				var_203_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_4.position).x, (manager.ui.mainCamera.transform.position - var_203_4.position).y, (manager.ui.mainCamera.transform.position - var_203_4.position).z)
				var_203_4.localEulerAngles.z = 0
				var_203_4.localEulerAngles.x = 0
				var_203_4.localEulerAngles = var_203_4.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_5 and arg_200_1.time_ < 0 + var_203_5 + arg_203_0 then
				var_203_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_203_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_4.position).x, (manager.ui.mainCamera.transform.position - var_203_4.position).y, (manager.ui.mainCamera.transform.position - var_203_4.position).z)
				var_203_4.localEulerAngles.z = 0
				var_203_4.localEulerAngles.x = 0
				var_203_4.localEulerAngles = var_203_4.localEulerAngles
			end

			local var_203_6 = arg_200_1.actors_["1019ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1019ui_story = var_203_6.localPosition
			end

			local var_203_7 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_6.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_200_1.time_ - 0) / var_203_7)
				var_203_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_6.position).x, (manager.ui.mainCamera.transform.position - var_203_6.position).y, (manager.ui.mainCamera.transform.position - var_203_6.position).z)
				var_203_6.localEulerAngles.z = 0
				var_203_6.localEulerAngles.x = 0
				var_203_6.localEulerAngles = var_203_6.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_6.localPosition = Vector3.New(0, 100, 0)
				var_203_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_6.position).x, (manager.ui.mainCamera.transform.position - var_203_6.position).y, (manager.ui.mainCamera.transform.position - var_203_6.position).z)
				var_203_6.localEulerAngles.z = 0
				var_203_6.localEulerAngles.x = 0
				var_203_6.localEulerAngles = var_203_6.localEulerAngles
			end

			local var_203_8 = arg_200_1.actors_["1011ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1011ui_story = var_203_8.localPosition
			end

			local var_203_9 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_9 then
				var_203_8.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_200_1.time_ - 0) / var_203_9)
				var_203_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_8.position).x, (manager.ui.mainCamera.transform.position - var_203_8.position).y, (manager.ui.mainCamera.transform.position - var_203_8.position).z)
				var_203_8.localEulerAngles.z = 0
				var_203_8.localEulerAngles.x = 0
				var_203_8.localEulerAngles = var_203_8.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_9 and arg_200_1.time_ < 0 + var_203_9 + arg_203_0 then
				var_203_8.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_203_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_8.position).x, (manager.ui.mainCamera.transform.position - var_203_8.position).y, (manager.ui.mainCamera.transform.position - var_203_8.position).z)
				var_203_8.localEulerAngles.z = 0
				var_203_8.localEulerAngles.x = 0
				var_203_8.localEulerAngles = var_203_8.localEulerAngles
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_203_10 = 0
			local var_203_11 = 0.05

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_12 = arg_200_1:GetWordFromCfg(101071053)
				local var_203_13 = arg_200_1:FormatText(var_203_12.content)

				arg_200_1.text_.text = var_203_13

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_15 = 2 <= 0 and var_203_11 or var_203_11 * (utf8.len(var_203_13) / 2)

				if (2 <= 0 and var_203_11 or var_203_11 * (utf8.len(var_203_13) / 2)) > 0 and var_203_11 < var_203_15 then
					arg_200_1.talkMaxDuration = var_203_15

					if var_203_15 + var_203_10 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_15 + var_203_10
					end
				end

				arg_200_1.text_.text = var_203_13
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071053", "story_v_out_101071.awb") ~= 0 then
					local var_203_16 = manager.audio:GetVoiceLength("story_v_out_101071", "101071053", "story_v_out_101071.awb") / 1000

					if var_203_16 + var_203_10 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_16 + var_203_10
					end

					if var_203_12.prefab_name ~= "" and arg_200_1.actors_[var_203_12.prefab_name] ~= nil then
						local var_203_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_12.prefab_name].transform, "story_v_out_101071", "101071053", "story_v_out_101071.awb")

						arg_200_1:RecordAudio("101071053", var_203_17)
						arg_200_1:RecordAudio("101071053", var_203_17)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_101071", "101071053", "story_v_out_101071.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_101071", "101071053", "story_v_out_101071.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_18 = math.max(var_203_11, arg_200_1.talkMaxDuration)

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_18 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_10) / var_203_18

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_10 + var_203_18 and arg_200_1.time_ < var_203_10 + var_203_18 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play101071054 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 101071054
		arg_204_1.duration_ = 3.8

		local var_204_0 = {
			ja = 3.8,
			ko = 2.266,
			zh = 2.4,
			en = 2.3
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
				arg_204_0:Play101071055(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) and arg_204_1.var_.characterEffect1019ui_story == nil then
				arg_204_1.var_.characterEffect1019ui_story = arg_204_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.1

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) then
				if arg_204_1.var_.characterEffect1019ui_story and not isNil(arg_204_1.actors_["1019ui_story"]) then
					arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) and arg_204_1.var_.characterEffect1019ui_story then
				arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_207_2 = arg_204_1.actors_["1011ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1011ui_story == nil then
				arg_204_1.var_.characterEffect1011ui_story = var_207_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_3 = 0.1

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.characterEffect1011ui_story and not isNil(var_207_2) then
					arg_204_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_3)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1011ui_story then
				arg_204_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_207_4 = arg_204_1.actors_["1011ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1011ui_story = var_207_4.localPosition
			end

			local var_207_5 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_5 then
				var_207_4.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_204_1.time_ - 0) / var_207_5)
				var_207_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_4.position).x, (manager.ui.mainCamera.transform.position - var_207_4.position).y, (manager.ui.mainCamera.transform.position - var_207_4.position).z)
				var_207_4.localEulerAngles.z = 0
				var_207_4.localEulerAngles.x = 0
				var_207_4.localEulerAngles = var_207_4.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_5 and arg_204_1.time_ < 0 + var_207_5 + arg_207_0 then
				var_207_4.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_207_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_4.position).x, (manager.ui.mainCamera.transform.position - var_207_4.position).y, (manager.ui.mainCamera.transform.position - var_207_4.position).z)
				var_207_4.localEulerAngles.z = 0
				var_207_4.localEulerAngles.x = 0
				var_207_4.localEulerAngles = var_207_4.localEulerAngles
			end

			local var_207_6 = arg_204_1.actors_["1019ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1019ui_story = var_207_6.localPosition
			end

			local var_207_7 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				var_207_6.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_204_1.time_ - 0) / var_207_7)
				var_207_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_6.position).x, (manager.ui.mainCamera.transform.position - var_207_6.position).y, (manager.ui.mainCamera.transform.position - var_207_6.position).z)
				var_207_6.localEulerAngles.z = 0
				var_207_6.localEulerAngles.x = 0
				var_207_6.localEulerAngles = var_207_6.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				var_207_6.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_207_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_6.position).x, (manager.ui.mainCamera.transform.position - var_207_6.position).y, (manager.ui.mainCamera.transform.position - var_207_6.position).z)
				var_207_6.localEulerAngles.z = 0
				var_207_6.localEulerAngles.x = 0
				var_207_6.localEulerAngles = var_207_6.localEulerAngles
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_207_8 = arg_204_1.actors_["1084ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1084ui_story = var_207_8.localPosition
			end

			local var_207_9 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_9 then
				var_207_8.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_9)
				var_207_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_8.position).x, (manager.ui.mainCamera.transform.position - var_207_8.position).y, (manager.ui.mainCamera.transform.position - var_207_8.position).z)
				var_207_8.localEulerAngles.z = 0
				var_207_8.localEulerAngles.x = 0
				var_207_8.localEulerAngles = var_207_8.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_9 and arg_204_1.time_ < 0 + var_207_9 + arg_207_0 then
				var_207_8.localPosition = Vector3.New(0, 100, 0)
				var_207_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_8.position).x, (manager.ui.mainCamera.transform.position - var_207_8.position).y, (manager.ui.mainCamera.transform.position - var_207_8.position).z)
				var_207_8.localEulerAngles.z = 0
				var_207_8.localEulerAngles.x = 0
				var_207_8.localEulerAngles = var_207_8.localEulerAngles
			end

			local var_207_10 = 0
			local var_207_11 = 0.225

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_12 = arg_204_1:GetWordFromCfg(101071054)
				local var_207_13 = arg_204_1:FormatText(var_207_12.content)

				arg_204_1.text_.text = var_207_13

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_15 = 10 <= 0 and var_207_11 or var_207_11 * (utf8.len(var_207_13) / 10)

				if (10 <= 0 and var_207_11 or var_207_11 * (utf8.len(var_207_13) / 10)) > 0 and var_207_11 < var_207_15 then
					arg_204_1.talkMaxDuration = var_207_15

					if var_207_15 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_10
					end
				end

				arg_204_1.text_.text = var_207_13
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071054", "story_v_out_101071.awb") ~= 0 then
					local var_207_16 = manager.audio:GetVoiceLength("story_v_out_101071", "101071054", "story_v_out_101071.awb") / 1000

					if var_207_16 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_16 + var_207_10
					end

					if var_207_12.prefab_name ~= "" and arg_204_1.actors_[var_207_12.prefab_name] ~= nil then
						local var_207_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_12.prefab_name].transform, "story_v_out_101071", "101071054", "story_v_out_101071.awb")

						arg_204_1:RecordAudio("101071054", var_207_17)
						arg_204_1:RecordAudio("101071054", var_207_17)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_101071", "101071054", "story_v_out_101071.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_101071", "101071054", "story_v_out_101071.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_18 = math.max(var_207_11, arg_204_1.talkMaxDuration)

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_18 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_10) / var_207_18

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_10 + var_207_18 and arg_204_1.time_ < var_207_10 + var_207_18 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play101071055 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 101071055
		arg_208_1.duration_ = 6.97

		local var_208_0 = {
			ja = 6.966,
			ko = 4.6,
			zh = 4.6,
			en = 4.633
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
				arg_208_0:Play101071056(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1011ui_story"]) and arg_208_1.var_.characterEffect1011ui_story == nil then
				arg_208_1.var_.characterEffect1011ui_story = arg_208_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.1

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1011ui_story"]) then
				if arg_208_1.var_.characterEffect1011ui_story and not isNil(arg_208_1.actors_["1011ui_story"]) then
					arg_208_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1011ui_story"]) and arg_208_1.var_.characterEffect1011ui_story then
				arg_208_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_211_2 = arg_208_1.actors_["1019ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect1019ui_story == nil then
				arg_208_1.var_.characterEffect1019ui_story = var_211_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_3 = 0.1

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.characterEffect1019ui_story and not isNil(var_211_2) then
					arg_208_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_3)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect1019ui_story then
				arg_208_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_211_4 = 0
			local var_211_5 = 0.375

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_6 = arg_208_1:GetWordFromCfg(101071055)
				local var_211_7 = arg_208_1:FormatText(var_211_6.content)

				arg_208_1.text_.text = var_211_7

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_9 = 15 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 15)

				if (15 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 15)) > 0 and var_211_5 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_7
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071055", "story_v_out_101071.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071055", "story_v_out_101071.awb") / 1000

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end

					if var_211_6.prefab_name ~= "" and arg_208_1.actors_[var_211_6.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_6.prefab_name].transform, "story_v_out_101071", "101071055", "story_v_out_101071.awb")

						arg_208_1:RecordAudio("101071055", var_211_11)
						arg_208_1:RecordAudio("101071055", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_101071", "101071055", "story_v_out_101071.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_101071", "101071055", "story_v_out_101071.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_4) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_4 + var_211_12 and arg_208_1.time_ < var_211_4 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play101071056 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 101071056
		arg_212_1.duration_ = 6.93

		local var_212_0 = {
			ja = 6.933,
			ko = 4,
			zh = 5.533,
			en = 5.233
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
				arg_212_0:Play101071057(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1019ui_story"]) and arg_212_1.var_.characterEffect1019ui_story == nil then
				arg_212_1.var_.characterEffect1019ui_story = arg_212_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.1

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1019ui_story"]) then
				if arg_212_1.var_.characterEffect1019ui_story and not isNil(arg_212_1.actors_["1019ui_story"]) then
					arg_212_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1019ui_story"]) and arg_212_1.var_.characterEffect1019ui_story then
				arg_212_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_215_2 = arg_212_1.actors_["1011ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1011ui_story == nil then
				arg_212_1.var_.characterEffect1011ui_story = var_215_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_3 = 0.1

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.characterEffect1011ui_story and not isNil(var_215_2) then
					arg_212_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_3)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1011ui_story then
				arg_212_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_215_4 = 0
			local var_215_5 = 0.7

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(101071056)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 28 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 28)

				if (28 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 28)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071056", "story_v_out_101071.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071056", "story_v_out_101071.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_out_101071", "101071056", "story_v_out_101071.awb")

						arg_212_1:RecordAudio("101071056", var_215_11)
						arg_212_1:RecordAudio("101071056", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_101071", "101071056", "story_v_out_101071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_101071", "101071056", "story_v_out_101071.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play101071057 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 101071057
		arg_216_1.duration_ = 4.3

		local var_216_0 = {
			ja = 3.566,
			ko = 4.066,
			zh = 4.3,
			en = 3.2
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
				arg_216_0:Play101071058(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_219_0 = 0
			local var_219_1 = 0.55

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_2 = arg_216_1:GetWordFromCfg(101071057)
				local var_219_3 = arg_216_1:FormatText(var_219_2.content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 22 <= 0 and var_219_1 or var_219_1 * (utf8.len(var_219_3) / 22)

				if (22 <= 0 and var_219_1 or var_219_1 * (utf8.len(var_219_3) / 22)) > 0 and var_219_1 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071057", "story_v_out_101071.awb") ~= 0 then
					local var_219_6 = manager.audio:GetVoiceLength("story_v_out_101071", "101071057", "story_v_out_101071.awb") / 1000

					if var_219_6 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_0
					end

					if var_219_2.prefab_name ~= "" and arg_216_1.actors_[var_219_2.prefab_name] ~= nil then
						local var_219_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_2.prefab_name].transform, "story_v_out_101071", "101071057", "story_v_out_101071.awb")

						arg_216_1:RecordAudio("101071057", var_219_7)
						arg_216_1:RecordAudio("101071057", var_219_7)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_101071", "101071057", "story_v_out_101071.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_101071", "101071057", "story_v_out_101071.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_8 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_8 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_8

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_8 and arg_216_1.time_ < var_219_0 + var_219_8 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play101071058 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 101071058
		arg_220_1.duration_ = 8.8

		local var_220_0 = {
			ja = 7,
			ko = 8.3,
			zh = 8.233,
			en = 8.8
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
				arg_220_0:Play101071059(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1011ui_story"]) and arg_220_1.var_.characterEffect1011ui_story == nil then
				arg_220_1.var_.characterEffect1011ui_story = arg_220_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.1

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1011ui_story"]) then
				if arg_220_1.var_.characterEffect1011ui_story and not isNil(arg_220_1.actors_["1011ui_story"]) then
					arg_220_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1011ui_story"]) and arg_220_1.var_.characterEffect1011ui_story then
				arg_220_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_223_2 = arg_220_1.actors_["1019ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect1019ui_story == nil then
				arg_220_1.var_.characterEffect1019ui_story = var_223_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_3 = 0.1

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.characterEffect1019ui_story and not isNil(var_223_2) then
					arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_3)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect1019ui_story then
				arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_223_4 = 0
			local var_223_5 = 0.875

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(101071058)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 35 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 35)

				if (35 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 35)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071058", "story_v_out_101071.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071058", "story_v_out_101071.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_101071", "101071058", "story_v_out_101071.awb")

						arg_220_1:RecordAudio("101071058", var_223_11)
						arg_220_1:RecordAudio("101071058", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_101071", "101071058", "story_v_out_101071.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_101071", "101071058", "story_v_out_101071.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play101071059 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 101071059
		arg_224_1.duration_ = 7.93

		local var_224_0 = {
			ja = 7.933,
			ko = 3.733,
			zh = 4.166,
			en = 3.5
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
			arg_224_1.auto_ = false
		end

		function arg_224_1.playNext_(arg_226_0)
			arg_224_1.onStoryFinished_()
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1019ui_story"]) and arg_224_1.var_.characterEffect1019ui_story == nil then
				arg_224_1.var_.characterEffect1019ui_story = arg_224_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.1

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1019ui_story"]) then
				if arg_224_1.var_.characterEffect1019ui_story and not isNil(arg_224_1.actors_["1019ui_story"]) then
					arg_224_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1019ui_story"]) and arg_224_1.var_.characterEffect1019ui_story then
				arg_224_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_227_2 = arg_224_1.actors_["1011ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect1011ui_story == nil then
				arg_224_1.var_.characterEffect1011ui_story = var_227_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_3 = 0.1

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.characterEffect1011ui_story and not isNil(var_227_2) then
					arg_224_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_3)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect1011ui_story then
				arg_224_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_227_4 = 0
			local var_227_5 = 0.4

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(101071059)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 16 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 16)

				if (16 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 16)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071059", "story_v_out_101071.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071059", "story_v_out_101071.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_101071", "101071059", "story_v_out_101071.awb")

						arg_224_1:RecordAudio("101071059", var_227_11)
						arg_224_1:RecordAudio("101071059", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_101071", "101071059", "story_v_out_101071.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_101071", "101071059", "story_v_out_101071.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play101071034 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 101071034
		arg_228_1.duration_ = 8.4

		local var_228_0 = {
			ja = 8.4,
			ko = 5.466,
			zh = 4.633,
			en = 5.2
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play101071035(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1019ui_story"]) and arg_228_1.var_.characterEffect1019ui_story == nil then
				arg_228_1.var_.characterEffect1019ui_story = arg_228_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.1

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1019ui_story"]) then
				if arg_228_1.var_.characterEffect1019ui_story and not isNil(arg_228_1.actors_["1019ui_story"]) then
					arg_228_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1019ui_story"]) and arg_228_1.var_.characterEffect1019ui_story then
				arg_228_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["1011ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1011ui_story == nil then
				arg_228_1.var_.characterEffect1011ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.1

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1011ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1011ui_story then
				arg_228_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_231_4 = "1019ui_story"

			if arg_228_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_231_5 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_228_1.stage_.transform)

				var_231_5.name = var_231_4
				var_231_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.actors_[var_231_4] = var_231_5

				local var_231_6 = var_231_5:GetComponentInChildren(typeof(CharacterEffect))

				var_231_6.enabled = true

				local var_231_7 = GameObjectTools.GetOrAddComponent(var_231_5, typeof(DynamicBoneHelper))

				if var_231_7 then
					var_231_7:EnableDynamicBone(false)
				end

				arg_228_1:ShowWeapon(var_231_6.transform, false)

				arg_228_1.var_[var_231_4 .. "Animator"] = var_231_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_228_1.var_[var_231_4 .. "Animator"].applyRootMotion = true
				arg_228_1.var_[var_231_4 .. "LipSync"] = var_231_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_231_8 = 0
			local var_231_9 = 0.675

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_10 = arg_228_1:GetWordFromCfg(101071034)
				local var_231_11 = arg_228_1:FormatText(var_231_10.content)

				arg_228_1.text_.text = var_231_11

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 26 <= 0 and var_231_9 or var_231_9 * (utf8.len(var_231_11) / 26)

				if (26 <= 0 and var_231_9 or var_231_9 * (utf8.len(var_231_11) / 26)) > 0 and var_231_9 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_8
					end
				end

				arg_228_1.text_.text = var_231_11
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071034", "story_v_out_101071.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071034", "story_v_out_101071.awb") / 1000

					if var_231_14 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_8
					end

					if var_231_10.prefab_name ~= "" and arg_228_1.actors_[var_231_10.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_10.prefab_name].transform, "story_v_out_101071", "101071034", "story_v_out_101071.awb")

						arg_228_1:RecordAudio("101071034", var_231_15)
						arg_228_1:RecordAudio("101071034", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_101071", "101071034", "story_v_out_101071.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_101071", "101071034", "story_v_out_101071.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_9, arg_228_1.talkMaxDuration)

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_8) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_8 + var_231_16 and arg_228_1.time_ < var_231_8 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play101071018 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 101071018
		arg_232_1.duration_ = 9.03

		local var_232_0 = {
			ja = 9.033,
			ko = 6.8,
			zh = 5.833,
			en = 5.3
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
				arg_232_0:Play101071019(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1084ui_story"]) and arg_232_1.var_.characterEffect1084ui_story == nil then
				arg_232_1.var_.characterEffect1084ui_story = arg_232_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.1

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1084ui_story"]) then
				if arg_232_1.var_.characterEffect1084ui_story and not isNil(arg_232_1.actors_["1084ui_story"]) then
					arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1084ui_story"]) and arg_232_1.var_.characterEffect1084ui_story then
				arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_235_2 = arg_232_1.actors_["1019ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1019ui_story = var_235_2.localPosition
			end

			local var_235_3 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_3 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_232_1.time_ - 0) / var_235_3)
				var_235_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_2.position).x, (manager.ui.mainCamera.transform.position - var_235_2.position).y, (manager.ui.mainCamera.transform.position - var_235_2.position).z)
				var_235_2.localEulerAngles.z = 0
				var_235_2.localEulerAngles.x = 0
				var_235_2.localEulerAngles = var_235_2.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_3 and arg_232_1.time_ < 0 + var_235_3 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_235_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_2.position).x, (manager.ui.mainCamera.transform.position - var_235_2.position).y, (manager.ui.mainCamera.transform.position - var_235_2.position).z)
				var_235_2.localEulerAngles.z = 0
				var_235_2.localEulerAngles.x = 0
				var_235_2.localEulerAngles = var_235_2.localEulerAngles
			end

			local var_235_4 = arg_232_1.actors_["1084ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = var_235_4.localPosition
			end

			local var_235_5 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_5 then
				var_235_4.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_232_1.time_ - 0) / var_235_5)
				var_235_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_4.position).x, (manager.ui.mainCamera.transform.position - var_235_4.position).y, (manager.ui.mainCamera.transform.position - var_235_4.position).z)
				var_235_4.localEulerAngles.z = 0
				var_235_4.localEulerAngles.x = 0
				var_235_4.localEulerAngles = var_235_4.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_5 and arg_232_1.time_ < 0 + var_235_5 + arg_235_0 then
				var_235_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_235_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_4.position).x, (manager.ui.mainCamera.transform.position - var_235_4.position).y, (manager.ui.mainCamera.transform.position - var_235_4.position).z)
				var_235_4.localEulerAngles.z = 0
				var_235_4.localEulerAngles.x = 0
				var_235_4.localEulerAngles = var_235_4.localEulerAngles
			end

			local var_235_6 = "1084ui_story"

			if arg_232_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_235_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_232_1.stage_.transform)

				var_235_7.name = var_235_6
				var_235_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_6] = var_235_7

				local var_235_8 = var_235_7:GetComponentInChildren(typeof(CharacterEffect))

				var_235_8.enabled = true

				local var_235_9 = GameObjectTools.GetOrAddComponent(var_235_7, typeof(DynamicBoneHelper))

				if var_235_9 then
					var_235_9:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_8.transform, false)

				arg_232_1.var_[var_235_6 .. "Animator"] = var_235_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_6 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_6 .. "LipSync"] = var_235_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action485")
			end

			local var_235_10 = "1084ui_story"

			if arg_232_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_235_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_232_1.stage_.transform)

				var_235_11.name = var_235_10
				var_235_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_10] = var_235_11

				local var_235_12 = var_235_11:GetComponentInChildren(typeof(CharacterEffect))

				var_235_12.enabled = true

				local var_235_13 = GameObjectTools.GetOrAddComponent(var_235_11, typeof(DynamicBoneHelper))

				if var_235_13 then
					var_235_13:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_12.transform, false)

				arg_232_1.var_[var_235_10 .. "Animator"] = var_235_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_10 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_10 .. "LipSync"] = var_235_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_235_14 = 0
			local var_235_15 = 0.7

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_16 = arg_232_1:GetWordFromCfg(101071018)
				local var_235_17 = arg_232_1:FormatText(var_235_16.content)

				arg_232_1.text_.text = var_235_17

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_19 = 28 <= 0 and var_235_15 or var_235_15 * (utf8.len(var_235_17) / 28)

				if (28 <= 0 and var_235_15 or var_235_15 * (utf8.len(var_235_17) / 28)) > 0 and var_235_15 < var_235_19 then
					arg_232_1.talkMaxDuration = var_235_19

					if var_235_19 + var_235_14 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_19 + var_235_14
					end
				end

				arg_232_1.text_.text = var_235_17
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071018", "story_v_out_101071.awb") ~= 0 then
					local var_235_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071018", "story_v_out_101071.awb") / 1000

					if var_235_20 + var_235_14 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_20 + var_235_14
					end

					if var_235_16.prefab_name ~= "" and arg_232_1.actors_[var_235_16.prefab_name] ~= nil then
						local var_235_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_16.prefab_name].transform, "story_v_out_101071", "101071018", "story_v_out_101071.awb")

						arg_232_1:RecordAudio("101071018", var_235_21)
						arg_232_1:RecordAudio("101071018", var_235_21)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_101071", "101071018", "story_v_out_101071.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_101071", "101071018", "story_v_out_101071.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_22 = math.max(var_235_15, arg_232_1.talkMaxDuration)

			if var_235_14 <= arg_232_1.time_ and arg_232_1.time_ < var_235_14 + var_235_22 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_14) / var_235_22

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_14 + var_235_22 and arg_232_1.time_ < var_235_14 + var_235_22 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play101071019 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 101071019
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play101071021(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["1084ui_story"]) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = arg_236_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_0 = 0.1

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["1084ui_story"]) then
				if arg_236_1.var_.characterEffect1084ui_story and not isNil(arg_236_1.actors_["1084ui_story"]) then
					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_0)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["1084ui_story"]) and arg_236_1.var_.characterEffect1084ui_story then
				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_239_1 = 0
			local var_239_2 = 0.4

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(101071019).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 16 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 16)

				if (16 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 16)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/S0101"
	},
	voices = {
		"story_v_out_101071.awb"
	}
}
