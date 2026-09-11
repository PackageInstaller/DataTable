return {
	Play106061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C02b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C02b")
				var_4_0.name = "C02b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C02b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C02b:GetComponent("SpriteRenderer")

				if var_4_1 then
					arg_1_1.var_.alphaOldValueC02b = var_4_1.color.a
					arg_1_1.var_.alphaMatValueC02b = var_4_1
				end

				arg_1_1.var_.alphaOldValueC02b = 0
			end

			local var_4_2 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_2 then
				if arg_1_1.var_.alphaMatValueC02b then
					arg_1_1.var_.alphaMatValueC02b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC02b, 1, (arg_1_1.time_ - 0) / var_4_2)
					arg_1_1.var_.alphaMatValueC02b.color = arg_1_1.var_.alphaMatValueC02b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_2 and arg_1_1.time_ < 0 + var_4_2 + arg_4_0 and arg_1_1.var_.alphaMatValueC02b then
				arg_1_1.var_.alphaMatValueC02b.color.a = 1
				arg_1_1.var_.alphaMatValueC02b.color = arg_1_1.var_.alphaMatValueC02b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_3 = arg_1_1.bgs_.C02b

				arg_1_1.bgs_.C02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_4 = var_4_3:GetComponent("SpriteRenderer")

				if var_4_4 and var_4_4.sprite then
					local var_4_5 = 2 * (var_4_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_3.transform.localScale = Vector3.New(var_4_5 / var_4_4.sprite.bounds.size.y < var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x and var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x or var_4_5 / var_4_4.sprite.bounds.size.y, var_4_5 / var_4_4.sprite.bounds.size.y < var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x and var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x or var_4_5 / var_4_4.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C02b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(106061001).content)

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
	Play106061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106061002
		arg_8_1.duration_ = 11.83

		local var_8_0 = {
			ja = 11.833,
			ko = 8.333,
			zh = 8.733,
			en = 9.4
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
				arg_8_0:Play106061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1093ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1093ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1093ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1093ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1093ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1093ui_story == nil then
				arg_8_1.var_.characterEffect1093ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1093ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1093ui_story then
				arg_8_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			local var_11_6 = arg_8_1.actors_["1093ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1093ui_story = var_11_6.localPosition

				arg_8_1:ShowWeapon(arg_8_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(0, -1.11, -5.88)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_11_8 = 0
			local var_11_9 = 0.925

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(106061002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 37 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 37)

				if (37 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 37)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061002", "story_v_out_106061.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_106061", "106061002", "story_v_out_106061.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_106061", "106061002", "story_v_out_106061.awb")

						arg_8_1:RecordAudio("106061002", var_11_15)
						arg_8_1:RecordAudio("106061002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106061", "106061002", "story_v_out_106061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106061", "106061002", "story_v_out_106061.awb")
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
				actorName = "1093ui_story",
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
	Play106061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106061003
		arg_12_1.duration_ = 12.6

		local var_12_0 = {
			ja = 12.6,
			ko = 12,
			zh = 8.333,
			en = 9.366
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
				arg_12_0:Play106061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_15_0 = 0
			local var_15_1 = 0.85

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(106061003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 34 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_3) / 34)

				if (34 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_3) / 34)) > 0 and var_15_1 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061003", "story_v_out_106061.awb") ~= 0 then
					local var_15_6 = manager.audio:GetVoiceLength("story_v_out_106061", "106061003", "story_v_out_106061.awb") / 1000

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end

					if var_15_2.prefab_name ~= "" and arg_12_1.actors_[var_15_2.prefab_name] ~= nil then
						local var_15_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_2.prefab_name].transform, "story_v_out_106061", "106061003", "story_v_out_106061.awb")

						arg_12_1:RecordAudio("106061003", var_15_7)
						arg_12_1:RecordAudio("106061003", var_15_7)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106061", "106061003", "story_v_out_106061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106061", "106061003", "story_v_out_106061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play106061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106061004
		arg_16_1.duration_ = 8.9

		local var_16_0 = {
			ja = 8.9,
			ko = 5.266,
			zh = 4.6,
			en = 5.266
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
				arg_16_0:Play106061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action472")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_6", "se_story_6_desheath", "")
			end

			local var_19_1 = 0
			local var_19_2 = 0.475

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(106061004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 17 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 17)

				if (17 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 17)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061004", "story_v_out_106061.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_106061", "106061004", "story_v_out_106061.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_106061", "106061004", "story_v_out_106061.awb")

						arg_16_1:RecordAudio("106061004", var_19_8)
						arg_16_1:RecordAudio("106061004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106061", "106061004", "story_v_out_106061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106061", "106061004", "story_v_out_106061.awb")
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
	Play106061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106061005
		arg_20_1.duration_ = 1.63

		local var_20_0 = {
			ja = 0.666,
			ko = 1.633,
			zh = 1.333,
			en = 0.933
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
				arg_20_0:Play106061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1093ui_story"]) and arg_20_1.var_.characterEffect1093ui_story == nil then
				arg_20_1.var_.characterEffect1093ui_story = arg_20_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1093ui_story"]) then
				if arg_20_1.var_.characterEffect1093ui_story and not isNil(arg_20_1.actors_["1093ui_story"]) then
					arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1093ui_story"]) and arg_20_1.var_.characterEffect1093ui_story then
				arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_23_1 = arg_20_1.actors_["1093ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1093ui_story = var_23_1.localPosition

				arg_20_1:ShowWeapon(arg_20_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_23_2 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 then
				var_23_1.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_2)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_2 and arg_20_1.time_ < 0 + var_23_2 + arg_23_0 then
				var_23_1.localPosition = Vector3.New(0, 100, 0)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			local var_23_3 = manager.ui.mainCamera.transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.shakeOldPos = var_23_3.localPosition
			end

			local var_23_4 = 0.6

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				local var_23_5, var_23_6 = math.modf((arg_20_1.time_ - 0) / 0.099)

				var_23_3.localPosition = Vector3.New(var_23_6 * 0.13, var_23_6 * 0.13, var_23_6 * 0.13) + arg_20_1.var_.shakeOldPos
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = arg_20_1.var_.shakeOldPos
			end

			local var_23_7 = 0
			local var_23_8 = 0.075

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(106061005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_12 = 3 <= 0 and var_23_8 or var_23_8 * (utf8.len(var_23_10) / 3)

				if (3 <= 0 and var_23_8 or var_23_8 * (utf8.len(var_23_10) / 3)) > 0 and var_23_8 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_7 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_7
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061005", "story_v_out_106061.awb") ~= 0 then
					local var_23_13 = manager.audio:GetVoiceLength("story_v_out_106061", "106061005", "story_v_out_106061.awb") / 1000

					if var_23_13 + var_23_7 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_7
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_106061", "106061005", "story_v_out_106061.awb")

						arg_20_1:RecordAudio("106061005", var_23_14)
						arg_20_1:RecordAudio("106061005", var_23_14)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106061", "106061005", "story_v_out_106061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106061", "106061005", "story_v_out_106061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_15 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_15 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_7) / var_23_15

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_7 + var_23_15 and arg_20_1.time_ < var_23_7 + var_23_15 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106061006
		arg_24_1.duration_ = 7.37

		local var_24_0 = {
			ja = 5.9,
			ko = 3.566,
			zh = 7.366,
			en = 7.1
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
				arg_24_0:Play106061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1093ui_story"]) and arg_24_1.var_.characterEffect1093ui_story == nil then
				arg_24_1.var_.characterEffect1093ui_story = arg_24_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1093ui_story"]) then
				if arg_24_1.var_.characterEffect1093ui_story and not isNil(arg_24_1.actors_["1093ui_story"]) then
					arg_24_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1093ui_story"]) and arg_24_1.var_.characterEffect1093ui_story then
				arg_24_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_27_2 = 0
			local var_27_3 = 0.5

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_4 = arg_24_1:GetWordFromCfg(106061006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 20 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 20)

				if (20 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 20)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061006", "story_v_out_106061.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_106061", "106061006", "story_v_out_106061.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_106061", "106061006", "story_v_out_106061.awb")

						arg_24_1:RecordAudio("106061006", var_27_9)
						arg_24_1:RecordAudio("106061006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106061", "106061006", "story_v_out_106061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106061", "106061006", "story_v_out_106061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1093ui_story"]) and arg_28_1.var_.characterEffect1093ui_story == nil then
				arg_28_1.var_.characterEffect1093ui_story = arg_28_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1093ui_story"]) then
				if arg_28_1.var_.characterEffect1093ui_story and not isNil(arg_28_1.actors_["1093ui_story"]) then
					arg_28_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1093ui_story"]) and arg_28_1.var_.characterEffect1093ui_story then
				arg_28_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_31_1 = arg_28_1.actors_["1093ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1093ui_story = var_31_1.localPosition
			end

			local var_31_2 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 then
				var_31_1.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_2)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = Vector3.New(0, 100, 0)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			local var_31_3 = 0
			local var_31_4 = 0.85

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(106061007).content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 34 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 34)

				if (34 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 34)) > 0 and var_31_4 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_8 and arg_28_1.time_ < var_31_3 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play106061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106061008
		arg_32_1.duration_ = 2.83

		local var_32_0 = {
			ja = 2.833,
			ko = 2,
			zh = 1.7,
			en = 2.233
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
				arg_32_0:Play106061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.15

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(106061008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 6 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 6)

				if (6 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 6)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061008", "story_v_out_106061.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_106061", "106061008", "story_v_out_106061.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_106061", "106061008", "story_v_out_106061.awb")

						arg_32_1:RecordAudio("106061008", var_35_6)
						arg_32_1:RecordAudio("106061008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106061", "106061008", "story_v_out_106061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106061", "106061008", "story_v_out_106061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play106061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106061009
		arg_36_1.duration_ = 4.53

		local var_36_0 = {
			ja = 3.5,
			ko = 3.633,
			zh = 4.533,
			en = 3.366
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
				arg_36_0:Play106061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1093ui_story"]) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = arg_36_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1093ui_story"]) then
				if arg_36_1.var_.characterEffect1093ui_story and not isNil(arg_36_1.actors_["1093ui_story"]) then
					arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1093ui_story"]) and arg_36_1.var_.characterEffect1093ui_story then
				arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_2 = 0
			local var_39_3 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(106061009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 18 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 18)

				if (18 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 18)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061009", "story_v_out_106061.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_106061", "106061009", "story_v_out_106061.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_106061", "106061009", "story_v_out_106061.awb")

						arg_36_1:RecordAudio("106061009", var_39_9)
						arg_36_1:RecordAudio("106061009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106061", "106061009", "story_v_out_106061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106061", "106061009", "story_v_out_106061.awb")
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
	Play106061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106061010
		arg_40_1.duration_ = 4.5

		local var_40_0 = {
			ja = 2.433,
			ko = 2.166,
			zh = 2.166,
			en = 4.5
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
				arg_40_0:Play106061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1093ui_story"]) and arg_40_1.var_.characterEffect1093ui_story == nil then
				arg_40_1.var_.characterEffect1093ui_story = arg_40_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1093ui_story"]) then
				if arg_40_1.var_.characterEffect1093ui_story and not isNil(arg_40_1.actors_["1093ui_story"]) then
					arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1093ui_story"]) and arg_40_1.var_.characterEffect1093ui_story then
				arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.075

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(106061010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 3 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 3)

				if (3 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 3)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061010", "story_v_out_106061.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_106061", "106061010", "story_v_out_106061.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_106061", "106061010", "story_v_out_106061.awb")

						arg_40_1:RecordAudio("106061010", var_43_8)
						arg_40_1:RecordAudio("106061010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_106061", "106061010", "story_v_out_106061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_106061", "106061010", "story_v_out_106061.awb")
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
	Play106061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106061011
		arg_44_1.duration_ = 3.03

		local var_44_0 = {
			ja = 2.833,
			ko = 2.166,
			zh = 3.033,
			en = 1.4
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
				arg_44_0:Play106061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1093ui_story"]) and arg_44_1.var_.characterEffect1093ui_story == nil then
				arg_44_1.var_.characterEffect1093ui_story = arg_44_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1093ui_story"]) then
				if arg_44_1.var_.characterEffect1093ui_story and not isNil(arg_44_1.actors_["1093ui_story"]) then
					arg_44_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1093ui_story"]) and arg_44_1.var_.characterEffect1093ui_story then
				arg_44_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_47_2 = 0
			local var_47_3 = 0.275

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(106061011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 11 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 11)

				if (11 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 11)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061011", "story_v_out_106061.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_106061", "106061011", "story_v_out_106061.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_106061", "106061011", "story_v_out_106061.awb")

						arg_44_1:RecordAudio("106061011", var_47_9)
						arg_44_1:RecordAudio("106061011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106061", "106061011", "story_v_out_106061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106061", "106061011", "story_v_out_106061.awb")
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
	Play106061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106061012
		arg_48_1.duration_ = 2.9

		local var_48_0 = {
			ja = 2.8,
			ko = 2.633,
			zh = 2.7,
			en = 2.9
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
				arg_48_0:Play106061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1093ui_story"]) and arg_48_1.var_.characterEffect1093ui_story == nil then
				arg_48_1.var_.characterEffect1093ui_story = arg_48_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1093ui_story"]) then
				if arg_48_1.var_.characterEffect1093ui_story and not isNil(arg_48_1.actors_["1093ui_story"]) then
					arg_48_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1093ui_story"]) and arg_48_1.var_.characterEffect1093ui_story then
				arg_48_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.125

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(106061012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 5 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 5)

				if (5 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 5)) > 0 and var_51_2 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061012", "story_v_out_106061.awb") ~= 0 then
					local var_51_7 = manager.audio:GetVoiceLength("story_v_out_106061", "106061012", "story_v_out_106061.awb") / 1000

					if var_51_7 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_1
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_106061", "106061012", "story_v_out_106061.awb")

						arg_48_1:RecordAudio("106061012", var_51_8)
						arg_48_1:RecordAudio("106061012", var_51_8)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_106061", "106061012", "story_v_out_106061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_106061", "106061012", "story_v_out_106061.awb")
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
	Play106061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106061013
		arg_52_1.duration_ = 1.17

		local var_52_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.166,
			en = 1.033
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
				arg_52_0:Play106061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_55_0 = 0
			local var_55_1 = 0.05

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_2 = arg_52_1:GetWordFromCfg(106061013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 2 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 2)

				if (2 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 2)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061013", "story_v_out_106061.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_106061", "106061013", "story_v_out_106061.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_106061", "106061013", "story_v_out_106061.awb")

						arg_52_1:RecordAudio("106061013", var_55_7)
						arg_52_1:RecordAudio("106061013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106061", "106061013", "story_v_out_106061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106061", "106061013", "story_v_out_106061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play106061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106061014
		arg_56_1.duration_ = 4.6

		local var_56_0 = {
			ja = 1.766,
			ko = 2.4,
			zh = 2.9,
			en = 4.6
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
				arg_56_0:Play106061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_6", "se_story_6_puncture02", "")
			end

			local var_59_1 = 0
			local var_59_2 = 0.2

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(106061014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 8 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 8)

				if (8 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 8)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061014", "story_v_out_106061.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_106061", "106061014", "story_v_out_106061.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_106061", "106061014", "story_v_out_106061.awb")

						arg_56_1:RecordAudio("106061014", var_59_8)
						arg_56_1:RecordAudio("106061014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_106061", "106061014", "story_v_out_106061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_106061", "106061014", "story_v_out_106061.awb")
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
	Play106061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106061015
		arg_60_1.duration_ = 2.3

		local var_60_0 = {
			ja = 2.033,
			ko = 1.2,
			zh = 2.3,
			en = 1.966
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
				arg_60_0:Play106061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1093ui_story"]) and arg_60_1.var_.characterEffect1093ui_story == nil then
				arg_60_1.var_.characterEffect1093ui_story = arg_60_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1093ui_story"]) then
				if arg_60_1.var_.characterEffect1093ui_story and not isNil(arg_60_1.actors_["1093ui_story"]) then
					arg_60_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1093ui_story"]) and arg_60_1.var_.characterEffect1093ui_story then
				arg_60_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_63_2 = 0.1

			if 0.1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_3 = 0.5

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_3 then
				local var_63_4 = Color.New(1, 1, 1)

				var_63_4.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_2) / var_63_3)
				arg_60_1.mask_.color = var_63_4
			end

			if arg_60_1.time_ >= var_63_2 + var_63_3 and arg_60_1.time_ < var_63_2 + var_63_3 + arg_63_0 then
				local var_63_5 = Color.New(1, 1, 1)

				arg_60_1.mask_.enabled = false
				var_63_5.a = 0
				arg_60_1.mask_.color = var_63_5
			end

			local var_63_6 = manager.ui.mainCamera.transform

			if 0.1 < arg_60_1.time_ and arg_60_1.time_ <= 0.1 + arg_63_0 then
				arg_60_1.var_.shakeOldPos = var_63_6.localPosition
			end

			local var_63_7 = 0.6

			if 0.1 <= arg_60_1.time_ and arg_60_1.time_ < 0.1 + var_63_7 then
				local var_63_8, var_63_9 = math.modf((arg_60_1.time_ - 0.1) / 0.099)

				var_63_6.localPosition = Vector3.New(var_63_9 * 0.13, var_63_9 * 0.13, var_63_9 * 0.13) + arg_60_1.var_.shakeOldPos
			end

			if arg_60_1.time_ >= 0.1 + var_63_7 and arg_60_1.time_ < 0.1 + var_63_7 + arg_63_0 then
				var_63_6.localPosition = arg_60_1.var_.shakeOldPos
			end

			local var_63_10 = 0
			local var_63_11 = 0.1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_12 = arg_60_1:GetWordFromCfg(106061015)
				local var_63_13 = arg_60_1:FormatText(var_63_12.content)

				arg_60_1.text_.text = var_63_13

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 4 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 4)

				if (4 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 4)) > 0 and var_63_11 < var_63_15 then
					arg_60_1.talkMaxDuration = var_63_15

					if var_63_15 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_13
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061015", "story_v_out_106061.awb") ~= 0 then
					local var_63_16 = manager.audio:GetVoiceLength("story_v_out_106061", "106061015", "story_v_out_106061.awb") / 1000

					if var_63_16 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_16 + var_63_10
					end

					if var_63_12.prefab_name ~= "" and arg_60_1.actors_[var_63_12.prefab_name] ~= nil then
						local var_63_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_12.prefab_name].transform, "story_v_out_106061", "106061015", "story_v_out_106061.awb")

						arg_60_1:RecordAudio("106061015", var_63_17)
						arg_60_1:RecordAudio("106061015", var_63_17)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106061", "106061015", "story_v_out_106061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106061", "106061015", "story_v_out_106061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_18 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_18 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_18

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_18 and arg_60_1.time_ < var_63_10 + var_63_18 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 106061016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play106061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1093ui_story"]) and arg_64_1.var_.characterEffect1093ui_story == nil then
				arg_64_1.var_.characterEffect1093ui_story = arg_64_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1093ui_story"]) then
				if arg_64_1.var_.characterEffect1093ui_story and not isNil(arg_64_1.actors_["1093ui_story"]) then
					arg_64_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1093ui_story"]) and arg_64_1.var_.characterEffect1093ui_story then
				arg_64_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_2 = 0.5

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = Color.New(1, 1, 1)

				var_67_3.a = Mathf.Lerp(1, 0, (arg_64_1.time_ - var_67_1) / var_67_2)
				arg_64_1.mask_.color = var_67_3
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				local var_67_4 = Color.New(1, 1, 1)

				arg_64_1.mask_.enabled = false
				var_67_4.a = 0
				arg_64_1.mask_.color = var_67_4
			end

			local var_67_5 = manager.ui.mainCamera.transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.shakeOldPosMainCamera = var_67_5.localPosition
			end

			local var_67_6 = 0.600000023841858

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_6 then
				local var_67_7, var_67_8 = math.modf((arg_64_1.time_ - 0) / 0.066)

				var_67_5.localPosition = Vector3.New(var_67_8 * 0.13, var_67_8 * 0.13, var_67_8 * 0.13) + arg_64_1.var_.shakeOldPosMainCamera
			end

			if arg_64_1.time_ >= 0 + var_67_6 and arg_64_1.time_ < 0 + var_67_6 + arg_67_0 then
				var_67_5.localPosition = arg_64_1.var_.shakeOldPosMainCamera
			end

			local var_67_9 = 0
			local var_67_10 = 0.875

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_11 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(106061016).content)

				arg_64_1.text_.text = var_67_11

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_13 = 35 <= 0 and var_67_10 or var_67_10 * (utf8.len(var_67_11) / 35)

				if (35 <= 0 and var_67_10 or var_67_10 * (utf8.len(var_67_11) / 35)) > 0 and var_67_10 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_9 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_9
					end
				end

				arg_64_1.text_.text = var_67_11
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_10, arg_64_1.talkMaxDuration)

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_9) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_9 + var_67_14 and arg_64_1.time_ < var_67_9 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play106061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 106061017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play106061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.7

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

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(106061017).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 28 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 28)

				if (28 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 28)) > 0 and var_71_0 < var_71_3 then
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
	Play106061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play106061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.775

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(106061018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 31 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 31)

				if (31 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 31)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play106061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106061019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play106061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.825

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(106061019).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 33 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 33)

				if (33 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 33)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play106061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106061020
		arg_80_1.duration_ = 3.57

		local var_80_0 = {
			ja = 3.2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 3.566
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
				arg_80_0:Play106061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1093ui_story"]) and arg_80_1.var_.characterEffect1093ui_story == nil then
				arg_80_1.var_.characterEffect1093ui_story = arg_80_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1093ui_story"]) then
				if arg_80_1.var_.characterEffect1093ui_story and not isNil(arg_80_1.actors_["1093ui_story"]) then
					arg_80_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1093ui_story"]) and arg_80_1.var_.characterEffect1093ui_story then
				arg_80_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1093ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1093ui_story = var_83_2.localPosition

				arg_80_1:ShowWeapon(arg_80_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_83_3 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 then
				var_83_2.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_80_1.time_ - 0) / var_83_3)
				var_83_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_2.position).x, (manager.ui.mainCamera.transform.position - var_83_2.position).y, (manager.ui.mainCamera.transform.position - var_83_2.position).z)
				var_83_2.localEulerAngles.z = 0
				var_83_2.localEulerAngles.x = 0
				var_83_2.localEulerAngles = var_83_2.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 then
				var_83_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_83_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_2.position).x, (manager.ui.mainCamera.transform.position - var_83_2.position).y, (manager.ui.mainCamera.transform.position - var_83_2.position).z)
				var_83_2.localEulerAngles.z = 0
				var_83_2.localEulerAngles.x = 0
				var_83_2.localEulerAngles = var_83_2.localEulerAngles
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_83_4 = 0
			local var_83_5 = 0.15

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(106061020)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 6 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 6)

				if (6 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 6)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061020", "story_v_out_106061.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_106061", "106061020", "story_v_out_106061.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_106061", "106061020", "story_v_out_106061.awb")

						arg_80_1:RecordAudio("106061020", var_83_11)
						arg_80_1:RecordAudio("106061020", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_106061", "106061020", "story_v_out_106061.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_106061", "106061020", "story_v_out_106061.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play106061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 106061021
		arg_84_1.duration_ = 8.03

		local var_84_0 = {
			ja = 5.6,
			ko = 8.033,
			zh = 6.6,
			en = 5.933
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
				arg_84_0:Play106061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.actors_["2033_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2033_tpose"))) then
				local var_87_0 = Object.Instantiate(Asset.Load("Char/" .. "2033_tpose"), arg_84_1.stage_.transform)

				var_87_0.name = "2033_tpose"
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["2033_tpose"] = var_87_0

				local var_87_1 = var_87_0:GetComponentInChildren(typeof(CharacterEffect))

				var_87_1.enabled = true

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end

				arg_84_1:ShowWeapon(var_87_1.transform, false)

				arg_84_1.var_["2033_tpose" .. "Animator"] = var_87_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_84_1.var_["2033_tpose" .. "Animator"].applyRootMotion = true
				arg_84_1.var_["2033_tpose" .. "LipSync"] = var_87_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_87_3 = arg_84_1.actors_["2033_tpose"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect2033_tpose == nil then
				arg_84_1.var_.characterEffect2033_tpose = var_87_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_4 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 and not isNil(var_87_3) then
				if arg_84_1.var_.characterEffect2033_tpose and not isNil(var_87_3) then
					arg_84_1.var_.characterEffect2033_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect2033_tpose then
				arg_84_1.var_.characterEffect2033_tpose.fillFlat = false
			end

			local var_87_6 = arg_84_1.actors_["1093ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_6) and arg_84_1.var_.characterEffect1093ui_story == nil then
				arg_84_1.var_.characterEffect1093ui_story = var_87_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_7 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 and not isNil(var_87_6) then
				if arg_84_1.var_.characterEffect1093ui_story and not isNil(var_87_6) then
					arg_84_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_7)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 and not isNil(var_87_6) and arg_84_1.var_.characterEffect1093ui_story then
				arg_84_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_87_8 = arg_84_1.actors_["1093ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1093ui_story = var_87_8.localPosition

				arg_84_1:ShowWeapon(arg_84_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_87_9 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_9 then
				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_9)
				var_87_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_8.position).x, (manager.ui.mainCamera.transform.position - var_87_8.position).y, (manager.ui.mainCamera.transform.position - var_87_8.position).z)
				var_87_8.localEulerAngles.z = 0
				var_87_8.localEulerAngles.x = 0
				var_87_8.localEulerAngles = var_87_8.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_9 and arg_84_1.time_ < 0 + var_87_9 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(0, 100, 0)
				var_87_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_8.position).x, (manager.ui.mainCamera.transform.position - var_87_8.position).y, (manager.ui.mainCamera.transform.position - var_87_8.position).z)
				var_87_8.localEulerAngles.z = 0
				var_87_8.localEulerAngles.x = 0
				var_87_8.localEulerAngles = var_87_8.localEulerAngles
			end

			local var_87_10 = arg_84_1.actors_["2033_tpose"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos2033_tpose = var_87_10.localPosition

				local var_87_11 = GameObjectTools.GetOrAddComponent(var_87_10.gameObject, typeof(DynamicBoneHelper))

				if var_87_11 then
					var_87_11:EnableDynamicBone(false)
				end
			end

			local var_87_12 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_12 then
				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos2033_tpose, Vector3.New(0, -1.37, -4.9), (arg_84_1.time_ - 0) / var_87_12)
				var_87_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_10.position).x, (manager.ui.mainCamera.transform.position - var_87_10.position).y, (manager.ui.mainCamera.transform.position - var_87_10.position).z)
				var_87_10.localEulerAngles.z = 0
				var_87_10.localEulerAngles.x = 0
				var_87_10.localEulerAngles = var_87_10.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_12 and arg_84_1.time_ < 0 + var_87_12 + arg_87_0 then
				var_87_10.localPosition = Vector3.New(0, -1.37, -4.9)
				var_87_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_10.position).x, (manager.ui.mainCamera.transform.position - var_87_10.position).y, (manager.ui.mainCamera.transform.position - var_87_10.position).z)
				var_87_10.localEulerAngles.z = 0
				var_87_10.localEulerAngles.x = 0
				var_87_10.localEulerAngles = var_87_10.localEulerAngles

				local var_87_13 = GameObjectTools.GetOrAddComponent(var_87_10.gameObject, typeof(DynamicBoneHelper))

				if var_87_13 then
					var_87_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("2033_tpose", "StoryTimeline/CharAction/story2033/story2033action/2033action1_1")
			end

			local var_87_14 = 0
			local var_87_15 = 0.35

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_16 = arg_84_1:GetWordFromCfg(106061021)
				local var_87_17 = arg_84_1:FormatText(var_87_16.content)

				arg_84_1.text_.text = var_87_17

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_19 = 14 <= 0 and var_87_15 or var_87_15 * (utf8.len(var_87_17) / 14)

				if (14 <= 0 and var_87_15 or var_87_15 * (utf8.len(var_87_17) / 14)) > 0 and var_87_15 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19

					if var_87_19 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_14
					end
				end

				arg_84_1.text_.text = var_87_17
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061021", "story_v_out_106061.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_106061", "106061021", "story_v_out_106061.awb") / 1000

					if var_87_20 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_14
					end

					if var_87_16.prefab_name ~= "" and arg_84_1.actors_[var_87_16.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_16.prefab_name].transform, "story_v_out_106061", "106061021", "story_v_out_106061.awb")

						arg_84_1:RecordAudio("106061021", var_87_21)
						arg_84_1:RecordAudio("106061021", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_106061", "106061021", "story_v_out_106061.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_106061", "106061021", "story_v_out_106061.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_15, arg_84_1.talkMaxDuration)

			if var_87_14 <= arg_84_1.time_ and arg_84_1.time_ < var_87_14 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_14) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_14 + var_87_22 and arg_84_1.time_ < var_87_14 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2033_tpose",
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
	Play106061022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 106061022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play106061023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["2033_tpose"]) and arg_88_1.var_.characterEffect2033_tpose == nil then
				arg_88_1.var_.characterEffect2033_tpose = arg_88_1.actors_["2033_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["2033_tpose"]) then
				if arg_88_1.var_.characterEffect2033_tpose and not isNil(arg_88_1.actors_["2033_tpose"]) then
					arg_88_1.var_.characterEffect2033_tpose.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["2033_tpose"]) and arg_88_1.var_.characterEffect2033_tpose then
				arg_88_1.var_.characterEffect2033_tpose.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["1093ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1093ui_story == nil then
				arg_88_1.var_.characterEffect1093ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect1093ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1093ui_story then
				arg_88_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story_6", "se_story_6_draw_out02", "")
			end

			local var_91_5 = 0
			local var_91_6 = 1.2

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(106061022).content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 48 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 48)

				if (48 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 48)) > 0 and var_91_6 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_10 and arg_88_1.time_ < var_91_5 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play106061023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 106061023
		arg_92_1.duration_ = 5.33

		local var_92_0 = {
			ja = 5.333,
			ko = 1.999999999999,
			zh = 3.266,
			en = 4.9
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
				arg_92_0:Play106061024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1093ui_story"]) and arg_92_1.var_.characterEffect1093ui_story == nil then
				arg_92_1.var_.characterEffect1093ui_story = arg_92_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1093ui_story"]) then
				if arg_92_1.var_.characterEffect1093ui_story and not isNil(arg_92_1.actors_["1093ui_story"]) then
					arg_92_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1093ui_story"]) and arg_92_1.var_.characterEffect1093ui_story then
				arg_92_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["2033_tpose"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect2033_tpose == nil then
				arg_92_1.var_.characterEffect2033_tpose = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect2033_tpose and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect2033_tpose.fillFlat = true
					arg_92_1.var_.characterEffect2033_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect2033_tpose then
				arg_92_1.var_.characterEffect2033_tpose.fillFlat = true
				arg_92_1.var_.characterEffect2033_tpose.fillRatio = 0.5
			end

			local var_95_4 = arg_92_1.actors_["2033_tpose"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos2033_tpose = var_95_4.localPosition

				local var_95_5 = GameObjectTools.GetOrAddComponent(var_95_4.gameObject, typeof(DynamicBoneHelper))

				if var_95_5 then
					var_95_5:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(arg_92_1.var_["2033_tpose" .. "Animator"].transform, true)
			end

			local var_95_6 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 then
				var_95_4.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos2033_tpose, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_6)
				var_95_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_4.position).x, (manager.ui.mainCamera.transform.position - var_95_4.position).y, (manager.ui.mainCamera.transform.position - var_95_4.position).z)
				var_95_4.localEulerAngles.z = 0
				var_95_4.localEulerAngles.x = 0
				var_95_4.localEulerAngles = var_95_4.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 then
				var_95_4.localPosition = Vector3.New(0, 100, 0)
				var_95_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_4.position).x, (manager.ui.mainCamera.transform.position - var_95_4.position).y, (manager.ui.mainCamera.transform.position - var_95_4.position).z)
				var_95_4.localEulerAngles.z = 0
				var_95_4.localEulerAngles.x = 0
				var_95_4.localEulerAngles = var_95_4.localEulerAngles

				local var_95_7 = GameObjectTools.GetOrAddComponent(var_95_4.gameObject, typeof(DynamicBoneHelper))

				if var_95_7 then
					var_95_7:EnableDynamicBone(true)
				end
			end

			local var_95_8 = arg_92_1.actors_["1093ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1093ui_story = var_95_8.localPosition
			end

			local var_95_9 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_9 then
				var_95_8.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_92_1.time_ - 0) / var_95_9)
				var_95_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_8.position).x, (manager.ui.mainCamera.transform.position - var_95_8.position).y, (manager.ui.mainCamera.transform.position - var_95_8.position).z)
				var_95_8.localEulerAngles.z = 0
				var_95_8.localEulerAngles.x = 0
				var_95_8.localEulerAngles = var_95_8.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_9 and arg_92_1.time_ < 0 + var_95_9 + arg_95_0 then
				var_95_8.localPosition = Vector3.New(0, -1.11, -5.88)
				var_95_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_8.position).x, (manager.ui.mainCamera.transform.position - var_95_8.position).y, (manager.ui.mainCamera.transform.position - var_95_8.position).z)
				var_95_8.localEulerAngles.z = 0
				var_95_8.localEulerAngles.x = 0
				var_95_8.localEulerAngles = var_95_8.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_95_10 = 0
			local var_95_11 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_12 = arg_92_1:GetWordFromCfg(106061023)
				local var_95_13 = arg_92_1:FormatText(var_95_12.content)

				arg_92_1.text_.text = var_95_13

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_15 = 9 <= 0 and var_95_11 or var_95_11 * (utf8.len(var_95_13) / 9)

				if (9 <= 0 and var_95_11 or var_95_11 * (utf8.len(var_95_13) / 9)) > 0 and var_95_11 < var_95_15 then
					arg_92_1.talkMaxDuration = var_95_15

					if var_95_15 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_15 + var_95_10
					end
				end

				arg_92_1.text_.text = var_95_13
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061023", "story_v_out_106061.awb") ~= 0 then
					local var_95_16 = manager.audio:GetVoiceLength("story_v_out_106061", "106061023", "story_v_out_106061.awb") / 1000

					if var_95_16 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_16 + var_95_10
					end

					if var_95_12.prefab_name ~= "" and arg_92_1.actors_[var_95_12.prefab_name] ~= nil then
						local var_95_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_12.prefab_name].transform, "story_v_out_106061", "106061023", "story_v_out_106061.awb")

						arg_92_1:RecordAudio("106061023", var_95_17)
						arg_92_1:RecordAudio("106061023", var_95_17)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_106061", "106061023", "story_v_out_106061.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_106061", "106061023", "story_v_out_106061.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_18 = math.max(var_95_11, arg_92_1.talkMaxDuration)

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_18 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_10) / var_95_18

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_10 + var_95_18 and arg_92_1.time_ < var_95_10 + var_95_18 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2033_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play106061024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 106061024
		arg_96_1.duration_ = 3.93

		local var_96_0 = {
			ja = 3.6,
			ko = 3.066,
			zh = 2,
			en = 3.933
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
			arg_96_1.auto_ = false
		end

		function arg_96_1.playNext_(arg_98_0)
			arg_96_1.onStoryFinished_()
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_99_0 = 0
			local var_99_1 = 0.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(106061024)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 9 <= 0 and var_99_1 or var_99_1 * (utf8.len(var_99_3) / 9)

				if (9 <= 0 and var_99_1 or var_99_1 * (utf8.len(var_99_3) / 9)) > 0 and var_99_1 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106061", "106061024", "story_v_out_106061.awb") ~= 0 then
					local var_99_6 = manager.audio:GetVoiceLength("story_v_out_106061", "106061024", "story_v_out_106061.awb") / 1000

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end

					if var_99_2.prefab_name ~= "" and arg_96_1.actors_[var_99_2.prefab_name] ~= nil then
						local var_99_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_2.prefab_name].transform, "story_v_out_106061", "106061024", "story_v_out_106061.awb")

						arg_96_1:RecordAudio("106061024", var_99_7)
						arg_96_1:RecordAudio("106061024", var_99_7)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_106061", "106061024", "story_v_out_106061.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_106061", "106061024", "story_v_out_106061.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_8 and arg_96_1.time_ < var_99_0 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C02b"
	},
	voices = {
		"story_v_out_106061.awb"
	}
}
