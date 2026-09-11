return {
	Play317312001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317312001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317312002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STwhite == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_4_0.name = "STwhite"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STwhite = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 2
			local var_4_12 = 0.45

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

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317312001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 18 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 18)

				if (18 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 18)) > 0 and var_4_12 < var_4_16 then
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
	Play317312002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 317312002
		arg_8_1.duration_ = 5.47

		local var_8_0 = {
			zh = 3.7,
			ja = 5.466
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
				arg_8_0:Play317312003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1015ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1015ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1015ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1015ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1015ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1015ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1015ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1015ui_story == nil then
				arg_8_1.var_.characterEffect1015ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1015ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1015ui_story then
				arg_8_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_11_8 = 0
			local var_11_9 = 0.375

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(317312002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 15 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 15)

				if (15 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 15)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312002", "story_v_out_317312.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_317312", "317312002", "story_v_out_317312.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_317312", "317312002", "story_v_out_317312.awb")

						arg_8_1:RecordAudio("317312002", var_11_15)
						arg_8_1:RecordAudio("317312002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_317312", "317312002", "story_v_out_317312.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_317312", "317312002", "story_v_out_317312.awb")
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play317312003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 317312003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play317312004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1015ui_story"]) and arg_12_1.var_.characterEffect1015ui_story == nil then
				arg_12_1.var_.characterEffect1015ui_story = arg_12_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1015ui_story"]) then
				if arg_12_1.var_.characterEffect1015ui_story and not isNil(arg_12_1.actors_["1015ui_story"]) then
					arg_12_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1015ui_story"]) and arg_12_1.var_.characterEffect1015ui_story then
				arg_12_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.625

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

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(317312003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 25 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 25)

				if (25 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 25)) > 0 and var_15_2 < var_15_5 then
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
	Play317312004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 317312004
		arg_16_1.duration_ = 9.5

		local var_16_0 = {
			zh = 8.1,
			ja = 9.5
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
				arg_16_0:Play317312005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1015ui_story"]) and arg_16_1.var_.characterEffect1015ui_story == nil then
				arg_16_1.var_.characterEffect1015ui_story = arg_16_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1015ui_story"]) then
				if arg_16_1.var_.characterEffect1015ui_story and not isNil(arg_16_1.actors_["1015ui_story"]) then
					arg_16_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1015ui_story"]) and arg_16_1.var_.characterEffect1015ui_story then
				arg_16_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_19_2 = 0
			local var_19_3 = 1.025

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(317312004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 41 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 41)

				if (41 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 41)) > 0 and var_19_3 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312004", "story_v_out_317312.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_317312", "317312004", "story_v_out_317312.awb") / 1000

					if var_19_8 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_2
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_317312", "317312004", "story_v_out_317312.awb")

						arg_16_1:RecordAudio("317312004", var_19_9)
						arg_16_1:RecordAudio("317312004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_317312", "317312004", "story_v_out_317312.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_317312", "317312004", "story_v_out_317312.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_10 and arg_16_1.time_ < var_19_2 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play317312005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 317312005
		arg_20_1.duration_ = 10

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play317312006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1015ui_story"]) and arg_20_1.var_.characterEffect1015ui_story == nil then
				arg_20_1.var_.characterEffect1015ui_story = arg_20_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1015ui_story"]) then
				if arg_20_1.var_.characterEffect1015ui_story and not isNil(arg_20_1.actors_["1015ui_story"]) then
					arg_20_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1015ui_story"]) and arg_20_1.var_.characterEffect1015ui_story then
				arg_20_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_23_1 = arg_20_1.actors_["1015ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1015ui_story = var_23_1.localPosition
			end

			local var_23_2 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 then
				var_23_1.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_2)
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

			local var_23_3 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_4 = 5

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_4 then
				local var_23_5 = Color.New(0, 0, 0)

				var_23_5.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_3) / var_23_4)
				arg_20_1.mask_.color = var_23_5
			end

			if arg_20_1.time_ >= var_23_3 + var_23_4 and arg_20_1.time_ < var_23_3 + var_23_4 + arg_23_0 then
				local var_23_6 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_6.a = 0
				arg_20_1.mask_.color = var_23_6
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_7 = 5
			local var_23_8 = 0.125

			if 5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_9 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_9:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(317312005).content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_12 = 5 <= 0 and var_23_8 or var_23_8 * (utf8.len(var_23_10) / 5)

				if (5 <= 0 and var_23_8 or var_23_8 * (utf8.len(var_23_10) / 5)) > 0 and var_23_8 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12
					var_23_7 = var_23_7 + 0.3

					if var_23_12 + var_23_7 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_7
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = var_23_7 + 0.3
			local var_23_14 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_7 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_13) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_13 + var_23_14 and arg_20_1.time_ < var_23_13 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317312006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 317312006
		arg_26_1.duration_ = 5

		local var_26_0 = {
			zh = 3.3,
			ja = 5
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
				arg_26_0:Play317312007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1015ui_story = arg_26_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_29_0 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 then
				arg_26_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_26_1.time_ - 0) / var_29_0)
				arg_26_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1015ui_story"].transform.position).z)
				arg_26_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["1015ui_story"].transform.localEulerAngles = arg_26_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 then
				arg_26_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_26_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1015ui_story"].transform.position).z)
				arg_26_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["1015ui_story"].transform.localEulerAngles = arg_26_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_29_1 = arg_26_1.actors_["1015ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect1015ui_story == nil then
				arg_26_1.var_.characterEffect1015ui_story = var_29_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_2 and not isNil(var_29_1) then
				if arg_26_1.var_.characterEffect1015ui_story and not isNil(var_29_1) then
					arg_26_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_2 and arg_26_1.time_ < 0 + var_29_2 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect1015ui_story then
				arg_26_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_29_4 = 0
			local var_29_5 = 0.375

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(317312006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 15 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 15)

				if (15 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 15)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312006", "story_v_out_317312.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312006", "story_v_out_317312.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_317312", "317312006", "story_v_out_317312.awb")

						arg_26_1:RecordAudio("317312006", var_29_11)
						arg_26_1:RecordAudio("317312006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_317312", "317312006", "story_v_out_317312.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_317312", "317312006", "story_v_out_317312.awb")
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

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play317312007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 317312007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play317312008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1015ui_story"]) and arg_30_1.var_.characterEffect1015ui_story == nil then
				arg_30_1.var_.characterEffect1015ui_story = arg_30_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1015ui_story"]) then
				if arg_30_1.var_.characterEffect1015ui_story and not isNil(arg_30_1.actors_["1015ui_story"]) then
					arg_30_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_0)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1015ui_story"]) and arg_30_1.var_.characterEffect1015ui_story then
				arg_30_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_33_1 = 0
			local var_33_2 = 0.6

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(317312007).content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 24 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 24)

				if (24 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 24)) > 0 and var_33_2 < var_33_5 then
					arg_30_1.talkMaxDuration = var_33_5

					if var_33_5 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_6 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_6 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_6

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_6 and arg_30_1.time_ < var_33_1 + var_33_6 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play317312008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 317312008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play317312009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.35

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(317312008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 14 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 14)

				if (14 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 14)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play317312009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 317312009
		arg_38_1.duration_ = 5.03

		local var_38_0 = {
			zh = 4.8,
			ja = 5.033
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play317312010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1015ui_story = arg_38_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				arg_38_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1015ui_story"].transform.position).z)
				arg_38_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1015ui_story"].transform.localEulerAngles = arg_38_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_38_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1015ui_story"].transform.position).z)
				arg_38_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1015ui_story"].transform.localEulerAngles = arg_38_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_41_1 = arg_38_1.actors_["1015ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect1015ui_story == nil then
				arg_38_1.var_.characterEffect1015ui_story = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect1015ui_story and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect1015ui_story then
				arg_38_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_41_4 = 0
			local var_41_5 = 0.275

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(317312009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 11 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 11)

				if (11 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 11)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312009", "story_v_out_317312.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312009", "story_v_out_317312.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_317312", "317312009", "story_v_out_317312.awb")

						arg_38_1:RecordAudio("317312009", var_41_11)
						arg_38_1:RecordAudio("317312009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_317312", "317312009", "story_v_out_317312.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_317312", "317312009", "story_v_out_317312.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play317312010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 317312010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play317312011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1015ui_story"]) and arg_42_1.var_.characterEffect1015ui_story == nil then
				arg_42_1.var_.characterEffect1015ui_story = arg_42_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1015ui_story"]) then
				if arg_42_1.var_.characterEffect1015ui_story and not isNil(arg_42_1.actors_["1015ui_story"]) then
					arg_42_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1015ui_story"]) and arg_42_1.var_.characterEffect1015ui_story then
				arg_42_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.15

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(317312010).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 6 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 6)

				if (6 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 6)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play317312011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 317312011
		arg_46_1.duration_ = 4.97

		local var_46_0 = {
			zh = 4.8,
			ja = 4.966
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
				arg_46_0:Play317312012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1015ui_story"]) and arg_46_1.var_.characterEffect1015ui_story == nil then
				arg_46_1.var_.characterEffect1015ui_story = arg_46_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1015ui_story"]) then
				if arg_46_1.var_.characterEffect1015ui_story and not isNil(arg_46_1.actors_["1015ui_story"]) then
					arg_46_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1015ui_story"]) and arg_46_1.var_.characterEffect1015ui_story then
				arg_46_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_49_2 = 0
			local var_49_3 = 0.55

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(317312011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 22 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 22)

				if (22 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 22)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312011", "story_v_out_317312.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_317312", "317312011", "story_v_out_317312.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_317312", "317312011", "story_v_out_317312.awb")

						arg_46_1:RecordAudio("317312011", var_49_9)
						arg_46_1:RecordAudio("317312011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_317312", "317312011", "story_v_out_317312.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_317312", "317312011", "story_v_out_317312.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play317312012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 317312012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play317312013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1015ui_story"]) and arg_50_1.var_.characterEffect1015ui_story == nil then
				arg_50_1.var_.characterEffect1015ui_story = arg_50_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1015ui_story"]) then
				if arg_50_1.var_.characterEffect1015ui_story and not isNil(arg_50_1.actors_["1015ui_story"]) then
					arg_50_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1015ui_story"]) and arg_50_1.var_.characterEffect1015ui_story then
				arg_50_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_53_1 = 0
			local var_53_2 = 0.15

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(317312012).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 6 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 6)

				if (6 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 6)) > 0 and var_53_2 < var_53_5 then
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

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play317312013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 317312013
		arg_54_1.duration_ = 8.2

		local var_54_0 = {
			zh = 5.066,
			ja = 8.2
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
				arg_54_0:Play317312014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1015ui_story"]) and arg_54_1.var_.characterEffect1015ui_story == nil then
				arg_54_1.var_.characterEffect1015ui_story = arg_54_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1015ui_story"]) then
				if arg_54_1.var_.characterEffect1015ui_story and not isNil(arg_54_1.actors_["1015ui_story"]) then
					arg_54_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1015ui_story"]) and arg_54_1.var_.characterEffect1015ui_story then
				arg_54_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_57_2 = 0
			local var_57_3 = 0.35

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(317312013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 14 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 14)

				if (14 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 14)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312013", "story_v_out_317312.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_317312", "317312013", "story_v_out_317312.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_317312", "317312013", "story_v_out_317312.awb")

						arg_54_1:RecordAudio("317312013", var_57_9)
						arg_54_1:RecordAudio("317312013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_317312", "317312013", "story_v_out_317312.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_317312", "317312013", "story_v_out_317312.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play317312014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 317312014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play317312015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1015ui_story"]) and arg_58_1.var_.characterEffect1015ui_story == nil then
				arg_58_1.var_.characterEffect1015ui_story = arg_58_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1015ui_story"]) then
				if arg_58_1.var_.characterEffect1015ui_story and not isNil(arg_58_1.actors_["1015ui_story"]) then
					arg_58_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1015ui_story"]) and arg_58_1.var_.characterEffect1015ui_story then
				arg_58_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.75

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(317312014).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 30 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 30)

				if (30 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 30)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play317312015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 317312015
		arg_62_1.duration_ = 3.3

		local var_62_0 = {
			zh = 3.3,
			ja = 2.733
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
				arg_62_0:Play317312016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1015ui_story = arg_62_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1015ui_story"].transform.position).z)
				arg_62_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1015ui_story"].transform.localEulerAngles = arg_62_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_62_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1015ui_story"].transform.position).z)
				arg_62_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1015ui_story"].transform.localEulerAngles = arg_62_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["1015ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1015ui_story == nil then
				arg_62_1.var_.characterEffect1015ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect1015ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1015ui_story then
				arg_62_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_65_4 = 0
			local var_65_5 = 0.3

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(317312015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 12 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 12)

				if (12 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 12)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312015", "story_v_out_317312.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312015", "story_v_out_317312.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_317312", "317312015", "story_v_out_317312.awb")

						arg_62_1:RecordAudio("317312015", var_65_11)
						arg_62_1:RecordAudio("317312015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_317312", "317312015", "story_v_out_317312.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_317312", "317312015", "story_v_out_317312.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play317312016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 317312016
		arg_66_1.duration_ = 10.47

		local var_66_0 = {
			zh = 10.466,
			ja = 9.1
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
				arg_66_0:Play317312017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 1.3

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(317312016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 52 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 52)

				if (52 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 52)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312016", "story_v_out_317312.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312016", "story_v_out_317312.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_317312", "317312016", "story_v_out_317312.awb")

						arg_66_1:RecordAudio("317312016", var_69_6)
						arg_66_1:RecordAudio("317312016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_317312", "317312016", "story_v_out_317312.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_317312", "317312016", "story_v_out_317312.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play317312017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 317312017
		arg_70_1.duration_ = 9

		local var_70_0 = {
			zh = 6.266,
			ja = 9
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play317312018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.5

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:GetWordFromCfg(317312017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 20 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 20)

				if (20 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 20)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312017", "story_v_out_317312.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312017", "story_v_out_317312.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_317312", "317312017", "story_v_out_317312.awb")

						arg_70_1:RecordAudio("317312017", var_73_6)
						arg_70_1:RecordAudio("317312017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_317312", "317312017", "story_v_out_317312.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_317312", "317312017", "story_v_out_317312.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play317312018 = function(arg_74_0, arg_74_1)
		arg_74_1.marker = "317312018dontskip"
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 317312018
		arg_74_1.duration_ = 1

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"

			SetActive(arg_74_1.choicesGo_, true)

			for iter_75_0, iter_75_1 in ipairs(arg_74_1.choices_) do
				SetActive(iter_75_1.go, iter_75_0 <= 1)
			end

			arg_74_1.choices_[1].txt.text = arg_74_1:FormatText(StoryChoiceCfg[595].name)
		end

		function arg_74_1.playNext_(arg_76_0)
			arg_74_1.marker = ""

			if arg_76_0 == 1 then
				arg_74_0:Play317312019(arg_74_1)
			end

			arg_74_1:RecordChoiceLog(317312018, 595)
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1015ui_story"]) and arg_74_1.var_.characterEffect1015ui_story == nil then
				arg_74_1.var_.characterEffect1015ui_story = arg_74_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1015ui_story"]) then
				if arg_74_1.var_.characterEffect1015ui_story and not isNil(arg_74_1.actors_["1015ui_story"]) then
					arg_74_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1015ui_story"]) and arg_74_1.var_.characterEffect1015ui_story then
				arg_74_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_77_1 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			if arg_74_1.time_ >= var_77_1 + 0.5 and arg_74_1.time_ < var_77_1 + 0.5 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end

			local var_77_2 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				SetActive(arg_74_1.dialog_, true)
				SetActive(arg_74_1.allBtn_.gameObject, true)
				arg_74_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Dispose()

				arg_74_1.isInLoopVideo = false
			end

			local var_77_3 = 1

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_3 then
				-- block empty
			end

			if arg_74_1.time_ >= var_77_2 + var_77_3 and arg_74_1.time_ < var_77_2 + var_77_3 + arg_77_0 then
				-- block empty
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play317312019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 317312019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play317312020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				SetActive(arg_78_1.dialog_, true)
				SetActive(arg_78_1.allBtn_.gameObject, true)
				arg_78_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_78_1.isInLoopVideo = false
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				-- block empty
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				-- block empty
			end

			local var_81_1 = 0
			local var_81_2 = 0.625

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(317312019).content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 25 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 25)

				if (25 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 25)) > 0 and var_81_2 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_6 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_6 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_6

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_6 and arg_78_1.time_ < var_81_1 + var_81_6 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play317312020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 317312020
		arg_82_1.duration_ = 7

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play317312021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if arg_82_1.bgs_.STblack == nil then
				local var_85_0 = Object.Instantiate(arg_82_1.paintGo_)

				var_85_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_85_0.name = "STblack"
				var_85_0.transform.parent = arg_82_1.stage_.transform
				var_85_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.bgs_.STblack = var_85_0
			end

			if 1 < arg_82_1.time_ and arg_82_1.time_ <= 1 + arg_85_0 then
				local var_85_1 = arg_82_1.bgs_.STblack

				arg_82_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_85_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_85_2 = var_85_1:GetComponent("SpriteRenderer")

				if var_85_2 and var_85_2.sprite then
					local var_85_3 = 2 * (var_85_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_85_1.transform.localScale = Vector3.New(var_85_3 / var_85_2.sprite.bounds.size.y < var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x and var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x or var_85_3 / var_85_2.sprite.bounds.size.y, var_85_3 / var_85_2.sprite.bounds.size.y < var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x and var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x or var_85_3 / var_85_2.sprite.bounds.size.y, 0)
				end

				for iter_85_0, iter_85_1 in pairs(arg_82_1.bgs_) do
					if iter_85_0 ~= "STblack" then
						iter_85_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_85_4 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_5 = 1

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_5 then
				local var_85_6 = Color.New(0, 0, 0)

				var_85_6.a = Mathf.Lerp(0, 1, (arg_82_1.time_ - var_85_4) / var_85_5)
				arg_82_1.mask_.color = var_85_6
			end

			if arg_82_1.time_ >= var_85_4 + var_85_5 and arg_82_1.time_ < var_85_4 + var_85_5 + arg_85_0 then
				local var_85_7 = Color.New(0, 0, 0)

				var_85_7.a = 1
				arg_82_1.mask_.color = var_85_7
			end

			local var_85_8 = 1

			if 1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_9 = 1

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_9 then
				local var_85_10 = Color.New(0, 0, 0)

				var_85_10.a = Mathf.Lerp(1, 0, (arg_82_1.time_ - var_85_8) / var_85_9)
				arg_82_1.mask_.color = var_85_10
			end

			if arg_82_1.time_ >= var_85_8 + var_85_9 and arg_82_1.time_ < var_85_8 + var_85_9 + arg_85_0 then
				local var_85_11 = Color.New(0, 0, 0)

				arg_82_1.mask_.enabled = false
				var_85_11.a = 0
				arg_82_1.mask_.color = var_85_11
			end

			local var_85_12 = arg_82_1.actors_["1015ui_story"].transform

			if 1 < arg_82_1.time_ and arg_82_1.time_ <= 1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1015ui_story = var_85_12.localPosition
			end

			local var_85_13 = 0.001

			if 1 <= arg_82_1.time_ and arg_82_1.time_ < 1 + var_85_13 then
				var_85_12.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 1) / var_85_13)
				var_85_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_12.position).x, (manager.ui.mainCamera.transform.position - var_85_12.position).y, (manager.ui.mainCamera.transform.position - var_85_12.position).z)
				var_85_12.localEulerAngles.z = 0
				var_85_12.localEulerAngles.x = 0
				var_85_12.localEulerAngles = var_85_12.localEulerAngles
			end

			if arg_82_1.time_ >= 1 + var_85_13 and arg_82_1.time_ < 1 + var_85_13 + arg_85_0 then
				var_85_12.localPosition = Vector3.New(0, 100, 0)
				var_85_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_12.position).x, (manager.ui.mainCamera.transform.position - var_85_12.position).y, (manager.ui.mainCamera.transform.position - var_85_12.position).z)
				var_85_12.localEulerAngles.z = 0
				var_85_12.localEulerAngles.x = 0
				var_85_12.localEulerAngles = var_85_12.localEulerAngles
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_14 = 2
			local var_85_15 = 0.925

			if 2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_16 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_16:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_17 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(317312020).content)

				arg_82_1.text_.text = var_85_17

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_19 = 37 <= 0 and var_85_15 or var_85_15 * (utf8.len(var_85_17) / 37)

				if (37 <= 0 and var_85_15 or var_85_15 * (utf8.len(var_85_17) / 37)) > 0 and var_85_15 < var_85_19 then
					arg_82_1.talkMaxDuration = var_85_19
					var_85_14 = var_85_14 + 0.3

					if var_85_19 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_14
					end
				end

				arg_82_1.text_.text = var_85_17
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_20 = var_85_14 + 0.3
			local var_85_21 = math.max(var_85_15, arg_82_1.talkMaxDuration)

			if var_85_14 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_20 + var_85_21 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_20) / var_85_21

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_20 + var_85_21 and arg_82_1.time_ < var_85_20 + var_85_21 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play317312021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 317312021
		arg_88_1.duration_ = 6.63

		local var_88_0 = {
			zh = 6.633,
			ja = 4.466
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
				arg_88_0:Play317312022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if arg_88_1.bgs_.YA0105 == nil then
				local var_91_0 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0105")
				var_91_0.name = "YA0105"
				var_91_0.transform.parent = arg_88_1.stage_.transform
				var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_.YA0105 = var_91_0
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				local var_91_1 = arg_88_1.bgs_.YA0105

				arg_88_1.bgs_.YA0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_2 = var_91_1:GetComponent("SpriteRenderer")

				if var_91_2 and var_91_2.sprite then
					local var_91_3 = 2 * (var_91_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_1.transform.localScale = Vector3.New(var_91_3 / var_91_2.sprite.bounds.size.y < var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x and var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x or var_91_3 / var_91_2.sprite.bounds.size.y, var_91_3 / var_91_2.sprite.bounds.size.y < var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x and var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x or var_91_3 / var_91_2.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "YA0105" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_4 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_5 = 2

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_5 then
				local var_91_6 = Color.New(0, 0, 0)

				var_91_6.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_4) / var_91_5)
				arg_88_1.mask_.color = var_91_6
			end

			if arg_88_1.time_ >= var_91_4 + var_91_5 and arg_88_1.time_ < var_91_4 + var_91_5 + arg_91_0 then
				local var_91_7 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_7.a = 0
				arg_88_1.mask_.color = var_91_7
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_8 = 2
			local var_91_9 = 0.4

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_10 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_10:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_11 = arg_88_1:GetWordFromCfg(317312021)
				local var_91_12 = arg_88_1:FormatText(var_91_11.content)

				arg_88_1.text_.text = var_91_12

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_14 = 16 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_12) / 16)

				if (16 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_12) / 16)) > 0 and var_91_9 < var_91_14 then
					arg_88_1.talkMaxDuration = var_91_14
					var_91_8 = var_91_8 + 0.3

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_12
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312021", "story_v_out_317312.awb") ~= 0 then
					local var_91_15 = manager.audio:GetVoiceLength("story_v_out_317312", "317312021", "story_v_out_317312.awb") / 1000

					if var_91_15 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_8
					end

					if var_91_11.prefab_name ~= "" and arg_88_1.actors_[var_91_11.prefab_name] ~= nil then
						local var_91_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_11.prefab_name].transform, "story_v_out_317312", "317312021", "story_v_out_317312.awb")

						arg_88_1:RecordAudio("317312021", var_91_16)
						arg_88_1:RecordAudio("317312021", var_91_16)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_317312", "317312021", "story_v_out_317312.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_317312", "317312021", "story_v_out_317312.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_17 = var_91_8 + 0.3
			local var_91_18 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_18 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_17) / var_91_18

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_17 + var_91_18 and arg_88_1.time_ < var_91_17 + var_91_18 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play317312022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 317312022
		arg_94_1.duration_ = 7

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play317312023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				local var_97_0 = arg_94_1.bgs_.STblack

				arg_94_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_1 = var_97_0:GetComponent("SpriteRenderer")

				if var_97_1 and var_97_1.sprite then
					local var_97_2 = 2 * (var_97_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_0.transform.localScale = Vector3.New(var_97_2 / var_97_1.sprite.bounds.size.y < var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x and var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x or var_97_2 / var_97_1.sprite.bounds.size.y, var_97_2 / var_97_1.sprite.bounds.size.y < var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x and var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x or var_97_2 / var_97_1.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "STblack" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_3 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_4 = 2

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_4 then
				local var_97_5 = Color.New(0, 0, 0)

				var_97_5.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_3) / var_97_4)
				arg_94_1.mask_.color = var_97_5
			end

			if arg_94_1.time_ >= var_97_3 + var_97_4 and arg_94_1.time_ < var_97_3 + var_97_4 + arg_97_0 then
				local var_97_6 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_6.a = 0
				arg_94_1.mask_.color = var_97_6
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_7 = 2
			local var_97_8 = 0.275

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_9 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_9:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_10 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(317312022).content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_12 = 11 <= 0 and var_97_8 or var_97_8 * (utf8.len(var_97_10) / 11)

				if (11 <= 0 and var_97_8 or var_97_8 * (utf8.len(var_97_10) / 11)) > 0 and var_97_8 < var_97_12 then
					arg_94_1.talkMaxDuration = var_97_12
					var_97_7 = var_97_7 + 0.3

					if var_97_12 + var_97_7 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_7
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = var_97_7 + 0.3
			local var_97_14 = math.max(var_97_8, arg_94_1.talkMaxDuration)

			if var_97_7 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_13 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_13) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_13 + var_97_14 and arg_94_1.time_ < var_97_13 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play317312023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 317312023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play317312024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.25

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(317312023).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 10 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 10)

				if (10 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 10)) > 0 and var_103_0 < var_103_3 then
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
	Play317312024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 317312024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play317312025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.95

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(317312024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 38 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 38)

				if (38 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 38)) > 0 and var_107_0 < var_107_3 then
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
	Play317312025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 317312025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play317312026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.075

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(317312025).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 3 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 3)

				if (3 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 3)) > 0 and var_111_0 < var_111_3 then
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
	Play317312026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 317312026
		arg_112_1.duration_ = 80.96

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play317312027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 73.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= 73.9583333333333 + arg_115_0 then
				local var_115_0 = arg_112_1.bgs_.STwhite

				arg_112_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_115_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_1 = var_115_0:GetComponent("SpriteRenderer")

				if var_115_1 and var_115_1.sprite then
					local var_115_2 = 2 * (var_115_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_115_0.transform.localScale = Vector3.New(var_115_2 / var_115_1.sprite.bounds.size.y < var_115_2 * manager.ui.mainCameraCom_.aspect / var_115_1.sprite.bounds.size.x and var_115_2 * manager.ui.mainCameraCom_.aspect / var_115_1.sprite.bounds.size.x or var_115_2 / var_115_1.sprite.bounds.size.y, var_115_2 / var_115_1.sprite.bounds.size.y < var_115_2 * manager.ui.mainCameraCom_.aspect / var_115_1.sprite.bounds.size.x and var_115_2 * manager.ui.mainCameraCom_.aspect / var_115_1.sprite.bounds.size.x or var_115_2 / var_115_1.sprite.bounds.size.y, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "STwhite" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_3 = 73.9583333333333

			if 73.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_4 = 2

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_4 then
				local var_115_5 = Color.New(0, 0, 0)

				var_115_5.a = Mathf.Lerp(1, 0, (arg_112_1.time_ - var_115_3) / var_115_4)
				arg_112_1.mask_.color = var_115_5
			end

			if arg_112_1.time_ >= var_115_3 + var_115_4 and arg_112_1.time_ < var_115_3 + var_115_4 + arg_115_0 then
				local var_115_6 = Color.New(0, 0, 0)

				arg_112_1.mask_.enabled = false
				var_115_6.a = 0
				arg_112_1.mask_.color = var_115_6
			end

			local var_115_7 = "1049ui_story"

			if arg_112_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_115_8 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_112_1.stage_.transform)

				var_115_8.name = var_115_7
				var_115_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_[var_115_7] = var_115_8

				local var_115_9 = var_115_8:GetComponentInChildren(typeof(CharacterEffect))

				var_115_9.enabled = true

				local var_115_10 = GameObjectTools.GetOrAddComponent(var_115_8, typeof(DynamicBoneHelper))

				if var_115_10 then
					var_115_10:EnableDynamicBone(false)
				end

				arg_112_1:ShowWeapon(var_115_9.transform, false)

				arg_112_1.var_[var_115_7 .. "Animator"] = var_115_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_112_1.var_[var_115_7 .. "Animator"].applyRootMotion = true
				arg_112_1.var_[var_115_7 .. "LipSync"] = var_115_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_115_11 = arg_112_1.actors_["1049ui_story"].transform

			if 75.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= 75.9583333333333 + arg_115_0 then
				arg_112_1.var_.moveOldPos1049ui_story = var_115_11.localPosition
			end

			local var_115_12 = 0.001

			if 75.9583333333333 <= arg_112_1.time_ and arg_112_1.time_ < 75.9583333333333 + var_115_12 then
				var_115_11.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_112_1.time_ - 75.9583333333333) / var_115_12)
				var_115_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_11.position).x, (manager.ui.mainCamera.transform.position - var_115_11.position).y, (manager.ui.mainCamera.transform.position - var_115_11.position).z)
				var_115_11.localEulerAngles.z = 0
				var_115_11.localEulerAngles.x = 0
				var_115_11.localEulerAngles = var_115_11.localEulerAngles
			end

			if arg_112_1.time_ >= 75.9583333333333 + var_115_12 and arg_112_1.time_ < 75.9583333333333 + var_115_12 + arg_115_0 then
				var_115_11.localPosition = Vector3.New(0, -1.2, -6)
				var_115_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_11.position).x, (manager.ui.mainCamera.transform.position - var_115_11.position).y, (manager.ui.mainCamera.transform.position - var_115_11.position).z)
				var_115_11.localEulerAngles.z = 0
				var_115_11.localEulerAngles.x = 0
				var_115_11.localEulerAngles = var_115_11.localEulerAngles
			end

			local var_115_13 = arg_112_1.actors_["1049ui_story"]

			if 75.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= 75.9583333333333 + arg_115_0 and not isNil(var_115_13) and arg_112_1.var_.characterEffect1049ui_story == nil then
				arg_112_1.var_.characterEffect1049ui_story = var_115_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_14 = 0.034000001847744

			if 75.9583333333333 <= arg_112_1.time_ and arg_112_1.time_ < 75.9583333333333 + var_115_14 and not isNil(var_115_13) then
				if arg_112_1.var_.characterEffect1049ui_story and not isNil(var_115_13) then
					arg_112_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 75.9583333333333 + var_115_14 and arg_112_1.time_ < 75.9583333333333 + var_115_14 + arg_115_0 and not isNil(var_115_13) and arg_112_1.var_.characterEffect1049ui_story then
				arg_112_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 75.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= 75.9583333333333 + arg_115_0 then
				arg_112_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 75.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= 75.9583333333333 + arg_115_0 then
				arg_112_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_115_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_112_1.bgmTxt_.text ~= var_115_18 and arg_112_1.bgmTxt_.text ~= "" then
						if arg_112_1.bgmTxt2_.text ~= "" then
							arg_112_1.bgmTxt_.text = arg_112_1.bgmTxt2_.text
						end

						arg_112_1.bgmTxt2_.text = var_115_18

						arg_112_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_112_1.bgmTxt_.text = var_115_18
						arg_112_1.bgmTxt2_.text = var_115_18
					end

					if arg_112_1.bgmTimer then
						arg_112_1.bgmTimer:Stop()

						arg_112_1.bgmTimer = nil
					end

					if arg_112_1.settingData.show_music_name == 1 then
						arg_112_1.musicController:SetSelectedState("show")
						arg_112_1.musicAnimator_:Play("open", 0, 0)

						if arg_112_1.settingData.music_time ~= 0 then
							arg_112_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_112_1.settingData.music_time), function()
								if arg_112_1 == nil or isNil(arg_112_1.bgmTxt_) then
									return
								end

								arg_112_1.musicController:SetSelectedState("hide")
								arg_112_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_115_19 = 0

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				SetActive(arg_112_1.dialog_, false)
				SetActive(arg_112_1.allBtn_.gameObject, false)
				arg_112_1.hideBtnsController_:SetSelectedIndex(1)

				arg_112_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/1031731.usm", function(arg_117_0)
					arg_112_1.time_ = var_115_19 + 73.9483333335568

					if arg_112_1.state_ == "pause" then
						arg_112_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_118_0)
					arg_112_1.state_ = arg_118_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_115_20 = 73.9583333333333

			if var_115_19 <= arg_112_1.time_ and arg_112_1.time_ < var_115_19 + var_115_20 then
				-- block empty
			end

			if arg_112_1.time_ >= var_115_19 + var_115_20 and arg_112_1.time_ < var_115_19 + var_115_20 + arg_115_0 then
				arg_112_1.marker = ""
			end

			local var_115_21 = 73.9583333333333

			if 73.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				SetActive(arg_112_1.dialog_, true)
				SetActive(arg_112_1.allBtn_.gameObject, true)
				arg_112_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_112_1.isInLoopVideo = false
			end

			local var_115_22 = 0.0166666666666667

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_22 then
				-- block empty
			end

			if arg_112_1.time_ >= var_115_21 + var_115_22 and arg_112_1.time_ < var_115_21 + var_115_22 + arg_115_0 then
				arg_112_1.marker = ""
			end

			local var_115_23 = 0
			local var_115_24 = manager.audio:GetVoiceLength("story_v_empty", "empty", "") / 1000

			if var_115_24 > 0 and 0.0333333333333333 < var_115_24 and var_115_24 + var_115_23 > arg_112_1.duration_ then
				arg_112_1.duration_ = var_115_24 + var_115_23
			end

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1:AudioAction("play", "voice", "story_v_empty", "empty", "")
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_26 = 75.9583333333333
			local var_115_27 = 0.95

			if 75.9583333333333 < arg_112_1.time_ and arg_112_1.time_ <= var_115_26 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_28 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_28:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_112_1.dialogCg_.alpha = arg_119_0
				end))
				var_115_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_29 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(317312026).content)

				arg_112_1.text_.text = var_115_29

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_31 = 38 <= 0 and var_115_27 or var_115_27 * (utf8.len(var_115_29) / 38)

				if (38 <= 0 and var_115_27 or var_115_27 * (utf8.len(var_115_29) / 38)) > 0 and var_115_27 < var_115_31 then
					arg_112_1.talkMaxDuration = var_115_31
					var_115_26 = var_115_26 + 0.3

					if var_115_31 + var_115_26 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_31 + var_115_26
					end
				end

				arg_112_1.text_.text = var_115_29
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_32 = var_115_26 + 0.3
			local var_115_33 = math.max(var_115_27, arg_112_1.talkMaxDuration)

			if var_115_26 + 0.3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_32 + var_115_33 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_32) / var_115_33

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_32 + var_115_33 and arg_112_1.time_ < var_115_32 + var_115_33 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 75.9583333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play317312027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317312027
		arg_121_1.duration_ = 2

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317312028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_124_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_121_1.bgmTxt_.text ~= var_124_2 and arg_121_1.bgmTxt_.text ~= "" then
						if arg_121_1.bgmTxt2_.text ~= "" then
							arg_121_1.bgmTxt_.text = arg_121_1.bgmTxt2_.text
						end

						arg_121_1.bgmTxt2_.text = var_124_2

						arg_121_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_121_1.bgmTxt_.text = var_124_2
						arg_121_1.bgmTxt2_.text = var_124_2
					end

					if arg_121_1.bgmTimer then
						arg_121_1.bgmTimer:Stop()

						arg_121_1.bgmTimer = nil
					end

					if arg_121_1.settingData.show_music_name == 1 then
						arg_121_1.musicController:SetSelectedState("show")
						arg_121_1.musicAnimator_:Play("open", 0, 0)

						if arg_121_1.settingData.music_time ~= 0 then
							arg_121_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_121_1.settingData.music_time), function()
								if arg_121_1 == nil or isNil(arg_121_1.bgmTxt_) then
									return
								end

								arg_121_1.musicController:SetSelectedState("hide")
								arg_121_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.733333333333333 < arg_121_1.time_ and arg_121_1.time_ <= 0.733333333333333 + arg_124_0 then
				arg_121_1:AudioAction("play", "music", "bgm_activity_2_6_ui", "bgm_activity_2_6_ui", "bgm_activity_2_6_ui.awb")

				local var_124_5 = manager.audio:GetAudioName("bgm_activity_2_6_ui", "bgm_activity_2_6_ui")

				if "" ~= "" then
					if arg_121_1.bgmTxt_.text ~= var_124_5 and arg_121_1.bgmTxt_.text ~= "" then
						if arg_121_1.bgmTxt2_.text ~= "" then
							arg_121_1.bgmTxt_.text = arg_121_1.bgmTxt2_.text
						end

						arg_121_1.bgmTxt2_.text = var_124_5

						arg_121_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_121_1.bgmTxt_.text = var_124_5
						arg_121_1.bgmTxt2_.text = var_124_5
					end

					if arg_121_1.bgmTimer then
						arg_121_1.bgmTimer:Stop()

						arg_121_1.bgmTimer = nil
					end

					if arg_121_1.settingData.show_music_name == 1 then
						arg_121_1.musicController:SetSelectedState("show")
						arg_121_1.musicAnimator_:Play("open", 0, 0)

						if arg_121_1.settingData.music_time ~= 0 then
							arg_121_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_121_1.settingData.music_time), function()
								if arg_121_1 == nil or isNil(arg_121_1.bgmTxt_) then
									return
								end

								arg_121_1.musicController:SetSelectedState("hide")
								arg_121_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_124_6 = 0
			local var_124_7 = 0.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(317312027)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 4 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 4)

				if (4 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 4)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312027", "story_v_out_317312.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_317312", "317312027", "story_v_out_317312.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_317312", "317312027", "story_v_out_317312.awb")

						arg_121_1:RecordAudio("317312027", var_124_13)
						arg_121_1:RecordAudio("317312027", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317312", "317312027", "story_v_out_317312.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317312", "317312027", "story_v_out_317312.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play317312028 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 317312028
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play317312029(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1049ui_story"]) and arg_127_1.var_.characterEffect1049ui_story == nil then
				arg_127_1.var_.characterEffect1049ui_story = arg_127_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1049ui_story"]) then
				if arg_127_1.var_.characterEffect1049ui_story and not isNil(arg_127_1.actors_["1049ui_story"]) then
					arg_127_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1049ui_story"]) and arg_127_1.var_.characterEffect1049ui_story then
				arg_127_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.075

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(317312028).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 3 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 3)

				if (3 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 3)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play317312029 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317312029
		arg_131_1.duration_ = 6.4

		local var_131_0 = {
			zh = 3.666,
			ja = 6.4
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play317312030(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1049ui_story = arg_131_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1049ui_story"].transform.position).z)
				arg_131_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1049ui_story"].transform.localEulerAngles = arg_131_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_131_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1049ui_story"].transform.position).z)
				arg_131_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1049ui_story"].transform.localEulerAngles = arg_131_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1049ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1049ui_story == nil then
				arg_131_1.var_.characterEffect1049ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1049ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1049ui_story then
				arg_131_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action425")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.275

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(317312029)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 11 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 11)

				if (11 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 11)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312029", "story_v_out_317312.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312029", "story_v_out_317312.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_317312", "317312029", "story_v_out_317312.awb")

						arg_131_1:RecordAudio("317312029", var_134_11)
						arg_131_1:RecordAudio("317312029", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_317312", "317312029", "story_v_out_317312.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_317312", "317312029", "story_v_out_317312.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play317312030 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 317312030
		arg_135_1.duration_ = 1

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"

			SetActive(arg_135_1.choicesGo_, true)

			for iter_136_0, iter_136_1 in ipairs(arg_135_1.choices_) do
				SetActive(iter_136_1.go, iter_136_0 <= 1)
			end

			arg_135_1.choices_[1].txt.text = arg_135_1:FormatText(StoryChoiceCfg[596].name)
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play317312031(arg_135_1)
			end

			arg_135_1:RecordChoiceLog(317312030, 596)
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1049ui_story"]) and arg_135_1.var_.characterEffect1049ui_story == nil then
				arg_135_1.var_.characterEffect1049ui_story = arg_135_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1049ui_story"]) then
				if arg_135_1.var_.characterEffect1049ui_story and not isNil(arg_135_1.actors_["1049ui_story"]) then
					arg_135_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1049ui_story"]) and arg_135_1.var_.characterEffect1049ui_story then
				arg_135_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_1 + 0.5 and arg_135_1.time_ < var_138_1 + 0.5 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play317312031 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 317312031
		arg_139_1.duration_ = 13.27

		local var_139_0 = {
			zh = 8,
			ja = 13.266
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play317312032(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1049ui_story = arg_139_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1049ui_story"].transform.position).z)
				arg_139_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1049ui_story"].transform.localEulerAngles = arg_139_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_139_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1049ui_story"].transform.position).z)
				arg_139_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1049ui_story"].transform.localEulerAngles = arg_139_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1049ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1049ui_story == nil then
				arg_139_1.var_.characterEffect1049ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1049ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1049ui_story then
				arg_139_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(317312031)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 12 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 12)

				if (12 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 12)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312031", "story_v_out_317312.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312031", "story_v_out_317312.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_317312", "317312031", "story_v_out_317312.awb")

						arg_139_1:RecordAudio("317312031", var_142_11)
						arg_139_1:RecordAudio("317312031", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_317312", "317312031", "story_v_out_317312.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_317312", "317312031", "story_v_out_317312.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play317312032 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 317312032
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play317312033(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1049ui_story = arg_143_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1049ui_story"].transform.position).z)
				arg_143_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1049ui_story"].transform.localEulerAngles = arg_143_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1049ui_story"].transform.position).z)
				arg_143_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1049ui_story"].transform.localEulerAngles = arg_143_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1049ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1049ui_story == nil then
				arg_143_1.var_.characterEffect1049ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1049ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1049ui_story then
				arg_143_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_146_3 = 0
			local var_146_4 = 1.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(317312032).content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 57 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 57)

				if (57 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 57)) > 0 and var_146_4 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_8 and arg_143_1.time_ < var_146_3 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play317312033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 317312033
		arg_147_1.duration_ = 6.63

		local var_147_0 = {
			zh = 3.166,
			ja = 6.633
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play317312034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.actors_["4039_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4039_tpose"))) then
				local var_150_0 = Object.Instantiate(Asset.Load("Char/" .. "4039_tpose"), arg_147_1.stage_.transform)

				var_150_0.name = "4039_tpose"
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["4039_tpose"] = var_150_0

				local var_150_1 = var_150_0:GetComponentInChildren(typeof(CharacterEffect))

				var_150_1.enabled = true

				local var_150_2 = GameObjectTools.GetOrAddComponent(var_150_0, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(false)
				end

				arg_147_1:ShowWeapon(var_150_1.transform, false)

				arg_147_1.var_["4039_tpose" .. "Animator"] = var_150_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_147_1.var_["4039_tpose" .. "Animator"].applyRootMotion = true
				arg_147_1.var_["4039_tpose" .. "LipSync"] = var_150_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_150_3 = arg_147_1.actors_["4039_tpose"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos4039_tpose = var_150_3.localPosition

				local var_150_4 = GameObjectTools.GetOrAddComponent(var_150_3.gameObject, typeof(DynamicBoneHelper))

				if var_150_4 then
					var_150_4:EnableDynamicBone(false)
				end
			end

			local var_150_5 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				var_150_3.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos4039_tpose, Vector3.New(0, -12.6, 234.5), (arg_147_1.time_ - 0) / var_150_5)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 then
				var_150_3.localPosition = Vector3.New(0, -12.6, 234.5)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles

				local var_150_6 = GameObjectTools.GetOrAddComponent(var_150_3.gameObject, typeof(DynamicBoneHelper))

				if var_150_6 then
					var_150_6:EnableDynamicBone(true)
				end
			end

			local var_150_7 = arg_147_1.actors_["4039_tpose"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.characterEffect4039_tpose == nil then
				arg_147_1.var_.characterEffect4039_tpose = var_150_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_8 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_8 and not isNil(var_150_7) then
				if arg_147_1.var_.characterEffect4039_tpose and not isNil(var_150_7) then
					arg_147_1.var_.characterEffect4039_tpose.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_8 and arg_147_1.time_ < 0 + var_150_8 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.characterEffect4039_tpose then
				arg_147_1.var_.characterEffect4039_tpose.fillFlat = false
			end

			local var_150_10 = 0
			local var_150_11 = 0.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_12 = arg_147_1:GetWordFromCfg(317312033)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 10 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 10)

				if (10 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 10)) > 0 and var_150_11 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312033", "story_v_out_317312.awb") ~= 0 then
					local var_150_16 = manager.audio:GetVoiceLength("story_v_out_317312", "317312033", "story_v_out_317312.awb") / 1000

					if var_150_16 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_10
					end

					if var_150_12.prefab_name ~= "" and arg_147_1.actors_[var_150_12.prefab_name] ~= nil then
						local var_150_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_12.prefab_name].transform, "story_v_out_317312", "317312033", "story_v_out_317312.awb")

						arg_147_1:RecordAudio("317312033", var_150_17)
						arg_147_1:RecordAudio("317312033", var_150_17)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_317312", "317312033", "story_v_out_317312.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_317312", "317312033", "story_v_out_317312.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_18 and arg_147_1.time_ < var_150_10 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4039_tpose",
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
	Play317312034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 317312034
		arg_151_1.duration_ = 9.93

		local var_151_0 = {
			zh = 4.866,
			ja = 9.933
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play317312035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.525

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(317312034)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 21 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 21)

				if (21 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 21)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312034", "story_v_out_317312.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312034", "story_v_out_317312.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_317312", "317312034", "story_v_out_317312.awb")

						arg_151_1:RecordAudio("317312034", var_154_6)
						arg_151_1:RecordAudio("317312034", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_317312", "317312034", "story_v_out_317312.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_317312", "317312034", "story_v_out_317312.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play317312035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 317312035
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play317312036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos4039_tpose = arg_155_1.actors_["4039_tpose"].transform.localPosition

				local var_158_0 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["4039_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_0 then
					var_158_0:EnableDynamicBone(false)
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["4039_tpose"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos4039_tpose, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_1)
				arg_155_1.actors_["4039_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["4039_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4039_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4039_tpose"].transform.position).z)
				arg_155_1.actors_["4039_tpose"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["4039_tpose"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["4039_tpose"].transform.localEulerAngles = arg_155_1.actors_["4039_tpose"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["4039_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["4039_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["4039_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4039_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4039_tpose"].transform.position).z)
				arg_155_1.actors_["4039_tpose"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["4039_tpose"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["4039_tpose"].transform.localEulerAngles = arg_155_1.actors_["4039_tpose"].transform.localEulerAngles

				local var_158_2 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["4039_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(true)
				end
			end

			local var_158_3 = 0
			local var_158_4 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(317312035).content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 35 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 35)

				if (35 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 35)) > 0 and var_158_4 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_8 and arg_155_1.time_ < var_158_3 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4039_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play317312036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 317312036
		arg_159_1.duration_ = 7.03

		local var_159_0 = {
			zh = 7.033,
			ja = 4.966
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
				arg_159_0:Play317312037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos4039_tpose = arg_159_1.actors_["4039_tpose"].transform.localPosition

				local var_162_0 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["4039_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_0 then
					var_162_0:EnableDynamicBone(false)
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["4039_tpose"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos4039_tpose, Vector3.New(0, -12.6, 234.5), (arg_159_1.time_ - 0) / var_162_1)
				arg_159_1.actors_["4039_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["4039_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4039_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4039_tpose"].transform.position).z)
				arg_159_1.actors_["4039_tpose"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["4039_tpose"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["4039_tpose"].transform.localEulerAngles = arg_159_1.actors_["4039_tpose"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["4039_tpose"].transform.localPosition = Vector3.New(0, -12.6, 234.5)
				arg_159_1.actors_["4039_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["4039_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4039_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4039_tpose"].transform.position).z)
				arg_159_1.actors_["4039_tpose"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["4039_tpose"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["4039_tpose"].transform.localEulerAngles = arg_159_1.actors_["4039_tpose"].transform.localEulerAngles

				local var_162_2 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["4039_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(true)
				end
			end

			local var_162_3 = arg_159_1.actors_["4039_tpose"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect4039_tpose == nil then
				arg_159_1.var_.characterEffect4039_tpose = var_162_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_3) then
				if arg_159_1.var_.characterEffect4039_tpose and not isNil(var_162_3) then
					arg_159_1.var_.characterEffect4039_tpose.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect4039_tpose then
				arg_159_1.var_.characterEffect4039_tpose.fillFlat = false
			end

			local var_162_6 = 0
			local var_162_7 = 0.55

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(317312036)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 22 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 22)

				if (22 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 22)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312036", "story_v_out_317312.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_317312", "317312036", "story_v_out_317312.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_317312", "317312036", "story_v_out_317312.awb")

						arg_159_1:RecordAudio("317312036", var_162_13)
						arg_159_1:RecordAudio("317312036", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_317312", "317312036", "story_v_out_317312.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_317312", "317312036", "story_v_out_317312.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4039_tpose",
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
	Play317312037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317312037
		arg_163_1.duration_ = 1

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"

			SetActive(arg_163_1.choicesGo_, true)

			for iter_164_0, iter_164_1 in ipairs(arg_163_1.choices_) do
				SetActive(iter_164_1.go, iter_164_0 <= 1)
			end

			arg_163_1.choices_[1].txt.text = arg_163_1:FormatText(StoryChoiceCfg[597].name)
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play317312038(arg_163_1)
			end

			arg_163_1:RecordChoiceLog(317312037, 597)
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= 0 + 0.5 and arg_163_1.time_ < 0 + 0.5 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_0 = arg_163_1.actors_["4039_tpose"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect4039_tpose == nil then
				arg_163_1.var_.characterEffect4039_tpose = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_1 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 and not isNil(var_166_0) then
				if arg_163_1.var_.characterEffect4039_tpose and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect4039_tpose.fillFlat = true
					arg_163_1.var_.characterEffect4039_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_1)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect4039_tpose then
				arg_163_1.var_.characterEffect4039_tpose.fillFlat = true
				arg_163_1.var_.characterEffect4039_tpose.fillRatio = 0.5
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play317312038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317312038
		arg_167_1.duration_ = 4.6

		local var_167_0 = {
			zh = 4.6,
			ja = 3.766
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play317312039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_170_1 = arg_167_1.actors_["4039_tpose"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect4039_tpose == nil then
				arg_167_1.var_.characterEffect4039_tpose = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect4039_tpose and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect4039_tpose.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect4039_tpose then
				arg_167_1.var_.characterEffect4039_tpose.fillFlat = false
			end

			local var_170_4 = 0
			local var_170_5 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(317312038)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 14 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 14)

				if (14 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 14)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312038", "story_v_out_317312.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312038", "story_v_out_317312.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_317312", "317312038", "story_v_out_317312.awb")

						arg_167_1:RecordAudio("317312038", var_170_11)
						arg_167_1:RecordAudio("317312038", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_317312", "317312038", "story_v_out_317312.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_317312", "317312038", "story_v_out_317312.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play317312039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317312039
		arg_171_1.duration_ = 1

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"

			SetActive(arg_171_1.choicesGo_, true)

			for iter_172_0, iter_172_1 in ipairs(arg_171_1.choices_) do
				SetActive(iter_172_1.go, iter_172_0 <= 1)
			end

			arg_171_1.choices_[1].txt.text = arg_171_1:FormatText(StoryChoiceCfg[598].name)
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play317312040(arg_171_1)
			end

			arg_171_1:RecordChoiceLog(317312039, 598)
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= 0 + 0.5 and arg_171_1.time_ < 0 + 0.5 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_0 = arg_171_1.actors_["4039_tpose"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect4039_tpose == nil then
				arg_171_1.var_.characterEffect4039_tpose = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_1 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 and not isNil(var_174_0) then
				if arg_171_1.var_.characterEffect4039_tpose and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect4039_tpose.fillFlat = true
					arg_171_1.var_.characterEffect4039_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_1)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect4039_tpose then
				arg_171_1.var_.characterEffect4039_tpose.fillFlat = true
				arg_171_1.var_.characterEffect4039_tpose.fillRatio = 0.5
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play317312040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317312040
		arg_175_1.duration_ = 8.27

		local var_175_0 = {
			zh = 5.966,
			ja = 8.266
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play317312041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_178_1 = arg_175_1.actors_["4039_tpose"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect4039_tpose == nil then
				arg_175_1.var_.characterEffect4039_tpose = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect4039_tpose and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect4039_tpose.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect4039_tpose then
				arg_175_1.var_.characterEffect4039_tpose.fillFlat = false
			end

			local var_178_4 = 0
			local var_178_5 = 0.35

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(317312040)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 14 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 14)

				if (14 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 14)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312040", "story_v_out_317312.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312040", "story_v_out_317312.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_317312", "317312040", "story_v_out_317312.awb")

						arg_175_1:RecordAudio("317312040", var_178_11)
						arg_175_1:RecordAudio("317312040", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_317312", "317312040", "story_v_out_317312.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_317312", "317312040", "story_v_out_317312.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play317312041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317312041
		arg_179_1.duration_ = 1

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"

			SetActive(arg_179_1.choicesGo_, true)

			for iter_180_0, iter_180_1 in ipairs(arg_179_1.choices_) do
				SetActive(iter_180_1.go, iter_180_0 <= 1)
			end

			arg_179_1.choices_[1].txt.text = arg_179_1:FormatText(StoryChoiceCfg[599].name)
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317312042(arg_179_1)
			end

			arg_179_1:RecordChoiceLog(317312041, 599)
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			if arg_179_1.time_ >= 0 + 0.5 and arg_179_1.time_ < 0 + 0.5 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			local var_182_0 = arg_179_1.actors_["4039_tpose"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect4039_tpose == nil then
				arg_179_1.var_.characterEffect4039_tpose = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_1 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 and not isNil(var_182_0) then
				if arg_179_1.var_.characterEffect4039_tpose and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect4039_tpose.fillFlat = true
					arg_179_1.var_.characterEffect4039_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_1)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect4039_tpose then
				arg_179_1.var_.characterEffect4039_tpose.fillFlat = true
				arg_179_1.var_.characterEffect4039_tpose.fillRatio = 0.5
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317312042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 317312042
		arg_183_1.duration_ = 6.07

		local var_183_0 = {
			zh = 6.066,
			ja = 5.466
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
				arg_183_0:Play317312043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_186_1 = arg_183_1.actors_["4039_tpose"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect4039_tpose == nil then
				arg_183_1.var_.characterEffect4039_tpose = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect4039_tpose and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect4039_tpose.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect4039_tpose then
				arg_183_1.var_.characterEffect4039_tpose.fillFlat = false
			end

			local var_186_4 = 0
			local var_186_5 = 0.4

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(317312042)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 16 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 16)

				if (16 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 16)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312042", "story_v_out_317312.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312042", "story_v_out_317312.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_317312", "317312042", "story_v_out_317312.awb")

						arg_183_1:RecordAudio("317312042", var_186_11)
						arg_183_1:RecordAudio("317312042", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_317312", "317312042", "story_v_out_317312.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_317312", "317312042", "story_v_out_317312.awb")
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

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play317312043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 317312043
		arg_187_1.duration_ = 1

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"

			SetActive(arg_187_1.choicesGo_, true)

			for iter_188_0, iter_188_1 in ipairs(arg_187_1.choices_) do
				SetActive(iter_188_1.go, iter_188_0 <= 1)
			end

			arg_187_1.choices_[1].txt.text = arg_187_1:FormatText(StoryChoiceCfg[600].name)
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play317312044(arg_187_1)
			end

			arg_187_1:RecordChoiceLog(317312043, 600)
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= 0 + 0.5 and arg_187_1.time_ < 0 + 0.5 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_0 = arg_187_1.actors_["4039_tpose"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect4039_tpose == nil then
				arg_187_1.var_.characterEffect4039_tpose = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_1 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 and not isNil(var_190_0) then
				if arg_187_1.var_.characterEffect4039_tpose and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect4039_tpose.fillFlat = true
					arg_187_1.var_.characterEffect4039_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_1)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect4039_tpose then
				arg_187_1.var_.characterEffect4039_tpose.fillFlat = true
				arg_187_1.var_.characterEffect4039_tpose.fillRatio = 0.5
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play317312044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317312044
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play317312045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos4039_tpose = arg_191_1.actors_["4039_tpose"].transform.localPosition

				local var_194_0 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["4039_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_0 then
					var_194_0:EnableDynamicBone(false)
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["4039_tpose"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos4039_tpose, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_1)
				arg_191_1.actors_["4039_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["4039_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4039_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4039_tpose"].transform.position).z)
				arg_191_1.actors_["4039_tpose"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["4039_tpose"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["4039_tpose"].transform.localEulerAngles = arg_191_1.actors_["4039_tpose"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["4039_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["4039_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["4039_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4039_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4039_tpose"].transform.position).z)
				arg_191_1.actors_["4039_tpose"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["4039_tpose"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["4039_tpose"].transform.localEulerAngles = arg_191_1.actors_["4039_tpose"].transform.localEulerAngles

				local var_194_2 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["4039_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(true)
				end
			end

			local var_194_3 = 0
			local var_194_4 = 0.825

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_3 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_5 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(317312044).content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 33 <= 0 and var_194_4 or var_194_4 * (utf8.len(var_194_5) / 33)

				if (33 <= 0 and var_194_4 or var_194_4 * (utf8.len(var_194_5) / 33)) > 0 and var_194_4 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_3 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_3
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_4, arg_191_1.talkMaxDuration)

			if var_194_3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_3 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_3) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_3 + var_194_8 and arg_191_1.time_ < var_194_3 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4039_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play317312045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317312045
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play317312046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.25

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(317312045).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 50 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 50)

				if (50 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 50)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317312046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317312046
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play317312047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(317312046).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 44 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 44)

				if (44 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 44)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play317312047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317312047
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play317312048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.4

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(317312047).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 16 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 16)

				if (16 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 16)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play317312048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317312048
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play317312049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.675

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(317312048).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 27 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 27)

				if (27 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 27)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play317312049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317312049
		arg_211_1.duration_ = 13.1

		local var_211_0 = {
			zh = 5.6,
			ja = 13.1
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
				arg_211_0:Play317312050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1049ui_story = arg_211_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1049ui_story"].transform.position).z)
				arg_211_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1049ui_story"].transform.localEulerAngles = arg_211_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_211_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1049ui_story"].transform.position).z)
				arg_211_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1049ui_story"].transform.localEulerAngles = arg_211_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1049ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1049ui_story == nil then
				arg_211_1.var_.characterEffect1049ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1049ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1049ui_story then
				arg_211_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_214_4 = 0
			local var_214_5 = 0.425

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(317312049)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 17 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 17)

				if (17 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 17)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312049", "story_v_out_317312.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312049", "story_v_out_317312.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_317312", "317312049", "story_v_out_317312.awb")

						arg_211_1:RecordAudio("317312049", var_214_11)
						arg_211_1:RecordAudio("317312049", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_317312", "317312049", "story_v_out_317312.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_317312", "317312049", "story_v_out_317312.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play317312050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317312050
		arg_215_1.duration_ = 8.3

		local var_215_0 = {
			zh = 6.533,
			ja = 8.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play317312051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.7

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(317312050)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 28 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 28)

				if (28 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 28)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312050", "story_v_out_317312.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312050", "story_v_out_317312.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_317312", "317312050", "story_v_out_317312.awb")

						arg_215_1:RecordAudio("317312050", var_218_6)
						arg_215_1:RecordAudio("317312050", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317312", "317312050", "story_v_out_317312.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317312", "317312050", "story_v_out_317312.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play317312051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317312051
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play317312052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1049ui_story"]) and arg_219_1.var_.characterEffect1049ui_story == nil then
				arg_219_1.var_.characterEffect1049ui_story = arg_219_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1049ui_story"]) then
				if arg_219_1.var_.characterEffect1049ui_story and not isNil(arg_219_1.actors_["1049ui_story"]) then
					arg_219_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1049ui_story"]) and arg_219_1.var_.characterEffect1049ui_story then
				arg_219_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.675

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(317312051).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 27 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 27)

				if (27 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 27)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play317312052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317312052
		arg_223_1.duration_ = 10.13

		local var_223_0 = {
			zh = 2.133,
			ja = 10.133
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
				arg_223_0:Play317312053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1049ui_story = arg_223_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1049ui_story"].transform.position).z)
				arg_223_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1049ui_story"].transform.localEulerAngles = arg_223_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_223_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1049ui_story"].transform.position).z)
				arg_223_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1049ui_story"].transform.localEulerAngles = arg_223_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1049ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1049ui_story == nil then
				arg_223_1.var_.characterEffect1049ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1049ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1049ui_story then
				arg_223_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action8_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.225

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(317312052)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 9 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 9)

				if (9 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 9)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312052", "story_v_out_317312.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312052", "story_v_out_317312.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_317312", "317312052", "story_v_out_317312.awb")

						arg_223_1:RecordAudio("317312052", var_226_11)
						arg_223_1:RecordAudio("317312052", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_317312", "317312052", "story_v_out_317312.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_317312", "317312052", "story_v_out_317312.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play317312053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317312053
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play317312054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1049ui_story"]) and arg_227_1.var_.characterEffect1049ui_story == nil then
				arg_227_1.var_.characterEffect1049ui_story = arg_227_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1049ui_story"]) then
				if arg_227_1.var_.characterEffect1049ui_story and not isNil(arg_227_1.actors_["1049ui_story"]) then
					arg_227_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1049ui_story"]) and arg_227_1.var_.characterEffect1049ui_story then
				arg_227_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.2

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

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(317312053).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 8 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 8)

				if (8 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 8)) > 0 and var_230_2 < var_230_5 then
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
	Play317312054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317312054
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play317312055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 1.075

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(317312054).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 43 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 43)

				if (43 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 43)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play317312055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317312055
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317312056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.5

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
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

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(317312055).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 20 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 20)

				if (20 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 20)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play317312056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 317312056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play317312057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.575

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(317312056).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 23 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 23)

				if (23 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 23)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play317312057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 317312057
		arg_243_1.duration_ = 5.2

		local var_243_0 = {
			zh = 2.5,
			ja = 5.2
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
				arg_243_0:Play317312058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1049ui_story = arg_243_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1049ui_story"].transform.position).z)
				arg_243_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1049ui_story"].transform.localEulerAngles = arg_243_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_243_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1049ui_story"].transform.position).z)
				arg_243_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1049ui_story"].transform.localEulerAngles = arg_243_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1049ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1049ui_story == nil then
				arg_243_1.var_.characterEffect1049ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1049ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1049ui_story then
				arg_243_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action8_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_246_4 = 0
			local var_246_5 = 0.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(317312057)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 8 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 8)

				if (8 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 8)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312057", "story_v_out_317312.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312057", "story_v_out_317312.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_317312", "317312057", "story_v_out_317312.awb")

						arg_243_1:RecordAudio("317312057", var_246_11)
						arg_243_1:RecordAudio("317312057", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_317312", "317312057", "story_v_out_317312.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_317312", "317312057", "story_v_out_317312.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play317312058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 317312058
		arg_247_1.duration_ = 1

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"

			SetActive(arg_247_1.choicesGo_, true)

			for iter_248_0, iter_248_1 in ipairs(arg_247_1.choices_) do
				SetActive(iter_248_1.go, iter_248_0 <= 1)
			end

			arg_247_1.choices_[1].txt.text = arg_247_1:FormatText(StoryChoiceCfg[601].name)
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play317312059(arg_247_1)
			end

			arg_247_1:RecordChoiceLog(317312058, 601)
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1049ui_story"]) and arg_247_1.var_.characterEffect1049ui_story == nil then
				arg_247_1.var_.characterEffect1049ui_story = arg_247_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1049ui_story"]) then
				if arg_247_1.var_.characterEffect1049ui_story and not isNil(arg_247_1.actors_["1049ui_story"]) then
					arg_247_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1049ui_story"]) and arg_247_1.var_.characterEffect1049ui_story then
				arg_247_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			if arg_247_1.time_ >= var_250_1 + 0.5 and arg_247_1.time_ < var_250_1 + 0.5 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play317312059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 317312059
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play317312060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1049ui_story = arg_251_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).z)
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles = arg_251_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).z)
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles = arg_251_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_254_1 = 0
			local var_254_2 = 1.15

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(317312059).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 46 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 46)

				if (46 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 46)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play317312060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 317312060
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play317312061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.425

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(317312060).content)

				arg_255_1.text_.text = var_258_1

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_3 = 17 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 17)

				if (17 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 17)) > 0 and var_258_0 < var_258_3 then
					arg_255_1.talkMaxDuration = var_258_3

					if var_258_3 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_3 + 0
					end
				end

				arg_255_1.text_.text = var_258_1
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_4 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_4

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play317312061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 317312061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play317312062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.325

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(317312061).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 13 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 13)

				if (13 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 13)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play317312062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 317312062
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play317312063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.625

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(317312062).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 25 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 25)

				if (25 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 25)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play317312063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 317312063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play317312064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.05

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(317312063).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 42 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 42)

				if (42 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 42)) > 0 and var_270_0 < var_270_3 then
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
	Play317312064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 317312064
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play317312065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.55

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(317312064).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 22 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 22)

				if (22 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 22)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play317312065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 317312065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play317312066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.825

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(317312065).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 33 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 33)

				if (33 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 33)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play317312066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 317312066
		arg_279_1.duration_ = 14.63

		local var_279_0 = {
			zh = 6.766,
			ja = 14.633
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play317312067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1049ui_story = arg_279_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1049ui_story"].transform.position).z)
				arg_279_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1049ui_story"].transform.localEulerAngles = arg_279_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_279_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1049ui_story"].transform.position).z)
				arg_279_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1049ui_story"].transform.localEulerAngles = arg_279_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1049ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1049ui_story == nil then
				arg_279_1.var_.characterEffect1049ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1049ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1049ui_story then
				arg_279_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_282_4 = 0
			local var_282_5 = 0.425

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(317312066)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 17 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 17)

				if (17 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 17)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312066", "story_v_out_317312.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_317312", "317312066", "story_v_out_317312.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_317312", "317312066", "story_v_out_317312.awb")

						arg_279_1:RecordAudio("317312066", var_282_11)
						arg_279_1:RecordAudio("317312066", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_317312", "317312066", "story_v_out_317312.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_317312", "317312066", "story_v_out_317312.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play317312067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 317312067
		arg_283_1.duration_ = 14.3

		local var_283_0 = {
			zh = 8.966,
			ja = 14.3
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
				arg_283_0:Play317312068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.575

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:GetWordFromCfg(317312067)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 23 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 23)

				if (23 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 23)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312067", "story_v_out_317312.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312067", "story_v_out_317312.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_317312", "317312067", "story_v_out_317312.awb")

						arg_283_1:RecordAudio("317312067", var_286_6)
						arg_283_1:RecordAudio("317312067", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_317312", "317312067", "story_v_out_317312.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_317312", "317312067", "story_v_out_317312.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play317312068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 317312068
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play317312069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1049ui_story"]) and arg_287_1.var_.characterEffect1049ui_story == nil then
				arg_287_1.var_.characterEffect1049ui_story = arg_287_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1049ui_story"]) then
				if arg_287_1.var_.characterEffect1049ui_story and not isNil(arg_287_1.actors_["1049ui_story"]) then
					arg_287_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1049ui_story"]) and arg_287_1.var_.characterEffect1049ui_story then
				arg_287_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.15

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(317312068).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 6 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 6)

				if (6 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 6)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play317312069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 317312069
		arg_291_1.duration_ = 9

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play317312070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if arg_291_1.bgs_.YA0208 == nil then
				local var_294_0 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0208")
				var_294_0.name = "YA0208"
				var_294_0.transform.parent = arg_291_1.stage_.transform
				var_294_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_.YA0208 = var_294_0
			end

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				local var_294_1 = arg_291_1.bgs_.YA0208

				arg_291_1.bgs_.YA0208.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_2 = var_294_1:GetComponent("SpriteRenderer")

				if var_294_2 and var_294_2.sprite then
					local var_294_3 = 2 * (var_294_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_1.transform.localScale = Vector3.New(var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "YA0208" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_4 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_5 = 2

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_5 then
				local var_294_6 = Color.New(0, 0, 0)

				var_294_6.a = Mathf.Lerp(0, 1, (arg_291_1.time_ - var_294_4) / var_294_5)
				arg_291_1.mask_.color = var_294_6
			end

			if arg_291_1.time_ >= var_294_4 + var_294_5 and arg_291_1.time_ < var_294_4 + var_294_5 + arg_294_0 then
				local var_294_7 = Color.New(0, 0, 0)

				var_294_7.a = 1
				arg_291_1.mask_.color = var_294_7
			end

			local var_294_8 = 2

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_9 = 2

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_9 then
				local var_294_10 = Color.New(0, 0, 0)

				var_294_10.a = Mathf.Lerp(1, 0, (arg_291_1.time_ - var_294_8) / var_294_9)
				arg_291_1.mask_.color = var_294_10
			end

			if arg_291_1.time_ >= var_294_8 + var_294_9 and arg_291_1.time_ < var_294_8 + var_294_9 + arg_294_0 then
				local var_294_11 = Color.New(0, 0, 0)

				arg_291_1.mask_.enabled = false
				var_294_11.a = 0
				arg_291_1.mask_.color = var_294_11
			end

			local var_294_12 = arg_291_1.actors_["1049ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1049ui_story = var_294_12.localPosition
			end

			local var_294_13 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_13 then
				var_294_12.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_13)
				var_294_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_12.position).x, (manager.ui.mainCamera.transform.position - var_294_12.position).y, (manager.ui.mainCamera.transform.position - var_294_12.position).z)
				var_294_12.localEulerAngles.z = 0
				var_294_12.localEulerAngles.x = 0
				var_294_12.localEulerAngles = var_294_12.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_13 and arg_291_1.time_ < 0 + var_294_13 + arg_294_0 then
				var_294_12.localPosition = Vector3.New(0, 100, 0)
				var_294_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_12.position).x, (manager.ui.mainCamera.transform.position - var_294_12.position).y, (manager.ui.mainCamera.transform.position - var_294_12.position).z)
				var_294_12.localEulerAngles.z = 0
				var_294_12.localEulerAngles.x = 0
				var_294_12.localEulerAngles = var_294_12.localEulerAngles
			end

			local var_294_14 = arg_291_1.bgs_.YA0208.transform

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				arg_291_1.var_.moveOldPosYA0208 = var_294_14.localPosition
			end

			local var_294_15 = 0.001

			if 2 <= arg_291_1.time_ and arg_291_1.time_ < 2 + var_294_15 then
				var_294_14.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosYA0208, Vector3.New(-0.63, -0.34, 2.43), (arg_291_1.time_ - 2) / var_294_15)
			end

			if arg_291_1.time_ >= 2 + var_294_15 and arg_291_1.time_ < 2 + var_294_15 + arg_294_0 then
				var_294_14.localPosition = Vector3.New(-0.63, -0.34, 2.43)
			end

			local var_294_16 = arg_291_1.bgs_.YA0208.transform

			if 2.034 < arg_291_1.time_ and arg_291_1.time_ <= 2.034 + arg_294_0 then
				arg_291_1.var_.moveOldPosYA0208 = var_294_16.localPosition
			end

			local var_294_17 = 3.191

			if 2.034 <= arg_291_1.time_ and arg_291_1.time_ < 2.034 + var_294_17 then
				var_294_16.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosYA0208, Vector3.New(-0.63, -0.34, 3), (arg_291_1.time_ - 2.034) / var_294_17)
			end

			if arg_291_1.time_ >= 2.034 + var_294_17 and arg_291_1.time_ < 2.034 + var_294_17 + arg_294_0 then
				var_294_16.localPosition = Vector3.New(-0.63, -0.34, 3)
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_18 = 4
			local var_294_19 = 1.225

			if 4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_18 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_20 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_20:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_21 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(317312069).content)

				arg_291_1.text_.text = var_294_21

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_23 = 49 <= 0 and var_294_19 or var_294_19 * (utf8.len(var_294_21) / 49)

				if (49 <= 0 and var_294_19 or var_294_19 * (utf8.len(var_294_21) / 49)) > 0 and var_294_19 < var_294_23 then
					arg_291_1.talkMaxDuration = var_294_23
					var_294_18 = var_294_18 + 0.3

					if var_294_23 + var_294_18 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_18
					end
				end

				arg_291_1.text_.text = var_294_21
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_24 = var_294_18 + 0.3
			local var_294_25 = math.max(var_294_19, arg_291_1.talkMaxDuration)

			if var_294_18 + 0.3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_24 + var_294_25 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_24) / var_294_25

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_24 + var_294_25 and arg_291_1.time_ < var_294_24 + var_294_25 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "YA0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.191,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play317312070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 317312070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play317312071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.9

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(317312070).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 36 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 36)

				if (36 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 36)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play317312071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 317312071
		arg_301_1.duration_ = 5.2

		local var_301_0 = {
			zh = 5.2,
			ja = 4.066
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play317312072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.2

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(317312071)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 8 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 8)

				if (8 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 8)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312071", "story_v_out_317312.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312071", "story_v_out_317312.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_317312", "317312071", "story_v_out_317312.awb")

						arg_301_1:RecordAudio("317312071", var_304_6)
						arg_301_1:RecordAudio("317312071", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_317312", "317312071", "story_v_out_317312.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_317312", "317312071", "story_v_out_317312.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play317312072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 317312072
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play317312073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(317312072).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 40 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 40)

				if (40 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 40)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play317312073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 317312073
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play317312074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.75

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(317312073).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 30 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 30)

				if (30 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 30)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play317312074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 317312074
		arg_313_1.duration_ = 6.8

		local var_313_0 = {
			zh = 3.433,
			ja = 6.8
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play317312075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.275

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(317312074)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 11 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 11)

				if (11 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 11)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312074", "story_v_out_317312.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312074", "story_v_out_317312.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_317312", "317312074", "story_v_out_317312.awb")

						arg_313_1:RecordAudio("317312074", var_316_6)
						arg_313_1:RecordAudio("317312074", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_317312", "317312074", "story_v_out_317312.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_317312", "317312074", "story_v_out_317312.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play317312075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 317312075
		arg_317_1.duration_ = 2.97

		local var_317_0 = {
			zh = 1.233,
			ja = 2.966
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play317312076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.075

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:GetWordFromCfg(317312075)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 3 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 3)

				if (3 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 3)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312075", "story_v_out_317312.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312075", "story_v_out_317312.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_317312", "317312075", "story_v_out_317312.awb")

						arg_317_1:RecordAudio("317312075", var_320_6)
						arg_317_1:RecordAudio("317312075", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_317312", "317312075", "story_v_out_317312.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_317312", "317312075", "story_v_out_317312.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play317312076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 317312076
		arg_321_1.duration_ = 9.97

		local var_321_0 = {
			zh = 5.233,
			ja = 9.966
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play317312077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.5

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(317312076)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 20 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 20)

				if (20 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 20)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312076", "story_v_out_317312.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312076", "story_v_out_317312.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_317312", "317312076", "story_v_out_317312.awb")

						arg_321_1:RecordAudio("317312076", var_324_6)
						arg_321_1:RecordAudio("317312076", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_317312", "317312076", "story_v_out_317312.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_317312", "317312076", "story_v_out_317312.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play317312077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 317312077
		arg_325_1.duration_ = 17.43

		local var_325_0 = {
			zh = 8.9,
			ja = 17.433
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play317312078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 2 < arg_325_1.time_ and arg_325_1.time_ <= 2 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.YA0208

				arg_325_1.bgs_.YA0208.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "YA0208" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_4 = 2

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_4 then
				local var_328_5 = Color.New(0, 0, 0)

				var_328_5.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_3) / var_328_4)
				arg_325_1.mask_.color = var_328_5
			end

			if arg_325_1.time_ >= var_328_3 + var_328_4 and arg_325_1.time_ < var_328_3 + var_328_4 + arg_328_0 then
				local var_328_6 = Color.New(0, 0, 0)

				var_328_6.a = 1
				arg_325_1.mask_.color = var_328_6
			end

			local var_328_7 = 2

			if 2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_8 = 2

			if var_328_7 <= arg_325_1.time_ and arg_325_1.time_ < var_328_7 + var_328_8 then
				local var_328_9 = Color.New(0, 0, 0)

				var_328_9.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_7) / var_328_8)
				arg_325_1.mask_.color = var_328_9
			end

			if arg_325_1.time_ >= var_328_7 + var_328_8 and arg_325_1.time_ < var_328_7 + var_328_8 + arg_328_0 then
				local var_328_10 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_10.a = 0
				arg_325_1.mask_.color = var_328_10
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_11 = 4
			local var_328_12 = 0.55

			if 4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_13 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_13:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(317312077)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_17 = 22 <= 0 and var_328_12 or var_328_12 * (utf8.len(var_328_15) / 22)

				if (22 <= 0 and var_328_12 or var_328_12 * (utf8.len(var_328_15) / 22)) > 0 and var_328_12 < var_328_17 then
					arg_325_1.talkMaxDuration = var_328_17
					var_328_11 = var_328_11 + 0.3

					if var_328_17 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_17 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312077", "story_v_out_317312.awb") ~= 0 then
					local var_328_18 = manager.audio:GetVoiceLength("story_v_out_317312", "317312077", "story_v_out_317312.awb") / 1000

					if var_328_18 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_11
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_317312", "317312077", "story_v_out_317312.awb")

						arg_325_1:RecordAudio("317312077", var_328_19)
						arg_325_1:RecordAudio("317312077", var_328_19)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_317312", "317312077", "story_v_out_317312.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_317312", "317312077", "story_v_out_317312.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_20 = var_328_11 + 0.3
			local var_328_21 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_20 + var_328_21 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_20) / var_328_21

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_20 + var_328_21 and arg_325_1.time_ < var_328_20 + var_328_21 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play317312078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 317312078
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play317312079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.975

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

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(317312078).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 39 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 39)

				if (39 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 39)) > 0 and var_334_0 < var_334_3 then
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
	Play317312079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 317312079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play317312080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.95

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(317312079).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 38 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 38)

				if (38 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 38)) > 0 and var_338_0 < var_338_3 then
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
	Play317312080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 317312080
		arg_339_1.duration_ = 17.6

		local var_339_0 = {
			zh = 5.2,
			ja = 17.6
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
				arg_339_0:Play317312081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.45

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(317312080)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 18 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 18)

				if (18 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 18)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312080", "story_v_out_317312.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312080", "story_v_out_317312.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_317312", "317312080", "story_v_out_317312.awb")

						arg_339_1:RecordAudio("317312080", var_342_6)
						arg_339_1:RecordAudio("317312080", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_317312", "317312080", "story_v_out_317312.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_317312", "317312080", "story_v_out_317312.awb")
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
	Play317312081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 317312081
		arg_343_1.duration_ = 5.5

		local var_343_0 = {
			zh = 4.833,
			ja = 5.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play317312082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.325

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(317312081)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 13 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 13)

				if (13 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 13)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312081", "story_v_out_317312.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312081", "story_v_out_317312.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_317312", "317312081", "story_v_out_317312.awb")

						arg_343_1:RecordAudio("317312081", var_346_6)
						arg_343_1:RecordAudio("317312081", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_317312", "317312081", "story_v_out_317312.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_317312", "317312081", "story_v_out_317312.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play317312082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 317312082
		arg_347_1.duration_ = 7.8

		local var_347_0 = {
			zh = 7.8,
			ja = 5.266
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
				arg_347_0:Play317312083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.675

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(317312082)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 27 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 27)

				if (27 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 27)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312082", "story_v_out_317312.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312082", "story_v_out_317312.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_317312", "317312082", "story_v_out_317312.awb")

						arg_347_1:RecordAudio("317312082", var_350_6)
						arg_347_1:RecordAudio("317312082", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_317312", "317312082", "story_v_out_317312.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_317312", "317312082", "story_v_out_317312.awb")
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
	Play317312083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 317312083
		arg_351_1.duration_ = 8

		local var_351_0 = {
			zh = 4.9,
			ja = 8
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
				arg_351_0:Play317312084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.525

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(317312083)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 21 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 21)

				if (21 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 21)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312083", "story_v_out_317312.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312083", "story_v_out_317312.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_317312", "317312083", "story_v_out_317312.awb")

						arg_351_1:RecordAudio("317312083", var_354_6)
						arg_351_1:RecordAudio("317312083", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_317312", "317312083", "story_v_out_317312.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_317312", "317312083", "story_v_out_317312.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play317312084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 317312084
		arg_355_1.duration_ = 22.2

		local var_355_0 = {
			zh = 4.033,
			ja = 22.2
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
				arg_355_0:Play317312085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.275

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(317312084)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 11 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 11)

				if (11 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 11)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312084", "story_v_out_317312.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312084", "story_v_out_317312.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_317312", "317312084", "story_v_out_317312.awb")

						arg_355_1:RecordAudio("317312084", var_358_6)
						arg_355_1:RecordAudio("317312084", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_317312", "317312084", "story_v_out_317312.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_317312", "317312084", "story_v_out_317312.awb")
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
	Play317312085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 317312085
		arg_359_1.duration_ = 3.2

		local var_359_0 = {
			zh = 2.866,
			ja = 3.2
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play317312086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.225

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(317312085)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 9 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 9)

				if (9 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 9)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312085", "story_v_out_317312.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312085", "story_v_out_317312.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_317312", "317312085", "story_v_out_317312.awb")

						arg_359_1:RecordAudio("317312085", var_362_6)
						arg_359_1:RecordAudio("317312085", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_317312", "317312085", "story_v_out_317312.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_317312", "317312085", "story_v_out_317312.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play317312086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 317312086
		arg_363_1.duration_ = 4.1

		local var_363_0 = {
			zh = 4.1,
			ja = 1.233
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play317312087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.275

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:GetWordFromCfg(317312086)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 11 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 11)

				if (11 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 11)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312086", "story_v_out_317312.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312086", "story_v_out_317312.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_317312", "317312086", "story_v_out_317312.awb")

						arg_363_1:RecordAudio("317312086", var_366_6)
						arg_363_1:RecordAudio("317312086", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_317312", "317312086", "story_v_out_317312.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_317312", "317312086", "story_v_out_317312.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play317312087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 317312087
		arg_367_1.duration_ = 2.83

		local var_367_0 = {
			zh = 2.833,
			ja = 1.066
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play317312088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.1

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(317312087)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 4 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 4)

				if (4 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 4)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312087", "story_v_out_317312.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312087", "story_v_out_317312.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_317312", "317312087", "story_v_out_317312.awb")

						arg_367_1:RecordAudio("317312087", var_370_6)
						arg_367_1:RecordAudio("317312087", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_317312", "317312087", "story_v_out_317312.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_317312", "317312087", "story_v_out_317312.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play317312088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 317312088
		arg_371_1.duration_ = 7.73

		local var_371_0 = {
			zh = 4.5,
			ja = 7.733
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play317312089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.375

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(317312088)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 15 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 15)

				if (15 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 15)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312088", "story_v_out_317312.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312088", "story_v_out_317312.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_317312", "317312088", "story_v_out_317312.awb")

						arg_371_1:RecordAudio("317312088", var_374_6)
						arg_371_1:RecordAudio("317312088", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_317312", "317312088", "story_v_out_317312.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_317312", "317312088", "story_v_out_317312.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play317312089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 317312089
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play317312090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.375

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(317312089).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 15 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 15)

				if (15 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 15)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play317312090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 317312090
		arg_379_1.duration_ = 6.07

		local var_379_0 = {
			zh = 5.633,
			ja = 6.066
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play317312091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.225

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:GetWordFromCfg(317312090)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 9 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 9)

				if (9 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 9)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317312", "317312090", "story_v_out_317312.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_out_317312", "317312090", "story_v_out_317312.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_out_317312", "317312090", "story_v_out_317312.awb")

						arg_379_1:RecordAudio("317312090", var_382_6)
						arg_379_1:RecordAudio("317312090", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_317312", "317312090", "story_v_out_317312.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_317312", "317312090", "story_v_out_317312.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play317312091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 317312091
		arg_383_1.duration_ = 9

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
			arg_383_1.auto_ = false
		end

		function arg_383_1.playNext_(arg_385_0)
			arg_383_1.onStoryFinished_()
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if arg_383_1.bgs_.D999 == nil then
				local var_386_0 = Object.Instantiate(arg_383_1.paintGo_)

				var_386_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D999")
				var_386_0.name = "D999"
				var_386_0.transform.parent = arg_383_1.stage_.transform
				var_386_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_.D999 = var_386_0
			end

			if 2 < arg_383_1.time_ and arg_383_1.time_ <= 2 + arg_386_0 then
				local var_386_1 = arg_383_1.bgs_.D999

				arg_383_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_386_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_2 = var_386_1:GetComponent("SpriteRenderer")

				if var_386_2 and var_386_2.sprite then
					local var_386_3 = 2 * (var_386_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_386_1.transform.localScale = Vector3.New(var_386_3 / var_386_2.sprite.bounds.size.y < var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x and var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x or var_386_3 / var_386_2.sprite.bounds.size.y, var_386_3 / var_386_2.sprite.bounds.size.y < var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x and var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x or var_386_3 / var_386_2.sprite.bounds.size.y, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "D999" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_4 = 0

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_5 = 2

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_5 then
				local var_386_6 = Color.New(0, 0, 0)

				var_386_6.a = Mathf.Lerp(0, 1, (arg_383_1.time_ - var_386_4) / var_386_5)
				arg_383_1.mask_.color = var_386_6
			end

			if arg_383_1.time_ >= var_386_4 + var_386_5 and arg_383_1.time_ < var_386_4 + var_386_5 + arg_386_0 then
				local var_386_7 = Color.New(0, 0, 0)

				var_386_7.a = 1
				arg_383_1.mask_.color = var_386_7
			end

			local var_386_8 = 2

			if 2 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_9 = 2

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_9 then
				local var_386_10 = Color.New(0, 0, 0)

				var_386_10.a = Mathf.Lerp(1, 0, (arg_383_1.time_ - var_386_8) / var_386_9)
				arg_383_1.mask_.color = var_386_10
			end

			if arg_383_1.time_ >= var_386_8 + var_386_9 and arg_383_1.time_ < var_386_8 + var_386_9 + arg_386_0 then
				local var_386_11 = Color.New(0, 0, 0)

				arg_383_1.mask_.enabled = false
				var_386_11.a = 0
				arg_383_1.mask_.color = var_386_11
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_12 = 4
			local var_386_13 = 1.075

			if 4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_12 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_14 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_14:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_15 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(317312091).content)

				arg_383_1.text_.text = var_386_15

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_17 = 43 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_15) / 43)

				if (43 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_15) / 43)) > 0 and var_386_13 < var_386_17 then
					arg_383_1.talkMaxDuration = var_386_17
					var_386_12 = var_386_12 + 0.3

					if var_386_17 + var_386_12 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_17 + var_386_12
					end
				end

				arg_383_1.text_.text = var_386_15
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_18 = var_386_12 + 0.3
			local var_386_19 = math.max(var_386_13, arg_383_1.talkMaxDuration)

			if var_386_12 + 0.3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_18 + var_386_19 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_18) / var_386_19

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_18 + var_386_19 and arg_383_1.time_ < var_386_18 + var_386_19 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/YA0105",
		"SofdecAsset/story/1031731.usm",
		"TextureConfig/Background/YA0208",
		"TextureConfig/Background/D999"
	},
	voices = {
		"story_v_out_317312.awb"
	},
	skipMarkers = {
		317312018,
		317312026
	}
}
