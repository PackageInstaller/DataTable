return {
	Play107011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play107011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A00 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_4_0.name = "A00"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A00 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueA00 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueA00 = var_4_4
				end

				arg_1_1.var_.alphaOldValueA00 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueA00 then
					arg_1_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA00, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueA00.color = arg_1_1.var_.alphaMatValueA00.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueA00 then
				arg_1_1.var_.alphaMatValueA00.color.a = 1
				arg_1_1.var_.alphaMatValueA00.color = arg_1_1.var_.alphaMatValueA00.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 1.5 and arg_1_1.time_ < var_4_9 + 1.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(107011001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 8 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 8)

				if (8 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 8)) > 0 and var_4_11 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_10 = var_4_10 + 0.3

					if var_4_15 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = var_4_10 + 0.3
			local var_4_17 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_17

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play107011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107011002
		arg_8_1.duration_ = 3.1

		local var_8_0 = {
			ja = 3.1,
			ko = 1.999999999999,
			zh = 2.466,
			en = 2.766
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
				arg_8_0:Play107011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1019ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1019ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1019ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1019ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1019ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_11_8 = 0
			local var_11_9 = 0.325

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(107011002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 13 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 13)

				if (13 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 13)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011002", "story_v_out_107011.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_107011", "107011002", "story_v_out_107011.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_107011", "107011002", "story_v_out_107011.awb")

						arg_8_1:RecordAudio("107011002", var_11_15)
						arg_8_1:RecordAudio("107011002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107011", "107011002", "story_v_out_107011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107011", "107011002", "story_v_out_107011.awb")
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
				actorName = "1019ui_story",
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
	Play107011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play107011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1019ui_story"]) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = arg_12_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1019ui_story"]) then
				if arg_12_1.var_.characterEffect1019ui_story and not isNil(arg_12_1.actors_["1019ui_story"]) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1019ui_story"]) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.65

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(107011003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 26 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 26)

				if (26 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 26)) > 0 and var_15_2 < var_15_5 then
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
	Play107011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 107011004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play107011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.725

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(107011004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 29 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 29)

				if (29 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 29)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play107011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 107011005
		arg_20_1.duration_ = 3.77

		local var_20_0 = {
			ja = 2.433,
			ko = 2.366,
			zh = 3.766,
			en = 3.066
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
				arg_20_0:Play107011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = arg_20_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(arg_20_1.actors_["1019ui_story"]) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_2 = 0
			local var_23_3 = 0.3

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(107011005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 12 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 12)

				if (12 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 12)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011005", "story_v_out_107011.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_107011", "107011005", "story_v_out_107011.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_107011", "107011005", "story_v_out_107011.awb")

						arg_20_1:RecordAudio("107011005", var_23_9)
						arg_20_1:RecordAudio("107011005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_107011", "107011005", "story_v_out_107011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_107011", "107011005", "story_v_out_107011.awb")
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
	Play107011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 107011006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play107011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = arg_24_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(arg_24_1.actors_["1019ui_story"]) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.8

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(107011006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 33 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 33)

				if (33 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 33)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play107011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 107011007
		arg_28_1.duration_ = 6.3

		local var_28_0 = {
			ja = 5.933,
			ko = 5.633,
			zh = 5.466,
			en = 6.3
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
				arg_28_0:Play107011008(arg_28_1)
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

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_2 = 0
			local var_31_3 = 0.775

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
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

				local var_31_4 = arg_28_1:GetWordFromCfg(107011007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 27 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 27)

				if (27 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 27)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011007", "story_v_out_107011.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_107011", "107011007", "story_v_out_107011.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_107011", "107011007", "story_v_out_107011.awb")

						arg_28_1:RecordAudio("107011007", var_31_9)
						arg_28_1:RecordAudio("107011007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_107011", "107011007", "story_v_out_107011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_107011", "107011007", "story_v_out_107011.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play107011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 107011008
		arg_32_1.duration_ = 13.1

		local var_32_0 = {
			ja = 13.1,
			ko = 12.5,
			zh = 13,
			en = 11.4
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
				arg_32_0:Play107011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_35_0 = 0
			local var_35_1 = 1.25

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(107011008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 50 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 50)

				if (50 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 50)) > 0 and var_35_1 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011008", "story_v_out_107011.awb") ~= 0 then
					local var_35_6 = manager.audio:GetVoiceLength("story_v_out_107011", "107011008", "story_v_out_107011.awb") / 1000

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end

					if var_35_2.prefab_name ~= "" and arg_32_1.actors_[var_35_2.prefab_name] ~= nil then
						local var_35_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_2.prefab_name].transform, "story_v_out_107011", "107011008", "story_v_out_107011.awb")

						arg_32_1:RecordAudio("107011008", var_35_7)
						arg_32_1:RecordAudio("107011008", var_35_7)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_107011", "107011008", "story_v_out_107011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_107011", "107011008", "story_v_out_107011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_8 and arg_32_1.time_ < var_35_0 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play107011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 107011009
		arg_36_1.duration_ = 0.1

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"

			SetActive(arg_36_1.choicesGo_, true)

			for iter_37_0, iter_37_1 in ipairs(arg_36_1.choices_) do
				SetActive(iter_37_1.go, iter_37_0 <= 1)
			end

			arg_36_1.choices_[1].txt.text = arg_36_1:FormatText(StoryChoiceCfg[36].name)
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play107011010(arg_36_1)
			end

			arg_36_1:RecordChoiceLog(107011009, 36)
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = arg_36_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) then
				if arg_36_1.var_.characterEffect1019ui_story and not isNil(arg_36_1.actors_["1019ui_story"]) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play107011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 107011010
		arg_40_1.duration_ = 6.87

		local var_40_0 = {
			ja = 6.8,
			ko = 5.3,
			zh = 6.866,
			en = 5.766
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
				arg_40_0:Play107011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = arg_40_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) then
				if arg_40_1.var_.characterEffect1019ui_story and not isNil(arg_40_1.actors_["1019ui_story"]) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_2 = 0
			local var_43_3 = 0.725

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(107011010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 29 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 29)

				if (29 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 29)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011010", "story_v_out_107011.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_107011", "107011010", "story_v_out_107011.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_107011", "107011010", "story_v_out_107011.awb")

						arg_40_1:RecordAudio("107011010", var_43_9)
						arg_40_1:RecordAudio("107011010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_107011", "107011010", "story_v_out_107011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_107011", "107011010", "story_v_out_107011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play107011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 107011011
		arg_44_1.duration_ = 4.37

		local var_44_0 = {
			ja = 2.966,
			ko = 4.366,
			zh = 3.1,
			en = 3.133
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
				arg_44_0:Play107011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_47_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_44_1.stage_.transform)

				var_47_0.name = "1084ui_story"
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1084ui_story"] = var_47_0

				local var_47_1 = var_47_0:GetComponentInChildren(typeof(CharacterEffect))

				var_47_1.enabled = true

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_1.transform, false)

				arg_44_1.var_["1084ui_story" .. "Animator"] = var_47_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_44_1.var_["1084ui_story" .. "LipSync"] = var_47_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_3 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_6 = arg_44_1.actors_["1019ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 and not isNil(var_47_6) then
				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_6) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_7)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_47_8 = arg_44_1.actors_["1019ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_8.localPosition
			end

			local var_47_9 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_9 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_44_1.time_ - 0) / var_47_9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_9 and arg_44_1.time_ < 0 + var_47_9 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			local var_47_10 = arg_44_1.actors_["1019ui_story"].transform

			if 0.033 < arg_44_1.time_ and arg_44_1.time_ <= 0.033 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_10.localPosition
			end

			local var_47_11 = 0.5

			if 0.033 <= arg_44_1.time_ and arg_44_1.time_ < 0.033 + var_47_11 then
				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_44_1.time_ - 0.033) / var_47_11)
				var_47_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_10.position).x, (manager.ui.mainCamera.transform.position - var_47_10.position).y, (manager.ui.mainCamera.transform.position - var_47_10.position).z)
				var_47_10.localEulerAngles.z = 0
				var_47_10.localEulerAngles.x = 0
				var_47_10.localEulerAngles = var_47_10.localEulerAngles
			end

			if arg_44_1.time_ >= 0.033 + var_47_11 and arg_44_1.time_ < 0.033 + var_47_11 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_47_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_10.position).x, (manager.ui.mainCamera.transform.position - var_47_10.position).y, (manager.ui.mainCamera.transform.position - var_47_10.position).z)
				var_47_10.localEulerAngles.z = 0
				var_47_10.localEulerAngles.x = 0
				var_47_10.localEulerAngles = var_47_10.localEulerAngles
			end

			local var_47_12 = arg_44_1.actors_["1084ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_12.localPosition
			end

			local var_47_13 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_13 then
				var_47_12.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_44_1.time_ - 0) / var_47_13)
				var_47_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_12.position).x, (manager.ui.mainCamera.transform.position - var_47_12.position).y, (manager.ui.mainCamera.transform.position - var_47_12.position).z)
				var_47_12.localEulerAngles.z = 0
				var_47_12.localEulerAngles.x = 0
				var_47_12.localEulerAngles = var_47_12.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_13 and arg_44_1.time_ < 0 + var_47_13 + arg_47_0 then
				var_47_12.localPosition = Vector3.New(0.7, -0.97, -6)
				var_47_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_12.position).x, (manager.ui.mainCamera.transform.position - var_47_12.position).y, (manager.ui.mainCamera.transform.position - var_47_12.position).z)
				var_47_12.localEulerAngles.z = 0
				var_47_12.localEulerAngles.x = 0
				var_47_12.localEulerAngles = var_47_12.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_14 = 0
			local var_47_15 = 0.425

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_16 = arg_44_1:GetWordFromCfg(107011011)
				local var_47_17 = arg_44_1:FormatText(var_47_16.content)

				arg_44_1.text_.text = var_47_17

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_19 = 17 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_17) / 17)

				if (17 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_17) / 17)) > 0 and var_47_15 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_14
					end
				end

				arg_44_1.text_.text = var_47_17
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011011", "story_v_out_107011.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_107011", "107011011", "story_v_out_107011.awb") / 1000

					if var_47_20 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_14
					end

					if var_47_16.prefab_name ~= "" and arg_44_1.actors_[var_47_16.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_16.prefab_name].transform, "story_v_out_107011", "107011011", "story_v_out_107011.awb")

						arg_44_1:RecordAudio("107011011", var_47_21)
						arg_44_1:RecordAudio("107011011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_107011", "107011011", "story_v_out_107011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_107011", "107011011", "story_v_out_107011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_15, arg_44_1.talkMaxDuration)

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_14) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_14 + var_47_22 and arg_44_1.time_ < var_47_14 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
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

		arg_44_1:InitPlayNodeList()
	end,
	Play107011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 107011012
		arg_48_1.duration_ = 2.83

		local var_48_0 = {
			ja = 2.833,
			ko = 2.8,
			zh = 2.833,
			en = 2.733
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
				arg_48_0:Play107011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1019ui_story"]) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = arg_48_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1019ui_story"]) then
				if arg_48_1.var_.characterEffect1019ui_story and not isNil(arg_48_1.actors_["1019ui_story"]) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1019ui_story"]) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_51_4 = 0
			local var_51_5 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(107011012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 15 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 15)

				if (15 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 15)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011012", "story_v_out_107011.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011012", "story_v_out_107011.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_107011", "107011012", "story_v_out_107011.awb")

						arg_48_1:RecordAudio("107011012", var_51_11)
						arg_48_1:RecordAudio("107011012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_107011", "107011012", "story_v_out_107011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_107011", "107011012", "story_v_out_107011.awb")
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
	Play107011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107011013
		arg_52_1.duration_ = 0.1

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"

			SetActive(arg_52_1.choicesGo_, true)

			for iter_53_0, iter_53_1 in ipairs(arg_52_1.choices_) do
				SetActive(iter_53_1.go, iter_53_0 <= 1)
			end

			arg_52_1.choices_[1].txt.text = arg_52_1:FormatText(StoryChoiceCfg[37].name)
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play107011014(arg_52_1)
			end

			arg_52_1:RecordChoiceLog(107011013, 37)
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = arg_52_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) then
				if arg_52_1.var_.characterEffect1019ui_story and not isNil(arg_52_1.actors_["1019ui_story"]) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play107011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107011014
		arg_56_1.duration_ = 7

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play107011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1.var_.moveOldPosA00 = arg_56_1.bgs_.A00.transform.localPosition
			end

			local var_59_0 = 0.001

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_0 then
				arg_56_1.bgs_.A00.transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosA00, Vector3.New(0, -100, 10), (arg_56_1.time_ - 1.5) / var_59_0)
			end

			if arg_56_1.time_ >= 1.5 + var_59_0 and arg_56_1.time_ < 1.5 + var_59_0 + arg_59_0 then
				arg_56_1.bgs_.A00.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_59_1 = "B13"

			if arg_56_1.bgs_.B13 == nil then
				local var_59_2 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_59_1)
				var_59_2.name = var_59_1
				var_59_2.transform.parent = arg_56_1.stage_.transform
				var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_[var_59_1] = var_59_2
			end

			if 1.4 < arg_56_1.time_ and arg_56_1.time_ <= 1.4 + arg_59_0 then
				local var_59_3 = arg_56_1.bgs_.B13

				arg_56_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_4 = var_59_3:GetComponent("SpriteRenderer")

				if var_59_4 and var_59_4.sprite then
					local var_59_5 = 2 * (var_59_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_3.transform.localScale = Vector3.New(var_59_5 / var_59_4.sprite.bounds.size.y < var_59_5 * manager.ui.mainCameraCom_.aspect / var_59_4.sprite.bounds.size.x and var_59_5 * manager.ui.mainCameraCom_.aspect / var_59_4.sprite.bounds.size.x or var_59_5 / var_59_4.sprite.bounds.size.y, var_59_5 / var_59_4.sprite.bounds.size.y < var_59_5 * manager.ui.mainCameraCom_.aspect / var_59_4.sprite.bounds.size.x and var_59_5 * manager.ui.mainCameraCom_.aspect / var_59_4.sprite.bounds.size.x or var_59_5 / var_59_4.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "B13" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_6 = arg_56_1.actors_["1084ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_6.localPosition
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_7)
				var_59_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_6.position).x, (manager.ui.mainCamera.transform.position - var_59_6.position).y, (manager.ui.mainCamera.transform.position - var_59_6.position).z)
				var_59_6.localEulerAngles.z = 0
				var_59_6.localEulerAngles.x = 0
				var_59_6.localEulerAngles = var_59_6.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)
				var_59_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_6.position).x, (manager.ui.mainCamera.transform.position - var_59_6.position).y, (manager.ui.mainCamera.transform.position - var_59_6.position).z)
				var_59_6.localEulerAngles.z = 0
				var_59_6.localEulerAngles.x = 0
				var_59_6.localEulerAngles = var_59_6.localEulerAngles
			end

			local var_59_8 = arg_56_1.actors_["1019ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_8.localPosition
			end

			local var_59_9 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_9 then
				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_9)
				var_59_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_8.position).x, (manager.ui.mainCamera.transform.position - var_59_8.position).y, (manager.ui.mainCamera.transform.position - var_59_8.position).z)
				var_59_8.localEulerAngles.z = 0
				var_59_8.localEulerAngles.x = 0
				var_59_8.localEulerAngles = var_59_8.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_9 and arg_56_1.time_ < 0 + var_59_9 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(0, 100, 0)
				var_59_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_8.position).x, (manager.ui.mainCamera.transform.position - var_59_8.position).y, (manager.ui.mainCamera.transform.position - var_59_8.position).z)
				var_59_8.localEulerAngles.z = 0
				var_59_8.localEulerAngles.x = 0
				var_59_8.localEulerAngles = var_59_8.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_10 = arg_56_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_59_10 then
					arg_56_1.var_.alphaOldValueA00 = var_59_10.color.a
					arg_56_1.var_.alphaMatValueA00 = var_59_10
				end

				arg_56_1.var_.alphaOldValueA00 = 1
			end

			local var_59_11 = 1.5

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_11 then
				if arg_56_1.var_.alphaMatValueA00 then
					arg_56_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueA00, 0, (arg_56_1.time_ - 0) / var_59_11)
					arg_56_1.var_.alphaMatValueA00.color = arg_56_1.var_.alphaMatValueA00.color
				end
			end

			if arg_56_1.time_ >= 0 + var_59_11 and arg_56_1.time_ < 0 + var_59_11 + arg_59_0 and arg_56_1.var_.alphaMatValueA00 then
				arg_56_1.var_.alphaMatValueA00.color.a = 0
				arg_56_1.var_.alphaMatValueA00.color = arg_56_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_12 = arg_56_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_59_12 then
					arg_56_1.var_.alphaOldValueB13 = var_59_12.color.a
					arg_56_1.var_.alphaMatValueB13 = var_59_12
				end

				arg_56_1.var_.alphaOldValueB13 = 0
			end

			local var_59_13 = 1.5

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_13 then
				if arg_56_1.var_.alphaMatValueB13 then
					arg_56_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueB13, 1, (arg_56_1.time_ - 1.5) / var_59_13)
					arg_56_1.var_.alphaMatValueB13.color = arg_56_1.var_.alphaMatValueB13.color
				end
			end

			if arg_56_1.time_ >= 1.5 + var_59_13 and arg_56_1.time_ < 1.5 + var_59_13 + arg_59_0 and arg_56_1.var_.alphaMatValueB13 then
				arg_56_1.var_.alphaMatValueB13.color.a = 1
				arg_56_1.var_.alphaMatValueB13.color = arg_56_1.var_.alphaMatValueB13.color
			end

			local var_59_14 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_14 + 2 and arg_56_1.time_ < var_59_14 + 2 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_15 = 2
			local var_59_16 = 0.4

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_17 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_17:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(107011014).content)

				arg_56_1.text_.text = var_59_18

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 16 <= 0 and var_59_16 or var_59_16 * (utf8.len(var_59_18) / 16)

				if (16 <= 0 and var_59_16 or var_59_16 * (utf8.len(var_59_18) / 16)) > 0 and var_59_16 < var_59_20 then
					arg_56_1.talkMaxDuration = var_59_20
					var_59_15 = var_59_15 + 0.3

					if var_59_20 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_20 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_18
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_21 = var_59_15 + 0.3
			local var_59_22 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_21) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_21 + var_59_22 and arg_56_1.time_ < var_59_21 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A00",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
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

		arg_56_1:InitPlayNodeList()
	end,
	Play107011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 107011015
		arg_62_1.duration_ = 5.03

		local var_62_0 = {
			ja = 5.033,
			ko = 3.833,
			zh = 5.033,
			en = 4.433
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
				arg_62_0:Play107011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if arg_62_1.bgs_.S0701 == nil then
				local var_65_0 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0701")
				var_65_0.name = "S0701"
				var_65_0.transform.parent = arg_62_1.stage_.transform
				var_65_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_.S0701 = var_65_0
			end

			if 1 < arg_62_1.time_ and arg_62_1.time_ <= 1 + arg_65_0 then
				local var_65_1 = arg_62_1.bgs_.S0701

				arg_62_1.bgs_.S0701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_65_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_2 = var_65_1:GetComponent("SpriteRenderer")

				if var_65_2 and var_65_2.sprite then
					local var_65_3 = 2 * (var_65_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_65_1.transform.localScale = Vector3.New(var_65_3 / var_65_2.sprite.bounds.size.y < var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x and var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x or var_65_3 / var_65_2.sprite.bounds.size.y, var_65_3 / var_65_2.sprite.bounds.size.y < var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x and var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x or var_65_3 / var_65_2.sprite.bounds.size.y, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "S0701" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				local var_65_4 = arg_62_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_65_4 then
					arg_62_1.var_.alphaOldValueB13 = var_65_4.color.a
					arg_62_1.var_.alphaMatValueB13 = var_65_4
				end

				arg_62_1.var_.alphaOldValueB13 = 1
			end

			local var_65_5 = 1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 then
				if arg_62_1.var_.alphaMatValueB13 then
					arg_62_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_62_1.var_.alphaOldValueB13, 0, (arg_62_1.time_ - 0) / var_65_5)
					arg_62_1.var_.alphaMatValueB13.color = arg_62_1.var_.alphaMatValueB13.color
				end
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 and arg_62_1.var_.alphaMatValueB13 then
				arg_62_1.var_.alphaMatValueB13.color.a = 0
				arg_62_1.var_.alphaMatValueB13.color = arg_62_1.var_.alphaMatValueB13.color
			end

			if 1 < arg_62_1.time_ and arg_62_1.time_ <= 1 + arg_65_0 then
				local var_65_6 = arg_62_1.bgs_.S0701:GetComponent("SpriteRenderer")

				if var_65_6 then
					arg_62_1.var_.alphaOldValueS0701 = var_65_6.color.a
					arg_62_1.var_.alphaMatValueS0701 = var_65_6
				end

				arg_62_1.var_.alphaOldValueS0701 = 0
			end

			local var_65_7 = 1

			if 1 <= arg_62_1.time_ and arg_62_1.time_ < 1 + var_65_7 then
				if arg_62_1.var_.alphaMatValueS0701 then
					arg_62_1.var_.alphaMatValueS0701.color.a = Mathf.Lerp(arg_62_1.var_.alphaOldValueS0701, 1, (arg_62_1.time_ - 1) / var_65_7)
					arg_62_1.var_.alphaMatValueS0701.color = arg_62_1.var_.alphaMatValueS0701.color
				end
			end

			if arg_62_1.time_ >= 1 + var_65_7 and arg_62_1.time_ < 1 + var_65_7 + arg_65_0 and arg_62_1.var_.alphaMatValueS0701 then
				arg_62_1.var_.alphaMatValueS0701.color.a = 1
				arg_62_1.var_.alphaMatValueS0701.color = arg_62_1.var_.alphaMatValueS0701.color
			end

			local var_65_8 = arg_62_1.bgs_.B13.transform

			if 1 < arg_62_1.time_ and arg_62_1.time_ <= 1 + arg_65_0 then
				arg_62_1.var_.moveOldPosB13 = var_65_8.localPosition
			end

			local var_65_9 = 0.001

			if 1 <= arg_62_1.time_ and arg_62_1.time_ < 1 + var_65_9 then
				var_65_8.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPosB13, Vector3.New(0, 100, 0), (arg_62_1.time_ - 1) / var_65_9)
			end

			if arg_62_1.time_ >= 1 + var_65_9 and arg_62_1.time_ < 1 + var_65_9 + arg_65_0 then
				var_65_8.localPosition = Vector3.New(0, 100, 0)
			end

			local var_65_10 = 0

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1.allBtn_.enabled = false
			end

			if arg_62_1.time_ >= var_65_10 + 2 and arg_62_1.time_ < var_65_10 + 2 + arg_65_0 then
				arg_62_1.allBtn_.enabled = true
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_11 = 2
			local var_65_12 = 0.225

			if 2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_13 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_13:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_62_1.dialogCg_.alpha = arg_66_0
				end))
				var_65_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_14 = arg_62_1:GetWordFromCfg(107011015)
				local var_65_15 = arg_62_1:FormatText(var_65_14.content)

				arg_62_1.text_.text = var_65_15

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_17 = 9 <= 0 and var_65_12 or var_65_12 * (utf8.len(var_65_15) / 9)

				if (9 <= 0 and var_65_12 or var_65_12 * (utf8.len(var_65_15) / 9)) > 0 and var_65_12 < var_65_17 then
					arg_62_1.talkMaxDuration = var_65_17
					var_65_11 = var_65_11 + 0.3

					if var_65_17 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_17 + var_65_11
					end
				end

				arg_62_1.text_.text = var_65_15
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011015", "story_v_out_107011.awb") ~= 0 then
					local var_65_18 = manager.audio:GetVoiceLength("story_v_out_107011", "107011015", "story_v_out_107011.awb") / 1000

					if var_65_18 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_11
					end

					if var_65_14.prefab_name ~= "" and arg_62_1.actors_[var_65_14.prefab_name] ~= nil then
						local var_65_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_14.prefab_name].transform, "story_v_out_107011", "107011015", "story_v_out_107011.awb")

						arg_62_1:RecordAudio("107011015", var_65_19)
						arg_62_1:RecordAudio("107011015", var_65_19)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_107011", "107011015", "story_v_out_107011.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_107011", "107011015", "story_v_out_107011.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_20 = var_65_11 + 0.3
			local var_65_21 = math.max(var_65_12, arg_62_1.talkMaxDuration)

			if var_65_11 + 0.3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_21 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_20) / var_65_21

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_20 + var_65_21 and arg_62_1.time_ < var_65_20 + var_65_21 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play107011016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 107011016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play107011017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.125

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(107011016).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 45 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 45)

				if (45 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 45)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play107011017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 107011017
		arg_72_1.duration_ = 11.97

		local var_72_0 = {
			ja = 10.833,
			ko = 9.8,
			zh = 8.9,
			en = 11.966
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
				arg_72_0:Play107011018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_75_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_72_1.stage_.transform)

				var_75_0.name = "1038ui_story"
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1038ui_story"] = var_75_0

				local var_75_1 = var_75_0:GetComponentInChildren(typeof(CharacterEffect))

				var_75_1.enabled = true

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_1.transform, false)

				arg_72_1.var_["1038ui_story" .. "Animator"] = var_75_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_72_1.var_["1038ui_story" .. "LipSync"] = var_75_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_3 = arg_72_1.actors_["1038ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1038ui_story == nil then
				arg_72_1.var_.characterEffect1038ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect1038ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1038ui_story then
				arg_72_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_75_6 = 0
			local var_75_7 = 1

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(107011017)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 37 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 37)

				if (37 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 37)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011017", "story_v_out_107011.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_107011", "107011017", "story_v_out_107011.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_107011", "107011017", "story_v_out_107011.awb")

						arg_72_1:RecordAudio("107011017", var_75_13)
						arg_72_1:RecordAudio("107011017", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_107011", "107011017", "story_v_out_107011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_107011", "107011017", "story_v_out_107011.awb")
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

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play107011018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 107011018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play107011019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1038ui_story"]) and arg_76_1.var_.characterEffect1038ui_story == nil then
				arg_76_1.var_.characterEffect1038ui_story = arg_76_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1038ui_story"]) then
				if arg_76_1.var_.characterEffect1038ui_story and not isNil(arg_76_1.actors_["1038ui_story"]) then
					arg_76_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1038ui_story"]) and arg_76_1.var_.characterEffect1038ui_story then
				arg_76_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.1

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(107011018).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 4 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 4)

				if (4 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 4)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play107011019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 107011019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play107011020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.525

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(107011019).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 21 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 21)

				if (21 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 21)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play107011020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 107011020
		arg_84_1.duration_ = 6.53

		local var_84_0 = {
			ja = 2.933,
			ko = 4.066,
			zh = 4.2,
			en = 6.533
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
				arg_84_0:Play107011021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1019ui_story"]) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = arg_84_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1019ui_story"]) then
				if arg_84_1.var_.characterEffect1019ui_story and not isNil(arg_84_1.actors_["1019ui_story"]) then
					arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1019ui_story"]) and arg_84_1.var_.characterEffect1019ui_story then
				arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_2 = 0
			local var_87_3 = 0.5

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_4 = arg_84_1:GetWordFromCfg(107011020)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 20 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 20)

				if (20 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 20)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011020", "story_v_out_107011.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_107011", "107011020", "story_v_out_107011.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_107011", "107011020", "story_v_out_107011.awb")

						arg_84_1:RecordAudio("107011020", var_87_9)
						arg_84_1:RecordAudio("107011020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_107011", "107011020", "story_v_out_107011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_107011", "107011020", "story_v_out_107011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play107011021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 107011021
		arg_88_1.duration_ = 1.47

		local var_88_0 = {
			ja = 1.466,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.433
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
				arg_88_0:Play107011022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1038ui_story"]) and arg_88_1.var_.characterEffect1038ui_story == nil then
				arg_88_1.var_.characterEffect1038ui_story = arg_88_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1038ui_story"]) then
				if arg_88_1.var_.characterEffect1038ui_story and not isNil(arg_88_1.actors_["1038ui_story"]) then
					arg_88_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1038ui_story"]) and arg_88_1.var_.characterEffect1038ui_story then
				arg_88_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["1019ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_91_4 = 0
			local var_91_5 = 0.05

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(107011021)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 2 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 2)

				if (2 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 2)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011021", "story_v_out_107011.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011021", "story_v_out_107011.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_107011", "107011021", "story_v_out_107011.awb")

						arg_88_1:RecordAudio("107011021", var_91_11)
						arg_88_1:RecordAudio("107011021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_107011", "107011021", "story_v_out_107011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_107011", "107011021", "story_v_out_107011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play107011022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 107011022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play107011023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1038ui_story"]) and arg_92_1.var_.characterEffect1038ui_story == nil then
				arg_92_1.var_.characterEffect1038ui_story = arg_92_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1038ui_story"]) then
				if arg_92_1.var_.characterEffect1038ui_story and not isNil(arg_92_1.actors_["1038ui_story"]) then
					arg_92_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1038ui_story"]) and arg_92_1.var_.characterEffect1038ui_story then
				arg_92_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.725

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(107011022).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 29 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 29)

				if (29 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 29)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play107011023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 107011023
		arg_96_1.duration_ = 3.57

		local var_96_0 = {
			ja = 2.6,
			ko = 2.233,
			zh = 3.066,
			en = 3.566
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
				arg_96_0:Play107011024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1038ui_story"]) and arg_96_1.var_.characterEffect1038ui_story == nil then
				arg_96_1.var_.characterEffect1038ui_story = arg_96_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1038ui_story"]) then
				if arg_96_1.var_.characterEffect1038ui_story and not isNil(arg_96_1.actors_["1038ui_story"]) then
					arg_96_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1038ui_story"]) and arg_96_1.var_.characterEffect1038ui_story then
				arg_96_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_99_2 = 0
			local var_99_3 = 0.2

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(107011023)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 8 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 8)

				if (8 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 8)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011023", "story_v_out_107011.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_107011", "107011023", "story_v_out_107011.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_107011", "107011023", "story_v_out_107011.awb")

						arg_96_1:RecordAudio("107011023", var_99_9)
						arg_96_1:RecordAudio("107011023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_107011", "107011023", "story_v_out_107011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_107011", "107011023", "story_v_out_107011.awb")
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
	Play107011024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 107011024
		arg_100_1.duration_ = 3.4

		local var_100_0 = {
			ja = 3.4,
			ko = 1.933,
			zh = 2.233,
			en = 2.4
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
				arg_100_0:Play107011025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = arg_100_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) then
				if arg_100_1.var_.characterEffect1019ui_story and not isNil(arg_100_1.actors_["1019ui_story"]) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1038ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1038ui_story == nil then
				arg_100_1.var_.characterEffect1038ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect1038ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1038ui_story then
				arg_100_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_4 = 0
			local var_103_5 = 0.3

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_6 = arg_100_1:GetWordFromCfg(107011024)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 23 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 23)

				if (23 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 23)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011024", "story_v_out_107011.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011024", "story_v_out_107011.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_107011", "107011024", "story_v_out_107011.awb")

						arg_100_1:RecordAudio("107011024", var_103_11)
						arg_100_1:RecordAudio("107011024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_107011", "107011024", "story_v_out_107011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_107011", "107011024", "story_v_out_107011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play107011025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 107011025
		arg_104_1.duration_ = 11.67

		local var_104_0 = {
			ja = 11.666,
			ko = 7.533,
			zh = 6,
			en = 8.1
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play107011026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1038ui_story"]) and arg_104_1.var_.characterEffect1038ui_story == nil then
				arg_104_1.var_.characterEffect1038ui_story = arg_104_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1038ui_story"]) then
				if arg_104_1.var_.characterEffect1038ui_story and not isNil(arg_104_1.actors_["1038ui_story"]) then
					arg_104_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1038ui_story"]) and arg_104_1.var_.characterEffect1038ui_story then
				arg_104_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1019ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1019ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1019ui_story then
				arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_4 = 0
			local var_107_5 = 0.65

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(107011025)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 26 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 26)

				if (26 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 26)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011025", "story_v_out_107011.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011025", "story_v_out_107011.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_107011", "107011025", "story_v_out_107011.awb")

						arg_104_1:RecordAudio("107011025", var_107_11)
						arg_104_1:RecordAudio("107011025", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_107011", "107011025", "story_v_out_107011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_107011", "107011025", "story_v_out_107011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play107011026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 107011026
		arg_108_1.duration_ = 6.4

		local var_108_0 = {
			ja = 5.8,
			ko = 5.1,
			zh = 4.9,
			en = 6.4
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play107011027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_111_0 = 0
			local var_111_1 = 0.5

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(107011026)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 20 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 20)

				if (20 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 20)) > 0 and var_111_1 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011026", "story_v_out_107011.awb") ~= 0 then
					local var_111_6 = manager.audio:GetVoiceLength("story_v_out_107011", "107011026", "story_v_out_107011.awb") / 1000

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_out_107011", "107011026", "story_v_out_107011.awb")

						arg_108_1:RecordAudio("107011026", var_111_7)
						arg_108_1:RecordAudio("107011026", var_111_7)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_107011", "107011026", "story_v_out_107011.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_107011", "107011026", "story_v_out_107011.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play107011027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 107011027
		arg_112_1.duration_ = 6.6

		local var_112_0 = {
			ja = 6.066,
			ko = 6.6,
			zh = 4.566,
			en = 4.433
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
				arg_112_0:Play107011028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = arg_112_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) then
				if arg_112_1.var_.characterEffect1084ui_story and not isNil(arg_112_1.actors_["1084ui_story"]) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["1038ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1038ui_story == nil then
				arg_112_1.var_.characterEffect1038ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect1038ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1038ui_story then
				arg_112_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_115_4 = 0
			local var_115_5 = 0.65

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_6 = arg_112_1:GetWordFromCfg(107011027)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 37 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 37)

				if (37 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 37)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011027", "story_v_out_107011.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011027", "story_v_out_107011.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_107011", "107011027", "story_v_out_107011.awb")

						arg_112_1:RecordAudio("107011027", var_115_11)
						arg_112_1:RecordAudio("107011027", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_107011", "107011027", "story_v_out_107011.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_107011", "107011027", "story_v_out_107011.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play107011028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 107011028
		arg_116_1.duration_ = 6.57

		local var_116_0 = {
			ja = 5.1,
			ko = 6.566,
			zh = 4.9,
			en = 3.766
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
				arg_116_0:Play107011029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1019ui_story"]) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = arg_116_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1019ui_story"]) then
				if arg_116_1.var_.characterEffect1019ui_story and not isNil(arg_116_1.actors_["1019ui_story"]) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1019ui_story"]) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_2 = arg_116_1.actors_["1038ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1038ui_story == nil then
				arg_116_1.var_.characterEffect1038ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.characterEffect1038ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1038ui_story then
				arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_119_4 = 0
			local var_119_5 = 0.7

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_6 = arg_116_1:GetWordFromCfg(107011028)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 50 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 50)

				if (50 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 50)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011028", "story_v_out_107011.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011028", "story_v_out_107011.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_107011", "107011028", "story_v_out_107011.awb")

						arg_116_1:RecordAudio("107011028", var_119_11)
						arg_116_1:RecordAudio("107011028", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_107011", "107011028", "story_v_out_107011.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_107011", "107011028", "story_v_out_107011.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play107011029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 107011029
		arg_120_1.duration_ = 4.7

		local var_120_0 = {
			ja = 4.7,
			ko = 3.233,
			zh = 4.1,
			en = 3.9
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
				arg_120_0:Play107011030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1038ui_story"]) and arg_120_1.var_.characterEffect1038ui_story == nil then
				arg_120_1.var_.characterEffect1038ui_story = arg_120_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1038ui_story"]) then
				if arg_120_1.var_.characterEffect1038ui_story and not isNil(arg_120_1.actors_["1038ui_story"]) then
					arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1038ui_story"]) and arg_120_1.var_.characterEffect1038ui_story then
				arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_123_2 = arg_120_1.actors_["1019ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_3 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_2) then
					arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_3)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1019ui_story then
				arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_123_4 = 0
			local var_123_5 = 0.275

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(107011029)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 11 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 11)

				if (11 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 11)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011029", "story_v_out_107011.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011029", "story_v_out_107011.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_107011", "107011029", "story_v_out_107011.awb")

						arg_120_1:RecordAudio("107011029", var_123_11)
						arg_120_1:RecordAudio("107011029", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_107011", "107011029", "story_v_out_107011.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_107011", "107011029", "story_v_out_107011.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play107011030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 107011030
		arg_124_1.duration_ = 13.7

		local var_124_0 = {
			ja = 13.7,
			ko = 8.933,
			zh = 9.5,
			en = 9.333
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
				arg_124_0:Play107011031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 1.8 < arg_124_1.time_ and arg_124_1.time_ <= 1.8 + arg_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) and arg_124_1.var_.characterEffect1019ui_story == nil then
				arg_124_1.var_.characterEffect1019ui_story = arg_124_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 1.8 <= arg_124_1.time_ and arg_124_1.time_ < 1.8 + var_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) then
				if arg_124_1.var_.characterEffect1019ui_story and not isNil(arg_124_1.actors_["1019ui_story"]) then
					arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 1.8 + var_127_0 and arg_124_1.time_ < 1.8 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1019ui_story"]) and arg_124_1.var_.characterEffect1019ui_story then
				arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 1.5 < arg_124_1.time_ and arg_124_1.time_ <= 1.5 + arg_127_0 then
				local var_127_2 = arg_124_1.bgs_.B13

				arg_124_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_127_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_3 = var_127_2:GetComponent("SpriteRenderer")

				if var_127_3 and var_127_3.sprite then
					local var_127_4 = 2 * (var_127_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_127_2.transform.localScale = Vector3.New(var_127_4 / var_127_3.sprite.bounds.size.y < var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x and var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x or var_127_4 / var_127_3.sprite.bounds.size.y, var_127_4 / var_127_3.sprite.bounds.size.y < var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x and var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x or var_127_4 / var_127_3.sprite.bounds.size.y, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "B13" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_5 = arg_124_1.actors_["1019ui_story"].transform

			if 1.8 < arg_124_1.time_ and arg_124_1.time_ <= 1.8 + arg_127_0 then
				arg_124_1.var_.moveOldPos1019ui_story = var_127_5.localPosition
			end

			local var_127_6 = 0.001

			if 1.8 <= arg_124_1.time_ and arg_124_1.time_ < 1.8 + var_127_6 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_124_1.time_ - 1.8) / var_127_6)
				var_127_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_5.position).x, (manager.ui.mainCamera.transform.position - var_127_5.position).y, (manager.ui.mainCamera.transform.position - var_127_5.position).z)
				var_127_5.localEulerAngles.z = 0
				var_127_5.localEulerAngles.x = 0
				var_127_5.localEulerAngles = var_127_5.localEulerAngles
			end

			if arg_124_1.time_ >= 1.8 + var_127_6 and arg_124_1.time_ < 1.8 + var_127_6 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_127_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_5.position).x, (manager.ui.mainCamera.transform.position - var_127_5.position).y, (manager.ui.mainCamera.transform.position - var_127_5.position).z)
				var_127_5.localEulerAngles.z = 0
				var_127_5.localEulerAngles.x = 0
				var_127_5.localEulerAngles = var_127_5.localEulerAngles
			end

			if 1.8 < arg_124_1.time_ and arg_124_1.time_ <= 1.8 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				local var_127_7 = arg_124_1.bgs_.S0701:GetComponent("SpriteRenderer")

				if var_127_7 then
					arg_124_1.var_.alphaOldValueS0701 = var_127_7.color.a
					arg_124_1.var_.alphaMatValueS0701 = var_127_7
				end

				arg_124_1.var_.alphaOldValueS0701 = 1
			end

			local var_127_8 = 1.5

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_8 then
				if arg_124_1.var_.alphaMatValueS0701 then
					arg_124_1.var_.alphaMatValueS0701.color.a = Mathf.Lerp(arg_124_1.var_.alphaOldValueS0701, 0, (arg_124_1.time_ - 0) / var_127_8)
					arg_124_1.var_.alphaMatValueS0701.color = arg_124_1.var_.alphaMatValueS0701.color
				end
			end

			if arg_124_1.time_ >= 0 + var_127_8 and arg_124_1.time_ < 0 + var_127_8 + arg_127_0 and arg_124_1.var_.alphaMatValueS0701 then
				arg_124_1.var_.alphaMatValueS0701.color.a = 0
				arg_124_1.var_.alphaMatValueS0701.color = arg_124_1.var_.alphaMatValueS0701.color
			end

			if 1.5 < arg_124_1.time_ and arg_124_1.time_ <= 1.5 + arg_127_0 then
				local var_127_9 = arg_124_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_127_9 then
					arg_124_1.var_.alphaOldValueB13 = var_127_9.color.a
					arg_124_1.var_.alphaMatValueB13 = var_127_9
				end

				arg_124_1.var_.alphaOldValueB13 = 0
			end

			local var_127_10 = 1.5

			if 1.5 <= arg_124_1.time_ and arg_124_1.time_ < 1.5 + var_127_10 then
				if arg_124_1.var_.alphaMatValueB13 then
					arg_124_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_124_1.var_.alphaOldValueB13, 1, (arg_124_1.time_ - 1.5) / var_127_10)
					arg_124_1.var_.alphaMatValueB13.color = arg_124_1.var_.alphaMatValueB13.color
				end
			end

			if arg_124_1.time_ >= 1.5 + var_127_10 and arg_124_1.time_ < 1.5 + var_127_10 + arg_127_0 and arg_124_1.var_.alphaMatValueB13 then
				arg_124_1.var_.alphaMatValueB13.color.a = 1
				arg_124_1.var_.alphaMatValueB13.color = arg_124_1.var_.alphaMatValueB13.color
			end

			local var_127_11 = arg_124_1.bgs_.S0701.transform

			if 1.5 < arg_124_1.time_ and arg_124_1.time_ <= 1.5 + arg_127_0 then
				arg_124_1.var_.moveOldPosS0701 = var_127_11.localPosition
			end

			local var_127_12 = 0.001

			if 1.5 <= arg_124_1.time_ and arg_124_1.time_ < 1.5 + var_127_12 then
				var_127_11.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPosS0701, Vector3.New(0, 100, 0), (arg_124_1.time_ - 1.5) / var_127_12)
			end

			if arg_124_1.time_ >= 1.5 + var_127_12 and arg_124_1.time_ < 1.5 + var_127_12 + arg_127_0 then
				var_127_11.localPosition = Vector3.New(0, 100, 0)
			end

			local var_127_13 = 0

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			if arg_124_1.time_ >= var_127_13 + 2 and arg_124_1.time_ < var_127_13 + 2 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_14 = 2
			local var_127_15 = 0.925

			if 2 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_16 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_16:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_17 = arg_124_1:GetWordFromCfg(107011030)
				local var_127_18 = arg_124_1:FormatText(var_127_17.content)

				arg_124_1.text_.text = var_127_18

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 37 <= 0 and var_127_15 or var_127_15 * (utf8.len(var_127_18) / 37)

				if (37 <= 0 and var_127_15 or var_127_15 * (utf8.len(var_127_18) / 37)) > 0 and var_127_15 < var_127_20 then
					arg_124_1.talkMaxDuration = var_127_20
					var_127_14 = var_127_14 + 0.3

					if var_127_20 + var_127_14 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_20 + var_127_14
					end
				end

				arg_124_1.text_.text = var_127_18
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011030", "story_v_out_107011.awb") ~= 0 then
					local var_127_21 = manager.audio:GetVoiceLength("story_v_out_107011", "107011030", "story_v_out_107011.awb") / 1000

					if var_127_21 + var_127_14 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_21 + var_127_14
					end

					if var_127_17.prefab_name ~= "" and arg_124_1.actors_[var_127_17.prefab_name] ~= nil then
						local var_127_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_17.prefab_name].transform, "story_v_out_107011", "107011030", "story_v_out_107011.awb")

						arg_124_1:RecordAudio("107011030", var_127_22)
						arg_124_1:RecordAudio("107011030", var_127_22)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_107011", "107011030", "story_v_out_107011.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_107011", "107011030", "story_v_out_107011.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_23 = var_127_14 + 0.3
			local var_127_24 = math.max(var_127_15, arg_124_1.talkMaxDuration)

			if var_127_14 + 0.3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_24 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_24

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_24 and arg_124_1.time_ < var_127_23 + var_127_24 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play107011031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 107011031
		arg_130_1.duration_ = 6.93

		local var_130_0 = {
			ja = 6.933,
			ko = 1.999999999999,
			zh = 5.8,
			en = 4.6
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
			arg_130_1.auto_ = false
		end

		function arg_130_1.playNext_(arg_132_0)
			arg_130_1.onStoryFinished_()
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_133_0 = 0
			local var_133_1 = 0.65

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(107011031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 25 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 25)

				if (25 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 25)) > 0 and var_133_1 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011031", "story_v_out_107011.awb") ~= 0 then
					local var_133_6 = manager.audio:GetVoiceLength("story_v_out_107011", "107011031", "story_v_out_107011.awb") / 1000

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end

					if var_133_2.prefab_name ~= "" and arg_130_1.actors_[var_133_2.prefab_name] ~= nil then
						local var_133_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_2.prefab_name].transform, "story_v_out_107011", "107011031", "story_v_out_107011.awb")

						arg_130_1:RecordAudio("107011031", var_133_7)
						arg_130_1:RecordAudio("107011031", var_133_7)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_107011", "107011031", "story_v_out_107011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_107011", "107011031", "story_v_out_107011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_8 and arg_130_1.time_ < var_133_0 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/S0701"
	},
	voices = {
		"story_v_out_107011.awb"
	}
}
